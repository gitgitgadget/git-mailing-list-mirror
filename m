Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3284C1F462
	for <e@80x24.org>; Tue, 18 Jun 2019 12:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729229AbfFRMYO (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 08:24:14 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:39338 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729176AbfFRMYI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 08:24:08 -0400
Received: by mail-ed1-f43.google.com with SMTP id m10so21453548edv.6
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 05:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eJ9DQSD72An4l0+TtPbcaP4Evus7jl+XGpkwHZpUNGk=;
        b=fBh3u/wpqUHPl0HaUSbt+HmMvJTjmgw4oCrrmopl4k6lFuCU0OMxf9LRyCmC6MlsLK
         lQ9TdPJzf9RaDfUmV1gHT0PhJakkat0TO4m4I+XY0M8v1aK2tCKnd3+uUM9j3/omIR+d
         vW/7ljDYx8MX+3TLnqF+/YbJTPpB6tuPrJM6pXyfP6Hgtw7I8KSfz6bm4IO7iXIJ6Uo6
         JM2GpY/hWlUetpFdIoO1lrAHDt8i40qtKhaMbaI1wiInOUKdKWhXZPvDVOPVO3xmIBup
         CO4Pu84L/EDlT6W1563VmMfiL99Snmz232St/xETFqFmcrnhi5SlcSnHWfy+SiD59Apf
         m6VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eJ9DQSD72An4l0+TtPbcaP4Evus7jl+XGpkwHZpUNGk=;
        b=stXQjXCe1FAedQJZ0tibwcJDeSJD9GznHz3tQyvh2eSibW6u0Ox2QnKRadb0k2G+tY
         hxoW5BDMS+QVn61e6A8IQP38LukyPzT77PTPRJWvjUaiCM7dmmS8t+q8v83/NVp9QO9L
         0LgTKmlVZXaxnqMjI8BrhoR9IpXt4iS4MYaEfabt2D95tvr8oozhuPVF3okZCbJc0F5+
         7qG1gnU/wXrHV95qu2/RCRw6EM4pM6GHD37nBpiOXv0lja0ij4kCkuIa6mzV3TS70Efj
         xwz4p+HB3ZfU8T5PRvpwsG2CKR10wZAFJsBRoCJc0G0oZC7RcQczKSLjcfW1YDXG3KFT
         8kuA==
X-Gm-Message-State: APjAAAUvz5UYeP6Muac+un4EUWTSVLWKH8TwThDddTBaT37PY8Lv33ke
        jeQM7D8sEWsO5KZWH8uXIKJIIMkT
X-Google-Smtp-Source: APXvYqwovykXiRDFV390920418ZkTQ/y/+F5WUcNZpu23e4WzouDjU6dos7aGXrCoEDxDTZzEWp+hQ==
X-Received: by 2002:a05:6402:609:: with SMTP id n9mr69881798edv.159.1560860645072;
        Tue, 18 Jun 2019 05:24:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q14sm2802353eju.47.2019.06.18.05.24.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 05:24:04 -0700 (PDT)
Date:   Tue, 18 Jun 2019 05:24:04 -0700 (PDT)
X-Google-Original-Date: Tue, 18 Jun 2019 12:23:50 GMT
Message-Id: <587cbcf61903693139ad4a02b32727bddd6d116d.1560860634.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.149.git.gitgitgadget@gmail.com>
References: <pull.149.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 13/17] msvc: support building Git using MS Visual C++
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

With this patch, Git can be built using the Microsoft toolchain, via:

	make MSVC=1 [DEBUG=1]

Third party libraries are built from source using the open source
"vcpkg" tool set. See https://github.com/Microsoft/vcpkg

On a first build, the vcpkg tools and the third party libraries are
automatically downloaded and built. DLLs for the third party libraries
are copied to the top-level (and t/helper) directory to facilitate
debugging. See compat/vcbuild/README.

A series of .bat files are invoked by the Makefile to find the location
of the installed version of Visual Studio and the associated compiler
tools (essentially replicating the environment setup performed by a
"Developer Command Prompt"). This should find the most recent VS2015 or
VS2017 installation. Output from these scripts are used by the Makefile
to define compiler and linker pathnames and -I and -L arguments.

The build produces .pdb files for both debug and release builds.

Note: This commit was squashed from an organic series of commits
developed between 2016 and 2018 in Git for Windows' `master` branch.
This combined commit eliminates the obsolete commits related to fetching
NuGet packages for third party libraries. It is difficult to use NuGet
packages for C/C++ sources because they may be built by earlier versions
of the MSVC compiler and have CRT version and linking issues.

Additionally, the C/C++ NuGet packages that we were using tended to not
be updated concurrently with the sources.  And in the case of cURL and
OpenSSL, this could expose us to security issues.

Helped-by: Yue Lin Ho <b8732003@student.nsysu.edu.tw>
Helped-by: Philip Oakley <philipoakley@iee.org>
Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile                           |  42 ++++++-
 compat/mingw.c                     |  12 ++
 compat/vcbuild/.gitignore          |   3 +
 compat/vcbuild/README              |  51 +++++++++
 compat/vcbuild/find_vs_env.bat     | 169 +++++++++++++++++++++++++++++
 compat/vcbuild/scripts/clink.pl    |  41 ++++++-
 compat/vcbuild/vcpkg_copy_dlls.bat |  39 +++++++
 compat/vcbuild/vcpkg_install.bat   |  80 ++++++++++++++
 config.mak.uname                   |  74 +++++++++++--
 git-compat-util.h                  |   9 ++
 10 files changed, 504 insertions(+), 16 deletions(-)
 create mode 100644 compat/vcbuild/.gitignore
 create mode 100644 compat/vcbuild/find_vs_env.bat
 create mode 100644 compat/vcbuild/vcpkg_copy_dlls.bat
 create mode 100644 compat/vcbuild/vcpkg_install.bat

diff --git a/Makefile b/Makefile
index 8a7e235352..7777af7d0e 100644
--- a/Makefile
+++ b/Makefile
@@ -1240,7 +1240,7 @@ endif
 
 ifdef SANE_TOOL_PATH
 SANE_TOOL_PATH_SQ = $(subst ','\'',$(SANE_TOOL_PATH))
-BROKEN_PATH_FIX = 's|^\# @@BROKEN_PATH_FIX@@$$|git_broken_path_fix $(SANE_TOOL_PATH_SQ)|'
+BROKEN_PATH_FIX = 's|^\# @@BROKEN_PATH_FIX@@$$|git_broken_path_fix "$(SANE_TOOL_PATH_SQ)"|'
 PATH := $(SANE_TOOL_PATH):${PATH}
 else
 BROKEN_PATH_FIX = '/^\# @@BROKEN_PATH_FIX@@$$/d'
@@ -2873,6 +2873,33 @@ install: all
 	$(INSTALL) $(ALL_PROGRAMS) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 	$(INSTALL) -m 644 $(SCRIPT_LIB) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 	$(INSTALL) $(install_bindir_programs) '$(DESTDIR_SQ)$(bindir_SQ)'
+ifdef MSVC
+	# We DO NOT install the individual foo.o.pdb files because they
+	# have already been rolled up into the exe's pdb file.
+	# We DO NOT have pdb files for the builtin commands (like git-status.exe)
+	# because it is just a copy/hardlink of git.exe, rather than a unique binary.
+	$(INSTALL) git.pdb '$(DESTDIR_SQ)$(bindir_SQ)'
+	$(INSTALL) git-shell.pdb '$(DESTDIR_SQ)$(bindir_SQ)'
+	$(INSTALL) git-upload-pack.pdb '$(DESTDIR_SQ)$(bindir_SQ)'
+	$(INSTALL) git-credential-store.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
+	$(INSTALL) git-daemon.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
+	$(INSTALL) git-fast-import.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
+	$(INSTALL) git-http-backend.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
+	$(INSTALL) git-http-fetch.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
+	$(INSTALL) git-http-push.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
+	$(INSTALL) git-imap-send.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
+	$(INSTALL) git-remote-http.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
+	$(INSTALL) git-remote-testsvn.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
+	$(INSTALL) git-sh-i18n--envsubst.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
+	$(INSTALL) git-show-index.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
+ifndef DEBUG
+	$(INSTALL) $(vcpkg_rel_bin)/*.dll '$(DESTDIR_SQ)$(bindir_SQ)'
+	$(INSTALL) $(vcpkg_rel_bin)/*.pdb '$(DESTDIR_SQ)$(bindir_SQ)'
+else
+	$(INSTALL) $(vcpkg_dbg_bin)/*.dll '$(DESTDIR_SQ)$(bindir_SQ)'
+	$(INSTALL) $(vcpkg_dbg_bin)/*.pdb '$(DESTDIR_SQ)$(bindir_SQ)'
+endif
+endif
 	$(MAKE) -C templates DESTDIR='$(DESTDIR_SQ)' install
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(mergetools_instdir_SQ)'
 	$(INSTALL) -m 644 mergetools/* '$(DESTDIR_SQ)$(mergetools_instdir_SQ)'
@@ -3085,6 +3112,19 @@ endif
 	$(RM) GIT-VERSION-FILE GIT-CFLAGS GIT-LDFLAGS GIT-BUILD-OPTIONS
 	$(RM) GIT-USER-AGENT GIT-PREFIX
 	$(RM) GIT-SCRIPT-DEFINES GIT-PERL-DEFINES GIT-PERL-HEADER GIT-PYTHON-VARS
+ifdef MSVC
+	$(RM) $(patsubst %.o,%.o.pdb,$(OBJECTS))
+	$(RM) $(patsubst %.exe,%.pdb,$(OTHER_PROGRAMS))
+	$(RM) $(patsubst %.exe,%.iobj,$(OTHER_PROGRAMS))
+	$(RM) $(patsubst %.exe,%.ipdb,$(OTHER_PROGRAMS))
+	$(RM) $(patsubst %.exe,%.pdb,$(PROGRAMS))
+	$(RM) $(patsubst %.exe,%.iobj,$(PROGRAMS))
+	$(RM) $(patsubst %.exe,%.ipdb,$(PROGRAMS))
+	$(RM) $(patsubst %.exe,%.pdb,$(TEST_PROGRAMS))
+	$(RM) $(patsubst %.exe,%.iobj,$(TEST_PROGRAMS))
+	$(RM) $(patsubst %.exe,%.ipdb,$(TEST_PROGRAMS))
+	$(RM) compat/vcbuild/MSVC-DEFS-GEN
+endif
 
 .PHONY: all install profile-clean cocciclean clean strip
 .PHONY: shell_compatibility_test please_set_SHELL_PATH_to_a_more_modern_shell
diff --git a/compat/mingw.c b/compat/mingw.c
index d14d33308d..667285887a 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2388,6 +2388,12 @@ static void maybe_redirect_std_handles(void)
 				  GENERIC_WRITE, FILE_FLAG_NO_BUFFERING);
 }
 
+#ifdef _MSC_VER
+#ifdef _DEBUG
+#include <crtdbg.h>
+#endif
+#endif
+
 /*
  * We implement wmain() and compile with -municode, which would
  * normally ignore main(), but we call the latter from the former
@@ -2405,6 +2411,12 @@ int wmain(int argc, const wchar_t **wargv)
 
 	trace2_initialize_clock();
 
+#ifdef _MSC_VER
+#ifdef USE_MSVC_CRTDBG
+	_CrtSetDbgFlag(_CRTDBG_ALLOC_MEM_DF | _CRTDBG_LEAK_CHECK_DF);
+#endif
+#endif
+
 	maybe_redirect_std_handles();
 
 	/* determine size of argv and environ conversion buffer */
diff --git a/compat/vcbuild/.gitignore b/compat/vcbuild/.gitignore
new file mode 100644
index 0000000000..8f8b794ef3
--- /dev/null
+++ b/compat/vcbuild/.gitignore
@@ -0,0 +1,3 @@
+/vcpkg/
+/MSVC-DEFS-GEN
+/VCPKG-DEFS
diff --git a/compat/vcbuild/README b/compat/vcbuild/README
index 60fd873fe8..81da36a93b 100644
--- a/compat/vcbuild/README
+++ b/compat/vcbuild/README
@@ -1,3 +1,54 @@
+The Steps to Build Git with VS2015 or VS2017 from the command line.
+
+1. Install the "vcpkg" open source package manager and build essential
+   third-party libraries.  The steps for this have been captured in a
+   set of convenience scripts.  These can be run from a stock Command
+   Prompt or from an SDK bash window:
+
+   $ cd <repo_root>
+   $ ./compat/vcbuild/vcpkg_install.bat
+
+   The vcpkg tools and all of the third-party sources will be installed
+   in this folder:
+      <repo_root>/compat/vcbuild/vcpkg/
+
+   A file will be created with a set of Makefile macros pointing to a
+   unified "include", "lib", and "bin" directory (release and debug) for
+   all of the required packages.  This file will be included by the main
+   Makefile:
+      <repo_root>/compat/vcbuild/MSVC-DEFS-GEN
+
+2. OPTIONALLY copy the third-party *.dll and *.pdb files into the repo
+   root to make it easier to run and debug git.exe without having to
+   manipulate your PATH.  This is especially true for debug sessions in
+   Visual Studio.
+
+   Use ONE of the following forms which should match how you want to
+   compile git.exe.
+
+   $ ./compat/vcbuild/vcpkg_copy_packages.bat debug
+   $ ./compat/vcbuild/vcpkg_copy_packages.bat release
+
+3. Build git using MSVC from an SDK bash window using one of the
+   following commands:
+
+   $ make MSVC=1
+   $ make MSVC=1 DEBUG=1
+
+================================================================
+
+Alternatively, run `make MSVC=1 vcxproj` and then load the generated
+git.sln in Visual Studio. The initial build will install the vcpkg
+system and build the dependencies automatically. This will take a while.
+
+Note that this will automatically add and commit the generated
+.sln and .vcxproj files to the repo.  You may want to drop this
+commit before submitting a Pull Request....
+
+Or maybe we should put the .sln/.vcxproj files in the .gitignore file
+and not do this.  I'm not sure.
+
+================================================================
 The Steps of Build Git with VS2008
 
 1. You need the build environment, which contains the Git dependencies
diff --git a/compat/vcbuild/find_vs_env.bat b/compat/vcbuild/find_vs_env.bat
new file mode 100644
index 0000000000..1232f200f7
--- /dev/null
+++ b/compat/vcbuild/find_vs_env.bat
@@ -0,0 +1,169 @@
+@ECHO OFF
+REM ================================================================
+REM You can use either GCC (the default) or MSVC to build git
+REM using the GIT-SDK command line tools.
+REM        $ make
+REM        $ make MSVC=1
+REM
+REM GIT-SDK BASH windows inherit environment variables with all of
+REM the bin/lib/include paths for GCC.  It DOES NOT inherit values
+REM for the corresponding MSVC tools.
+REM
+REM During normal (non-git) Windows development, you launch one
+REM of the provided "developer command prompts" to set environment
+REM variables for the MSVC tools.
+REM
+REM Therefore, to allow MSVC command line builds of git from BASH
+REM and MAKE, we must blend these two different worlds.  This script
+REM attempts to do that.
+REM ================================================================
+REM This BAT file starts in a plain (non-developer) command prompt,
+REM searches for the "best" commmand prompt setup script, installs
+REM it into the current CMD process, and exports the various MSVC
+REM environment variables for use by MAKE.
+REM
+REM The output of this script should be written to a make "include
+REM file" and referenced by the top-level Makefile.
+REM
+REM See "config.mak.uname" (look for compat/vcbuild/MSVC-DEFS-GEN).
+REM ================================================================
+REM The provided command prompts are custom to each VS release and
+REM filled with lots of internal knowledge (such as Registry settings);
+REM even their names vary by release, so it is not appropriate for us
+REM to look inside them.  Rather, just run them in a subordinate
+REM process and extract the settings we need.
+REM ================================================================
+REM
+REM Current (VS2017 and beyond)
+REM -------------------
+REM Visual Studio 2017 introduced a new installation layout and
+REM support for side-by-side installation of multiple versions of
+REM VS2017.  Furthermore, these can all coexist with installations
+REM of previous versions of VS (which have a completely different
+REM layout on disk).
+REM
+REM VS2017 Update 2 introduced a "vswhere.exe" command:
+REM https://github.com/Microsoft/vswhere
+REM https://blogs.msdn.microsoft.com/heaths/2017/02/25/vswhere-available/
+REM https://blogs.msdn.microsoft.com/vcblog/2017/03/06/finding-the-visual-c-compiler-tools-in-visual-studio-2017/
+REM
+REM VS2015
+REM ------
+REM Visual Studio 2015 uses the traditional VcVarsAll.
+REM
+REM Earlier Versions
+REM ----------------
+REM TODO
+REM
+REM ================================================================
+REM Note: Throughout this script we use "dir <path> && <cmd>" rather
+REM than "if exist <path>" because of script problems with pathnames
+REM containing spaces.
+REM ================================================================
+
+REM Sanitize PATH to prevent git-sdk paths from confusing "wmic.exe"
+REM (called internally in some of the system BAT files).
+SET PATH=%SystemRoot%\system32;%SystemRoot%;%SystemRoot%\System32\Wbem;
+
+REM ================================================================
+
+:current
+   SET vs_where=C:\Program Files (x86)\Microsoft Visual Studio\Installer\vswhere.exe
+   dir "%vs_where%" >nul 2>nul && GOTO have_vs_where
+   GOTO not_2017
+
+:have_vs_where
+   REM Try to use VsWhere to get the location of VsDevCmd.
+
+   REM Keep VsDevCmd from cd'ing away.
+   SET VSCMD_START_DIR=.
+
+   REM Get the root of the VS product installation.
+   FOR /F "usebackq tokens=*" %%i IN (`"%vs_where%" -latest -requires Microsoft.VisualStudio.Workload.NativeDesktop -property installationPath`) DO @SET vs_ip=%%i
+
+   SET vs_devcmd=%vs_ip%\Common7\Tools\VsDevCmd.bat
+   dir "%vs_devcmd%" >nul 2>nul && GOTO have_vs_devcmd
+   GOTO not_2017
+
+:have_vs_devcmd
+   REM Use VsDevCmd to setup the environment of this process.
+   REM Setup CL for building 64-bit apps using 64-bit tools.
+   @call "%vs_devcmd%" -no_logo -arch=x64 -host_arch=x64
+
+   SET tgt=%VSCMD_ARG_TGT_ARCH%
+
+   SET mn=%VCToolsInstallDir%
+   SET msvc_includes=-I"%mn%INCLUDE"
+   SET msvc_libs=-L"%mn%lib\%tgt%"
+   SET msvc_bin_dir=%mn%bin\Host%VSCMD_ARG_HOST_ARCH%\%tgt%
+
+   SET sdk_dir=%WindowsSdkDir%
+   SET sdk_ver=%WindowsSDKVersion%
+   SET si=%sdk_dir%Include\%sdk_ver%
+   SET sdk_includes=-I"%si%ucrt" -I"%si%um" -I"%si%shared"
+   SET sl=%sdk_dir%lib\%sdk_ver%
+   SET sdk_libs=-L"%sl%ucrt\%tgt%" -L"%sl%um\%tgt%"
+
+   SET vs_ver=%VisualStudioVersion%
+
+   GOTO print_vars
+
+REM ================================================================
+
+:not_2017
+   REM See if VS2015 is installed.
+
+   SET vs_2015_bat=C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat
+   dir "%vs_2015_bat%" >nul 2>nul && GOTO have_vs_2015
+   GOTO not_2015
+
+:have_vs_2015
+   REM Use VcVarsAll like the "x64 Native" command prompt.
+   REM Setup CL for building 64-bit apps using 64-bit tools.
+   @call "%vs_2015_bat%" amd64
+
+   REM Note that in VS2015 they use "x64" in some contexts and "amd64" in others.
+   SET mn=C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\
+   SET msvc_includes=-I"%mn%INCLUDE"
+   SET msvc_libs=-L"%mn%lib\amd64"
+   SET msvc_bin_dir=%mn%bin\amd64
+
+   SET sdk_dir=%WindowsSdkDir%
+   SET sdk_ver=%WindowsSDKVersion%
+   SET si=%sdk_dir%Include\%sdk_ver%
+   SET sdk_includes=-I"%si%ucrt" -I"%si%um" -I"%si%shared" -I"%si%winrt"
+   SET sl=%sdk_dir%lib\%sdk_ver%
+   SET sdk_libs=-L"%sl%ucrt\x64" -L"%sl%um\x64"
+
+   SET vs_ver=%VisualStudioVersion%
+
+   GOTO print_vars
+
+REM ================================================================
+
+:not_2015
+   REM TODO....
+   echo TODO support older versions of VS. >&2
+   EXIT /B 1
+
+REM ================================================================
+
+:print_vars
+   REM Dump the essential vars to stdout to allow the main
+   REM Makefile to include it.  See config.mak.uname.
+   REM Include DOS-style and BASH-style path for bin dir.
+
+   echo msvc_bin_dir=%msvc_bin_dir%
+   SET X1=%msvc_bin_dir:C:=/C%
+   SET X2=%X1:\=/%
+   echo msvc_bin_dir_msys=%X2%
+
+   echo msvc_includes=%msvc_includes%
+   echo msvc_libs=%msvc_libs%
+
+   echo sdk_includes=%sdk_includes%
+   echo sdk_libs=%sdk_libs%
+
+   echo vs_ver=%vs_ver%
+
+   EXIT /B 0
diff --git a/compat/vcbuild/scripts/clink.pl b/compat/vcbuild/scripts/clink.pl
index a87d0da512..c7b021bfac 100755
--- a/compat/vcbuild/scripts/clink.pl
+++ b/compat/vcbuild/scripts/clink.pl
@@ -12,32 +12,62 @@
 use strict;
 my @args = ();
 my @cflags = ();
+my @lflags = ();
 my $is_linking = 0;
+my $is_debug = 0;
 while (@ARGV) {
 	my $arg = shift @ARGV;
-	if ("$arg" =~ /^-[DIMGO]/) {
+	if ("$arg" eq "-DDEBUG") {
+	    # Some vcpkg-based libraries have different names for release
+	    # and debug versions.  This hack assumes that -DDEBUG comes
+	    # before any "-l*" flags.
+	    $is_debug = 1;
+	}
+	if ("$arg" =~ /^-[DIMGOZ]/) {
 		push(@cflags, $arg);
 	} elsif ("$arg" eq "-o") {
 		my $file_out = shift @ARGV;
 		if ("$file_out" =~ /exe$/) {
 			$is_linking = 1;
+			# Create foo.exe and foo.pdb
 			push(@args, "-OUT:$file_out");
 		} else {
+			# Create foo.o and foo.o.pdb
 			push(@args, "-Fo$file_out");
+			push(@args, "-Fd$file_out.pdb");
 		}
 	} elsif ("$arg" eq "-lz") {
+	    if ($is_debug) {
+		push(@args, "zlibd.lib");
+	    } else{
 		push(@args, "zlib.lib");
+	    }
 	} elsif ("$arg" eq "-liconv") {
-		push(@args, "iconv.lib");
+		push(@args, "libiconv.lib");
 	} elsif ("$arg" eq "-lcrypto") {
 		push(@args, "libeay32.lib");
 	} elsif ("$arg" eq "-lssl") {
 		push(@args, "ssleay32.lib");
 	} elsif ("$arg" eq "-lcurl") {
-		push(@args, "libcurl.lib");
+		my $lib = "";
+		# Newer vcpkg definitions call this libcurl_imp.lib; Do we
+		# need to use that instead?
+		foreach my $flag (@lflags) {
+			if ($flag =~ /^-LIBPATH:(.*)/) {
+				foreach my $l ("libcurl_imp.lib", "libcurl.lib") {
+					if (-f "$1/$l") {
+						$lib = $l;
+						last;
+					}
+				}
+			}
+		}
+		push(@args, $lib);
+	} elsif ("$arg" eq "-lexpat") {
+		push(@args, "expat.lib");
 	} elsif ("$arg" =~ /^-L/ && "$arg" ne "-LTCG") {
 		$arg =~ s/^-L/-LIBPATH:/;
-		push(@args, $arg);
+		push(@lflags, $arg);
 	} elsif ("$arg" =~ /^-R/) {
 		# eat
 	} else {
@@ -45,10 +75,11 @@
 	}
 }
 if ($is_linking) {
+	push(@args, @lflags);
 	unshift(@args, "link.exe");
 } else {
 	unshift(@args, "cl.exe");
 	push(@args, @cflags);
 }
-#printf("**** @args\n");
+printf(STDERR "**** @args\n\n\n") if (!defined($ENV{'QUIET_GEN'}));
 exit (system(@args) != 0);
diff --git a/compat/vcbuild/vcpkg_copy_dlls.bat b/compat/vcbuild/vcpkg_copy_dlls.bat
new file mode 100644
index 0000000000..13661c14f8
--- /dev/null
+++ b/compat/vcbuild/vcpkg_copy_dlls.bat
@@ -0,0 +1,39 @@
+@ECHO OFF
+REM ================================================================
+REM This script is an optional step. It copies the *.dll and *.pdb
+REM files (created by vcpkg_install.bat) into the top-level directory
+REM of the repo so that you can type "./git.exe" and find them without
+REM having to fixup your PATH.
+REM
+REM NOTE: Because the names of some DLL files change between DEBUG and
+REM NOTE: RELEASE builds when built using "vcpkg.exe", you will need
+REM NOTE: to copy up the corresponding version.
+REM ================================================================
+
+	SETLOCAL EnableDelayedExpansion
+
+	@FOR /F "delims=" %%D IN ("%~dp0") DO @SET cwd=%%~fD
+	cd %cwd%
+
+	SET arch=x64-windows
+	SET inst=%cwd%vcpkg\installed\%arch%
+
+	IF [%1]==[release] (
+		echo Copying RELEASE mode DLLs to repo root...
+	) ELSE IF [%1]==[debug] (
+		SET inst=%inst%\debug
+		echo Copying DEBUG mode DLLs to repo root...
+	) ELSE (
+		echo ERROR: Invalid argument.
+		echo Usage: %~0 release
+		echo Usage: %~0 debug
+		EXIT /B 1
+	)
+
+	xcopy /e/s/v/y %inst%\bin\*.dll ..\..\
+	xcopy /e/s/v/y %inst%\bin\*.pdb ..\..\
+
+	xcopy /e/s/v/y %inst%\bin\*.dll ..\..\t\helper\
+	xcopy /e/s/v/y %inst%\bin\*.pdb ..\..\t\helper\
+
+	EXIT /B 0
diff --git a/compat/vcbuild/vcpkg_install.bat b/compat/vcbuild/vcpkg_install.bat
new file mode 100644
index 0000000000..ebd0bad242
--- /dev/null
+++ b/compat/vcbuild/vcpkg_install.bat
@@ -0,0 +1,80 @@
+@ECHO OFF
+REM ================================================================
+REM This script installs the "vcpkg" source package manager and uses
+REM it to build the third-party libraries that git requires when it
+REM is built using MSVC.
+REM
+REM [1] Install VCPKG.
+REM     [a] Create <root>/compat/vcbuild/vcpkg/
+REM     [b] Download "vcpkg".
+REM     [c] Compile using the currently installed version of VS.
+REM     [d] Create <root>/compat/vcbuild/vcpkg/vcpkg.exe
+REM
+REM [2] Install third-party libraries.
+REM     [a] Download each (which may also install CMAKE).
+REM     [b] Compile in RELEASE mode and install in:
+REM         vcpkg/installed/<arch>/{bin,lib}
+REM     [c] Compile in DEBUG mode and install in:
+REM         vcpkg/installed/<arch>/debug/{bin,lib}
+REM     [d] Install headers in:
+REM         vcpkg/installed/<arch>/include
+REM
+REM [3] Create a set of MAKE definitions for the top-level
+REM     Makefile to allow "make MSVC=1" to find the above
+REM     third-party libraries.
+REM     [a] Write vcpkg/VCPGK-DEFS
+REM
+REM https://blogs.msdn.microsoft.com/vcblog/2016/09/19/vcpkg-a-tool-to-acquire-and-build-c-open-source-libraries-on-windows/
+REM https://github.com/Microsoft/vcpkg
+REM https://vcpkg.readthedocs.io/en/latest/
+REM ================================================================
+
+	SETLOCAL EnableDelayedExpansion
+
+	@FOR /F "delims=" %%D IN ("%~dp0") DO @SET cwd=%%~fD
+	cd %cwd%
+
+	dir vcpkg\vcpkg.exe >nul 2>nul && GOTO :install_libraries
+
+	echo Fetching vcpkg in %cwd%vcpkg
+	git.exe clone https://github.com/Microsoft/vcpkg vcpkg
+	IF ERRORLEVEL 1 ( EXIT /B 1 )
+
+	cd vcpkg
+	echo Building vcpkg
+	powershell -exec bypass scripts\bootstrap.ps1
+	IF ERRORLEVEL 1 ( EXIT /B 1 )
+
+	echo Successfully installed %cwd%vcpkg\vcpkg.exe
+
+:install_libraries
+	SET arch=x64-windows
+
+	echo Installing third-party libraries...
+	FOR %%i IN (zlib expat libiconv openssl libssh2 curl) DO (
+	    cd %cwd%vcpkg
+	    IF NOT EXIST "packages\%%i_%arch%" CALL :sub__install_one %%i
+	    IF ERRORLEVEL 1 ( EXIT /B 1 )
+	)
+
+:install_defines
+	cd %cwd%
+	SET inst=%cwd%vcpkg\installed\%arch%
+
+	echo vcpkg_inc=-I"%inst%\include">VCPKG-DEFS
+	echo vcpkg_rel_lib=-L"%inst%\lib">>VCPKG-DEFS
+	echo vcpkg_rel_bin="%inst%\bin">>VCPKG-DEFS
+	echo vcpkg_dbg_lib=-L"%inst%\debug\lib">>VCPKG-DEFS
+	echo vcpkg_dbg_bin="%inst%\debug\bin">>VCPKG-DEFS
+
+	EXIT /B 0
+
+
+:sub__install_one
+	echo     Installing package %1...
+
+	.\vcpkg.exe install %1:%arch%
+	IF ERRORLEVEL 1 ( EXIT /B 1 )
+
+	echo     Finished %1
+	goto :EOF
diff --git a/config.mak.uname b/config.mak.uname
index 3310f6284c..36237711c5 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -1,5 +1,9 @@
 # Platform specific Makefile tweaks based on uname detection
 
+# Define NO_SAFESEH if you need MSVC/Visual Studio to ignore the lack of
+# Microsoft's Safe Exception Handling in libraries (such as zlib).
+# Typically required for VS2013+/32-bit compilation on Vista+ versions.
+
 uname_S := $(shell sh -c 'uname -s 2>/dev/null || echo not')
 uname_M := $(shell sh -c 'uname -m 2>/dev/null || echo not')
 uname_O := $(shell sh -c 'uname -o 2>/dev/null || echo not')
@@ -11,6 +15,19 @@ ifdef MSVC
 	# avoid the MingW and Cygwin configuration sections
 	uname_S := Windows
 	uname_O := Windows
+
+	# Generate and include makefile variables that point to the
+	# currently installed set of MSVC command line tools.
+compat/vcbuild/MSVC-DEFS-GEN: compat/vcbuild/find_vs_env.bat
+	@"$<" | tr '\\' / >"$@"
+include compat/vcbuild/MSVC-DEFS-GEN
+
+	# See if vcpkg and the vcpkg-build versions of the third-party
+	# libraries that we use are installed.  We include the result
+	# to get $(vcpkg_*) variables defined for the Makefile.
+compat/vcbuild/VCPKG-DEFS: compat/vcbuild/vcpkg_install.bat
+	@"$<"
+include compat/vcbuild/VCPKG-DEFS
 endif
 
 # We choose to avoid "if .. else if .. else .. endif endif"
@@ -356,6 +373,19 @@ endif
 ifeq ($(uname_S),Windows)
 	GIT_VERSION := $(GIT_VERSION).MSVC
 	pathsep = ;
+	# Assume that this is built in Git for Windows' SDK
+	ifeq (MINGW32,$(MSYSTEM))
+		prefix = /mingw32
+	else
+		prefix = /mingw64
+	endif
+	# Prepend MSVC 64-bit tool-chain to PATH.
+	#
+	# A regular Git Bash *does not* have cl.exe in its $PATH. As there is a
+	# link.exe next to, and required by, cl.exe, we have to prepend this
+	# onto the existing $PATH.
+	#
+	SANE_TOOL_PATH ?= $(msvc_bin_dir_msys)
 	HAVE_ALLOCA_H = YesPlease
 	NO_PREAD = YesPlease
 	NEEDS_CRYPTO_WITH_SSL = YesPlease
@@ -368,11 +398,14 @@ ifeq ($(uname_S),Windows)
 	NO_STRCASESTR = YesPlease
 	NO_STRLCPY = YesPlease
 	NO_MEMMEM = YesPlease
-	# NEEDS_LIBICONV = YesPlease
-	NO_ICONV = YesPlease
+	NEEDS_LIBICONV = YesPlease
 	NO_STRTOUMAX = YesPlease
 	NO_MKDTEMP = YesPlease
-	SNPRINTF_RETURNS_BOGUS = YesPlease
+	NO_INTTYPES_H = YesPlease
+	# VS2015 with UCRT claims that snprintf and friends are C99 compliant,
+	# so we don't need this:
+	#
+	#   SNPRINTF_RETURNS_BOGUS = YesPlease
 	NO_SVN_TESTS = YesPlease
 	RUNTIME_PREFIX = YesPlease
 	HAVE_WPGMPTR = YesWeDo
@@ -385,7 +418,6 @@ ifeq ($(uname_S),Windows)
 	NO_REGEX = YesPlease
 	NO_GETTEXT = YesPlease
 	NO_PYTHON = YesPlease
-	BLK_SHA1 = YesPlease
 	ETAGS_TARGET = ETAGS
 	NO_POSIX_GOODIES = UnfortunatelyYes
 	NATIVE_CRLF = YesPlease
@@ -394,24 +426,46 @@ ifeq ($(uname_S),Windows)
 	CC = compat/vcbuild/scripts/clink.pl
 	AR = compat/vcbuild/scripts/lib.pl
 	CFLAGS =
-	BASIC_CFLAGS = -nologo -I. -I../zlib -Icompat/vcbuild -Icompat/vcbuild/include -DWIN32 -D_CONSOLE -DHAVE_STRING_H -D_CRT_SECURE_NO_WARNINGS -D_CRT_NONSTDC_NO_DEPRECATE
+	BASIC_CFLAGS = -nologo -I. -Icompat/vcbuild/include -DWIN32 -D_CONSOLE -DHAVE_STRING_H -D_CRT_SECURE_NO_WARNINGS -D_CRT_NONSTDC_NO_DEPRECATE
 	COMPAT_OBJS = compat/msvc.o compat/winansi.o \
 		compat/win32/path-utils.o \
 		compat/win32/pthread.o compat/win32/syslog.o \
 		compat/win32/trace2_win32_process_info.o \
 		compat/win32/dirent.o
-	COMPAT_CFLAGS = -D__USE_MINGW_ACCESS -DNOGDI -DHAVE_STRING_H -Icompat -Icompat/regex -Icompat/win32 -DSTRIP_EXTENSION=\".exe\"
+	COMPAT_CFLAGS = -D__USE_MINGW_ACCESS -DDETECT_MSYS_TTY -DNOGDI -DHAVE_STRING_H -Icompat -Icompat/regex -Icompat/win32 -DSTRIP_EXTENSION=\".exe\"
 	BASIC_LDFLAGS = -IGNORE:4217 -IGNORE:4049 -NOLOGO -ENTRY:wmainCRTStartup -SUBSYSTEM:CONSOLE
-	EXTLIBS = user32.lib advapi32.lib shell32.lib wininet.lib ws2_32.lib invalidcontinue.obj
+	# invalidcontinue.obj allows Git's source code to close the same file
+	# handle twice, or to access the osfhandle of an already-closed stdout
+	# See https://msdn.microsoft.com/en-us/library/ms235330.aspx
+	EXTLIBS = user32.lib advapi32.lib shell32.lib wininet.lib ws2_32.lib invalidcontinue.obj kernel32.lib ntdll.lib
 	PTHREAD_LIBS =
 	lib =
+	BASIC_CFLAGS += $(vcpkg_inc) $(sdk_includes) $(msvc_includes)
+ifndef DEBUG
+	BASIC_CFLAGS += $(vcpkg_rel_lib)
+else
+	BASIC_CFLAGS += $(vcpkg_dbg_lib)
+endif
+	BASIC_CFLAGS += $(sdk_libs) $(msvc_libs)
+
+	# Optionally enable memory leak reporting.
+	# BASIC_CLFAGS += -DUSE_MSVC_CRTDBG
 	BASIC_CFLAGS += -DPROTECT_NTFS_DEFAULT=1
+	# Always give "-Zi" to the compiler and "-debug" to linker (even in
+	# release mode) to force a PDB to be generated (like RelWithDebInfo).
+	BASIC_CFLAGS += -Zi
+	BASIC_LDFLAGS += -debug -Zf
+
+ifdef NO_SAFESEH
+	LDFLAGS += -SAFESEH:NO
+endif
+
 ifndef DEBUG
-	BASIC_CFLAGS += -GL -Os -MD
-	BASIC_LDFLAGS += -LTCG
+	BASIC_CFLAGS += -GL -Gy -O2 -Oy- -MD -DNDEBUG
+	BASIC_LDFLAGS += -release -LTCG /OPT:REF /OPT:ICF /INCREMENTAL:NO /DEBUGTYPE:CV,FIXUP
 	AR += -LTCG
 else
-	BASIC_CFLAGS += -Zi -MDd
+	BASIC_CFLAGS += -MDd -DDEBUG -D_DEBUG
 endif
 	X = .exe
 
diff --git a/git-compat-util.h b/git-compat-util.h
index cc0e7e9733..83be89de0a 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1,6 +1,15 @@
 #ifndef GIT_COMPAT_UTIL_H
 #define GIT_COMPAT_UTIL_H
 
+#ifdef USE_MSVC_CRTDBG
+/*
+ * For these to work they must appear very early in each
+ * file -- before most of the standard header files.
+ */
+#include <stdlib.h>
+#include <crtdbg.h>
+#endif
+
 #define _FILE_OFFSET_BITS 64
 
 
-- 
gitgitgadget

