Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 660F51F404
	for <e@80x24.org>; Mon, 13 Aug 2018 11:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbeHMOO5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 10:14:57 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38849 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728661AbeHMOO4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 10:14:56 -0400
Received: by mail-pf1-f195.google.com with SMTP id x17-v6so7530790pfh.5
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 04:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/aLUo0ESp4syeXDLBwRxK6plUus5IjCwAIBaeoNjDHE=;
        b=AsFCwFMcMS8nm0xCfwqX7evVorhIm6eBlqfroAha+euCpBlukehSaWXlK72uSjcgnR
         XpydEqh1kqICtdXplMayU6pziym9UEVVRbuKHZzDTFAPv8sO+OYZsoopiP5DzfQJsCOk
         qw5mRtgpnPapNpwAWYy1zy0p/ohEw3VzckWaGHHRjf900sRCtmek/pgOP9s6ufiNEK1Q
         9Nqsrovk4i81AdAMA1FsCMDIAHJSclh0kdHO2h++yTKeFyI15q7NchLUujreNam6U08Z
         f54LS38DlLWo7D2UmBY5FSs2WE6AOFHKyiXo/tamJqU7g+44Uy1294pHBvHHmgVJcRWv
         fFlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/aLUo0ESp4syeXDLBwRxK6plUus5IjCwAIBaeoNjDHE=;
        b=XDOnEPWQMyc+CR9QGrxvR4ijdbA7a2gmdL7FjXKlfivQMsuTDYwHiVwdEpDGlrha/V
         /094d/RkVgUNjkHujq8r3WjYgab1y44msoq+KydokdoX4eyVGquK2TLfdtA9fuZWhKtF
         jzVpRDCPsIwfFv0RNsBCY+sR+Hur73KjZRUeF7nEFPU/nvaHk46mJ5oX52iEn8AY1noG
         AP8g1K4Hh0Js4ehpFeX3kd78Lg6LXwiGRbXOTjjMZI+U7Y/od646iZiNgCqfizzrjWKj
         CDlZGCVR6iQZRj/squZ52vhTjgIbNC3FtCHy9TXl7DS8SRu0DrBKjr0ozC5odcr1I+Va
         rZTQ==
X-Gm-Message-State: AOUpUlFOG6SwNlmMBafkoAQatza2JnaKHtvi1taY8InDwFWLSj5tGwQC
        IIUQfhiV/TMI2UESj5WMAXAiy/Ju
X-Google-Smtp-Source: AA+uWPxuN70zSaf9a0hBQzbDcIC6boZEU1xMBbJ7HheHAeAaj92LiSd/Q+/s0ZBC42AhH8YVgH5qSA==
X-Received: by 2002:a62:280a:: with SMTP id o10-v6mr15561645pfo.129.1534159983247;
        Mon, 13 Aug 2018 04:33:03 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id e73-v6sm37624589pfb.153.2018.08.13.04.33.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 04:33:02 -0700 (PDT)
Date:   Mon, 13 Aug 2018 04:33:02 -0700 (PDT)
X-Google-Original-Date: Mon, 13 Aug 2018 11:32:37 GMT
Message-Id: <33758f361c4cbe47bca50d10d61ff36bf6da2b5a.1534159977.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1.v6.git.gitgitgadget@gmail.com>
References: <pull.1.v5.git.gitgitgadget@gmail.com>
        <pull.1.v6.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v6 02/21] Introduce `range-diff` to compare iterations of a
 topic branch
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

This command does not do a whole lot so far, apart from showing a usage
that is oddly similar to that of `git tbdiff`. And for a good reason:
the next commits will turn `range-branch` into a full-blown replacement
for `tbdiff`.

At this point, we ignore tbdiff's color options, as they will all be
implemented later using diff_options.

Since f318d739159 (generate-cmds.sh: export all commands to
command-list.h, 2018-05-10), every new command *requires* a man page to
build right away, so let's also add a blank man page, too.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .gitignore                       |  1 +
 Documentation/git-range-diff.txt | 10 ++++++++++
 Makefile                         |  1 +
 builtin.h                        |  1 +
 builtin/range-diff.c             | 25 +++++++++++++++++++++++++
 command-list.txt                 |  1 +
 git.c                            |  1 +
 7 files changed, 40 insertions(+)
 create mode 100644 Documentation/git-range-diff.txt
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
diff --git a/Documentation/git-range-diff.txt b/Documentation/git-range-diff.txt
new file mode 100644
index 000000000..49f717db8
--- /dev/null
+++ b/Documentation/git-range-diff.txt
@@ -0,0 +1,10 @@
+git-range-diff(1)
+=================
+
+NAME
+----
+git-range-diff - Compare two commit ranges (e.g. two versions of a branch)
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index 1af719b44..7ff7eba42 100644
--- a/Makefile
+++ b/Makefile
@@ -1063,6 +1063,7 @@ BUILTIN_OBJS += builtin/prune-packed.o
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
index fc7d15d54..5b48cac3a 100644
--- a/git.c
+++ b/git.c
@@ -520,6 +520,7 @@ static struct cmd_struct commands[] = {
 	{ "prune-packed", cmd_prune_packed, RUN_SETUP },
 	{ "pull", cmd_pull, RUN_SETUP | NEED_WORK_TREE },
 	{ "push", cmd_push, RUN_SETUP },
+	{ "range-diff", cmd_range_diff, RUN_SETUP | USE_PAGER },
 	{ "read-tree", cmd_read_tree, RUN_SETUP | SUPPORT_SUPER_PREFIX},
 	{ "rebase--helper", cmd_rebase__helper, RUN_SETUP | NEED_WORK_TREE },
 	{ "receive-pack", cmd_receive_pack },
-- 
gitgitgadget

