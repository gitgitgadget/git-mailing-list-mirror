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
	by dcvr.yhbt.net (Postfix) with ESMTP id A46971F462
	for <e@80x24.org>; Mon,  3 Jun 2019 16:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729379AbfFCQEF (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 12:04:05 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37276 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729312AbfFCQEB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 12:04:01 -0400
Received: by mail-wm1-f68.google.com with SMTP id 22so3454308wmg.2
        for <git@vger.kernel.org>; Mon, 03 Jun 2019 09:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JryWLpjMcZS5AWedz+Eyr/7CrwKO7q7cMNBm/cFWD6s=;
        b=JlxD2Nx9UByfqNCKsve8Dhcc8u40/RjNW4vQJ4YWo8yZg0U81b8Zpg35S4Ojd2494E
         +XUOCiqscgcduBuR4/JzYWFDV+ADDL715C1hMwL6c9gUWGn9eC2nZtw8RWiY3hhTtKy2
         L6mtDHzG3gBm8HXjNM7JFvVtMZ8ipVr0M3CH1OQxxDRlGyfydW+u/CumUJJQWET4WCUB
         32HMFc4njI+EIr4+nv3NzOt7nEUZuxNGYN51u/Yzjg7SV1vUI0Xf6Wq0/4k01ufdjBA5
         ai4wcihXo1STeGAmrZNUy8YfvVpCO4FQQ/h11KxSyr8xyCWL+HyfH7uxi7bhmjSpYQ3O
         DhOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JryWLpjMcZS5AWedz+Eyr/7CrwKO7q7cMNBm/cFWD6s=;
        b=qV1Rc9d+ppRdW6qfI16mnaooc+2QcRAY8DHJPe1jD+XlbfrmQBhg91fJyo4//q6ZRv
         xINkQzmRndK6mb37n6mRfrm/f9dRBHx/YuxwigPrpaOOAANQkf1F8xHuCminG2p3G8ax
         MkE9cJWOfkIfQuCVzHcDUdIntH2U7NfdEiFm9TOyn6yS1BLhB05CrKZGpkPz8XLnjhFg
         RGGqm7ObKjSnC7L0BzERAEYSED3lgA6cGpj8ZlyFff0VMlAWJ3zG1WTURhmfm05YK9bT
         /nMM32gcYNsvU4h6IODShN0eHTClv9bP9zOOWNvjJagKz3anruXkHPmU67Wg5wlhzTR6
         zTyg==
X-Gm-Message-State: APjAAAVgsGOoXd4NlQtGhVQqLjVq8+bEZ2nQGtAxym6dmBXHXyz0aYcG
        QjsLiCA5gzoHmrtrKqmW+QVL2CKl
X-Google-Smtp-Source: APXvYqxuUS3SQdfiji/X/tGaI6XeHGEu8FYMJ8copjJkErV8gllQZ5jjwHRZLM9Fl1S73cIcHtCS9g==
X-Received: by 2002:a05:600c:c4:: with SMTP id u4mr2874620wmm.96.1559577838492;
        Mon, 03 Jun 2019 09:03:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f10sm27125065wrg.24.2019.06.03.09.03.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 09:03:57 -0700 (PDT)
Date:   Mon, 03 Jun 2019 09:03:57 -0700 (PDT)
X-Google-Original-Date: Mon, 03 Jun 2019 16:03:41 GMT
Message-Id: <87fb895fe4e9ebc4fd97a6b193d1f99d0f27419c.1559577826.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.v3.git.gitgitgadget@gmail.com>
References: <pull.184.v2.git.gitgitgadget@gmail.com>
        <pull.184.v3.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 09/14] commit-graph: merge commit-graph chains
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

When searching for a commit in a commit-graph chain of G graphs with N
commits, the search takes O(G log N) time. If we always add a new tip
graph with every write, the linear G term will start to dominate and
slow the lookup process.

To keep lookups fast, but also keep most incremental writes fast, create
a strategy for merging levels of the commit-graph chain. The strategy is
detailed in the commit-graph design document, but is summarized by these
two conditions:

  1. If the number of commits we are adding is more than half the number
     of commits in the graph below, then merge with that graph.

  2. If we are writing more than 64,000 commits into a single graph,
     then merge with all lower graphs.

The numeric values in the conditions above are currently constant, but
can become config options in a future update.

As we merge levels of the commit-graph chain, check that the commits
still exist in the repository. A garbage-collection operation may have
removed those commits from the object store and we do not want to
persist them in the commit-graph chain. This is a non-issue if the
'git gc' process wrote a new, single-level commit-graph file.

After we merge levels, the old graph-{hash}.graph files are no longer
referenced by the commit-graph-chain file. We will expire these files in
a future change.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/technical/commit-graph.txt |  80 ++++++++++
 commit-graph.c                           | 184 +++++++++++++++++++----
 t/t5323-split-commit-graph.sh            |  13 ++
 3 files changed, 244 insertions(+), 33 deletions(-)

diff --git a/Documentation/technical/commit-graph.txt b/Documentation/technical/commit-graph.txt
index 1dca3bd8fe..d9c6253b0a 100644
--- a/Documentation/technical/commit-graph.txt
+++ b/Documentation/technical/commit-graph.txt
@@ -186,6 +186,86 @@ positions to refer to their parents, which may be in `graph-{hash1}.graph` or
 its containment in the intervals [0, X0), [X0, X0 + X1), [X0 + X1, X0 + X1 +
 X2).
 
+Each commit-graph file (except the base, `graph-{hash0}.graph`) contains data
+specifying the hashes of all files in the lower layers. In the above example,
+`graph-{hash1}.graph` contains `{hash0}` while `graph-{hash2}.graph` contains
+`{hash0}` and `{hash1}`.
+
+## Merging commit-graph files
+
+If we only added a new commit-graph file on every write, we would run into a
+linear search problem through many commit-graph files.  Instead, we use a merge
+strategy to decide when the stack should collapse some number of levels.
+
+The diagram below shows such a collapse. As a set of new commits are added, it
+is determined by the merge strategy that the files should collapse to
+`graph-{hash1}`. Thus, the new commits, the commits in `graph-{hash2}` and
+the commits in `graph-{hash1}` should be combined into a new `graph-{hash3}`
+file.
+
+			    +---------------------+
+			    |                     |
+			    |    (new commits)    |
+			    |                     |
+			    +---------------------+
+			    |                     |
+ +-----------------------+  +---------------------+
+ |  graph-{hash2} |->|                     |
+ +-----------------------+  +---------------------+
+	  |                 |                     |
+ +-----------------------+  +---------------------+
+ |                       |  |                     |
+ |  graph-{hash1} |->|                     |
+ |                       |  |                     |
+ +-----------------------+  +---------------------+
+	  |                  tmp_graphXXX
+ +-----------------------+
+ |                       |
+ |                       |
+ |                       |
+ |  graph-{hash0} |
+ |                       |
+ |                       |
+ |                       |
+ +-----------------------+
+
+During this process, the commits to write are combined, sorted and we write the
+contents to a temporary file, all while holding a `commit-graph-chain.lock`
+lock-file.  When the file is flushed, we rename it to `graph-{hash3}`
+according to the computed `{hash3}`. Finally, we write the new chain data to
+`commit-graph-chain.lock`:
+
+```
+	{hash3}
+	{hash0}
+```
+
+We then close the lock-file.
+
+## Merge Strategy
+
+When writing a set of commits that do not exist in the commit-graph stack of
+height N, we default to creating a new file at level N + 1. We then decide to
+merge with the Nth level if one of two conditions hold:
+
+  1. The expected file size for level N + 1 is at least half the file size for
+     level N.
+
+  2. Level N + 1 contains more than 64,0000 commits.
+
+This decision cascades down the levels: when we merge a level we create a new
+set of commits that then compares to the next level.
+
+The first condition bounds the number of levels to be logarithmic in the total
+number of commits.  The second condition bounds the total number of commits in
+a `graph-{hashN}` file and not in the `commit-graph` file, preventing
+significant performance issues when the stack merges and another process only
+partially reads the previous stack.
+
+The merge strategy values (2 for the size multiple, 64,000 for the maximum
+number of commits) could be extracted into config settings for full
+flexibility.
+
 Related Links
 -------------
 [0] https://bugs.chromium.org/p/git/issues/detail?id=8
diff --git a/commit-graph.c b/commit-graph.c
index 7d3e001479..bfef1b6960 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1291,36 +1291,6 @@ static int write_graph_chunk_base(struct hashfile *f,
 	return 0;
 }
 
-static void init_commit_graph_chain(struct write_commit_graph_context *ctx)
-{
-	struct commit_graph *g = ctx->r->objects->commit_graph;
-	uint32_t i;
-
-	ctx->new_base_graph = g;
-	ctx->base_graph_name = xstrdup(g->filename);
-	ctx->new_num_commits_in_base = g->num_commits + g->num_commits_in_base;
-
-	ctx->num_commit_graphs_after = ctx->num_commit_graphs_before + 1;
-
-	ALLOC_ARRAY(ctx->commit_graph_filenames_after, ctx->num_commit_graphs_after);
-	ALLOC_ARRAY(ctx->commit_graph_hash_after, ctx->num_commit_graphs_after);
-
-	for (i = 0; i < ctx->num_commit_graphs_before - 1; i++)
-		ctx->commit_graph_filenames_after[i] = xstrdup(ctx->commit_graph_filenames_before[i]);
-
-	if (ctx->num_commit_graphs_before)
-		ctx->commit_graph_filenames_after[ctx->num_commit_graphs_before - 1] =
-			get_split_graph_filename(ctx->obj_dir, oid_to_hex(&g->oid));
-
-	i = ctx->num_commit_graphs_before - 1;
-
-	while (g) {
-		ctx->commit_graph_hash_after[i] = xstrdup(oid_to_hex(&g->oid));
-		i--;
-		g = g->base_graph;
-	}
-}
-
 static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 {
 	uint32_t i;
@@ -1498,6 +1468,149 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	return 0;
 }
 
+static int split_strategy_max_commits = 64000;
+static float split_strategy_size_mult = 2.0f;
+
+static void split_graph_merge_strategy(struct write_commit_graph_context *ctx)
+{
+	struct commit_graph *g = ctx->r->objects->commit_graph;
+	uint32_t num_commits = ctx->commits.nr;
+	uint32_t i;
+
+	g = ctx->r->objects->commit_graph;
+	ctx->num_commit_graphs_after = ctx->num_commit_graphs_before + 1;
+
+	while (g && (g->num_commits <= split_strategy_size_mult * num_commits ||
+		     num_commits > split_strategy_max_commits)) {
+		num_commits += g->num_commits;
+		g = g->base_graph;
+
+		ctx->num_commit_graphs_after--;
+	}
+
+	ctx->new_base_graph = g;
+
+	ALLOC_ARRAY(ctx->commit_graph_filenames_after, ctx->num_commit_graphs_after);
+	ALLOC_ARRAY(ctx->commit_graph_hash_after, ctx->num_commit_graphs_after);
+
+	for (i = 0; i < ctx->num_commit_graphs_after &&
+		    i < ctx->num_commit_graphs_before; i++)
+		ctx->commit_graph_filenames_after[i] = xstrdup(ctx->commit_graph_filenames_before[i]);
+
+	i = ctx->num_commit_graphs_before - 1;
+	g = ctx->r->objects->commit_graph;
+
+	while (g) {
+		if (i < ctx->num_commit_graphs_after)
+			ctx->commit_graph_hash_after[i] = xstrdup(oid_to_hex(&g->oid));
+
+		i--;
+		g = g->base_graph;
+	}
+}
+
+static void merge_commit_graph(struct write_commit_graph_context *ctx,
+			       struct commit_graph *g)
+{
+	uint32_t i;
+	uint32_t offset = g->num_commits_in_base;
+
+	ALLOC_GROW(ctx->commits.list, ctx->commits.nr + g->num_commits, ctx->commits.alloc);
+
+	for (i = 0; i < g->num_commits; i++) {
+		struct object_id oid;
+		struct commit *result;
+
+		display_progress(ctx->progress, i + 1);
+
+		load_oid_from_graph(g, i + offset, &oid);
+
+		/* only add commits if they still exist in the repo */
+		result = lookup_commit_reference_gently(ctx->r, &oid, 1);
+
+		if (result) {
+			ctx->commits.list[ctx->commits.nr] = result;
+			ctx->commits.nr++;
+		}
+	}
+}
+
+static int commit_compare(const void *_a, const void *_b)
+{
+	const struct commit *a = *(const struct commit **)_a;
+	const struct commit *b = *(const struct commit **)_b;
+	return oidcmp(&a->object.oid, &b->object.oid);
+}
+
+static void deduplicate_commits(struct write_commit_graph_context *ctx)
+{
+	uint32_t i, num_parents, last_distinct = 0, duplicates = 0;
+	struct commit_list *parent;
+
+	if (ctx->report_progress)
+		ctx->progress = start_delayed_progress(
+					_("De-duplicating merged commits"),
+					ctx->commits.nr);
+
+	QSORT(ctx->commits.list, ctx->commits.nr, commit_compare);
+
+	ctx->num_extra_edges = 0;
+	for (i = 1; i < ctx->commits.nr; i++) {
+		display_progress(ctx->progress, i);
+
+		if (oideq(&ctx->commits.list[last_distinct]->object.oid,
+			  &ctx->commits.list[i]->object.oid)) {
+			duplicates++;
+		} else {
+			if (duplicates)
+				ctx->commits.list[last_distinct + 1] = ctx->commits.list[i];
+			last_distinct++;
+
+			num_parents = 0;
+			for (parent = ctx->commits.list[i]->parents; parent; parent = parent->next)
+				num_parents++;
+
+			if (num_parents > 2)
+				ctx->num_extra_edges += num_parents - 2;
+		}
+	}
+
+	ctx->commits.nr -= duplicates;
+	stop_progress(&ctx->progress);
+}
+
+static void merge_commit_graphs(struct write_commit_graph_context *ctx)
+{
+	struct commit_graph *g = ctx->r->objects->commit_graph;
+	uint32_t current_graph_number = ctx->num_commit_graphs_before;
+	struct strbuf progress_title = STRBUF_INIT;
+
+	while (g && current_graph_number >= ctx->num_commit_graphs_after) {
+		current_graph_number--;
+
+		if (ctx->report_progress) {
+			strbuf_addstr(&progress_title, _("Merging commit-graph"));
+			ctx->progress = start_delayed_progress(progress_title.buf, 0);
+		}
+
+		merge_commit_graph(ctx, g);
+		stop_progress(&ctx->progress);
+		strbuf_release(&progress_title);
+
+		g = g->base_graph;
+	}
+
+	if (g) {
+		ctx->new_base_graph = g;
+		ctx->new_num_commits_in_base = g->num_commits + g->num_commits_in_base;
+	}
+
+	if (ctx->new_base_graph)
+		ctx->base_graph_name = xstrdup(ctx->new_base_graph->filename);
+
+	deduplicate_commits(ctx);
+}
+
 int write_commit_graph(const char *obj_dir,
 		       struct string_list *pack_indexes,
 		       struct string_list *commit_hex,
@@ -1543,6 +1656,9 @@ int write_commit_graph(const char *obj_dir,
 	ctx->approx_nr_objects = approximate_object_count();
 	ctx->oids.alloc = ctx->approx_nr_objects / 32;
 
+	if (ctx->split && ctx->oids.alloc > split_strategy_max_commits)
+		ctx->oids.alloc = split_strategy_max_commits;
+
 	if (ctx->append) {
 		prepare_commit_graph_one(ctx->r, ctx->obj_dir);
 		if (ctx->r->objects->commit_graph)
@@ -1596,9 +1712,11 @@ int write_commit_graph(const char *obj_dir,
 	if (!ctx->commits.nr)
 		goto cleanup;
 
-	if (ctx->split)
-		init_commit_graph_chain(ctx);
-	else
+	if (ctx->split) {
+		split_graph_merge_strategy(ctx);
+
+		merge_commit_graphs(ctx);
+	} else
 		ctx->num_commit_graphs_after = 1;
 
 	compute_generation_numbers(ctx);
diff --git a/t/t5323-split-commit-graph.sh b/t/t5323-split-commit-graph.sh
index ccd24bd22b..5cb5663a30 100755
--- a/t/t5323-split-commit-graph.sh
+++ b/t/t5323-split-commit-graph.sh
@@ -119,4 +119,17 @@ test_expect_success 'add one commit, write a tip graph' '
 
 graph_git_behavior 'three-layer commit-graph: commit 11 vs 6' commits/11 commits/6
 
+test_expect_success 'add one commit, write a merged graph' '
+	test_commit 12 &&
+	git branch commits/12 &&
+	git commit-graph write --reachable --split &&
+	test_path_is_file $graphdir/commit-graph-chain &&
+	test_line_count = 2 $graphdir/commit-graph-chain &&
+	ls $graphdir/graph-*.graph >graph-files &&
+	test_line_count = 4 graph-files &&
+	verify_chain_files_exist $graphdir
+'
+
+graph_git_behavior 'merged commit-graph: commit 12 vs 6' commits/12 commits/6
+
 test_done
-- 
gitgitgadget

