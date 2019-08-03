Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E0151F732
	for <e@80x24.org>; Sat,  3 Aug 2019 23:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729301AbfHCXwN (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Aug 2019 19:52:13 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44832 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729291AbfHCXwN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Aug 2019 19:52:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id p17so80803491wrf.11
        for <git@vger.kernel.org>; Sat, 03 Aug 2019 16:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gg+zgjiajEZ8zkcXgY9lYVZsk1/id0fz4eQnMZ13omg=;
        b=O9YjFukJM2JBYJl0ppg8ORuhH6fTl9F3JcZ6kIpTvwBrGq+gImSVqsKaMO4bgfvl1W
         xV/LFkw3Oqmc8ikM5l9x23SmADZd0ujIUf+nzFJIIlCwBBeBP02A1xI7byKxY8bsCgrh
         jh4YxbupzdOX1T3apJzPG1jeQUPWL6lBz/dpQ8R1fEgaSY9+qTHA5jloMU6dGEcuquqT
         d6yjV536mOOcebcD6YDqqLEz4We8vxZx67Gz9xvVzrjp/xkcED3Fsxq+4BTGe0HVMZF2
         6Fi9sus0vtevNuPswiefoJP5GD0drKFP21q3iTIEzcZZT+zXjpFtl9IoU/hT71KfmA1e
         FS2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gg+zgjiajEZ8zkcXgY9lYVZsk1/id0fz4eQnMZ13omg=;
        b=Y0nneXuBxL8CPJYo8DlYv7rTgrlKKzHCt/yW4tRUOW4dfpyd9WioT/iMxKZUmvfxy/
         YmgmZU2I9JWtirAh8TRf83mFBubn/vUgZyOWDTJUO9xutUE/6tSBhm0d4ZwmoySj8aPL
         4HLghZGDwnUmb8D8VO3DgfXcZkn2FDU8IyTP3xmPmDGHGTc5vmkgcHiOqXhT9sP+XCXE
         ecQcsJvkysNMfinI0lLepa6M70sglvewWrqL3Lk/peyAAl1KR32m/n3JITSST1MInWXf
         /vg6PPRvYwdSVcp/BwDems4sfgobPG3PEQNHiMtqUY8vO9S/7nFOLyhv10e8tQjkAWVV
         1NvQ==
X-Gm-Message-State: APjAAAUiE9/gFrbtWOn8qk50tfVoTcScXfCA5mHBw1Sq/52RVJttZekT
        Ob9uB4czf5XOg87W7bptMz4fNyM3
X-Google-Smtp-Source: APXvYqzx6xlLPJ4actseF7XiZUEPOOmnQvipuf0jzOVDTLWel52jLdL92m3JtPJvRiZ9YHRaKChE9A==
X-Received: by 2002:a5d:5692:: with SMTP id f18mr107731527wrv.104.1564876330826;
        Sat, 03 Aug 2019 16:52:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w25sm73013495wmk.18.2019.08.03.16.52.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Aug 2019 16:52:10 -0700 (PDT)
Date:   Sat, 03 Aug 2019 16:52:10 -0700 (PDT)
X-Google-Original-Date: Sat, 03 Aug 2019 23:52:03 GMT
Message-Id: <301a796de9e853f9b0e398bc0d0c54a737a2f2c0.1564876327.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.305.git.gitgitgadget@gmail.com>
References: <pull.305.git.gitgitgadget@gmail.com>
From:   "lufia via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/6] Fix C syntactic errors for the Plan 9 C compiler
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, lufia <lufia@lufia.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: lufia <lufia@lufia.org>

Signed-off-by: lufia <lufia@lufia.org>
---
 compat/plan9/openssl/crypto.h |  5 +++++
 compat/regex/regex_internal.h |  3 +++
 config.c                      |  3 ++-
 git-compat-util.h             |  9 ++++++++-
 parse-options.h               | 18 +++++++++---------
 remove-bitfields.rc           | 14 ++++++++++++++
 6 files changed, 41 insertions(+), 11 deletions(-)
 create mode 100644 compat/plan9/openssl/crypto.h
 create mode 100644 remove-bitfields.rc

diff --git a/compat/plan9/openssl/crypto.h b/compat/plan9/openssl/crypto.h
new file mode 100644
index 0000000000..9d1ef43422
--- /dev/null
+++ b/compat/plan9/openssl/crypto.h
@@ -0,0 +1,5 @@
+#ifndef __attribute__
+#define __attribute__(x)
+#endif
+
+#include_next <openssl/crypto.h>
diff --git a/compat/regex/regex_internal.h b/compat/regex/regex_internal.h
index 3ee8aae59d..7313c747a6 100644
--- a/compat/regex/regex_internal.h
+++ b/compat/regex/regex_internal.h
@@ -26,6 +26,9 @@
 #include <stdlib.h>
 #include <string.h>
 
+#ifdef NEEDS_SYS_PARAM_H
+#include <sys/param.h>
+#endif
 #if defined HAVE_LANGINFO_H || defined HAVE_LANGINFO_CODESET || defined _LIBC
 # include <langinfo.h>
 #endif
diff --git a/config.c b/config.c
index f67cef5cf8..993f9f57be 100644
--- a/config.c
+++ b/config.c
@@ -2461,7 +2461,8 @@ static int store_aux_event(enum config_event_t type,
 			return error(_("invalid section name '%s'"), cf->var.buf);
 
 		if (cf->subsection_case_sensitive)
-			cmpfn = strncasecmp;
+			/* Plan 9's strncasecmp is typed (char*, char*, int) */
+			cmpfn = (int (*)(const char*, const char*, size_t))strncasecmp;
 		else
 			cmpfn = strncmp;
 
diff --git a/git-compat-util.h b/git-compat-util.h
index f8fdd79591..1aa7877af4 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -164,7 +164,11 @@
 #define GIT_WINDOWS_NATIVE
 #endif
 
+#include <sys/types.h>
 #include <unistd.h>
+#ifdef __PLAN9__
+#include <libv.h>
+#endif
 #include <stdio.h>
 #include <sys/stat.h>
 #include <fcntl.h>
@@ -180,7 +184,6 @@
 #ifdef NEEDS_SYS_PARAM_H
 #include <sys/param.h>
 #endif
-#include <sys/types.h>
 #include <dirent.h>
 #include <sys/time.h>
 #include <time.h>
@@ -282,6 +285,10 @@ char *gitbasename(char *);
 char *gitdirname(char *);
 #endif
 
+#ifdef __PLAN9__
+#include <machine/endian.h>
+#endif
+
 #ifndef NO_ICONV
 #include <iconv.h>
 #endif
diff --git a/parse-options.h b/parse-options.h
index a4bd40bb6a..38a33a087e 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -46,6 +46,15 @@ enum parse_opt_option_flags {
 	PARSE_OPT_COMP_ARG = 1024
 };
 
+enum parse_opt_result {
+	PARSE_OPT_COMPLETE = -3,
+	PARSE_OPT_HELP = -2,
+	PARSE_OPT_ERROR = -1,	/* must be the same as error() */
+	PARSE_OPT_DONE = 0,	/* fixed so that "return 0" works */
+	PARSE_OPT_NON_OPTION,
+	PARSE_OPT_UNKNOWN
+};
+
 struct option;
 typedef int parse_opt_cb(const struct option *, const char *arg, int unset);
 
@@ -241,15 +250,6 @@ const char *optname(const struct option *opt, int flags);
 
 /*----- incremental advanced APIs -----*/
 
-enum parse_opt_result {
-	PARSE_OPT_COMPLETE = -3,
-	PARSE_OPT_HELP = -2,
-	PARSE_OPT_ERROR = -1,	/* must be the same as error() */
-	PARSE_OPT_DONE = 0,	/* fixed so that "return 0" works */
-	PARSE_OPT_NON_OPTION,
-	PARSE_OPT_UNKNOWN
-};
-
 /*
  * It's okay for the caller to consume argv/argc in the usual way.
  * Other fields of that structure are private to parse-options and should not
diff --git a/remove-bitfields.rc b/remove-bitfields.rc
new file mode 100644
index 0000000000..897f98da10
--- /dev/null
+++ b/remove-bitfields.rc
@@ -0,0 +1,14 @@
+#!/bin/rc
+# Plan 9 C compiler rejects initialization a structure including bit field.
+# usage: remove-bitfields.rc [dir ...]
+
+fn sigexit sighup sigint sigquit sigterm {
+	rm -f /tmp/remove-bitfields.$pid
+	exit
+}
+
+files=`{du -a $* | awk '/\.[ch]$/ { print $2 }'}
+for(i in $files){
+	sed '/(^[ 	]*\*|\?)/!s/([a-z]+[a-z0-9]*) *: *[0-9]+([,;])/\1\2/g' $i >/tmp/remove-bitfields.$pid
+	cp /tmp/remove-bitfields.$pid $i
+}
-- 
gitgitgadget

