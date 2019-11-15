Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 640731F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 12:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbfKOMge (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 07:36:34 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46722 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727628AbfKOMga (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 07:36:30 -0500
Received: by mail-wr1-f65.google.com with SMTP id b3so10794459wrs.13
        for <git@vger.kernel.org>; Fri, 15 Nov 2019 04:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+aeG46lF7Hex/vXHBat13Ws6AAx+3WqVKgob/BMugWY=;
        b=dIGuTlX++H2MQVjP30NjP60pRX7ql+eD4c7snDMaSzNkRAHc5d3EqDQYDpKtmtfr/p
         ODXmAmn9DE929Mu/N+7qSfehROEgjuQdbpDIc9HZaRuSgNjoVsv1gE2xL4yW8DzG+FrF
         iuOL/W90ZbCIffgQOvOOF267iWFFe/V+9vi/Cp/31jWUbzPOFKe9SyLPC7wqMI4ZGtOd
         t3Rnsk4Qao+WLU+Tm//MW297daNEniBG4uDG+kemrOoCQBfNEk5EyWUF/PJAFfqLBeIX
         +faCziv++8ePhWrOWe49lkW+CoSPmLy+6TLzSV8b2UqnRoevmZc6WQ0f8ztk4sto8kPo
         AUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+aeG46lF7Hex/vXHBat13Ws6AAx+3WqVKgob/BMugWY=;
        b=GEawtmogi3ZeE+qb9W0bCqo2sPL9/8yXUIYXCsuwA6W53jOsK5Htv7v4vQKxZeQxAT
         m7Mxo2aexUEUV5aRi3RcRRFk1FYwTR0oEjEsjmQgCPFwPUoKGH7S43pCau8BPTpOuPf+
         eAANPQofHhYE1U+MURKf5YF/eiDiJqAvqul6QNEMbOJ1z8mR3IKNLG9ZiWUnWxUZOZhY
         XlXbDhgJYJ/jM6grH2rzldrXEdAKeNTVDTdGcbjt7o606g7xTY4A4R2wEpNaMH28yDjP
         ngALuOFe7YSnva1t+SjSVqwlsGM0PoEfiPStdKB/jEmisxpflkB7YFOadosbl29zVzRY
         ZK+g==
X-Gm-Message-State: APjAAAVfG3eco0ag8AsLzXG4oVthG8ROUqAIWSep+fetR1PQZkX5HdkL
        YYAHDmDf7rAmjrkrg69xq0OuMyp1
X-Google-Smtp-Source: APXvYqzeBSIjBHU0SvPuB7M7L7LRumfxwWZzp0yXlfh6428dgze0E4gq/R2jKMhj6de4fcUFNjnSRg==
X-Received: by 2002:adf:e4c5:: with SMTP id v5mr12223302wrm.106.1573821388621;
        Fri, 15 Nov 2019 04:36:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u4sm11157788wrq.22.2019.11.15.04.36.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 04:36:28 -0800 (PST)
Message-Id: <499f3f19e026a60e050f2ed1bb2d820febc6b0a0.1573821382.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.171.git.1573821382.gitgitgadget@gmail.com>
References: <pull.171.git.1573821382.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 15 Nov 2019 12:36:21 +0000
Subject: [PATCH 7/8] built-in add -i: re-implement the `diff` command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

It is not only laziness that we simply spawn `git diff -p --cached`
here: this command needs to use the pager, and the pager needs to exit
when the diff is done. Currently we do not have any way to make that
happen if we run the diff in-process. So let's just spawn.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-interactive.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/add-interactive.c b/add-interactive.c
index fb8124fc57..f33075b202 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -927,6 +927,47 @@ static int run_patch(struct add_i_state *s, const struct pathspec *ps,
 	return res;
 }
 
+static int run_diff(struct add_i_state *s, const struct pathspec *ps,
+		    struct prefix_item_list *files,
+		    struct list_and_choose_options *opts)
+{
+	int res = 0;
+	ssize_t count, i;
+
+	struct object_id oid;
+	int is_initial = !resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, &oid,
+					     NULL);
+	if (get_modified_files(s->r, INDEX_ONLY, files, ps, NULL, NULL) < 0)
+		return -1;
+
+	if (!files->items.nr) {
+		putchar('\n');
+		return 0;
+	}
+
+	opts->prompt = N_("Review diff");
+	opts->flags = IMMEDIATE;
+	count = list_and_choose(s, files, opts);
+	opts->flags = 0;
+	if (count >= 0) {
+		struct argv_array args = ARGV_ARRAY_INIT;
+
+		argv_array_pushl(&args, "git", "diff", "-p", "--cached",
+				 oid_to_hex(!is_initial ? &oid :
+					    s->r->hash_algo->empty_tree),
+				 "--", NULL);
+		for (i = 0; i < files->items.nr; i++)
+			if (files->selected[i])
+				argv_array_push(&args,
+						files->items.items[i].string);
+		res = run_command_v_opt(args.argv, 0);
+		argv_array_clear(&args);
+	}
+
+	putchar('\n');
+	return res;
+}
+
 static int run_help(struct add_i_state *s, const struct pathspec *unused_ps,
 		    struct prefix_item_list *unused_files,
 		    struct list_and_choose_options *unused_opts)
@@ -1025,6 +1066,7 @@ int run_add_i(struct repository *r, const struct pathspec *ps)
 		{ "revert", run_revert },
 		{ "add untracked", run_add_untracked },
 		{ "patch", run_patch },
+		{ "diff", run_diff },
 		{ "help", run_help },
 	};
 	struct prefix_item_list commands = PREFIX_ITEM_LIST_INIT;
-- 
gitgitgadget

