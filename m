Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E053920248
	for <e@80x24.org>; Thu, 18 Apr 2019 13:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388976AbfDRNQo (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Apr 2019 09:16:44 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46756 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388263AbfDRNQo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Apr 2019 09:16:44 -0400
Received: by mail-ed1-f66.google.com with SMTP id d1so1741404edd.13
        for <git@vger.kernel.org>; Thu, 18 Apr 2019 06:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hmgh1spK7bY/uqTyrRKjzG8oiX7n4p75EKmnfUK2B24=;
        b=F/fTOJtkVUF+S5YLBClf18x3+U5rez2/i9LUpcvMcsImRRiGjXhqp+RdSkYCXVPYaz
         lHDW5leE/xWSdWejmKyxurAuyTpHsbl9Jbf/WTlibUwVpVc//9cTr1uM7DMAQcesxx0w
         Y/mAYc/2FNfMFO28yyA4wmzA6OvckN2z6DuefdxqyYxNq8q7tkSV6EUM2lMnchjHrIrQ
         EskDiGElfQV4ZlyWVtS87g0LMPVRBWb2VrOw6B/AnHwN+stFNGxtaQPWKXNaHphGndvA
         CYyYUnDHDcUdmuNqtrkWp4b92KLPJmDKm7U66qApuTHLR8dzD1nxcYkFRjw+a5IvyP/R
         EV3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hmgh1spK7bY/uqTyrRKjzG8oiX7n4p75EKmnfUK2B24=;
        b=OMxdaNkE9ultM11drG86856u8TkWv8+azqF2Kyth68bI0G0vib5D6GxeLBEl2TwPA0
         jg7ouOmRvCSA1c7gmP7CyrFSI3sSsxxSqhK7qVZMdrH9UsiYQjny1GNJC3NvfZJnZwm2
         t4dq4UIJFDFEsPhVhxe7avpEZqhiPns0+9oK5KhoKVVbM60Y8RhVYbnY8+14HC0lSm2C
         MKWXLdLw2NzAzCaCu7sXFscWxaOmWgtbXPZte65xQAlN+1We/l/FkCPd0da7jcGVw0IM
         fdCcZ/IfZT5OzpQ0yNqdVolOi2l1d/07fKbgWSKXm82mNskghJlZAiU96ywMzepayY5w
         9lmA==
X-Gm-Message-State: APjAAAXvtpg2vOuA40mwQJIaIO3ldAcGjOs8liEpV+4tiK/ZyIs0bXRR
        1zxP/XocjbbzGAVQY050/VuJkXbB
X-Google-Smtp-Source: APXvYqwiVJdyxPs5oGHDpDj81bSX3RAcZJhXvGk4CRr0RZZZtLR/Nk6ip57q2xot6uO7bCRwLsehSQ==
X-Received: by 2002:a17:906:48c7:: with SMTP id d7mr50947420ejt.225.1555593401414;
        Thu, 18 Apr 2019 06:16:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j18sm507716edj.92.2019.04.18.06.16.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 06:16:40 -0700 (PDT)
Date:   Thu, 18 Apr 2019 06:16:40 -0700 (PDT)
X-Google-Original-Date: Thu, 18 Apr 2019 13:16:31 GMT
Message-Id: <9b498a6f218e323306afeeb791ece93510bad746.1555593396.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.168.v2.git.gitgitgadget@gmail.com>
References: <pull.168.git.gitgitgadget@gmail.com>
        <pull.168.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 3/8] help -a: do not list commands that are excluded from
 the build
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When built with NO_CURL or with NO_UNIX_SOCKETS, some commands are
skipped from the build. It does not make sense to list them in the
output of `git help -a`, so let's just not.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile            | 14 ++++++++++++--
 generate-cmdlist.sh | 10 +++++++++-
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index f5be2f633e..e7bcfcaae9 100644
--- a/Makefile
+++ b/Makefile
@@ -611,6 +611,7 @@ FUZZ_PROGRAMS =
 LIB_OBJS =
 PROGRAM_OBJS =
 PROGRAMS =
+EXCLUDED_PROGRAMS =
 SCRIPT_PERL =
 SCRIPT_PYTHON =
 SCRIPT_SH =
@@ -1319,6 +1320,7 @@ ifdef NO_CURL
 	REMOTE_CURL_PRIMARY =
 	REMOTE_CURL_ALIASES =
 	REMOTE_CURL_NAMES =
+	EXCLUDED_PROGRAMS += git-http-fetch git-http-push
 else
 	ifdef CURLDIR
 		# Try "-Wl,-rpath=$(CURLDIR)/$(lib)" in such a case.
@@ -1343,7 +1345,11 @@ endif
 	ifeq "$(curl_check)" "070908"
 		ifndef NO_EXPAT
 			PROGRAM_OBJS += http-push.o
+		else
+			EXCLUDED_PROGRAMS += git-http-push
 		endif
+	else
+		EXCLUDED_PROGRAMS += git-http-push
 	endif
 	curl_check := $(shell (echo 072200; $(CURL_CONFIG) --vernum | sed -e '/^70[BC]/s/^/0/') 2>/dev/null | sort -r | sed -ne 2p)
 	ifeq "$(curl_check)" "072200"
@@ -1589,7 +1595,9 @@ ifdef NO_INET_PTON
 	LIB_OBJS += compat/inet_pton.o
 	BASIC_CFLAGS += -DNO_INET_PTON
 endif
-ifndef NO_UNIX_SOCKETS
+ifdef NO_UNIX_SOCKETS
+	EXCLUDED_PROGRAMS += git-credential-cache git-credential-cache--daemon
+else
 	LIB_OBJS += unix-socket.o
 	PROGRAM_OBJS += credential-cache.o
 	PROGRAM_OBJS += credential-cache--daemon.o
@@ -2108,7 +2116,9 @@ $(BUILT_INS): git$X
 command-list.h: generate-cmdlist.sh command-list.txt
 
 command-list.h: $(wildcard Documentation/git*.txt) Documentation/*config.txt Documentation/config/*.txt
-	$(QUIET_GEN)$(SHELL_PATH) ./generate-cmdlist.sh command-list.txt >$@+ && mv $@+ $@
+	$(QUIET_GEN)$(SHELL_PATH) ./generate-cmdlist.sh \
+		$(patsubst %,--exclude-program %,$(EXCLUDED_PROGRAMS)) \
+		command-list.txt >$@+ && mv $@+ $@
 
 SCRIPT_DEFINES = $(SHELL_PATH_SQ):$(DIFF_SQ):$(GIT_VERSION):\
 	$(localedir_SQ):$(NO_CURL):$(USE_GETTEXT_SCHEME):$(SANE_TOOL_PATH_SQ):\
diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index 709d67405b..71158f7d8b 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -6,7 +6,7 @@ die () {
 }
 
 command_list () {
-	grep -v '^#' "$1"
+	eval "grep -ve '^#' $exclude_programs" <"$1"
 }
 
 get_categories () {
@@ -93,6 +93,14 @@ EOF
 EOF
 }
 
+exclude_programs=
+while test "--exclude-program" = "$1"
+do
+	shift
+	exclude_programs="$exclude_programs -e \"^$1 \""
+	shift
+done
+
 echo "/* Automatically generated by generate-cmdlist.sh */
 struct cmdname_help {
 	const char *name;
-- 
gitgitgadget

