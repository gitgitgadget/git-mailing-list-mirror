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
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DA011F462
	for <e@80x24.org>; Tue, 18 Jun 2019 12:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729135AbfFRMYC (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 08:24:02 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39924 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729115AbfFRMYB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 08:24:01 -0400
Received: by mail-ed1-f66.google.com with SMTP id m10so21453123edv.6
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 05:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=myJh4IksGT5LpjsbiGigjofo29xoMjLU+JcS5Ji/PC8=;
        b=PuyF/NPZd1BjCFxhfGWHJrMoRGl+aAtUKbEneNsfXuoryq1w9EsE50n+3QInWxcpt/
         TvxuxETPRyvVvOqZmeXfR+fOipNQLa5fenPH21kuYwg3YYHwBdDLrmI4Eq/gMG1LzL8N
         uDOVa0fnGSXFkpzQ8DAKbuPBBPiSPvatmCu3YS48ftmUNSJ7d/Wit8ObkSNxu4hrwqNw
         jCYAulC5h5I5OCLTGaFORaZEYekOo5Sca0sEhdBze4P7FMDFForSO7jxXELBJpVVAbDV
         Aw3bIkF4ZQy0KR+R2bnrj2284wAEJRsiudeNNeefCawkxSDipgFM5BxsnBHDKQmlhoFJ
         P3hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=myJh4IksGT5LpjsbiGigjofo29xoMjLU+JcS5Ji/PC8=;
        b=qujUwt0+izFKEmiRhwNXblCLdsqIWyc/SHhu4u3q9xiXuaYj3oZygvZBFEasusrZJv
         8Fv1k6bEGVd3795TzaSEXQcaPOfubCJOLGpXO10OdFefh3j1txEX8cQ8u+ZmVuaFLLG7
         kRE7q3yyOJJJa2KVSCJl6AirSXW6VlIgTW91v+oZSHC4R86GoJ78HvuXh6RpRRrZnulW
         2mN9EM9DDeMJGVWoOCBtsk3gUgHAuJs6UFyczftxqzMUkX5CiHHFy1dLxFdLyIYQ/R9u
         Qh1XJNoKsDSSuCnpO0EOfNs37+47gpPe2a3mCvtCQEhgd9XJH1ysOI+j4zJGKC6T29+J
         hcuw==
X-Gm-Message-State: APjAAAXy5i6MUviZ5IqqkPUI/CZCGKVV3WlDnYR078XbMsqAnRT/p0tR
        5ErWwwzjTZglwvNgEXxvG5GkoACZ
X-Google-Smtp-Source: APXvYqywaG3T76se8NeR3y5nrELJV83Nn/3iRZDuEwh6L0oBAGLBDsELeAKU4VfGd9KG+6SU4V96Fg==
X-Received: by 2002:a17:906:3e88:: with SMTP id a8mr12180443ejj.206.1560860639598;
        Tue, 18 Jun 2019 05:23:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l50sm4768262edb.77.2019.06.18.05.23.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 05:23:59 -0700 (PDT)
Date:   Tue, 18 Jun 2019 05:23:59 -0700 (PDT)
X-Google-Original-Date: Tue, 18 Jun 2019 12:23:42 GMT
Message-Id: <47105b63503b84be2769186db95be2d45d81577d.1560860634.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.149.git.gitgitgadget@gmail.com>
References: <pull.149.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 05/17] mingw: replace mingw_startup() hack
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Git for Windows has special code to retrieve the command-line parameters
(and even the environment) in UTF-16 encoding, so that they can be
converted to UTF-8. This is necessary because Git for Windows wants to
use UTF-8 encoded strings throughout its code, and the main() function
does not get the parameters in that encoding.

To do that, we used the __wgetmainargs() function, which is not even a
Win32 API function, but provided by the MINGW "runtime" instead.

Obviously, this method would not work with any compiler other than GCC,
and in preparation for compiling with Visual C++, we would like to avoid
precisely that.

Lucky us, there is a much more elegant way: we can simply implement the
UTF-16 variant of `main()`: `wmain()`.

To make that work, we need to link with -municode. The command-line
parameters are passed to `wmain()` encoded in UTF-16, as desired, and
this method also works with GCC, and also with Visual C++ after
adjusting the MSVC linker flags to force it to use `wmain()`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c   | 53 +++++++++++++++++++++++++++++++-----------------
 compat/mingw.h   | 22 ++++++++++----------
 config.mak.uname |  3 ++-
 3 files changed, 47 insertions(+), 31 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 9b6d2400e1..0d8713e515 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2301,18 +2301,13 @@ static void setup_windows_environment(void)
 		setenv("TERM", "cygwin", 1);
 }
 
+#if !defined(_MSC_VER)
 /*
  * Disable MSVCRT command line wildcard expansion (__getmainargs called from
  * mingw startup code, see init.c in mingw runtime).
  */
 int _CRT_glob = 0;
-
-typedef struct {
-	int newmode;
-} _startupinfo;
-
-extern int __wgetmainargs(int *argc, wchar_t ***argv, wchar_t ***env, int glob,
-		_startupinfo *si);
+#endif
 
 static NORETURN void die_startup(void)
 {
@@ -2390,22 +2385,25 @@ static void maybe_redirect_std_handles(void)
 				  GENERIC_WRITE, FILE_FLAG_NO_BUFFERING);
 }
 
-void mingw_startup(void)
+/*
+ * We implement wmain() and compile with -municode, which would
+ * normally ignore main(), but we call the latter from the former
+ * so that we can handle non-ASCII command-line parameters
+ * appropriately.
+ *
+ * To be more compatible with the core git code, we convert
+ * argv into UTF8 and pass them directly to main().
+ */
+int wmain(int argc, const wchar_t **wargv)
 {
-	int i, maxlen, argc;
-	char *buffer;
-	wchar_t **wenv, **wargv;
-	_startupinfo si;
+	int i, maxlen, exit_status;
+	char *buffer, **save;
+	const char **argv;
 
 	trace2_initialize_clock();
 
 	maybe_redirect_std_handles();
 
-	/* get wide char arguments and environment */
-	si.newmode = 0;
-	if (__wgetmainargs(&argc, &wargv, &wenv, _CRT_glob, &si) < 0)
-		die_startup();
-
 	/* determine size of argv and environ conversion buffer */
 	maxlen = wcslen(wargv[0]);
 	for (i = 1; i < argc; i++)
@@ -2415,9 +2413,16 @@ void mingw_startup(void)
 	maxlen = 3 * maxlen + 1;
 	buffer = malloc_startup(maxlen);
 
-	/* convert command line arguments and environment to UTF-8 */
+	/*
+	 * Create a UTF-8 version of w_argv. Also create a "save" copy
+	 * to remember all the string pointers because parse_options()
+	 * will remove claimed items from the argv that we pass down.
+	 */
+	ALLOC_ARRAY(argv, argc + 1);
+	ALLOC_ARRAY(save, argc + 1);
 	for (i = 0; i < argc; i++)
-		__argv[i] = wcstoutfdup_startup(buffer, wargv[i], maxlen);
+		argv[i] = save[i] = wcstoutfdup_startup(buffer, wargv[i], maxlen);
+	argv[i] = save[i] = NULL;
 	free(buffer);
 
 	/* fix Windows specific environment settings */
@@ -2436,6 +2441,16 @@ void mingw_startup(void)
 
 	/* initialize Unicode console */
 	winansi_init();
+
+	/* invoke the real main() using our utf8 version of argv. */
+	exit_status = main(argc, argv);
+
+	for (i = 0; i < argc; i++)
+		free(save[i]);
+	free(save);
+	free(argv);
+
+	return exit_status;
 }
 
 int uname(struct utsname *buf)
diff --git a/compat/mingw.h b/compat/mingw.h
index 593bdbffe6..210f1b01a8 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -562,18 +562,18 @@ int xwcstoutf(char *utf, const wchar_t *wcs, size_t utflen);
 extern CRITICAL_SECTION pinfo_cs;
 
 /*
- * A replacement of main() that adds win32 specific initialization.
+ * Git, like most portable C applications, implements a main() function. On
+ * Windows, this main() function would receive parameters encoded in the
+ * current locale, but Git for Windows would prefer UTF-8 encoded  parameters.
+ *
+ * To make that happen, we still declare main() here, and then declare and
+ * implement wmain() (which is the Unicode variant of main()) and compile with
+ * -municode. This wmain() function reencodes the parameters from UTF-16 to
+ * UTF-8 format, sets up a couple of other things as required on Windows, and
+ * then hands off to the main() function.
  */
-
-void mingw_startup(void);
-#define main(c,v) dummy_decl_mingw_main(void); \
-static int mingw_main(c,v); \
-int main(int argc, const char **argv) \
-{ \
-	mingw_startup(); \
-	return mingw_main(__argc, (void *)__argv); \
-} \
-static int mingw_main(c,v)
+int wmain(int argc, const wchar_t **w_argv);
+int main(int argc, const char **argv);
 
 /*
  * Used by Pthread API implementation for Windows
diff --git a/config.mak.uname b/config.mak.uname
index b71688eeb7..bf5d160ef4 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -401,7 +401,7 @@ ifeq ($(uname_S),Windows)
 		compat/win32/trace2_win32_process_info.o \
 		compat/win32/dirent.o
 	COMPAT_CFLAGS = -D__USE_MINGW_ACCESS -DNOGDI -DHAVE_STRING_H -Icompat -Icompat/regex -Icompat/win32 -DSTRIP_EXTENSION=\".exe\"
-	BASIC_LDFLAGS = -IGNORE:4217 -IGNORE:4049 -NOLOGO -SUBSYSTEM:CONSOLE
+	BASIC_LDFLAGS = -IGNORE:4217 -IGNORE:4049 -NOLOGO -ENTRY:wmainCRTStartup -SUBSYSTEM:CONSOLE
 	EXTLIBS = user32.lib advapi32.lib shell32.lib wininet.lib ws2_32.lib invalidcontinue.obj
 	PTHREAD_LIBS =
 	lib =
@@ -548,6 +548,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	ETAGS_TARGET = ETAGS
 	NO_POSIX_GOODIES = UnfortunatelyYes
 	DEFAULT_HELP_FORMAT = html
+	BASIC_LDFLAGS += -municode
 	COMPAT_CFLAGS += -DNOGDI -Icompat -Icompat/win32
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
 	COMPAT_OBJS += compat/mingw.o compat/winansi.o \
-- 
gitgitgadget

