#compdef go -P -value-,GO*,-default- -P -value-,CGO*,-default-
# ------------------------------------------------------------------------------
# Copyright (c) 2016 Github zsh-users - http://github.com/zsh-users
# Copyright (c) 2013-2015 Robby Russell and contributors (see
# https://github.com/robbyrussell/oh-my-zsh/contributors)
# Copyright (c) 2010-2014 Go authors
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#     * Neither the name of the zsh-users nor the
#       names of its contributors may be used to endorse or promote products
#       derived from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL ZSH-USERS BE LIABLE FOR ANY DIRECT,
# INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
# ------------------------------------------------------------------------------
# Description
# -----------
#
#  Completion script for go 1.14 (http://golang.org).
#
# ------------------------------------------------------------------------------
# Authors
# -------
#
#  * Mikkel Oscar Lyderik Larsen <mikkeloscar@gmail.com>
#  * Paul Seyfert <pseyfert.mathphys@gmail.com>
#  * oh-my-zsh authors:
#        https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/golang/golang.plugin.zsh
#  * Go authors
#
# ------------------------------------------------------------------------------

__go_buildmodes() {
  local -a buildmodes
  buildmodes=(
  'archive[non-main packages into .a files]'
  'c-archive[main package, plus all packages it imports, into a C archive file]'
  'c-shared[main package, plus all packages it imports, into a C shared library]'
  'default[main packages are built into executables and listed non-main packages are built into .a files]'
  'shared[non-main packages into a single shared library that will be used when building with the -linkshared option]'
  'exe[main packages into executables]'
  'pie[main packages and everything they import into position independent executables (PIE)]'
  'plugin[main packages, plus all packages that they import, into a Go plugin]'
  )

  _values 'mode' $buildmodes
}


__go_runtimedebug() {
  local -a vars
  vars=(
    'allocfreetrace[profile allocations]:boolean:(1 0)'
    'clobberfree[clobber memory after free]:boolean:(1 0)'
    'cgocheck[check passing go pointers to non-go]: :((0\:"no checks" 1\:"check checks" 2\:"expensive checks"))'
    'efence[allocate on unique pages]:boolean:(1 0)'
    "gccheckmark[verify garbage collector's concurrent mark phase]:boolean:(1 0)"
    'gcpacertrace[print state of the concurrent pacer from garbage collector]:boolean:(1 0)'
    'gcshrinkstackoff[disable moving goroutines to smaller stacks]:boolean:(1 0)'
    'gcstoptheworld[disable concurrent garbage collection]: :((0\:default 1\:"disable concurrent garbage collection" 2\:"disable concurrent gc and sweeping"))'
    'gctrace[emit memory collection and pause information from the garbage collector]:boolean:(1 0)'
    'madvdontneed[use MADV_DONTNEED instead of MADV_FREE]:boolean:(1 0)'
    'memprofilerate[every N-th allocation should be profiled]:int:'
    'invalidptr[crash on invalid integers in pointer-type variables]:boolean:(1 0)'
    'sbrk[replace memory allocator and garbage collector by trivial allocator]:boolean:(1 0)'
    'scavenge[enable debugging mode of heap scavenger]:boolean:(1 0)'
    'scavtrace[emit scavenger work information (memory returned and memory utilization)]:boolean:(1 0)'
    'scheddetail[emit detailed states of scheduler, processors, threads, goroutines]:boolean:(1 0)'
    'schedtrace[emmit scheduler state every N ms to stderr]:int'
    'tracebackancestors[set ancestor goroutines to be printed in goroutine creation stacks]:int'
    'asyncpreemptoff[disable signal-based asynchronous goroutine preemption.]:boolean:(1 0)'
  )
  _values -s ',' -S '=' "runtime debug behaviour" $vars[@]
}

__go_gcdebugflags() {
  _values -s , -S = 'debug flag' \
    'append[print information about append compilation]' \
    'checkptr[instrument unsafe pointer conversions]:pointer conversion checks:((0\:"instrumentation disabled" 1\:"conversions involving unsafe.Pointer are instrumented" 2\:"conversions to unsafe.Pointer force heap allocation"))' \
    'closure[print information about closure compilation]' \
    'compilelater[compile functions as late as possible]' \
    'disablenil[disable nil checks]' \
    'dclstack[run internal dclstack check]' \
    'gcprog[print dump of GC programs]' \
    'libfuzzer[coverage instrumentation for libfuzzer]' \
    'nil[print information about nil checks]' \
    'panic[do not hide any compiler panic]' \
    'slice[print information about slice compilation]' \
    'typeassert[print information about type assertion inlining]' \
    'wb[print information about write barriers]' \
    'export[print export data]' \
    'pctab[print named pc-value table]:pc-value:(pctospadj pctofile pctoline pctoinline pctopcdata)' \
    'locationlists[print information about DWARF location list creation]' \
    'typecheckinl[eager typechecking of inline function bodies]' \
    'dwarfinl[print information about DWARF inlined function creation]' \
    'softfloat[force compiler to emit soft-float code]' \
    'defer[print information about defer compilation]' \
    'ssa/help[print help about SSA debugging]'
}

__go_gcflags() {
  _arguments \
  '-%[debug non-static initializers]' \
  '-c=[concurrency during compilation]:int' \
  '-+[compiling runtime]' \
  '-B[disable bounds checking]' \
  '-C[disable printing of columns in error messages]' \
  '-D=[set relative path for local imports]:path: _path_files -/' \
  '-E[debug symbol export]' \
  '-I=[add directory to import search path]:directory: _path_files -/' \
  '-K[debug missing line numbers]' \
  '-L[show full file names in error messages]' \
  '-N[disable optimizations]' \
  '-S[print assembly listing]' \
  '-V[print version and exit]' \
  '-W[debug parse tree after type checking]' \
  '-asmhdr=[write assembly header to file]:file' \
  '-bench=[append benchmark times to file]:file' \
  '-blockprofile=[write block profile to file]:file' \
  '-buildid=[record id as the build id in the export metadata]:id' \
  '-complete[compiling complete package (no C or assembly)]' \
  '-cpuprofile=[write cpu profile to file]:file' \
  '-d=[print debug information about items in list; try -d help]:list: __go_gcdebugflags' \
  '-dwarf[generate DWARF symbols (default true)]' \
  '-dwarfbasentries[use base address selection entries in DWARF (default true)]' \
  '-dwarflocationlists[add location lists to DWARF in optimized mode (default true)]' \
  '-dynlink[support references to Go symbols defined in other shared libraries]' \
  '-e[no limit on number of errors reported]' \
  '-gendwarfinl=[generate DWARF inline info records (default 2)]:int' \
  '-goversion=[required version of the runtime]:string' \
  '-h[halt on error]' \
  '-importcfg=[read import configuration from file]:file' \
  '-importmap=[add definition of the form source=actual to import map]:definition' \
  '-installsuffix=[set pkg directory suffix]:suffix' \
  '-j[debug runtime-initialized variables]' \
  '-json=[version,destination for JSON compiler/optimizer logging]:string' \
  '-l[disable inlining]' \
  '-lang=[release to compile for]:string' \
  '-linkobj=[write linker-specific object to file]:file' \
  '-linkshared[generate code that will be linked against Go shared libraries]' \
  '-live[debug liveness analysis]' \
  '-m[print optimization decisions]' \
  '-memprofile=[write memory profile to file]:file' \
  '-memprofilerate=[set runtime.MemProfileRate to rate]:rate' \
  '-msan[build code compatible with C/C++ memory sanitizer]' \
  '-mutexprofile=[write mutex profile to file]:file' \
  '-newobj[use new object file format]' \
  '-nolocalimports[reject local (relative) imports]' \
  '-o=[write output to file]:file' \
  '-p=[set expected package import path]:path: _path_files -/' \
  '-pack[write to file.a instead of file.o]' \
  '-r[debug generated wrappers]' \
  '-race[enable race detector]' \
  '-shared[generate code that can be linked into a shared library]' \
  '-smallframes[reduce the size limit for stack allocated objects]' \
  '-spectre=[enable spectre mitigations]:mitigations:(all index ret)' \
  '-std[compiling standard library]' \
  '-symabis=[read symbol ABIs from file]:file' \
  '-traceprofile=[write an execution trace to file]:file' \
  '-trimpath=[remove prefix from recorded source file paths]:prefix' \
  '-v[increase debug verbosity]' \
  '-w[debug type checking]' \
  '-wb[enable write barrier (default true)]' \
}


local -a commands build_flags
commands=(
'bug:start a bug report'
'build:compile packages and dependencies'
'clean:remove object files and cached files'
'doc:show documentation for package or symbol'
'env:print Go environment information'
'fix:update packages to use new APIs'
'fmt:gofmt (reformat) package sources'
'generate:generate Go files by processing source'
'get:download and install packages and dependencies'
'install:compile and install packages and dependencies'
'list:list packages or modules'
'mod:module maintenance'
'run:compile and run Go program'
'test:test packages'
'tool:run specified go tool'
'version:print Go version'
'vet:report likely mistakes in packages'
'help:get more information about a command'
)

__go_envvarvals() {
  # if __go_envvarvals is called for -value-, I use the function argument to
  # decide which variable to go to.  if $1 is not set, then __go_envvarvals is
  # called from the `go env` completion and the current word (with all after
  # the first '=' removed) is the current variable.
  local variable
  variable=${1-${words[$CURRENT]%%=*}}
  case $variable in
    # commands
    AR)
      ;&
    CC)
      ;&
    CXX)
      ;&
    FC)
      ;&
    GCCGO)
      _command_names -e
      ;;
    # directories (using fallthrough)
    GOBIN)
      ;&
    GOCACHE)
      ;&
    GOTMPDIR)
      ;&
    GOTOOLDIR)
      ;&
    GOROOT)
      ;&
    GOROOT_FINAL)
      ;&
    GCCGOTOOLDIR)
      ;&
    GOPATH)
      ;&
    GOMODCACHE)
      _files -/
      ;;
    # regular files (using fallthrough)
    GOMOD)
      ;&
    PKG_CONFIG)
      ;&
    GOENV)
      _files
      ;;
    # special
    GOHOSTOS)
      ;&
    GOOS)
      # from https://golang.org/doc/install/source#environment
      _values 'operating system' aix android darwin dragonfly freebsd illumos js linux netbsd openbsd plan9 solaris windows
      ;;
    GOHOSTARCH)
      ;&
    GOARCH)
      _values 'architecture' amd64 386 arm ppc64
      ;;
    CGO_ENABLED)
      _values 'enable/disable cgo' 0 1
      ;;
    GO_EXTLINK_ENABLED)
      _values 'enable/disable external linkage' 0 1
      ;;
    GOARM)
      _values 'target arm architecture' 5 6 7
      ;;
    GO386)
      _values 'x86 floating point instruction set' 387 sse2
      ;;
    GOMIPS*)
      _values 'mips floating point instructions' hardfloat softfloat
      ;;
    GOWASM)
      _values 'web assembly features' -s ',' satconv signext
      ;;
    GOPROXY)
      _urls
      ;;
    GOEXE)
      _message "suffix for executables"
      ;;
    CGO_*FLAGS_*ALLOW)
      _message "regexp"
      ;;
    CGO_*FLAGS)
      _dispatch $service -value-,${variable#CGO_},-default-
      ;;
    GODEBUG)
      __go_runtimedebug
      ;;
    GOFLAGS)
      # not implemented, sorry
      ;;
    GOINSECURE)
      ;&
    GOPRIVATE)
      ;&
    GONOPROXY)
      ;&
    GONOSUMDB)
      # comma separated glob patterns (in the syntax of Go's path.Match)
      _message "comma separated glob pattern"
      ;;
    GOSUMDB)
      _message "e.g. sum.golang.org+<publickey> https://sum.golang.org"
      ;;
  esac
}

if [[ "$service" = -value-* ]]; then
  variable=${${service%,-default-}#-value-,}
  # some special variables are not read from the environment
  local -a blacklist
  blacklist=('GOEXE' 'GOGCCFLAGS' 'GOHOSTARCH' 'GOHOSTOS' 'GOMOD' 'GOTOOLDIR')
  if (($blacklist[(I)$variable])); then
    return
  fi
  __go_envvarvals $variable
  return
fi

_arguments \
  "1: :{_describe 'command' commands}" \
  '*:: :->args'

case $state in
  args)
    build_flags=(
    '-a[force rebuilding of packages that are already up-to-date]'
    '-n[print the commands but do not run them]'
    '-p[number of builds that can be run in parallel]:number'
    '-race[enable data race detection]'
    '-msan[enable interoperation with memory sanitizer]'
    '-v[print the names of packages as they are compiled]'
    '-work[print temporary work directory and keep it]'
    '-x[print the commands]'
    '-asmflags[arguments for each go tool asm invocation]:flags'
    '-buildmode[build mode to use]:mode:__go_buildmodes'
    '-compiler[name of compiler to use]:name'
    '-gccgoflags[arguments for gccgo]:args'
    '*-gcflags=[arguments for each go tool compile invocation]:args:__go_gcflags'
    '-installsuffix[suffix to add to package directory]:suffix'
    '-ldflags[arguments to pass on each go tool link invocation.]:flags'
    '-linkshared[link against shared libraries]'
    '-overlay[read a JSON config file that provides an overlay for build operations]:file:_files -g "*.json"'
    '-pkgdir[install and load all packages from dir]:dir'
    '-tags[list of build tags to consider satisfied]:tags'
    '-trimpath[remove all file system paths from the resulting executable]'
    '-toolexec[program to use to invoke toolchain programs]:args'
    )
    mod_flags=(
    '-mod=[module download mode to use]:download mode:(readonly vendor mod)'
    '-modcacherw[leave newly-created directories in the module cache read-write]'
    '-modfile=[read an alternate go.mod file]:modfile: _files -g "*.mod"'
    )

    __go_packages() {
      local gopaths
      declare -a gopaths
      gopaths=("${(s/:/)$(go env GOPATH)}")
      gopaths+=("$(go env GOROOT)")
      for p in $gopaths; do
        _path_files $@ -W "$p/src" -/
      done
      # no special treatment for
      # - relative paths starting with ..
      # - absolute path starting with /
      # - variables, substitutions, subshells
      if [[ $words[$CURRENT] = ..* || $words[$CURRENT] = \$* || $words[$CURRENT] = /* ]]; then
        _path_files $@ -/ -g '*.go'
      else
        # go build accepts paths relative to the cwd but they must start with './', so prefix them
        _path_files $@ -P './' -/ -g '*.go'
      fi
    }

    case $words[1] in
      build)
        _arguments \
          '-o[force build to write to named output file or directory]:file or directory:_files' \
          '-i[installs the packages that are dependencies of the target]' \
          ${build_flags[@]} \
          ${mod_flags[@]} \
          '*:importpaths:__go_packages'
          ;;

      clean)
        _arguments \
          '-i[remove corresponding installed archive or binary]' \
          '-r[apply clean recursively on all dependencies]' \
          ${build_flags[@]} \
          ${mod_flags[@]} \
          '*:importpaths:__go_packages'
          ;;

      doc)
        _arguments \
          '-c[respect case when matching symbols]' \
          '-cmd[treat a command (package main) like a regular package]' \
          '-u[show docs for unexported and exported symbols and methods]'
          ;;

      env)
        local -a goenvvars
        goenvvars=(
          "GOARCH[architecture, or processor, for which to compile code.]:architecture"
          "GCCGO[gccgo command to run.]:gccgo command"
          "GOBIN[directory where 'go install' installs to]:go install target dir"
          "GOCACHE[directory to store cached information]:go build cache dir"
          "GODEBUG[enable runtime debug facilities]:runtime debug settings"
          "GOENV[location of the go environment configuration file]:configuration file"
          "GOFLAGS[default go command line flags]:space sparated default command line flags"
          "GOINSECURE[module prefixes that are feched insecurely]:comma separated module prefixes"
          "GOOS[target operating system]:operating system"
          "GOPATH[path to resolve import statements]:import path"
          "GOPROXY[URL of go module proxy]:proxy url"
          "GOROOT[root of the go tree]:go root directory"
          "GOTMPDIR[directory for temporary sources, packages, and binaries]:tmp directory"
          "GOPRIVATE[modules that should always be fetched directly]:comma separated glob patterns"
          "GONOPROXY[modules that should always be fetched directly]:comma separated glob patterns"
          "GONOSUMDB[modules that should not be compared against the checksum db]:comma separated glob patterns"
          "GOMODCACHE[module cache directory]:path"
          "GOSUMDB[checksum database]:name(+publickey( url))"
          "AR[command for manipulating library archives (for gccgo)]:archive manipulation program"
          "CC[command to compile C code]:C compiler"
          "CGO_ENABLED[enable/disable cgo]:boolean"
          "CGO_CFLAGS[flags passed to the compiler for C code]:C compilation flags"
          "CGO_CFLAGS_ALLOW[additional flags to allow to appear in #cgo CFLAGS]:regular expression"
          "CGO_CFLAGS_DISALLOW[flags that must be disallowed from appearing in #cgo CFLAGS]"
          "CGO_CPPFLAGS[flags passed to the C preprocessor]:C preprocessor flags"
          "CGO_CPPFLAGS_ALLOW[additional flags to allow to appear in #cgo CPPFLAGS]:regular expression"
          "CGO_CPPFLAGS_DISALLOW[flags that must be disallowed from appearing in #cgo CPPFLAGS]"
          "CGO_CXXFLAGS[flags passed to the compiler for C++ code]:C++ compilation flags"
          "CGO_CXXFLAGS_ALLOW[additional flags to allow to appear in #cgo CXXFLAGS]:regular expression"
          "CGO_CXXFLAGS_DISALLOW[flags that must be disallowed from appearing in #cgo CXXFLAGS]"
          "CGO_FFLAGS[flags passed to the compiler for Fortran code]:Fortran compilation flags"
          "CGO_FFLAGS_ALLOW[additional flags to allow to appear in #cgo FFLAGS]:regular expression"
          "CGO_FFLAGS_DISALLOW[flags that must be disallowed from appearing in #cgo FFLAGS]"
          "CGO_LDFLAGS[flags passed to the compiler for linker]:linker flags"
          "CGO_LDFLAGS_ALLOW[additional flags to allow to appear in #cgo LDFLAGS]:regular expression"
          "CGO_LDFLAGS_DISALLOW[flags that must be disallowed from appearing in #cgo LDFLAGS]"
          "CXX[command to compile C++]:C++ compiler"
          "FC[command to compile Fortran]:Fortran compiler"
          "PKG_CONFIG[Path to pkg-config tool.]:path to pkg-config"
          "GOARM[arm architecture]:arm architecture"
          "GO386[x86 instruction set]:x86 instruction set"
          "GOMIPS[mips instruction set]:mips instruction set"
          "GOMIPS64[mips64 instruction set]:mips64 instruction set"
          "GOWASM[web assembly features]:comma separated web assembly features"
          "GCCGOTOOLDIR[directory of gccgo tools]:gccgo tool director"
          "GOROOT_FINAL[root of the go tree]:go root"
          "GO_EXTLINK_ENABLED[enable external linking mode]:boolean"
          "GIT_ALLOW_PROTOCOL[schemes allowed to fetch]:colon separated git schemes"
          "GOEXE[suffix for executables]:executable suffix"
          "GOGCCFLAGS[arguments supplied to CC]:space separated arguments to CC"
          "GOHOSTARCH[architecture of the toolchain binaries]:host os architecture"
          "GOHOSTOS[operating system of the toolchain binaries]:host os"
          "GOMOD[absolute path the the main go.mod]:abs path to main go.mod"
          "GOTOOLDIR[installation directory of go tools]:tool installation directory"
        )
        local -a exclude_from_w
        exclude_from_w=(GOENV)

        __list_env_vars() {
          # the parameter expansion strops off everything after the first [
          _values -s ' ' -w 'environment variable' ${goenvvars[@]%%\[*}
        }

        # the ^ parameter expansion appends ": __go_envvarvals" to every element of goenvvars
        # the :# parameter expansion removes all elements matching GOENV*
        [[ $words[2] != '-w' ]] && _arguments \
          '-json[print the environment in JSON format]' \
          '-u[unset environment variables]' \
          '-w[change the default setting of environment variables]' \
          '*:[show environment variable]: __list_env_vars' || _values \
          -s ' ' -S "=" -w 'environment variable' ${^goenvvars:#GOENV*}": __go_envvarvals"
        ;;

      fix)
        _arguments '*:importpaths:__go_packages'
        ;;

      fmt)
        _arguments \
          '-n[prints commands that would be executed]' \
          '-x[prints commands as they are executed]' \
          '*:importpaths:__go_packages'
          ;;

      generate)
        _arguments \
          '-run=[specifies a regular expression to select directives]:regex' \
          '-x[print the commands]' \
          '-n[print the commands but do not run them]' \
          '-v[print the names of packages as they are compiled]' \
          "*:args:{ _alternative ':importpaths:__go_packages' _files }"
          ;;

      get)
        # no mod_flags for get
        _arguments \
          '-d[instructs get to stop after downloading the packages]' \
          '-f[force get -u not to verify that each package has been checked from vcs]' \
          '-fix[run the fix tool on the downloaded packages]' \
          '-insecure[permit fetching/resolving custom domains]' \
          '-t[also download the packages required to build tests]' \
          '-u[use the network to update the named packages]' \
          ${build_flags[@]} \
          '*:importpaths:__go_packages'
          ;;

      install)
        _arguments ${build_flags[@]} \
          '*:importpaths:__go_packages'
          ;;

      list)
        local -a list_args
        list_args=(
          '-e[changes the handling of erroneous packages]'
          '-f[specifies an alternate format for the list]:format'
          '-json[causes package data to be printed in JSON format]'
          '-compiled[set CompiledGoFiles to the Go source files presented to the compiler]'
          '-deps[iterate over named packages and their dependencies]'
          '-m[list modules instead of packages]'
          ${build_flags[@]}
          ${mod_flags[@]}
          '*:importpaths:__go_packages'
        )
        # -u and -versions are only available if -m is present on the commandline
        if (($words[(I)-m])); then
          list_args+=(
          '-u[adds information about available upgrades]'
          '-versions[list all known versions of modules]'
          )
        fi
        _arguments ${list_args[@]}
          ;;

      mod)
        local -a mod_commands
        mod_commands=(
        'download:download modules to local cache'
        'edit:edit go.mod from tools or scripts'
        'graph:print module requirement graph'
        'init:initialize new module in current directory'
        'tidy:add missing and remove unused modules'
        'vendor:make vendored copy of dependencies'
        'verify:verify dependencies have expected content'
        'why:explain why packages or modules are needed'
        'help:get more information about a command'
        )

        _arguments \
          "1: :{_describe 'command' mod_commands}" \
          '*:: :->args'

        case $state in
          args)
            case $words[1] in
              download)
                _arguments \
                  '-json[print a sequance of JSON objects to standard output]'
                ;;

              edit)
                _arguments \
                  '-fmt[reformats the go.mod file without making other changes]' \
                  "-module[change the module's path]" \
                  '*-require=[add a requirement on the given module path and version]:require' \
                  '*-droprequire=[drop a requirement on the given module path and version]:droprequire' \
                  '*-exclude=[add an exclusion for the given module path and version]:exclude' \
                  '*-dropexclude=[drop an exclusion for the given module path and version]:dropexclude' \
                  '*-replace=[add a replacement of the given module path and version]:replace' \
                  '*-dropreplace=[drop a replacement of the given module path and version]:dropreplace' \
                  '-json[prints the final go.mod file in JSON format]' \
                  '-print[prints the final go.mod in its text format]' \
                  ':go.mod:_path_files -g "go.mod"'
                ;;
              graph)
                ;;
              init)
                # Use go packages as module name suggestion
                _arguments \
                  '*:module:__go_packages'
                ;;
              tidy)
                _arguments \
                  '-v[print information about removed modules to standard error]' \
                  '-e[attempt to proceed despite errors encountered while loading packages]'
                ;;
              vendor)
                _arguments \
                  '-v[print the names of vendored modules and packages to standard error]' \
                  '-e[attempt to proceed despite errors encountered while loading packages]'
                ;;
              verify)
                ;;
              why)
                _arguments \
                  '-m[treats the arguments as a list of modules]' \
                  '-vendor[exclude tests of dependencies]' \
                  '*:module:__go_packages'
                ;;
            esac
            ;;
        esac
        ;;

      run)
        _arguments \
          ${build_flags[@]} \
          '-exec[invoke the binary using xprog]:xporg' \
          '*:importpaths:__go_packages'
          ;;

      test)
        if [[ $words[$CURRENT] = -test.* ]]; then
          _arguments \
            '-test.bench[run only benchmarks matching regexp]:regexp' \
            '-test.benchmem[print memory allocations for benchmarks]' \
            '-test.benchtime[run each benchmark for duration d (default 1s)]:d' \
            '-test.blockprofile[write a goroutine blocking profile to file]:file:_files' \
            '-test.blockprofilerate[set blocking profile rate (see runtime.SetBlockProfileRate) (default 1)]:rate' \
            '-test.count[run tests and benchmarks n times (default 1)]:n' \
            '-test.coverprofile[write a coverage profile to file]:file:_files' \
            '-test.cpu[comma-separated list of cpu counts to run each test with]:comma-separated list' \
            '-test.cpuprofile[write a cpu profile to file]:file:_files' \
            '-test.failfast[do not start new tests after the first test failure]' \
            '-test.list[list tests, examples, and benchmarks matching regexp then exit]:regexp' \
            '-test.memprofile[write an allocation profile to file]:file:_files' \
            '-test.memprofilerate[set memory allocation profiling rate (see runtime.MemProfileRate)]:rate' \
            '-test.mutexprofile[write a mutex contention profile to the named file after execution]:string' \
            '-test.mutexprofilefraction[if >= 0, calls runtime.SetMutexProfileFraction() (default 1)]:int' \
            '-test.outputdir[write profiles to dir]:dir:_path_files -/' \
            '-test.parallel[run at most n tests in parallel (default 4)]:n' \
            '-test.run[run only tests and examples matching regexp]:regexp' \
            '-test.short[run smaller test suite to save time]' \
            '-test.testlogfile[write test action log to file (for use only by cmd/go)]:file' \
            '-test.timeout[panic test binary after duration d (default 0, timeout disabled)]:d' \
            '-test.trace[write an execution trace to file]:file' \
            '-test.v[verbose: print additional output]'
        else
          _arguments \
            "-c[compile but don't run test]" \
            '-i[install dependencies of the test]' \
            '-bench[run benchmarks matching the regular expression]:regexp' \
            '-benchmem[print memory allocation statistics for benchmarks]' \
            '-benchtime[run benchmarks for t rime]:t' \
            '-blockprofile[write a goroutine blocking profile to the specified file]:block' \
            '-blockprofilerate[control goroutine blocking profiles]:n' \
            '-count[run each test and benchmark n times]:n' \
            '-cover[enable coverage analysis]' \
            '-covermode[set the mode for coverage analysis]:mode:(set count atomic)' \
            '-coverpkg[apply coverage analysis in each test of listed packages]:list' \
            '-coverprofile[write a coverage profile to file]:cover' \
            '-cpu[specify a list of GOMAXPROCS values]:cpus' \
            '-cpuprofile[write a CPU profile to the specified file]:profile' \
            '-memprofile[write a memory profile to file]:mem' \
            '-memprofilerate[enable more precise memory profiles]:n' \
            '-outputdir[place output files from profiling in output dir]:dir' \
            '-parallel[allow parallel execution of test functions]:n' \
            '-run[run tests and examples matching the regular expression]:regexp' \
            '-short[tell long-running tests to shorten their run time]' \
            '-test.-[specify options for test running]:test running options:' \
            '-timeout[timeout long running tests]:t' \
            '-trace[write an execution trace to the specified file]:trace' \
            '-v[verbose output]' \
            ${build_flags[@]} \
            '-exec[run test binary using xprog]:xprog' \
            '-o[compile test binary to named file]:file:_files' \
            '*:importpaths:__go_packages'
        fi
          ;;

      tool)
        local -a tools
        tools=($(go tool))

        _arguments \
          '-n[print command that would be executed]' \
          "1: :{_describe 'tool' tools}" \
          '*:: :->args'

        case $state in
          args)
            case $words[1] in
              addr2line)
                _files
                ;;

              asm)
                _arguments \
                  '-D[predefined symbol with optional simple value]:value' \
                  '-I[include directory]:value' \
                  '-S[print assembly and machine code]' \
                  '-debug[dump instructions as they are parsed]' \
                  '-dynlink[support references to Go symbols]' \
                  '-o[output file]:string' \
                  '-shared[generate code that can be linked into a shared lib]' \
                  '-trimpath[remove prefix from recorded source file paths]:string'
                ;;

              callgraph)
                local -a algos graphs
                algos=(
                'static:static calls only'
                'cha:Class Hierarchy Analysis'
                'rta:Rapid Type Analysis'
                'pta:inclusion-based Points-To Analysis'
                )
                graphs=(
                'digraph:output in digraph format'
                'graphviz:output in AT&T GraphViz (.dot) format'
                )

                _arguments \
                  '-algo=[call-graph construction algorithm]:algos:{ _describe "algos" algos }' \
                  "-test[include the package's tests in the analysis]" \
                  '-format=[format in which each call graph edge is displayed]:graphs:{ _describe "graphs" graphs }'
                ;;

              cgo)
                _arguments \
                  '-debug-define[print relevant #defines]' \
                  '-debug-gcc[print gcc invocations]' \
                  '-dynimport[if non-empty, print dynamic import data]:string' \
                  '-dynlinker[record dynamic linker information]' \
                  '-dynout[write -dynimport output to file]:file' \
                  '-dynpackage[set Go package for -dynimport output]:string' \
                  '-exportheader[where to write export header]:string' \
                  '-gccgo[generate files for use with gccgo]' \
                  '-gccgopkgpath[-fgo-pkgpath option used with gccgo]:string' \
                  '-gccgoprefix[-fgo-prefix option used with gccgo]:string' \
                  '-godefs[write Go definitions for C file to stdout]' \
                  '-import_runtime_cgo[import runtime/cgo in generated code]' \
                  '-import_syscall[import syscall in generated code]' \
                  '-importpath[import path of package being built]:path' \
                  '-objdir[object directory]:dir'
                ;;

              compile)
                _arguments \
                  '-%[debug non-static initializers]' \
                  '-+[compiling runtime]' \
                  "-A[for bootstrapping, allow 'any' type]" \
                  '-B[disable bounds checking]' \
                  '-D[set relative path for local imports]:path' \
                  '-E[debug symbol export]' \
                  '-I[add directory to import search path]:directory' \
                  '-K[debug missing line numbers]' \
                  '-L[use full (long) path in error messages]' \
                  '-M[debug move generation]' \
                  '-N[disable optimizations]' \
                  '-P[debug peephole optimizer]' \
                  '-R[debug register optimizer]' \
                  '-S[print assembly listing]' \
                  '-V[print compiler version]' \
                  '-W[debug parse tree after type checking]' \
                  '-asmhdr[write assembly header to file]:file' \
                  '-buildid[record id as the build id in the export metadata]:id' \
                  '-complete[compiling complete package (no C or assembly)]' \
                  '-cpuprofile[write cpu profile to file]:file' \
                  '-d[print debug information about items in list]:list' \
                  '-dynlink[support references to Go symbols]' \
                  '-e[no limit on number of errors reported]' \
                  '-f[debug stack frames]' \
                  '-g[debug code generation]' \
                  '-h[halt on error]' \
                  '-i[debug line number stack]' \
                  '-importmap[add definition of the form source=actual to import map]:definition' \
                  '-installsuffix[set pkg directory suffix]:suffix' \
                  '-j[debug runtime-initialized variables]' \
                  '-l[disable inlining]' \
                  '-largemodel[generate code that assumes a large memory model]' \
                  '-live[debug liveness analysis]' \
                  '-m[print optimization decisions]' \
                  '-memprofile[write memory profile to file]:file' \
                  '-memprofilerate[set runtime.MemProfileRate to rate]:rate' \
                  '-nolocalimports[reject local (relative) imports]' \
                  '-o[write output to file]:file' \
                  '-p[set expected package import path]:path' \
                  '-pack[write package file instead of object file]' \
                  '-r[debug generated wrappers]' \
                  '-race[enable race detector]' \
                  '-s[warn about composite literals that can be simplified]' \
                  '-shared[generate code that can be linked into a shared library]' \
                  '-trimpath[remove prefix from recorded source file paths]:prefix' \
                  '-u[reject unsafe code]' \
                  '-v[increase debug verbosity]' \
                  '-w[debug type checking]' \
                  '-wb[enable write barrier (default 1)]' \
                  '-x[debug lexer]' \
                  '-y[debug declarations in canned imports (with -d)]' \
                  '*:file:_files -g "*.go(-.)"'
                ;;

              cover)
                if (( CURRENT == 2 )); then
                  _arguments \
                    '-func=[output coverage profile information for each function]:string' \
                    '-html=[generate HTML representation of coverage profile]:file:_files' \
                    '-mode=[coverage mode]:mode:(set count atomic)'
                  return
                fi

                _arguments \
                  '-o[file for output]:file' \
                  '-var=[name of coverage variable to generate]:var' \
                  '*:file:_files -g "*.go(-.)"'
                ;;

              doc)
                _arguments \
                  '-c[respect case when matching symbols]' \
                  '-cmd[treat a command (package main) like a regular package]' \
                  '-u[show docs for unexported and exported symbols and methods]' \
                  ;;

              fix)
                _arguments \
                  '-diff[display diffs instead of rewriting files]' \
                  '-force[force fixes to run even if the code looks updated]:string' \
                  '-r[restrict the rewrites]:string' \
                  '*:files:_files'
                ;;

              link)
                _arguments \
                  '-B[add an ELF NT_GNU_BUILD_ID note when using ELF]:note' \
                  '-C[check Go calls to C code]' \
                  '-D[set data segment address (default -1)]:address' \
                  '-E[set entry symbol name]:entry' \
                  '-H[set header type]:type' \
                  '-I[use linker as ELF dynamic linker]:linker' \
                  '-L[add specified directory to library path]:directory' \
                  '-R[set address rounding quantum (default -1)]:quantum' \
                  '-T[set text segment address (default -1)]:address' \
                  '-V[print version and exit]' \
                  '-W[disassemble input]' \
                  '-X[add string value definition]:definition' \
                  '-a[disassemble output]' \
                  '-buildid[record id as Go toolchain build id]:id' \
                  '-buildmode[set build mode]:mode' \
                  '-c[dump call graph]' \
                  '-cpuprofile[write cpu profile to file]:file' \
                  '-d[disable dynamic executable]' \
                  '-extld[use linker when linking in external mode]:linker' \
                  '-extldflags[pass flags to external linker]:flags' \
                  '-f[ignore version mismatch]' \
                  '-g[disable go package data checks]' \
                  '-h[halt on error]' \
                  '-installsuffix[set package directory suffix]:suffix' \
                  '-k[set field tracking symbol]:symbol' \
                  '-linkmode[set link mode]:mode:(internal external auto)' \
                  '-linkshared[link against installed Go shared libraries]' \
                  '-memprofile[write memory profile to file]:file' \
                  '-memprofilerate[set runtime.MemProfileRate to rate]:rate' \
                  '-n[dump symbol table]' \
                  '-o[write output to file]:file' \
                  '-r[set the ELF dynamic linker search path to dir1:dir2:...]:path' \
                  '-race[enable race detector]' \
                  '-s[disable symbol table]' \
                  '-shared[generate shared object (implies -linkmode external)]' \
                  '-tmpdir[use directory for temporary files]:directory' \
                  '-u[reject unsafe packages]' \
                  '-v[print link trace]' \
                  '-w[disable DWARF generation]' \
                  '*:files:_files'
                ;;

              objdump)
                _arguments \
                  '-s[only dump symbols matching this regexp]:regexp' \
                  '*:files:_files'
                ;;

              pack)
                _arguments '1:ops:(c p r t x)' '::verbose:(v)' ':files:_files'
                ;;

              pprof)
                _arguments \
                  '-callgrind[outputs a graph in callgrind format]' \
                  '-disasm=[output annotated assembly]:p' \
                  '-dot[outputs a graph in DOT format]' \
                  '-eog[visualize graph through eog]' \
                  '-evince[visualize graph through evince]' \
                  '-gif[outputs a graph image in GIF format]' \
                  '-gv[visualize graph through gv]' \
                  '-list=[output annotated source for functions matching regexp]:p' \
                  '-pdf[outputs a graph in PDF format]' \
                  '-peek=[output callers/callees of functions matching regexp]:p' \
                  '-png[outputs a graph image in PNG format]' \
                  '-proto[outputs the profile in compressed protobuf format]' \
                  '-ps[outputs a graph in PS format]' \
                  '-raw[outputs a text representation of the raw profile]' \
                  '-svg[outputs a graph in SVG format]' \
                  '-tags[outputs all tags in the profile]' \
                  '-text[outputs top entries in text form]' \
                  '-top[outputs top entries in text form]' \
                  '-tree[outputs a text rendering of call graph]' \
                  '-web[visualize graph through web browser]' \
                  '-weblist=[output annotated source in HTML]:p' \
                  '-output=[generate output on file f (stdout by default)]:f' \
                  '-functions[report at function level (default)]' \
                  '-files[report at source file level]' \
                  '-lines[report at source line level]' \
                  '-addresses[report at address level]' \
                  '-base[show delta from this profile]:profile' \
                  '-drop_negative[ignore negative differences]' \
                  '-cum[sort by cumulative data]' \
                  '-seconds=[length of time for dynamic profiles]:n' \
                  '-nodecount=[max number of nodes to show]:n' \
                  '-nodefraction=[hide nodes below <f>*total]:f' \
                  '-edgefraction=[hide edges below <f>*total]:f' \
                  '-sample_index[index of sample value to display]' \
                  '-mean[average sample value over first value]' \
                  '-inuse_space[display in-use memory size]' \
                  '-inuse_objects[display in-use object counts]' \
                  '-alloc_space[display allocated memory size]' \
                  '-alloc_objects[display allocated object counts]' \
                  '-total_delay[display total delay at each region]' \
                  '-contentions[display number of delays at each region]' \
                  '-mean_delay[display mean delay at each region]' \
                  '-runtime[show runtime call frames in memory profiles]' \
                  '-focus=[restricts to paths going through a node matching regexp]:r' \
                  '-ignore=[skips paths going through any nodes matching regexp]:r' \
                  '-tagfocus=[restrict to samples tagged with key:value matching regexp]:r' \
                  '-tagignore=[discard samples tagged with key:value matching regexp]' \
                  '-call_tree[generate a context-sensitive call tree]' \
                  '-unit=[convert all samples to unit u for display]:u' \
                  '-divide_by=[scale all samples by dividing them by f]:f' \
                  '-buildid=[override build id for main binary in profile]:id' \
                  '-tools=[search path for object-level tools]:path' \
                  '-help[help message]' \
                  '*:files:_files'
                ;;

              trace)
                _arguments \
                  '-http=[HTTP service address]:addr' \
                  '*:files:_files'
                ;;

              vet)
                _arguments \
                  '-all[check everything]' \
                  '-asmdecl[check assembly against Go declarations]' \
                  '-assign[check for useless assignments]' \
                  '-atomic[check for common mistaken usages of the sync/atomic]' \
                  '-bool[check for mistakes involving boolean operators]' \
                  '-buildtags[check that +build tags are valid]' \
                  '-composites[check that composite literals used field-keyed elements]' \
                  '-compositewhitelist[use composite white list]' \
                  '-copylocks[check that locks are not passed by value]' \
                  '-methods[check that canonically named methods are canonically defined]' \
                  '-nilfunc[check for comparisons between functions and nil]' \
                  '-printf[check printf-like invocations]' \
                  '-printfuncs[print function names to check]:string' \
                  '-rangeloops[check that range loop variables are used correctly]' \
                  '-shadow[check for shadowed variables]' \
                  '-shadowstrict[whether to be strict about shadowing]' \
                  '-shift[check for useless shifts]' \
                  '-structtags[check that struct field tags have canonical format]' \
                  '-tags[list of build tags to apply when parsing]:list' \
                  '-test[for testing only: sets -all and -shadow]' \
                  '-unreachable[check for unreachable code]' \
                  '-unsafeptr[check for misuse of unsafe.Pointer]' \
                  '-unusedfuncs[list of functions whose results must be used]:string' \
                  '-unusedresult[check for unused result of calls to functions in -unusedfuncs]' \
                  '-unusedstringmethods[list of methods whose results must be used]:string' \
                  '-v[verbose]' \
                  '*:files:_files'
                ;;

              yacc)
                _arguments \
                  '-o[output]:output' \
                  '-v[parsetable]:parsetable' \
                  '*:files:_files'
                ;;
            esac
            ;;
        esac
        ;;

      vet)
        _arguments \
          '-n[print commands that would be executed]' \
          '-x[prints commands as they are executed]' \
          ${build_flags[@]} \
          '*:importpaths:__go_packages'
          ;;
      help)
        local -a topics
        topics=(
        'buildmode:build modes'
        'c:calling between Go and C'
        'cache:build and test caching'
        'environment:environment variables'
        'filetype:file types'
        'go.mod:the go.mod file'
        'gopath:GOPATH environment variable'
        'gopath-get:legacy GOPATH go get'
        'goproxy:module proxy protocol'
        'importpath:import path syntax'
        'modules:modules, module versions, and more'
        'module-get:module-aware go get'
        'module-auth:module authentication using go.sum'
        'module-private:module configuration for non-public modules'
        'packages:package lists and patterns'
        'testflag:testing flags'
        'testfunc:testing functions'
        )

        _arguments "1: :{_describe 'command' commands -- topics}"
        ;;
    esac
    ;;
esac

# Local Variables:
# mode: Shell-Script
# sh-indentation: 2
# indent-tabs-mode: nil
# sh-basic-offset: 2
# End:
# vim: ft=zsh sw=2 ts=2 et
