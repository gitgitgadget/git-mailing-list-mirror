Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72CD11F453
	for <e@80x24.org>; Mon, 21 Jan 2019 09:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbfAUJNq (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Jan 2019 04:13:46 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39974 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfAUJNo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jan 2019 04:13:44 -0500
Received: by mail-ed1-f65.google.com with SMTP id g22so15964629edr.7
        for <git@vger.kernel.org>; Mon, 21 Jan 2019 01:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6Y2WvcczK8cknroo/M285WWWCxDBVS1J4gBLizPfG74=;
        b=Lsw6ShRKDh1OEa8+DmKB5b4HtGLQvpWWRJfDYkoOg/EXPe3yJIg+/x+IqCdtd0l3uV
         nphIyt+Bws+xBh3k+A+mCv5JlWrPY/kU3JyH4oCPdLOMk3sRrfFCV/cMX24rajZEDXsS
         3CoaW8hlqPhHj0Eles6FtoFpuz/SzUE2vriMoI9z7Ll0LnxS/ceZVaTQbREUrse3q4ca
         qK5x+kTSLCca3GO/H9AKxLSjz8GoDpIA5V2FjyfsQ4q24cawSpg9q3gH3EiIaSuqa25X
         cqTOTem7omrhAH4jt9Scd59XLTPExwCCHKZmVap97BgHJCrDPkoy98JVytwinB1emmPG
         fsCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6Y2WvcczK8cknroo/M285WWWCxDBVS1J4gBLizPfG74=;
        b=O9iKdiSu5E57XlDoDv8ez1Vphm0PGtoEH/gny3LxKv2zfXhOY9yJCdoopwHvB1prIc
         FckEvlai/d4cDa2uSUAMATF4J0qsdp551JhDzhPUMq2p0blq2AYazT2Ty/2Cp5iN9gcH
         hK2k5oAvCVGjwJec1L4ufHVkTNldcBStJMDAzpi0HhJXhDKHM5Udy0Z4yfMoT1VLF64M
         c2k3yli33LIjVTXcLLHkMRbSOZ06hLJdhajooLKb3jJf9uQiFQfNtddwkwXx7cG86wMX
         jIHq5fXjqCczfU541r5EETQkJGnj6JFcLfBIbfN7m6KJMkMTfGTJGEmHXbwbZkJQ9Xp/
         WEKA==
X-Gm-Message-State: AJcUukfy1LzXIeY0POQVagpEylPFZbHxCRilxX0lMJd6X0VkgfqBa2lo
        5gPB2kg0XpS6E59m9ON3jDFQplwP
X-Google-Smtp-Source: ALg8bN4sw8wlkNmookemkZ0sxk2G7RKJ1sSLasHDkmNb2JYV373dsaJ0+9laiOaFxdGWOBOaxdSFGw==
X-Received: by 2002:a50:a3d1:: with SMTP id t17mr26712811edb.238.1548062022596;
        Mon, 21 Jan 2019 01:13:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ga24-v6sm4916692ejb.72.2019.01.21.01.13.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 01:13:42 -0800 (PST)
Date:   Mon, 21 Jan 2019 01:13:42 -0800 (PST)
X-Google-Original-Date: Mon, 21 Jan 2019 09:13:34 GMT
Message-Id: <91b1963125f7dfdd46fe5166125ee59ef2557b13.1548062019.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.103.v3.git.gitgitgadget@gmail.com>
References: <pull.103.v2.git.gitgitgadget@gmail.com>
        <pull.103.v3.git.gitgitgadget@gmail.com>
From:   "Daniel Ferreira via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 2/7] add--helper: create builtin helper for interactive add
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
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

