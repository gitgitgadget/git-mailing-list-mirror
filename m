Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E08E1F453
	for <e@80x24.org>; Fri, 25 Jan 2019 12:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbfAYMXg (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Jan 2019 07:23:36 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44599 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728063AbfAYMXf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jan 2019 07:23:35 -0500
Received: by mail-ed1-f68.google.com with SMTP id y56so7215422edd.11
        for <git@vger.kernel.org>; Fri, 25 Jan 2019 04:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6Y2WvcczK8cknroo/M285WWWCxDBVS1J4gBLizPfG74=;
        b=EMT1PHUleO8/TmrWdD00Cfl/yrxCBWar9AUh5/Jk+KzIQ/Fg4UNIB70JZzD1X1sMWg
         VGZpiOhAA3nYuFl9iw3GSXNxIJm7NmMRLgYjJepxkq26kOFwZYbLIAjau+MCTp0xchX2
         ly00INR1q8hU5WrSETchoqzTCkSjP360/lueRDxxfq0cg75sufaFFlD4ezh3U4Rb9gm4
         YUNXM+s+uSuMFxLYKYiC0fsMfq04uceJX1HXndE/eCwHvYH9goMucywMxKwpUdRCAJ0N
         WZfKZWOiM5DPto5xtO85aYHyEcFmpvYekYrs+kHyY2ivGAvckbXmmz8P259qkmzOYQ86
         9h0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6Y2WvcczK8cknroo/M285WWWCxDBVS1J4gBLizPfG74=;
        b=mwQiD8HvoLBGO9WbgIOw1/0nztIbw8SRnfpjpG2N9SGx4h21PavZDIqGrVb/4KT6p7
         BT7vQBu6hcHpOwg8a6b23cEE6z+wyn+/xWmnFjK1rX5uiZjX/3J486tOwEnp3HZL1wHW
         uPYA1PwFftMacB6THrWCOX9aSJV121Q7wPx1PHw8x1azNqfHPjv16REdiCmI+UsfwFep
         9wDoq5lIBIggQRmTXLJqhqCxXf7RThw2mkIEa3s0viKKCWvZoU+x1NMYUZFgNUUtzX+p
         1arjWbK0SPXDkld90iqRCudPVV/MychkrTiqk43/Q32HPJNFCT/ZngGEef6p2n7u1wD0
         slyw==
X-Gm-Message-State: AJcUukeLBuTYR7p1T8x/aXOIsHwELcRNNBjM+a3COz1ay2/nWIGcHuQD
        TVEJKQruzFhUovLQedUfh5FVmr9V
X-Google-Smtp-Source: ALg8bN4vJ5smryfdQXULkrFLlGtpwE+4A+oI3zaZp2vwOmnmytU5SZAFsI/skWAv3KCqh32Z4GwieQ==
X-Received: by 2002:a50:a347:: with SMTP id 65mr10806929edn.40.1548419013217;
        Fri, 25 Jan 2019 04:23:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y4-v6sm6425669ejc.10.2019.01.25.04.23.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 04:23:32 -0800 (PST)
Date:   Fri, 25 Jan 2019 04:23:32 -0800 (PST)
X-Google-Original-Date: Fri, 25 Jan 2019 12:23:24 GMT
Message-Id: <91b1963125f7dfdd46fe5166125ee59ef2557b13.1548419009.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.103.v4.git.gitgitgadget@gmail.com>
References: <pull.103.v3.git.gitgitgadget@gmail.com>
        <pull.103.v4.git.gitgitgadget@gmail.com>
From:   "Daniel Ferreira via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 2/7] add--helper: create builtin helper for interactive add
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Daniel Ferreira <bnmvco@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Daniel Ferreira <bnmvco@gmail.com>

Create a builtin helper for git-add--interactive, which right now is not
able to do anything.

This is the first step in an effort to convert git-add--interactive.perl
to a C builtin, in search for better portability, expressibility and
performance (specially on non-POSIX systems like Windows).

Additionally, an eventual complete port of git-add--interactive would
remove the last "big" Git script to have Perl as a dependency, allowing
most Git users to have a NOPERL build running without big losses.

Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>
Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
---
 .gitignore            | 1 +
 Makefile              | 1 +
 builtin.h             | 1 +
 builtin/add--helper.c | 6 ++++++
 git.c                 | 1 +
 5 files changed, 10 insertions(+)
 create mode 100644 builtin/add--helper.c

diff --git a/.gitignore b/.gitignore
index 0d77ea5894..2ee71ed217 100644
--- a/.gitignore
+++ b/.gitignore
@@ -15,6 +15,7 @@
 /git
 /git-add
 /git-add--interactive
+/git-add--helper
 /git-am
 /git-annotate
 /git-apply
diff --git a/Makefile b/Makefile
index 1a44c811aa..9c84b80739 100644
--- a/Makefile
+++ b/Makefile
@@ -1023,6 +1023,7 @@ LIB_OBJS += xdiff-interface.o
 LIB_OBJS += zlib.o
 
 BUILTIN_OBJS += builtin/add.o
+BUILTIN_OBJS += builtin/add--helper.o
 BUILTIN_OBJS += builtin/am.o
 BUILTIN_OBJS += builtin/annotate.o
 BUILTIN_OBJS += builtin/apply.o
diff --git a/builtin.h b/builtin.h
index 6538932e99..dd811ef7d5 100644
--- a/builtin.h
+++ b/builtin.h
@@ -128,6 +128,7 @@ extern void setup_auto_pager(const char *cmd, int def);
 extern int is_builtin(const char *s);
 
 extern int cmd_add(int argc, const char **argv, const char *prefix);
+extern int cmd_add__helper(int argc, const char **argv, const char *prefix);
 extern int cmd_am(int argc, const char **argv, const char *prefix);
 extern int cmd_annotate(int argc, const char **argv, const char *prefix);
 extern int cmd_apply(int argc, const char **argv, const char *prefix);
diff --git a/builtin/add--helper.c b/builtin/add--helper.c
new file mode 100644
index 0000000000..6a97f0e191
--- /dev/null
+++ b/builtin/add--helper.c
@@ -0,0 +1,6 @@
+#include "builtin.h"
+
+int cmd_add__helper(int argc, const char **argv, const char *prefix)
+{
+	return 0;
+}
diff --git a/git.c b/git.c
index 2f604a41ea..5507591f2e 100644
--- a/git.c
+++ b/git.c
@@ -443,6 +443,7 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 
 static struct cmd_struct commands[] = {
 	{ "add", cmd_add, RUN_SETUP | NEED_WORK_TREE },
+	{ "add--helper", cmd_add__helper, RUN_SETUP | NEED_WORK_TREE },
 	{ "am", cmd_am, RUN_SETUP | NEED_WORK_TREE },
 	{ "annotate", cmd_annotate, RUN_SETUP | NO_PARSEOPT },
 	{ "apply", cmd_apply, RUN_SETUP_GENTLY },
-- 
gitgitgadget

