Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40EB21F45F
	for <e@80x24.org>; Wed,  8 May 2019 15:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbfEHPyI (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 11:54:08 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37535 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727800AbfEHPyD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 11:54:03 -0400
Received: by mail-ed1-f67.google.com with SMTP id w37so22537372edw.4
        for <git@vger.kernel.org>; Wed, 08 May 2019 08:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qacG8flSJ7gE5kMq/9MbFnFYYl9YmrIK2KqvQuDxKGo=;
        b=bHbaT4lNlALNnMc98zSPFo4GTqamEqdETZKZ6wpOBjbztKg2ap3WxaFXm9Lnu2aX+u
         YueN79bOQewI3ywUwRl7VTApIiEYp9MzlXGiHS/ayoeXDfisZP3omMOQUZ867Ar6enZd
         pz2Izv1jpUuA6NYk//kQFR/u2kQXrwbhHwhtdyIyEmtHOSnOWvTpszIzwXHmpE/hJF6V
         YRjJ1q+mM1GRKc5zNiM8ag8r9R5e9rTU2KtEVeQPoGfwIwrvzZgyIImBiTnhZSbjR7mh
         CwvZu8PgFMc1dAE09s0IvWxIgkKQBE1LAhcT0z+MS/dkJXIOm7yG5cbZS3OdWzDJU7vC
         L8xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qacG8flSJ7gE5kMq/9MbFnFYYl9YmrIK2KqvQuDxKGo=;
        b=d7+9XUFfTARVurQTumohatsVaPtDLZ5ew74A46l49h1Gv1pKjVLJKliX8Di+ZTHDXO
         IMWR641W39qshMIS5T8Z/lEv55SbhhHa/O5MG9THPBugndZS7SIcerIvhzsXObkPSMYT
         0bgj64/f5/TZqDFryIBs9h9oSxuX2gMXiN7YxKpFt6V/gwKw3StwzKfIWAssLoYWkGpw
         xdgTk7mtO7Vp2VwKQb9yZxISSJsZRqvMB3ymN2TsGZvwo0RMAl3LgtbyP9A1pwlktT8D
         pHTVe9gZ+IMXs5vBxqfhN+eJczcmxe+GkkRpf9pZJKEdEvLo7D/r4NjQpA9Ym1+NUhBx
         FVVQ==
X-Gm-Message-State: APjAAAV+SZdOD+z6trOA2NdYX50Zdfw2olqz0GGR2N2VDe5DlhSen7pg
        IrH4jc9dJy7/COsnoK1KAfsnwr6q9O0=
X-Google-Smtp-Source: APXvYqwny4nqECsdOsZdF23cn7BpIcRkTcXZCiSVU+dK9yLxvvBAXhVwcqcbdj6YtdWlPiQd+atkfg==
X-Received: by 2002:a17:906:c78f:: with SMTP id cw15mr10028637ejb.179.1557330840882;
        Wed, 08 May 2019 08:54:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c2sm5231022edb.23.2019.05.08.08.54.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 08:54:00 -0700 (PDT)
Date:   Wed, 08 May 2019 08:54:00 -0700 (PDT)
X-Google-Original-Date: Wed, 08 May 2019 15:53:44 GMT
Message-Id: <aa4a096813aaa3796cef391f866cc4a6ae99a6bf.1557330827.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.git.gitgitgadget@gmail.com>
References: <pull.184.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 15/17] commit-graph: write split commit-graph files
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

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c          | 248 +++++++++++++++++++++++++++++++++++++++-
 commit-graph.h          |   1 +
 t/t5318-commit-graph.sh |   2 +-
 3 files changed, 244 insertions(+), 7 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 5f6193277a..44448aabe4 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -40,6 +40,8 @@
 #define GRAPH_MIN_SIZE (GRAPH_HEADER_SIZE + 4 * GRAPH_CHUNKLOOKUP_WIDTH \
 			+ GRAPH_FANOUT_SIZE + the_hash_algo->rawsz)
 
+#define MAX_SPLIT_COMMITS 64000
+
 char *get_commit_graph_filename(const char *obj_dir)
 {
 	return xstrfmt("%s/info/commit-graph", obj_dir);
@@ -619,9 +621,14 @@ struct write_commit_graph_context {
 	unsigned long approx_nr_objects;
 	struct progress *progress;
 	int progress_done;
+	int num_commit_graphs_before;
+	int num_commit_graphs_after;
+	uint32_t new_num_commits_in_base;
+	struct commit_graph *new_base_graph;
 	uint64_t progress_cnt;
 	unsigned append:1,
-		 report_progress:1;
+		 report_progress:1,
+		 split:1;
 };
 
 static void write_graph_chunk_fanout(struct hashfile *f,
@@ -691,6 +698,16 @@ static void write_graph_chunk_data(struct hashfile *f, int hash_len,
 					      ctx->commits.nr,
 					      commit_to_sha1);
 
+			if (edge_value >= 0)
+				edge_value += ctx->new_num_commits_in_base;
+			else {
+				uint32_t pos;
+				if (find_commit_in_graph(parent->item,
+							 ctx->new_base_graph,
+							 &pos))
+					edge_value = pos;
+			}
+
 			if (edge_value < 0)
 				BUG("missing parent %s for commit %s",
 				    oid_to_hex(&parent->item->object.oid),
@@ -711,6 +728,17 @@ static void write_graph_chunk_data(struct hashfile *f, int hash_len,
 					      ctx->commits.list,
 					      ctx->commits.nr,
 					      commit_to_sha1);
+
+			if (edge_value >= 0)
+				edge_value += ctx->new_num_commits_in_base;
+			else {
+				uint32_t pos;
+				if (find_commit_in_graph(parent->item,
+							 ctx->new_base_graph,
+							 &pos))
+					edge_value = pos;
+			}
+
 			if (edge_value < 0)
 				BUG("missing parent %s for commit %s",
 				    oid_to_hex(&parent->item->object.oid),
@@ -768,6 +796,16 @@ static void write_graph_chunk_extra_edges(struct hashfile *f,
 						  ctx->commits.nr,
 						  commit_to_sha1);
 
+			if (edge_value >= 0)
+				edge_value += ctx->new_num_commits_in_base;
+			else {
+				uint32_t pos;
+				if (find_commit_in_graph(parent->item,
+							 ctx->new_base_graph,
+							 &pos))
+					edge_value = pos;
+			}
+
 			if (edge_value < 0)
 				BUG("missing parent %s for commit %s",
 				    oid_to_hex(&parent->item->object.oid),
@@ -782,7 +820,7 @@ static void write_graph_chunk_extra_edges(struct hashfile *f,
 	}
 }
 
-static int commit_compare(const void *_a, const void *_b)
+static int oid_compare(const void *_a, const void *_b)
 {
 	const struct object_id *a = (const struct object_id *)_a;
 	const struct object_id *b = (const struct object_id *)_b;
@@ -859,7 +897,13 @@ static void close_reachable(struct write_commit_graph_context *ctx)
 		display_progress(ctx->progress, i + 1);
 		commit = lookup_commit(ctx->r, &ctx->oids.list[i]);
 
-		if (commit && !parse_commit_no_graph(commit))
+		if (!commit)
+			continue;
+		if (ctx->split) {
+			if (!parse_commit(commit) &&
+			    commit->graph_pos == COMMIT_NOT_FROM_GRAPH)
+				add_missing_parents(ctx, commit);
+		} else if (!parse_commit_no_graph(commit))
 			add_missing_parents(ctx, commit);
 	}
 	stop_progress(&ctx->progress);
@@ -1051,12 +1095,20 @@ static uint32_t count_distinct_commits(struct write_commit_graph_context *ctx)
 			_("Counting distinct commits in commit graph"),
 			ctx->oids.nr);
 	display_progress(ctx->progress, 0); /* TODO: Measure QSORT() progress */
-	QSORT(ctx->oids.list, ctx->oids.nr, commit_compare);
+	QSORT(ctx->oids.list, ctx->oids.nr, oid_compare);
 
 	for (i = 1; i < ctx->oids.nr; i++) {
 		display_progress(ctx->progress, i + 1);
-		if (!oideq(&ctx->oids.list[i - 1], &ctx->oids.list[i]))
+		if (!oideq(&ctx->oids.list[i - 1], &ctx->oids.list[i])) {
+			if (ctx->split) {
+				struct commit *c = lookup_commit(ctx->r, &ctx->oids.list[i]);
+
+				if (!c || c->graph_pos != COMMIT_NOT_FROM_GRAPH)
+					continue;
+			}
+
 			count_distinct++;
+		}
 	}
 	stop_progress(&ctx->progress);
 
@@ -1079,7 +1131,13 @@ static void copy_oids_to_commits(struct write_commit_graph_context *ctx)
 		if (i > 0 && oideq(&ctx->oids.list[i - 1], &ctx->oids.list[i]))
 			continue;
 
+		ALLOC_GROW(ctx->commits.list, ctx->commits.nr + 1, ctx->commits.alloc);
 		ctx->commits.list[ctx->commits.nr] = lookup_commit(ctx->r, &ctx->oids.list[i]);
+
+		if (ctx->split &&
+		    ctx->commits.list[ctx->commits.nr]->graph_pos != COMMIT_NOT_FROM_GRAPH)
+			continue;
+
 		parse_commit_no_graph(ctx->commits.list[ctx->commits.nr]);
 
 		for (parent = ctx->commits.list[ctx->commits.nr]->parents;
@@ -1105,7 +1163,13 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	struct strbuf progress_title = STRBUF_INIT;
 	int num_chunks = ctx->num_extra_edges ? 4 : 3;
 
-	ctx->graph_name = get_commit_graph_filename(ctx->obj_dir);
+	if (ctx->num_commit_graphs_after > 1)
+		ctx->graph_name = get_split_graph_filename(
+					ctx->obj_dir,
+					ctx->num_commit_graphs_after - 1);
+	else
+		ctx->graph_name = get_commit_graph_filename(ctx->obj_dir);
+
 	if (safe_create_leading_directories(ctx->graph_name)) {
 		UNLEAK(ctx->graph_name);
 		error(_("unable to create leading directories of %s"),
@@ -1167,11 +1231,166 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 
 	close_commit_graph(ctx->r);
 	finalize_hashfile(f, NULL, CSUM_HASH_IN_STREAM | CSUM_FSYNC);
+
+	while (ctx->num_commit_graphs_before > ctx->num_commit_graphs_after) {
+		char *graph_name = get_split_graph_filename(
+					ctx->obj_dir,
+					--ctx->num_commit_graphs_before);
+		unlink(graph_name);
+		free(graph_name);
+	}
+
 	commit_lock_file(&lk);
 
 	return 0;
 }
 
+static size_t expected_commit_graph_size(size_t num_commits)
+{
+	return GRAPH_HEADER_SIZE + GRAPH_FANOUT_SIZE + 6 * GRAPH_CHUNKLOOKUP_WIDTH +
+		(num_commits + 1) * (GRAPH_DATA_WIDTH + the_hash_algo->rawsz);
+}
+
+static void split_graph_merge_strategy(struct write_commit_graph_context *ctx)
+{
+	struct commit_graph *g = ctx->r->objects->commit_graph;
+	uint32_t num_commits = ctx->commits.nr;
+	size_t expected_size = expected_commit_graph_size(num_commits);
+
+	ctx->num_commit_graphs_before = 0;
+	while (g) {
+		ctx->num_commit_graphs_before++;
+		g = g->base_graph;
+	}
+
+	g = ctx->r->objects->commit_graph;
+	ctx->num_commit_graphs_after = ctx->num_commit_graphs_before + 1;
+
+	while (g && (g->data_len <= 2 * expected_size || num_commits > MAX_SPLIT_COMMITS)) {
+		num_commits += g->num_commits;
+		expected_size = expected_commit_graph_size(num_commits);
+		g = g->base_graph;
+		ctx->num_commit_graphs_after--;
+	}
+}
+
+static void merge_commit_graph(struct write_commit_graph_context *ctx,
+			       struct commit_graph *g)
+{
+	uint32_t i;
+	uint32_t offset = g->num_commits_in_base;
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
+			ALLOC_GROW(ctx->commits.list, ctx->commits.nr + 1, ctx->commits.alloc);
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
+			if (current_graph_number)
+				strbuf_addf(&progress_title,
+					    _("Merging commit-graph-%d"),
+					    current_graph_number);
+			else
+				strbuf_addstr(&progress_title,
+					      _("Merging commit-graph"));
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
+	deduplicate_commits(ctx);
+}
+
+static void collapse_all_commit_graphs(struct write_commit_graph_context *ctx)
+{
+	struct commit_graph *g = ctx->r->objects->commit_graph;
+
+	ctx->num_commit_graphs_after = 1;
+	ctx->num_commit_graphs_before = 0;
+
+	while (g) {
+		ctx->num_commit_graphs_before++;
+		g = g->base_graph;
+	}
+}
+
 int write_commit_graph(const char *obj_dir,
 		       struct string_list *pack_indexes,
 		       struct string_list *commit_hex,
@@ -1189,10 +1408,17 @@ int write_commit_graph(const char *obj_dir,
 	ctx->obj_dir = obj_dir;
 	ctx->append = flags & COMMIT_GRAPH_APPEND ? 1 : 0;
 	ctx->report_progress = flags & COMMIT_GRAPH_PROGRESS ? 1 : 0;
+	ctx->split = flags & COMMIT_GRAPH_SPLIT ? 1 : 0;
+
+	if (ctx->split)
+		prepare_commit_graph(ctx->r);
 
 	ctx->approx_nr_objects = approximate_object_count();
 	ctx->oids.alloc = ctx->approx_nr_objects / 32;
 
+	if (ctx->split && ctx->oids.alloc > MAX_SPLIT_COMMITS)
+		ctx->oids.alloc = MAX_SPLIT_COMMITS;
+
 	if (ctx->append) {
 		prepare_commit_graph_one(ctx->r, ctx->obj_dir);
 		if (ctx->r->objects->commit_graph)
@@ -1243,6 +1469,16 @@ int write_commit_graph(const char *obj_dir,
 		goto cleanup;
 	}
 
+	if (!ctx->commits.nr)
+		goto cleanup;
+
+	if (ctx->split) {
+		split_graph_merge_strategy(ctx);
+
+		merge_commit_graphs(ctx);
+	} else
+		collapse_all_commit_graphs(ctx);
+
 	compute_generation_numbers(ctx);
 
 	res = write_commit_graph_file(ctx);
diff --git a/commit-graph.h b/commit-graph.h
index 170920720d..7a39ae2278 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -71,6 +71,7 @@ int generation_numbers_enabled(struct repository *r);
 
 #define COMMIT_GRAPH_APPEND     (1 << 0)
 #define COMMIT_GRAPH_PROGRESS   (1 << 1)
+#define COMMIT_GRAPH_SPLIT      (1 << 2)
 
 int write_commit_graph_reachable(const char *obj_dir, unsigned int flags);
 int write_commit_graph(const char *obj_dir,
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index e80c1cac02..d621608500 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -20,7 +20,7 @@ test_expect_success 'verify graph with no graph file' '
 test_expect_success 'write graph with no packs' '
 	cd "$TRASH_DIRECTORY/full" &&
 	git commit-graph write --object-dir . &&
-	test_path_is_file info/commit-graph
+	test_path_is_missing info/commit-graph
 '
 
 test_expect_success 'create commits and repack' '
-- 
gitgitgadget

