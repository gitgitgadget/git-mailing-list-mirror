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
	by dcvr.yhbt.net (Postfix) with ESMTP id E750D1F461
	for <e@80x24.org>; Tue, 27 Aug 2019 13:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730146AbfH0NqV (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 09:46:21 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39822 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730121AbfH0NqU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 09:46:20 -0400
Received: by mail-wr1-f68.google.com with SMTP id t16so18881950wra.6
        for <git@vger.kernel.org>; Tue, 27 Aug 2019 06:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=90SVQyxr5QA0/1cAonN4lmSjn053dRfK0vKcEE84rsk=;
        b=QYAx0AAFfQR1U4J030yKU2Qvjhn2WWV3WElqnA+OJ9EKPScDRxcR73pfHiGr0iaH8P
         HPiC29pxEsCyGgoZUiYQCmFeB8zXFCOaDOYyIpJ2EcL78kQQbA34wk2ztoDjQWm9Y/te
         OzyTJokC93UOjUVq4oXWrnVaLx8KgBLrPT0vkHdfqA+Yt0Q64b/w3LwxcQqXpCKn6K+f
         rCFt63Qsi83avxQj9h1WCo2qqKIiZZIT8y3CHwwDwMI7J3LDawY91RtW3Nos+CPIozVH
         Ge1c2u9FO/MzzyKD58zJUn0ME0h613BWrWe5LZvV/G3FtPY6A98mSYnfTK3kQS9oM8JC
         3BvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=90SVQyxr5QA0/1cAonN4lmSjn053dRfK0vKcEE84rsk=;
        b=FjV2uNotJX6SxNAEhLDSgjRZZyzlXNS4evADaJ/zSIW6EVbSd6WJtingQ9j70cXT0a
         dJuqcXSKegoKb3QyvaOxaKSjFdI9ES4ZKExXzzgNGVGmZsEp99cYk75gjksNP0Zn/JqZ
         2hfy06nrBwOjL9izVWIogpO4TZhuGjdniN+hnGC33XSV5sBw03rfeKwqMe+PToTw3Q5H
         SijQ4tWRnwllgWBS/vTJrn6tlOpG/GxJlW92qefHVNRqL/U4tyhguSm+jVideikZws4n
         kCtnmKmEhV9heW07NedSPOpjSYlcLBqx67G91wRDH5IC3IdBxMuzHWzZdBurrzFCQX5C
         YE1w==
X-Gm-Message-State: APjAAAVPSbA4a98llK40xFgmOdksCTPdNkxGzZSnNvE1nDTRckEOy42r
        p/a3tXWQpoCkuEDjFbFQJtdYdlDwODg=
X-Google-Smtp-Source: APXvYqzvfLK97xK7QmGPX/NAb2EIyyL4u3WqbC4qvMzwHuF4kglxNyq4jIciFV4vcSB3XsnrAjX3GA==
X-Received: by 2002:a5d:628d:: with SMTP id k13mr6779091wru.69.1566913578732;
        Tue, 27 Aug 2019 06:46:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a17sm3227003wmm.47.2019.08.27.06.46.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 06:46:18 -0700 (PDT)
Date:   Tue, 27 Aug 2019 06:46:18 -0700 (PDT)
X-Google-Original-Date: Tue, 27 Aug 2019 13:46:14 GMT
Message-Id: <7abbd36e1ddc2037925c3ff148f62f0352a8954b.1566913575.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.305.v2.git.gitgitgadget@gmail.com>
References: <pull.305.git.gitgitgadget@gmail.com>
        <pull.305.v2.git.gitgitgadget@gmail.com>
From:   "lufia via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 2/3] Fix C syntactic errors for the Plan 9 C compiler
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
 remove-bitfields.sh           | 17 +++++++++++++++++
 6 files changed, 44 insertions(+), 11 deletions(-)
 create mode 100644 compat/plan9/openssl/crypto.h
 create mode 100755 remove-bitfields.sh

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
index 14de96ee6d..0024b767e5 100644
--- a/config.c
+++ b/config.c
@@ -2462,7 +2462,8 @@ static int store_aux_event(enum config_event_t type,
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
diff --git a/remove-bitfields.sh b/remove-bitfields.sh
new file mode 100755
index 0000000000..952bd34f12
--- /dev/null
+++ b/remove-bitfields.sh
@@ -0,0 +1,17 @@
+#!/bin/ape/sh
+# Plan 9 C compiler rejects initialization a structure including bit field.
+# usage: remove-bitfields.sh [dir ...]
+
+if ! echo abc | sed 's/(ab)c/\1/' >/dev/null 2>&1
+then
+	alias sed='sed -E'
+fi
+
+trap 'rm -f /tmp/remove-bitfields.$pid; exit 1' 1 2 3 15 EXIT
+
+files=$(du -a $* | awk '/\.[ch]$/ { print $2 }')
+for i in $files
+do
+	sed '/(^[ 	]*\*|\?)/!s/([a-z]+[a-z0-9]*) *: *[0-9]+([,;])/\1\2/g' $i >/tmp/remove-bitfields.$pid
+	cp /tmp/remove-bitfields.$pid $i
+done
-- 
gitgitgadget

