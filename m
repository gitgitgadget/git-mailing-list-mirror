Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09D9F1F404
	for <e@80x24.org>; Tue,  4 Sep 2018 22:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbeIEC1T (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 22:27:19 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34421 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727442AbeIEC1S (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 22:27:18 -0400
Received: by mail-pl1-f193.google.com with SMTP id f6-v6so2264819plo.1
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 15:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jwtuBe/kN3mrenHU9aOAC8JX+GNiU6OK7rhNTs2mN7Y=;
        b=FyUcGBlIIiVO6VJM8uX4aBsIo9NPh2in6y+PuKiNe+vFaMAOqTuVxZdnlgBHWmy+rx
         QNuHwIMpM+sEUfotGGxDAJn8oXzg4LMWk30T5xMgn3DzX2T+N3ogzv9EBcIs4VENPxNC
         YTtXQxgvDggs5U80XEwqfEG+M8Z+54ybKATjHHcTNnhka3bsh52EZSqNxbuVWbnJrPWI
         fMgIU8GEd/hNI5Gp64VCnDKmCrIq3cq4qoYBLyGH1LEeMjj7DNwnP/2y2lCGCeGWGgr4
         nUqZ2qHKtfV6q2NdJEn8mhox4o6vz16MkoZsL2vdwKCCTGaDxtgbyRCeA+CT63U3sdyT
         e4HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jwtuBe/kN3mrenHU9aOAC8JX+GNiU6OK7rhNTs2mN7Y=;
        b=HiMjJyiKZmNqY3U8kdgFQV+Ksrxk14tU015yECt99Nn6AhwtRxiZMi/NtWkndNz7t9
         eP3abGVljV/9DvqzLE+W25GJy8zP8abh6NCdXwg/Wi1UNBPeXyTM0Nl4Rbhx2pTev7pq
         3dO7o+A4zGvpbC/MBGEvgyJ5FAJs+GEMM4kwr4ldpxg3uG+tSKEP4OKM1wEwAUnmgnrj
         KhM+V2XfBH4nEFlL0KKsAx2tLkzYQJMTf6rzJIRPIGOjMOG+cN6TMozySc+nqfyPZ9ak
         i674DbPpeqeOEEyouJ15sYzHdjCZAR40oTCpZ/zAfgIr7dWLWJZBqYjreqjudcf5E/P6
         G+TQ==
X-Gm-Message-State: APzg51AJMoqaSFEW/KSYKAfB5xg+0Ctzpua4Wekg+1ZRpvpRK5gLwpZA
        e0VQ8uSaUeV+omkLvWPiRwTaxvyf
X-Google-Smtp-Source: ANB0VdZ2ifWjo1XkxnbhUEv2IG/XEr1/EMYHyhbZZaqGhlroaqR0Vs0fziPvqJhAWjsB7etOD25kMg==
X-Received: by 2002:a17:902:9a0c:: with SMTP id v12-v6mr11197012plp.159.1536098413581;
        Tue, 04 Sep 2018 15:00:13 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id d12-v6sm28099299pfn.118.2018.09.04.15.00.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 15:00:12 -0700 (PDT)
Date:   Tue, 04 Sep 2018 15:00:12 -0700 (PDT)
X-Google-Original-Date: Tue, 04 Sep 2018 21:59:45 GMT
Message-Id: <f1551410230e8f25c8d69e0b57984f59cb6d6df7.1536098386.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.33.v2.git.gitgitgadget@gmail.com>
References: <20180808152140.14585-1-predatoramigo@gmail.com>
        <pull.33.v2.git.gitgitgadget@gmail.com>
From:   "Pratik Karki via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 18/18] builtin rebase: support --root
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

This option allows to rebase entire histories up to, and including, the
root commit.

The conversion from the shell script is straight-forward, apart from
the fact that we do not have to write an empty tree in C.

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 847c7daf1c..71b92658ec 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -76,6 +76,7 @@ struct rebase_options {
 	const char *revisions;
 	const char *switch_to;
 	int root;
+	struct object_id *squash_onto;
 	struct commit *restrict_revision;
 	int dont_finish_rebase;
 	enum {
@@ -375,6 +376,9 @@ static int run_specific_rebase(struct rebase_options *opts)
 		opts->rebase_cousins ? "t" : "");
 	add_var(&script_snippet, "strategy", opts->strategy);
 	add_var(&script_snippet, "strategy_opts", opts->strategy_opts);
+	add_var(&script_snippet, "rebase_root", opts->root ? "t" : "");
+	add_var(&script_snippet, "squash_onto",
+		opts->squash_onto ? oid_to_hex(opts->squash_onto) : "");
 
 	switch (opts->type) {
 	case REBASE_AM:
@@ -653,6 +657,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	const char *rebase_merges = NULL;
 	int fork_point = -1;
 	struct string_list strategy_options = STRING_LIST_INIT_NODUP;
+	struct object_id squash_onto;
+	char *squash_onto_name = NULL;
 	struct option builtin_rebase_options[] = {
 		OPT_STRING(0, "onto", &options.onto_name,
 			   N_("revision"),
@@ -743,6 +749,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 				N_("option"),
 				N_("pass the argument through to the merge "
 				   "strategy")),
+		OPT_BOOL(0, "root", &options.root,
+			 N_("rebase all reachable commits up to the root(s)")),
 		OPT_END(),
 	};
 
@@ -1020,6 +1028,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		}
 	}
 
+	if (options.root && !options.onto_name)
+		imply_interactive(&options, "--root without --onto");
+
 	switch (options.type) {
 	case REBASE_MERGE:
 	case REBASE_INTERACTIVE:
@@ -1058,8 +1069,22 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		if (!options.upstream)
 			die(_("invalid upstream '%s'"), options.upstream_name);
 		options.upstream_arg = options.upstream_name;
-	} else
-		die("TODO: upstream for --root");
+	} else {
+		if (!options.onto_name) {
+			if (commit_tree("", 0, the_hash_algo->empty_tree, NULL,
+					&squash_onto, NULL, NULL) < 0)
+				die(_("Could not create new root commit"));
+			options.squash_onto = &squash_onto;
+			options.onto_name = squash_onto_name =
+				xstrdup(oid_to_hex(&squash_onto));
+		}
+		options.upstream_name = NULL;
+		options.upstream = NULL;
+		if (argc > 1)
+			usage_with_options(builtin_rebase_usage,
+					   builtin_rebase_options);
+		options.upstream_arg = "--root";
+	}
 
 	/* Make sure the branch to rebase onto is valid. */
 	if (!options.onto_name)
@@ -1207,6 +1232,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	 */
 	if (can_fast_forward(options.onto, &options.orig_head, &merge_base) &&
 	    !is_interactive(&options) && !options.restrict_revision &&
+	    options.upstream &&
 	    !oidcmp(&options.upstream->object.oid, &options.onto->object.oid)) {
 		int flag;
 
@@ -1311,5 +1337,6 @@ cleanup:
 	free(options.head_name);
 	free(options.gpg_sign_opt);
 	free(options.cmd);
+	free(squash_onto_name);
 	return ret;
 }
-- 
gitgitgadget
