Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F1071F453
	for <e@80x24.org>; Wed, 20 Feb 2019 11:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbfBTLlc (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Feb 2019 06:41:32 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33265 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbfBTLlc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Feb 2019 06:41:32 -0500
Received: by mail-ed1-f66.google.com with SMTP id c55so1846088edb.0
        for <git@vger.kernel.org>; Wed, 20 Feb 2019 03:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IexQ6Me58SUukPm6bR+UsHfgWpM5fMfQ77DJoKkSyVo=;
        b=atxDuhEipID8Uypcj9aasxMoMAfZEtEDqtl7FKobxI91rOLr6/w1iO9uMJMQSeFZXA
         M57oP6bp4UPrYncC62VHGXNn9bIreJeRAfLtMRcbillYasAMy6+hrmfhI9rtgnMqzeDK
         Q/37ygJ5ClJYCfawoaGh5VkJy8ijvgtmcMJfmCuFDGKj45Fa2ThYm3xcbBPbPYRGMe6a
         dgpcJMyBLG/EUbWQhhVhmy9guNYUCoHFvwsbO3uTaoNKNVqymO5eeFC2U4Mdhv4xjwuY
         UmFpNHSvYqWkQCOa6KKPzDyW+eQ0sorRbL2Gcwq44/k9vw85SNoF3HnbBZR9Ke36qhjR
         dotQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IexQ6Me58SUukPm6bR+UsHfgWpM5fMfQ77DJoKkSyVo=;
        b=kwuLgfRsfQGmnr8vkM+ObGlSk/hJYmJCdr+ZF+5WKJeC0RH+Pz4hipSFUP7Ge/pC7l
         3fapiYBH8vnLrtg6TL6yUBMWx3dz6xrficcymzveNYcLjSc2ZQZHqy8f/jbuk1IetUgf
         VG6vLGHqEUQEEyayEbFkZ2e1Ch3EZHvwjttrBkqERnUnizK0rYD7oWlA3EeS6o/hwE3A
         wT+nFI8NFuzgMDedOKu0Hv6U04d6d60uyRxUwyDM35NPFTlmdQk/UerxD6fmHjlGT8Uh
         kfEkMbZFc7pdpRqJ2WGdJcrmNAnyT544TEz417lURibfp7Y9zMK6nlikwVzWMQW1Hm+Q
         ebdg==
X-Gm-Message-State: AHQUAuYSIpwGlfGNufcIsMQcx3ULoonX3o8/kzPMHENIK6Bzwwhqqr8w
        DhXg73LhD4MeF0jaBhBDwTQYduuc
X-Google-Smtp-Source: AHgI3IZLo++ddCKrGAkEj7t2O8k559APMSd0DY5YhSBb17UjseRUBf05x45C6jFrNQKVkDSEcFYrKw==
X-Received: by 2002:aa7:cb52:: with SMTP id w18mr15965821edt.257.1550662890271;
        Wed, 20 Feb 2019 03:41:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y24sm5756151eds.35.2019.02.20.03.41.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 03:41:29 -0800 (PST)
Date:   Wed, 20 Feb 2019 03:41:29 -0800 (PST)
X-Google-Original-Date: Wed, 20 Feb 2019 11:41:19 GMT
Message-Id: <304c3863b123e08536412019e881967bf01dc4a4.1550662887.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.103.v5.git.gitgitgadget@gmail.com>
References: <pull.103.v4.git.gitgitgadget@gmail.com>
        <pull.103.v5.git.gitgitgadget@gmail.com>
From:   "Daniel Ferreira via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 02/10] add--helper: create builtin helper for interactive
 add
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Daniel Ferreira <bnmvco@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Daniel Ferreira <bnmvco@gmail.com>

Create a builtin helper for git-add--interactive, which at this point
is not doing anything.

This is the first step in an effort to convert git-add--interactive.perl
to a C builtin, in search for better portability, expressibility and
performance (specially on non-POSIX systems like Windows).

Additionally, an eventual complete port of git-add--interactive would
remove the last "big" Git script to have Perl as a dependency, allowing
most Git users to have a NOPERL build running without big losses.

Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
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
index 7374587f9d..7b6d7681f9 100644
--- a/.gitignore
+++ b/.gitignore
@@ -16,6 +16,7 @@
 /git
 /git-add
 /git-add--interactive
+/git-add--helper
 /git-am
 /git-annotate
 /git-apply
diff --git a/Makefile b/Makefile
index f0b2299172..e64e202deb 100644
--- a/Makefile
+++ b/Makefile
@@ -1043,6 +1043,7 @@ LIB_OBJS += xdiff-interface.o
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
index 2dd588674f..cb42591f37 100644
--- a/git.c
+++ b/git.c
@@ -444,6 +444,7 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 
 static struct cmd_struct commands[] = {
 	{ "add", cmd_add, RUN_SETUP | NEED_WORK_TREE },
+	{ "add--helper", cmd_add__helper, RUN_SETUP | NEED_WORK_TREE },
 	{ "am", cmd_am, RUN_SETUP | NEED_WORK_TREE },
 	{ "annotate", cmd_annotate, RUN_SETUP | NO_PARSEOPT },
 	{ "apply", cmd_apply, RUN_SETUP_GENTLY },
-- 
gitgitgadget

