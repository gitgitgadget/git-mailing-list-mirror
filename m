Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.9 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_96_XX,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1C041F660
	for <e@80x24.org>; Tue,  3 Jul 2018 11:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753123AbeGCL11 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 07:27:27 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36398 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753166AbeGCL0N (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 07:26:13 -0400
Received: by mail-pf0-f196.google.com with SMTP id u16-v6so879309pfh.3
        for <git@vger.kernel.org>; Tue, 03 Jul 2018 04:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc:cc;
        bh=jRO0x+R8SOGG6rYALhu+29hgkvNOW65Zq8ppbqsOjEI=;
        b=ERH0xLwX/tLOkIAyZNyZrfdEp2aIOR69uBYvJpSMmhp260LiD8QT75tChT53+fxwEA
         jlq8jluqHoeuO0RxBun69s8vScMT41YxVPZN5sAS7UuFE3CX6PcHHIhfooC95vCCbWub
         1ojfYMTNN+eS937zcPAU5s0i74yT0KNz0kuw9nbU8WtYYvwg91yNbCoBX7CDv+eM1pv4
         R5lNhVcek7KUcgv2D2fABpCBEc4pAoBPtFABl2w+9B/uI44EtpZXZ76AIYxICjVPHQ+K
         MUjSw3gHV8LTJM+WWBrl3o96pw5KbY9Io7qfO8kfgeVJnh7GXzIcGEpidBRFb/rk95Zd
         rkrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc:cc;
        bh=jRO0x+R8SOGG6rYALhu+29hgkvNOW65Zq8ppbqsOjEI=;
        b=LOzA9p+9F6FqTPnhEtlsZQdrLQ0KWQO+6uPEnTMROpP53N5s3yu/3HMPGLFWrS22jn
         MS8efmcnlm86lzsMviB3TcFVqiZBlAVxMpV+VJ0AyaFSQGP7EOvfoxp5Mhkzr4JtEYgJ
         dY2A3EkUwcUXdkwKRJ08Xcvu34JXTmYOsEX/iTlq5aJFTH0X2VGeXB5754T2J9ATtwyy
         AhUuliB1EGlWknR/0KNkUuHb82yW60WsNWFjsSPpu+NlZoTdlVLWutnpHZ19vZqPCD4U
         y6DnRetevBLJfvlPbICp3PCQzixP+Clfffe8kS642rsf8DCxDEa/Ffu38NJSxnQqyFjj
         TO4g==
X-Gm-Message-State: APt69E3gh8+iwhRGmrfS2Tlsiis4sjxwXfurusKv/cK2DG6FVphlevZU
        g0e4c6w5HGXuP5+DzFk19SiTdQ==
X-Google-Smtp-Source: AAOMgpdsZNR2YPrvWZ1ucWZqJa2Z9mhkA2cUtFBHUuLFG53g+SjFey8AtsJqy3tpF520nefttkdVsw==
X-Received: by 2002:a65:6109:: with SMTP id z9-v6mr13228804pgu.243.1530617172289;
        Tue, 03 Jul 2018 04:26:12 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id u17-v6sm6225108pfa.176.2018.07.03.04.26.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 04:26:11 -0700 (PDT)
Message-Id: <7f15b26d4eaeca276ae2050584ff632b012787f2.1530617166.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1.v3.git.gitgitgadget@gmail.com>
References: <cover.1525448066.git.johannes.schindelin@gmx.de>
        <pull.1.v3.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 1 May 2018 21:42:28 +0200
Subject: [PATCH v3 02/20] Introduce `range-diff` to compare iterations of a
 topic branch
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This command does not do a whole lot so far, apart from showing a usage
that is oddly similar to that of `git tbdiff`. And for a good reason:
the next commits will turn `range-branch` into a full-blown replacement
for `tbdiff`.

At this point, we ignore tbdiff's color options, as they will all be
implemented later using diff_options.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .gitignore           |  1 +
 Makefile             |  1 +
 builtin.h            |  1 +
 builtin/range-diff.c | 25 +++++++++++++++++++++++++
 command-list.txt     |  1 +
 git.c                |  1 +
 6 files changed, 30 insertions(+)
 create mode 100644 builtin/range-diff.c

diff --git a/.gitignore b/.gitignore
index 3284a1e9b..cc0ad74b4 100644
--- a/.gitignore
+++ b/.gitignore
@@ -113,6 +113,7 @@
 /git-pull
 /git-push
 /git-quiltimport
+/git-range-diff
 /git-read-tree
 /git-rebase
 /git-rebase--am
diff --git a/Makefile b/Makefile
index c5ba124f1..190384cae 100644
--- a/Makefile
+++ b/Makefile
@@ -1059,6 +1059,7 @@ BUILTIN_OBJS += builtin/prune-packed.o
 BUILTIN_OBJS += builtin/prune.o
 BUILTIN_OBJS += builtin/pull.o
 BUILTIN_OBJS += builtin/push.o
+BUILTIN_OBJS += builtin/range-diff.o
 BUILTIN_OBJS += builtin/read-tree.o
 BUILTIN_OBJS += builtin/rebase--helper.o
 BUILTIN_OBJS += builtin/receive-pack.o
diff --git a/builtin.h b/builtin.h
index 0362f1ce2..99206df4b 100644
--- a/builtin.h
+++ b/builtin.h
@@ -201,6 +201,7 @@ extern int cmd_prune(int argc, const char **argv, const char *prefix);
 extern int cmd_prune_packed(int argc, const char **argv, const char *prefix);
 extern int cmd_pull(int argc, const char **argv, const char *prefix);
 extern int cmd_push(int argc, const char **argv, const char *prefix);
+extern int cmd_range_diff(int argc, const char **argv, const char *prefix);
 extern int cmd_read_tree(int argc, const char **argv, const char *prefix);
 extern int cmd_rebase__helper(int argc, const char **argv, const char *prefix);
 extern int cmd_receive_pack(int argc, const char **argv, const char *prefix);
diff --git a/builtin/range-diff.c b/builtin/range-diff.c
new file mode 100644
index 000000000..36788ea4f
--- /dev/null
+++ b/builtin/range-diff.c
@@ -0,0 +1,25 @@
+#include "cache.h"
+#include "builtin.h"
+#include "parse-options.h"
+
+static const char * const builtin_range_diff_usage[] = {
+N_("git range-diff [<options>] <old-base>..<old-tip> <new-base>..<new-tip>"),
+N_("git range-diff [<options>] <old-tip>...<new-tip>"),
+N_("git range-diff [<options>] <base> <old-tip> <new-tip>"),
+NULL
+};
+
+int cmd_range_diff(int argc, const char **argv, const char *prefix)
+{
+	int creation_factor = 60;
+	struct option options[] = {
+		OPT_INTEGER(0, "creation-factor", &creation_factor,
+			    N_("Percentage by which creation is weighted")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, NULL, options,
+			     builtin_range_diff_usage, 0);
+
+	return 0;
+}
diff --git a/command-list.txt b/command-list.txt
index e1c26c1bb..a9dda3b8a 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -139,6 +139,7 @@ git-prune-packed                        plumbingmanipulators
 git-pull                                mainporcelain           remote
 git-push                                mainporcelain           remote
 git-quiltimport                         foreignscminterface
+git-range-diff                          mainporcelain
 git-read-tree                           plumbingmanipulators
 git-rebase                              mainporcelain           history
 git-receive-pack                        synchelpers
diff --git a/git.c b/git.c
index 9dbe6ffaa..13e37f1e3 100644
--- a/git.c
+++ b/git.c
@@ -517,6 +517,7 @@ static struct cmd_struct commands[] = {
 	{ "prune-packed", cmd_prune_packed, RUN_SETUP },
 	{ "pull", cmd_pull, RUN_SETUP | NEED_WORK_TREE },
 	{ "push", cmd_push, RUN_SETUP },
+	{ "range-diff", cmd_range_diff, RUN_SETUP | USE_PAGER },
 	{ "read-tree", cmd_read_tree, RUN_SETUP | SUPPORT_SUPER_PREFIX},
 	{ "rebase--helper", cmd_rebase__helper, RUN_SETUP | NEED_WORK_TREE },
 	{ "receive-pack", cmd_receive_pack },
-- 
gitgitgadget

