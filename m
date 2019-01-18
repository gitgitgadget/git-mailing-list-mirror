Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BE791F453
	for <e@80x24.org>; Fri, 18 Jan 2019 07:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfARHrI (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 02:47:08 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34328 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbfARHrG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 02:47:06 -0500
Received: by mail-ed1-f66.google.com with SMTP id b3so10466816ede.1
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 23:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6Y2WvcczK8cknroo/M285WWWCxDBVS1J4gBLizPfG74=;
        b=Txaonq5RtxxuWIHIAwRiMtVG53vFtIKCqysmc36AoNPVIHXrYI7jJH+vBj8KvrPdi1
         l36dpl1Qq8aMZMheZH5oROV+Jxy8sTZK7/1S/bMJ6yZRU6/G4c5oDhR90pf6mLeZ1pGN
         jtB6fnMzaVYGw/PEmSPc8Aku0+TkH6zBQlnMKO8fCrdaEvBWhdwp5I4UxYtsPOPd2xNA
         id4OnCUUrc+Y+JH5iXqdYntgJNP5Hjr6OY0Tq+lvRoB73RwkTo8lI1pDcud4KFBirmuW
         8kRdwRsJscnPTzKHYwBZ3i582jtZ7Zhoitqg/NHEKQ95Jajuye9dAVGvB08HfsJJlW21
         zDoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6Y2WvcczK8cknroo/M285WWWCxDBVS1J4gBLizPfG74=;
        b=GdAZKB8G5/x9nGjfJ8Q1sSc65UzX6G6lPaBqJbmXB3LuINfvNT6hE6gZb45eDAPRKo
         DYl689Edxkm1yhmb7PmTd5nxYkNyNrgEeqbn9ovU5Jhqymy2rEgRIVFez0TDFB7X4WCe
         PPhDLwB+/NYYojanZef4juORoJCCyPSfVvVl80RI28n9SDNZWEe7CFCKYX/FX+3oZxpR
         WUmsPkKSmtuUcmW9TI8BQfb+Otwl6Slzemy4LMRhpWwIQg2XAgqediGTgNuyb5g114z0
         ZuhSc8L2AkqcWaUsG219dYIt5pDz5V1ebZ0RbipnYewbyGQLm4fSCQw1Ey9fl7hbCYbc
         C0BA==
X-Gm-Message-State: AJcUukfyPB2HomiCowdXUzbuHslhJsq1NhQCJnxrzup71ET6+ViDPVQs
        8URcu5mBACD4TNR/14U0ahiZby+i
X-Google-Smtp-Source: ALg8bN6t8YEwuieYG19C0TMAgzxWfxDrhRDa2EwDS2rh7f7p+B5LOm+1qfwDqZ6/WI4AmfrmEm026g==
X-Received: by 2002:a17:906:20c2:: with SMTP id c2-v6mr13645864ejc.241.1547797624210;
        Thu, 17 Jan 2019 23:47:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x38sm7124165edx.24.2019.01.17.23.47.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 23:47:03 -0800 (PST)
Date:   Thu, 17 Jan 2019 23:47:03 -0800 (PST)
X-Google-Original-Date: Fri, 18 Jan 2019 07:46:55 GMT
Message-Id: <91b1963125f7dfdd46fe5166125ee59ef2557b13.1547797620.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.103.v2.git.gitgitgadget@gmail.com>
References: <pull.103.git.gitgitgadget@gmail.com>
        <pull.103.v2.git.gitgitgadget@gmail.com>
From:   "Daniel Ferreira via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 2/7] add--helper: create builtin helper for interactive add
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
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

