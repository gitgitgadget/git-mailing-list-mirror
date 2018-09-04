Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6C4C1F404
	for <e@80x24.org>; Tue,  4 Sep 2018 21:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbeIEByG (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 21:54:06 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37144 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbeIEByF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 21:54:05 -0400
Received: by mail-pg1-f193.google.com with SMTP id 2-v6so2292031pgo.4
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 14:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=anopz/elHvmwmNv5JomhuAYLyYvnMAQyZgWdzh82OkQ=;
        b=fJ1qINoNl98qkvAY/wVteBLfVA0LixpGqKCjnxsVEp461ltnOxkVnA9HMwj3vg+/N0
         THFZtx7Na2kFWXeEX4Mq+ajVM4Nzv7Unz3lHWL9+CZy1X5Cjv2rBUmCAtAIFr0tIojWl
         ewFvm09EiM0864aYlouKJ10G66Npb5w+22BpU6P7/OGVU/DfNc2Embb5xhbJN+kWpMOV
         /duD69xlOS3rWis6VzCJq065wCz2grKRJaC/+eHfQGXl1d2vfIcsH9BdqjlWHOrxlpN8
         qmbJL24Jd2iqdfo+ZZqWbdGEckzrRS99x2Q56u9aA/DRgUJm9hOedyEd1sVBG8Ez+lXa
         94TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=anopz/elHvmwmNv5JomhuAYLyYvnMAQyZgWdzh82OkQ=;
        b=Ge6uiPnTdGidrrwgbTP2B/Myi40lNO81WWLEO/llBThqiDsmRyyH/zhqhf8MRus1BC
         umDnmv1zKcrrjR81ESYdbhPRxnDAOzhxParp3vHn8Thf+ucOaDCRVyANMAP3Zzx1mcQ8
         i6HqMHmY3G+ETiXE+/c6B6pGSIkn4JNfYwoGzIBBMba7BlQTx5C8IshRzpFO6UGoIvTR
         qQNVMBrxCPIz9ZEYs22fhv/t95kdPG3YwYyFGTcVpdkotvz/PzdgWK1uFnl8MhQ6U3xl
         MxhdFq9Gj7WB92/99wc2d6+UXIFDqwXDn89IzxoXZABGHGNWMZMZiS708ChgrUvXowV6
         K/gg==
X-Gm-Message-State: APzg51Cc1DOlIwI0LxUKdon/cBx+mmwVyFIhnX+GPO1tZ5celTvgdiP3
        fP1J7mHEEq970WxxU36uMl+1RgU/
X-Google-Smtp-Source: ANB0Vdb+xKMxeQIgAUszKXbEWaIQTqpnKyH5qufwrXMjZ/7JDs/3wDJYy/v5a6Mn76p9iJUixnCPrw==
X-Received: by 2002:a63:c00b:: with SMTP id h11-v6mr32924402pgg.279.1536096428563;
        Tue, 04 Sep 2018 14:27:08 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id e26-v6sm27115356pfi.70.2018.09.04.14.27.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 14:27:07 -0700 (PDT)
Date:   Tue, 04 Sep 2018 14:27:07 -0700 (PDT)
X-Google-Original-Date: Tue, 04 Sep 2018 21:26:54 GMT
Message-Id: <fba1b3e2a91a85e68ccfcca8ad0a84c7758936a3.1536096424.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.32.v2.git.gitgitgadget@gmail.com>
References: <20180808134830.19949-1-predatoramigo@gmail.com>
        <pull.32.v2.git.gitgitgadget@gmail.com>
From:   "Pratik Karki via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 01/11] builtin rebase: support --onto
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Pratik Karki <predatoramigo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pratik Karki <predatoramigo@gmail.com>

The `--onto` option is important, as it allows to rebase a range of
commits onto a different base commit (which gave the command its odd
name: "rebase").

This commit introduces options parsing so that different options can
be added in future commits.

Note: As this commit introduces to the parse_options() call (which
"eats" argv[0]), the argc is now expected to be lower by one after this
patch, compared to before this patch: argv[0] no longer refers to the
command name, but to the first (non-option) command-line parameter.

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index e695d8a430..742ed31498 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -16,6 +16,16 @@
 #include "cache-tree.h"
 #include "unpack-trees.h"
 #include "lockfile.h"
+#include "parse-options.h"
+
+static char const * const builtin_rebase_usage[] = {
+	N_("git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] "
+		"[<upstream>] [<branch>]"),
+	N_("git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] "
+		"--root [<branch>]"),
+	N_("git rebase --continue | --abort | --skip | --edit-todo"),
+	NULL
+};
 
 static GIT_PATH_FUNC(apply_dir, "rebase-apply")
 static GIT_PATH_FUNC(merge_dir, "rebase-merge")
@@ -301,6 +311,12 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	int ret, flags;
 	struct strbuf msg = STRBUF_INIT;
 	struct strbuf revisions = STRBUF_INIT;
+	struct option builtin_rebase_options[] = {
+		OPT_STRING(0, "onto", &options.onto_name,
+			   N_("revision"),
+			   N_("rebase onto given branch instead of upstream")),
+		OPT_END(),
+	};
 
 	/*
 	 * NEEDSWORK: Once the builtin rebase has been tested enough
@@ -318,13 +334,22 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			BUG("sane_execvp() returned???");
 	}
 
-	if (argc != 2)
-		die(_("Usage: %s <base>"), argv[0]);
+	if (argc == 2 && !strcmp(argv[1], "-h"))
+		usage_with_options(builtin_rebase_usage,
+				   builtin_rebase_options);
+
 	prefix = setup_git_directory();
 	trace_repo_setup(prefix);
 	setup_work_tree();
 
 	git_config(git_default_config, NULL);
+	argc = parse_options(argc, argv, prefix,
+			     builtin_rebase_options,
+			     builtin_rebase_usage, 0);
+
+	if (argc > 2)
+		usage_with_options(builtin_rebase_usage,
+				   builtin_rebase_options);
 
 	switch (options.type) {
 	case REBASE_MERGE:
@@ -343,10 +368,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	}
 
 	if (!options.root) {
-		if (argc < 2)
+		if (argc < 1)
 			die("TODO: handle @{upstream}");
 		else {
-			options.upstream_name = argv[1];
+			options.upstream_name = argv[0];
 			argc--;
 			argv++;
 			if (!strcmp(options.upstream_name, "-"))
@@ -377,7 +402,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	 * orig_head -- commit object name of tip of the branch before rebasing
 	 * head_name -- refs/heads/<that-branch> or "detached HEAD"
 	 */
-	if (argc > 1)
+	if (argc > 0)
 		 die("TODO: handle switch_to");
 	else {
 		/* Do not need to switch branches, we are already on it. */
-- 
gitgitgadget

