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
	by dcvr.yhbt.net (Postfix) with ESMTP id 71AB01F462
	for <e@80x24.org>; Wed, 19 Jun 2019 21:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730401AbfFSVF6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 17:05:58 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34477 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfFSVF6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 17:05:58 -0400
Received: by mail-ed1-f68.google.com with SMTP id s49so1325648edb.1
        for <git@vger.kernel.org>; Wed, 19 Jun 2019 14:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Jmdug+gvd5UrCeMyMeMLyCtsHMr/0+qXCzVrSQQKHfQ=;
        b=UZmtlGdFMAcTk4Bqvlhx/Ip7HJ2ncNhVE9OubU6gdjhzqr+bVw7GdI6HTyvmI0I/y0
         ReHPj3fhwJomLo1kAilZ1hbglYABifsHIO//cIxZSOyudLnpjZWRp42QTHeH0SJbwRTc
         mcav/CHAgphxB6r60MsdcgwKSlRr1Vf0zTygBp2qDXjtjDZBQ1avwpiKu6G4S2r4PmjL
         j5QLqFwwELNwzRaMQZsXJTvt3Mmpty96B4/VNPBt9iZlZ1hs2gNlj6rxZlkfu6Gcv1Bx
         IwMfzd+dCTFDph/K/UB/r6XIOjYORhswN0NCB9/oGDda7nLFPpSMoaX2E1xfMEs0Yrpv
         Zllg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Jmdug+gvd5UrCeMyMeMLyCtsHMr/0+qXCzVrSQQKHfQ=;
        b=PI4HT3ZoZSAMqiJQKmf/w/zYhlp1J9n6yOIyNwYWRFzN7ygqc+eJ682nQm7Nrpl5nZ
         A0gEFBCLkKcBD80DTu+AlWRJmwqmObpq06bIHFpuFRFFmjF9Qhf/+lkYiKdKE9JmBe8m
         3jQ60WGFZVscP8d6DhDMG6Y7jntUtxO3n4JE0eWGCiyytezOKdBzxIvAAd60TVOeo3tX
         PVMvS0HTP36Smr+Ueql8jzBS+G7VR/WS0bU/RPr1YL+pt4A3VxIEZC7frqRD/VqpcpZh
         tzNGSpECQ+27DLlVS2jI1TmdOkibDaz93iVWztl/iX+RkIUkw0Hso0+Z9FZ9o6RviqSt
         m7bw==
X-Gm-Message-State: APjAAAUY7HlP7LDDc0TwDGUZ2HQHfC95JF1aGiYf1xzqRPElAETU/bHo
        1dFSBDSs9pNkwmoyNGMSBkf3wdqQ
X-Google-Smtp-Source: APXvYqyxYy3bQxGlAYjBk0LGXaiCSoHSbtHhmSZBcL0jLG4RMZV841kaxxnuFYXvS7Stls9ocK5vXQ==
X-Received: by 2002:aa7:de0e:: with SMTP id h14mr69643728edv.36.1560978355932;
        Wed, 19 Jun 2019 14:05:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y22sm5660243edw.94.2019.06.19.14.05.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 14:05:55 -0700 (PDT)
Date:   Wed, 19 Jun 2019 14:05:55 -0700 (PDT)
X-Google-Original-Date: Wed, 19 Jun 2019 21:05:34 GMT
Message-Id: <pull.149.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.149.git.gitgitgadget@gmail.com>
References: <pull.149.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 00/20] Fix MSVC support, at long last
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Carlo Arenas <carenas@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley and Jeff Hostetler worked quite a bit on getting Git to
compile with MS Visual C again, and this patch series is the culmination of
those efforts. With these patches, it is as easy as

make MSVC=1

Note: the patches went through quite the number of iterations. For example,
for a long time we targeted Visual Studio 2015, and used NuGet packages for
the dependencies (such as OpenSSL, cURL, etc), while the current iteration
targets Visual Studio 2017 and uses vcpkg
[https://docs.microsoft.com/en-us/cpp/vcpkg?view=vs-2017] for dependencies.
Hopefully I did not forget to remove any remnants of those previous
versions.

Please also note that this patch series is part 1 of 3 in a bigger story:
the next patch series will add support to build Git in Microsoft Visual
Studio, and the third patch series will add Continuous Testing by adding an
MSVC build and a corresponding parallelized test job to our Azure Pipeline.

Changes since v1:

 * The BASIC_CLFAGS typo was fixed.
 * Instead of sorting the output of stdout/stderr, the fixed test case in 
   t0001 now greps for the tell-tales it wants to be present.
 * In addition to cache-tree.c's DEBUG constant, now also builtin/blame.c's
   is renamed.
 * Two changes were factored out of the patch titled "msvc: support building
   Git using MS Visual C++": the support for spaces in SANE_TOOL_PATH, and
   the support for the compile time flag to enable CrtDbg's detailed heap
   diagnostics.
 * A comment about the vcxproj target has been dropped; The corresponding
   change is slated for a future patch series.
 * A left-over "TODO" comment was replaced by stating the final decision
   that only Visual Studio 2015 or later are supported for now.
 * A left-over, commented-out SIGINT case label was removed, and an adjacent
   comment was moved so that its indentation no longer looks strange.

Jeff Hostetler (10):
  cache-tree/blame: avoid reusing the DEBUG constant
  msvc: mark a variable as non-const
  msvc: do not re-declare the timespec struct
  msvc: define ftello()
  msvc: fix detect_msys_tty()
  msvc: update Makefile to allow for spaces in the compiler path
  msvc: support building Git using MS Visual C++
  msvc: add a compile-time flag to allow detailed heap debugging
  msvc: do not pretend to support all signals
  msvc: ignore .dll and incremental compile output

Johannes Schindelin (7):
  mingw: fix a typo in the msysGit-specific section
  Mark .bat files as requiring CR/LF endings
  t0001 (mingw): do not expect a specific order of stdout/stderr
  obstack: fix compiler warning
  mingw: replace mingw_startup() hack
  msvc: fix dependencies of compat/msvc.c
  msvc: avoid debug assertion windows in Debug Mode

Philip Oakley (3):
  msvc: include sigset_t definition
  msvc: define O_ACCMODE
  msvc: add pragmas for common warnings

 .gitattributes                     |   1 +
 .gitignore                         |   5 +
 Makefile                           |  40 +++++++
 builtin/blame.c                    |   6 +-
 cache-tree.c                       |  14 +--
 compat/mingw.c                     |  99 +++++++++++++----
 compat/mingw.h                     |  24 +++--
 compat/msvc.h                      |  10 ++
 compat/obstack.h                   |   2 +-
 compat/vcbuild/.gitignore          |   3 +
 compat/vcbuild/README              |  39 +++++++
 compat/vcbuild/find_vs_env.bat     | 168 +++++++++++++++++++++++++++++
 compat/vcbuild/scripts/clink.pl    |  41 ++++++-
 compat/vcbuild/vcpkg_copy_dlls.bat |  39 +++++++
 compat/vcbuild/vcpkg_install.bat   |  80 ++++++++++++++
 compat/winansi.c                   |  13 +++
 config.mak.uname                   |  83 +++++++++++---
 git-compat-util.h                  |   9 ++
 t/t0001-init.sh                    |   4 +-
 19 files changed, 619 insertions(+), 61 deletions(-)
 create mode 100644 compat/vcbuild/.gitignore
 create mode 100644 compat/vcbuild/find_vs_env.bat
 create mode 100644 compat/vcbuild/vcpkg_copy_dlls.bat
 create mode 100644 compat/vcbuild/vcpkg_install.bat


base-commit: b697d92f56511e804b8ba20ccbe7bdc85dc66810
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-149%2Fdscho%2Fmsvc-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-149/dscho/msvc-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/149

Range-diff vs v1:

  -:  ---------- >  1:  9d4d6ae7db mingw: fix a typo in the msysGit-specific section
  1:  b30429e0a4 =  2:  aa27e7f9cb Mark .bat files as requiring CR/LF endings
  2:  d551cdeafb <  -:  ---------- t0001 (mingw): do not expect a specific order of stdout/stderr
  -:  ---------- >  3:  3e108cfb02 t0001 (mingw): do not expect a specific order of stdout/stderr
  3:  486297ec8c !  4:  90ac088d22 cache-tree.c: avoid reusing the DEBUG constant
     @@ -1,16 +1,40 @@
      Author: Jeff Hostetler <jeffhost@microsoft.com>
      
     -    cache-tree.c: avoid reusing the DEBUG constant
     +    cache-tree/blame: avoid reusing the DEBUG constant
      
     -    In MSVC, the DEBUG constant is set automatically whenever compiling with
     -    debug information.
     +    In MS Visual C, the `DEBUG` constant is set automatically whenever
     +    compiling with debug information.
      
     -    This is clearly not what was intended in cache-tree.c, so let's use a less
     -    ambiguous constant there.
     +    This is clearly not what was intended in `cache-tree.c` nor in
     +    `builtin/blame.c`, so let's use a less ambiguous name there.
      
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     + diff --git a/builtin/blame.c b/builtin/blame.c
     + --- a/builtin/blame.c
     + +++ b/builtin/blame.c
     +@@
     + 
     + static struct string_list mailmap = STRING_LIST_INIT_NODUP;
     + 
     +-#ifndef DEBUG
     +-#define DEBUG 0
     ++#ifndef DEBUG_BLAME
     ++#define DEBUG_BLAME 0
     + #endif
     + 
     + static unsigned blame_move_score;
     +@@
     + 	if (blame_copy_score)
     + 		sb.copy_score = blame_copy_score;
     + 
     +-	sb.debug = DEBUG;
     ++	sb.debug = DEBUG_BLAME;
     + 	sb.on_sanity_fail = &sanity_check_on_fail;
     + 
     + 	sb.show_root = show_root;
     +
       diff --git a/cache-tree.c b/cache-tree.c
       --- a/cache-tree.c
       +++ b/cache-tree.c
  4:  bda1c270c1 =  5:  71d85b58b6 obstack: fix compiler warning
  5:  47105b6350 =  6:  02f618464f mingw: replace mingw_startup() hack
  6:  250385d7a3 =  7:  5c383985a1 msvc: fix dependencies of compat/msvc.c
  7:  037fbed117 =  8:  0a2985dc3c msvc: include sigset_t definition
  8:  b23651a357 =  9:  99a2939cc2 msvc: define O_ACCMODE
  9:  e813075ade = 10:  1542e8abe5 msvc: mark a variable as non-const
 10:  2ed60dfffc = 11:  51d73c61d3 msvc: do not re-declare the timespec struct
 11:  e6cd002806 = 12:  7cfd0fc9b4 msvc: define ftello()
 12:  073dc01b14 = 13:  f528883d97 msvc: fix detect_msys_tty()
  -:  ---------- > 14:  63bf9f1f92 msvc: update Makefile to allow for spaces in the compiler path
 13:  587cbcf619 ! 15:  245f28ac3b msvc: support building Git using MS Visual C++
     @@ -46,8 +46,8 @@
       
       ifdef SANE_TOOL_PATH
       SANE_TOOL_PATH_SQ = $(subst ','\'',$(SANE_TOOL_PATH))
     --BROKEN_PATH_FIX = 's|^\# @@BROKEN_PATH_FIX@@$$|git_broken_path_fix $(SANE_TOOL_PATH_SQ)|'
     -+BROKEN_PATH_FIX = 's|^\# @@BROKEN_PATH_FIX@@$$|git_broken_path_fix "$(SANE_TOOL_PATH_SQ)"|'
     +-BROKEN_PATH_FIX = 's|^\# @@BROKEN_PATH_FIX@@$$|git_broken_path_fix "$(SANE_TOOL_PATH_SQ)"|'
     ++BROKEN_PATH_FIX = 's|^\# @@BROKEN_PATH_FIX@@$$|git_broken_path_fix $(SANE_TOOL_PATH_SQ)|'
       PATH := $(SANE_TOOL_PATH):${PATH}
       else
       BROKEN_PATH_FIX = '/^\# @@BROKEN_PATH_FIX@@$$/d'
     @@ -122,19 +122,6 @@
       /*
        * We implement wmain() and compile with -municode, which would
        * normally ignore main(), but we call the latter from the former
     -@@
     - 
     - 	trace2_initialize_clock();
     - 
     -+#ifdef _MSC_VER
     -+#ifdef USE_MSVC_CRTDBG
     -+	_CrtSetDbgFlag(_CRTDBG_ALLOC_MEM_DF | _CRTDBG_LEAK_CHECK_DF);
     -+#endif
     -+#endif
     -+
     - 	maybe_redirect_std_handles();
     - 
     - 	/* determine size of argv and environ conversion buffer */
      
       diff --git a/compat/vcbuild/.gitignore b/compat/vcbuild/.gitignore
       new file mode 100644
     @@ -188,18 +175,6 @@
      +
      +================================================================
      +
     -+Alternatively, run `make MSVC=1 vcxproj` and then load the generated
     -+git.sln in Visual Studio. The initial build will install the vcpkg
     -+system and build the dependencies automatically. This will take a while.
     -+
     -+Note that this will automatically add and commit the generated
     -+.sln and .vcxproj files to the repo.  You may want to drop this
     -+commit before submitting a Pull Request....
     -+
     -+Or maybe we should put the .sln/.vcxproj files in the .gitignore file
     -+and not do this.  I'm not sure.
     -+
     -+================================================================
       The Steps of Build Git with VS2008
       
       1. You need the build environment, which contains the Git dependencies
     @@ -264,7 +239,7 @@
      +REM
      +REM Earlier Versions
      +REM ----------------
     -+REM TODO
     ++REM Currently unsupported.
      +REM
      +REM ================================================================
      +REM Note: Throughout this script we use "dir <path> && <cmd>" rather
     @@ -353,8 +328,7 @@
      +REM ================================================================
      +
      +:not_2015
     -+   REM TODO....
     -+   echo TODO support older versions of VS. >&2
     ++   echo "ERROR: unsupported VS version (older than VS2015)" >&2
      +   EXIT /B 1
      +
      +REM ================================================================
     @@ -702,8 +676,6 @@
      +endif
      +	BASIC_CFLAGS += $(sdk_libs) $(msvc_libs)
      +
     -+	# Optionally enable memory leak reporting.
     -+	# BASIC_CLFAGS += -DUSE_MSVC_CRTDBG
       	BASIC_CFLAGS += -DPROTECT_NTFS_DEFAULT=1
      +	# Always give "-Zi" to the compiler and "-debug" to linker (even in
      +	# release mode) to force a PDB to be generated (like RelWithDebInfo).
     @@ -726,23 +698,3 @@
       endif
       	X = .exe
       
     -
     - diff --git a/git-compat-util.h b/git-compat-util.h
     - --- a/git-compat-util.h
     - +++ b/git-compat-util.h
     -@@
     - #ifndef GIT_COMPAT_UTIL_H
     - #define GIT_COMPAT_UTIL_H
     - 
     -+#ifdef USE_MSVC_CRTDBG
     -+/*
     -+ * For these to work they must appear very early in each
     -+ * file -- before most of the standard header files.
     -+ */
     -+#include <stdlib.h>
     -+#include <crtdbg.h>
     -+#endif
     -+
     - #define _FILE_OFFSET_BITS 64
     - 
     - 
  -:  ---------- > 16:  e7888bedbd msvc: add a compile-time flag to allow detailed heap debugging
 14:  0cca8c3c68 = 17:  d9668558dd msvc: add pragmas for common warnings
 15:  1491ea4140 ! 18:  c883f037e0 msvc: do not pretend to support all signals
     @@ -17,14 +17,6 @@
       		return 0;
       
      +#if defined(_MSC_VER)
     -+		/*
     -+		 * <signal.h> in the CRT defines 8 signals as being
     -+		 * supported on the platform.  Anything else causes
     -+		 * an "Invalid signal or error" (which in DEBUG builds
     -+		 * causes the Abort/Retry/Ignore dialog).  We by-pass
     -+		 * the CRT for things we already know will fail.
     -+		 */
     -+		/*case SIGINT:*/
      +	case SIGILL:
      +	case SIGFPE:
      +	case SIGSEGV:
     @@ -32,6 +24,13 @@
      +	case SIGBREAK:
      +	case SIGABRT:
      +	case SIGABRT_COMPAT:
     ++		/*
     ++		 * The <signal.h> header in the MS C Runtime defines 8 signals
     ++		 * as being supported on the platform. Anything else causes an
     ++		 * "Invalid signal or error" (which in DEBUG builds causes the
     ++		 * Abort/Retry/Ignore dialog). We by-pass the CRT for things we
     ++		 * already know will fail.
     ++		 */
      +		return raise(sig);
      +	default:
      +		errno = EINVAL;
 16:  831d603e25 = 19:  51a20ff2df msvc: avoid debug assertion windows in Debug Mode
 17:  0c7f5479bf = 20:  4d44d1fab1 msvc: ignore .dll and incremental compile output

-- 
gitgitgadget
