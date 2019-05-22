Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14B231F462
	for <e@80x24.org>; Wed, 22 May 2019 19:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387854AbfEVTxh (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 May 2019 15:53:37 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46205 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387845AbfEVTxd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 May 2019 15:53:33 -0400
Received: by mail-ed1-f67.google.com with SMTP id f37so5442602edb.13
        for <git@vger.kernel.org>; Wed, 22 May 2019 12:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eu+SZqHceiKPRW+o8RQCVPllMT/cbikxjJkIiWp+jCo=;
        b=qvVVrt5S5Q32XZLn9OELBoZF7wDIHwrQVYxuvSEhgAZ67UxymC+VaPRpKmwyUtgmM4
         XN0GvokXB1zeIJacGs7rg6csUvS+nnjqcRijH2mk6fjkm3TbTV5SfMRkVvOpThbpXSmB
         LVLxCOeO/iMDZNe8uaQd/tX36fbpKnyUiSYtHMu90yDnzwWmAePocOogWQ+e0AWPh4p8
         PhzHynxdGAynigga7mVLianmE1+quBO135O/bbPlSLu0SWnob+YKo1CcZ9Ae4GEoH5hR
         UssdD9z5GgDurBgQMNqW+ekBiDSuNI/MWd3WtmvkMpKpgOfeMgSZZTbMhcJy2INUy2TB
         W+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eu+SZqHceiKPRW+o8RQCVPllMT/cbikxjJkIiWp+jCo=;
        b=bI73V7zjywgqaWzV1yqOlTgmeEvGChN7A6le3kVV7Iaephsgj+DukKDu/j7gyl8p2Q
         ZKkfta7V1aHcuWWQk3tm0+yojtkqkNA3U9BtIP6MyeGcqyZOOEd4tbgr0526sNiRe3WF
         2B1aba5rIzsnxyW7plA/FMZP+5Iws505cTS6dOeU+kK+PS1ZQL+mBdsqh/6B4WDezi4q
         BVqcIXqSX9fhc5qeSqAto9gtXjtk7uYlUi2cdVLA2PW87Z4qkmvVseSi03fRndYQ/T1S
         zbekX1QeS/0l9WMeIaLrvp+PbB5WDKvImApnI+lCfxqQiqqv1WIcqor8ajNbeKrQpC0M
         z3dg==
X-Gm-Message-State: APjAAAUIUz5IyB69Ggo+e0Wv4y+wLh49Odqftd83Esu4IShJ1e0izxfe
        aPIFlkIGX2B8WKhF2bVpxhYgsXJE
X-Google-Smtp-Source: APXvYqygavdqbEhZkZl4D5vzJcnU3zdDXkiGLuIKd+x4Bjf6KMviocQGjohg2tSkYOGRe1K9bqSXOA==
X-Received: by 2002:a50:a7a5:: with SMTP id i34mr45976182edc.294.1558554810354;
        Wed, 22 May 2019 12:53:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w6sm2467332ejf.0.2019.05.22.12.53.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 12:53:29 -0700 (PDT)
Date:   Wed, 22 May 2019 12:53:29 -0700 (PDT)
X-Google-Original-Date: Wed, 22 May 2019 19:53:19 GMT
Message-Id: <4cfe19a933fae40465e424cb364dad812e8283f5.1558554800.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.v2.git.gitgitgadget@gmail.com>
References: <pull.184.git.gitgitgadget@gmail.com>
        <pull.184.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 10/11] commit-graph: allow cross-alternate chains
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, git@jeffhostetler.com,
        jrnieder@google.com, steadmon@google.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

In an environment like a fork network, it is helpful to have a
commit-graph chain that spans both the base repo and the fork repo. The
fork is usually a small set of data on top of the large repo, but
sometimes the fork is much larger. For example, git-for-windows/git has
almost double the number of commits as git/git because it rebases its
commits on every major version update.

To allow cross-alternate commit-graph chains, we need a few pieces:

1. When looking for a graph-{hash}.graph file, check all alternates.

2. When merging commit-graph chains, do not merge across alternates.

3. When writing a new commit-graph chain based on a commit-graph file
   in another object directory, do not allow success if the base file
   has of the name "commit-graph" instead of
   "commit-graphs/graoh-{hash}.graph".

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/technical/commit-graph.txt | 40 +++++++++++++++++++++
 commit-graph.c                           | 46 ++++++++++++++++++------
 commit-graph.h                           |  1 +
 t/t5323-split-commit-graph.sh            | 37 +++++++++++++++++++
 4 files changed, 114 insertions(+), 10 deletions(-)

diff --git a/Documentation/technical/commit-graph.txt b/Documentation/technical/commit-graph.txt
index 083fff9927..b6fe8b2321 100644
--- a/Documentation/technical/commit-graph.txt
+++ b/Documentation/technical/commit-graph.txt
@@ -267,6 +267,42 @@ The merge strategy values (2 for the size multiple, 64,000 for the maximum
 number of commits) could be extracted into config settings for full
 flexibility.
 
+## Chains across multiple object directories
+
+In a repo with alternates, we look for the `commit-graph-chain` file starting
+in the local object directory and then in each alternate. The first file that
+exists defines our chain. As we look for the `graph-{hash}` files for
+each `{hash}` in the chain file, we follow the same pattern for the host
+directories.
+
+This allows commit-graphs to be split across multiple forks in a fork network.
+The typical case is a large "base" repo with many smaller forks.
+
+As the base repo advances, it will likely update and merge its commit-graph
+chain more frequently than the forks. If a fork updates their commit-graph after
+the base repo, then it should "reparent" the commit-graph chain onto the new
+chain in the base repo. When reading each `graph-{hash}` file, we track
+the object directory containing it. During a write of a new commit-graph file,
+we check for any changes in the source object directory and read the
+`commit-graph-chain` file for that source and create a new file based on those
+files. During this "reparent" operation, we necessarily need to collapse all
+levels in the fork, as all of the files are invalid against the new base file.
+
+It is crucial to be careful when cleaning up "unreferenced" `graph-{hash}.graph`
+files in this scenario. It falls to the user to define the proper settings for
+their custom environment:
+
+ 1. When merging levels in the base repo, the unreferenced files may still be
+    referenced by chains from fork repos.
+
+ 2. The expiry time should be set to a length of time such that every fork has
+    time to recompute their commit-graph chain to "reparent" onto the new base
+    file(s).
+
+ 3. If the commit-graph chain is updated in the base, the fork will not have
+    access to the new chain until its chain is updated to reference those files.
+    (This may change in the future [5].)
+
 Related Links
 -------------
 [0] https://bugs.chromium.org/p/git/issues/detail?id=8
@@ -293,3 +329,7 @@ Related Links
 
 [4] https://public-inbox.org/git/20180108154822.54829-1-git@jeffhostetler.com/T/#u
     A patch to remove the ahead-behind calculation from 'status'.
+
+[5] https://public-inbox.org/git/f27db281-abad-5043-6d71-cbb083b1c877@gmail.com/
+    A discussion of a "two-dimensional graph position" that can allow reading
+    multiple commit-graph chains at the same time.
diff --git a/commit-graph.c b/commit-graph.c
index e9784cd559..0d8b942e2b 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -320,6 +320,9 @@ static int prepare_commit_graph_v1(struct repository *r, const char *obj_dir)
 	r->objects->commit_graph = load_commit_graph_one(graph_name);
 	free(graph_name);
 
+	if (r->objects->commit_graph)
+		r->objects->commit_graph->obj_dir = obj_dir;
+
 	return r->objects->commit_graph ? 0 : -1;
 }
 
@@ -380,8 +383,7 @@ static void prepare_commit_graph_chain(struct repository *r, const char *obj_dir
 	oids = xcalloc(st.st_size / (the_hash_algo->hexsz + 1), sizeof(struct object_id));
 
 	while (strbuf_getline_lf(&line, fp) != EOF && valid) {
-		char *graph_name;
-		struct commit_graph *g;
+		struct object_directory *odb;
 
 		if (get_oid_hex(line.buf, &oids[i])) {
 			warning(_("invalid commit-graph chain: line '%s' not a hash"),
@@ -390,14 +392,23 @@ static void prepare_commit_graph_chain(struct repository *r, const char *obj_dir
 			break;
 		}
 
-		graph_name = get_split_graph_filename(obj_dir, line.buf);
-		g = load_commit_graph_one(graph_name);
-		free(graph_name);
+		for (odb = r->objects->odb; odb; odb = odb->next) {
+			char *graph_name = get_split_graph_filename(odb->path, line.buf);
+			struct commit_graph *g = load_commit_graph_one(graph_name);
 
-		if (g && add_graph_to_chain(g, r->objects->commit_graph, oids, i))
-			r->objects->commit_graph = g;
-		else
-			valid = 0;
+			free(graph_name);
+
+			if (g) {
+				g->obj_dir = odb->path;
+
+				if (add_graph_to_chain(g, r->objects->commit_graph, oids, i))
+					r->objects->commit_graph = g;
+				else
+					valid = 0;
+
+				break;
+			}
+		}
 	}
 
 	free(oids);
@@ -1397,7 +1408,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 
 	if (ctx->split && ctx->base_graph_name && ctx->num_commit_graphs_after > 1) {
 		char *new_base_hash = xstrdup(oid_to_hex(&ctx->new_base_graph->oid));
-		char *new_base_name = get_split_graph_filename(ctx->obj_dir, new_base_hash);
+		char *new_base_name = get_split_graph_filename(ctx->new_base_graph->obj_dir, new_base_hash);
 
 		free(ctx->commit_graph_filenames_after[ctx->num_commit_graphs_after - 2]);
 		free(ctx->commit_graph_hash_after[ctx->num_commit_graphs_after - 2]);
@@ -1468,6 +1479,9 @@ static void split_graph_merge_strategy(struct write_commit_graph_context *ctx)
 
 	while (g && (g->num_commits <= split_strategy_size_mult * num_commits ||
 		     num_commits > split_strategy_max_commits)) {
+		if (strcmp(g->obj_dir, ctx->obj_dir))
+			break;
+
 		num_commits += g->num_commits;
 		g = g->base_graph;
 
@@ -1476,6 +1490,18 @@ static void split_graph_merge_strategy(struct write_commit_graph_context *ctx)
 
 	ctx->new_base_graph = g;
 
+	if (ctx->num_commit_graphs_after == 2) {
+		char *old_graph_name = get_commit_graph_filename(g->obj_dir);
+
+		if (!strcmp(g->filename, old_graph_name) &&
+		    strcmp(g->obj_dir, ctx->obj_dir)) {
+			ctx->num_commit_graphs_after = 1;
+			ctx->new_base_graph = NULL;
+		}
+
+		free(old_graph_name);
+	}
+
 	ALLOC_ARRAY(ctx->commit_graph_filenames_after, ctx->num_commit_graphs_after);
 	ALLOC_ARRAY(ctx->commit_graph_hash_after, ctx->num_commit_graphs_after);
 
diff --git a/commit-graph.h b/commit-graph.h
index 5c48c4f66a..10466bc064 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -48,6 +48,7 @@ struct commit_graph {
 	uint32_t num_commits;
 	struct object_id oid;
 	char *filename;
+	const char *obj_dir;
 
 	uint32_t num_commits_in_base;
 	struct commit_graph *base_graph;
diff --git a/t/t5323-split-commit-graph.sh b/t/t5323-split-commit-graph.sh
index 3902fd9aee..ed5cac8617 100755
--- a/t/t5323-split-commit-graph.sh
+++ b/t/t5323-split-commit-graph.sh
@@ -90,6 +90,21 @@ test_expect_success 'add more commits, and write a new base graph' '
 	graph_read_expect 12
 '
 
+test_expect_success 'fork and fail to base a chain on a commit-graph file' '
+	test_when_finished rm -rf fork &&
+	git clone . fork &&
+	(
+		cd fork &&
+		rm .git/objects/info/commit-graph &&
+		echo "$TRASH_DIRECTORY/.git/objects" >.git/objects/info/alternates &&
+		test_commit new-commit &&
+		git commit-graph write --reachable --split &&
+		test_path_is_file $graphdir/commit-graph-chain &&
+		test_line_count = 1 $graphdir/commit-graph-chain &&
+		verify_chain_files_exist $graphdir
+	)
+'
+
 test_expect_success 'add three more commits, write a tip graph' '
 	git reset --hard commits/3 &&
 	git merge merge/1 &&
@@ -132,4 +147,26 @@ test_expect_success 'add one commit, write a merged graph' '
 
 graph_git_behavior 'merged commit-graph: commit 12 vs 6' commits/12 commits/6
 
+test_expect_success 'create fork and chain across alternate' '
+	git clone . fork &&
+	(
+		cd fork &&
+		git config core.commitGraph true &&
+		rm -rf $graphdir &&
+		echo "$TRASH_DIRECTORY/.git/objects" >.git/objects/info/alternates &&
+		test_commit 13 &&
+		git branch commits/13 &&
+		git commit-graph write --reachable --split &&
+		test_path_is_file $graphdir/commit-graph-chain &&
+		test_line_count = 3 $graphdir/commit-graph-chain &&
+		ls $graphdir/graph-*.graph >graph-files &&
+		test_line_count = 1 graph-files &&
+		git -c core.commitGraph=true  rev-list HEAD >expect &&
+		git -c core.commitGraph=false rev-list HEAD >actual &&
+		test_cmp expect actual
+	)
+'
+
+graph_git_behavior 'alternate: commit 13 vs 6' commits/13 commits/6
+
 test_done
-- 
gitgitgadget

