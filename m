Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 505811F45F
	for <e@80x24.org>; Wed,  8 May 2019 15:54:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbfEHPxz (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 11:53:55 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40047 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727686AbfEHPxz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 11:53:55 -0400
Received: by mail-ed1-f65.google.com with SMTP id e56so22521694ede.7
        for <git@vger.kernel.org>; Wed, 08 May 2019 08:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XLsyJ3l6cMF9SDOGmuvtPRB6xoQOGSbFQzigLBJAR54=;
        b=Qq2SBgkmRNZHO5ZRwkDhGBYiU6umCD4BNSHNVwXZCSi60rYm2Enq/fe84n/pOdNAg8
         2eSea/3JwK2b2MhBrjUv9d5g6wuzTUYR2t4azHjFJ0M5Qo1dNR67hu74g5wW8O0BpwSd
         TFDec0cpV1VT7KPdr67KhBDz2MCalZee8k72i/3gi/fQSPgf+7w/m9m5CZDMPGgZSLJk
         W3Vt54GiTDNaJqBvKg4gjmRdntsryjNA1DG7rwyLJP6oUMELJVA4JjAOZqjlc4htJ/95
         JqvwCvTvCbVWMpF64Whf3fuuxatT4gLxdDd8pYgm6sdapiGsL/4LacM4HcHZ24zyrDC8
         P22w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XLsyJ3l6cMF9SDOGmuvtPRB6xoQOGSbFQzigLBJAR54=;
        b=qJS/bLSHOh2IjZSrAwZFxBQ/D5DCuaFrsu3DZv0+WLqRLOlIb/S1SdMJzCaA385lp2
         XPSkMVLUDarfzgXiG4xsg3hMjVnvt59n0JFFWsarvZL4V8GaYB0wE/2Muzi8aaPnOwXh
         YaXtwI7jFZjnEJiEeNZIlGGPQD3LzRNUKBXDCydeSGn1CTLkp/gjiC8KfwmUJgxGXwe2
         keMAn0KE0BP5rbHx/XuEg4UBf5AtmfLIYSuVOmXc/ES51YrI7IXZViV1hLVsssV4mA6s
         UlTc1Hhm/RalZbhAggc31nPdS+uo8dc/SedRa3VEaR0IVC2cm2aCzphwevhrh/mTxLpq
         eYOQ==
X-Gm-Message-State: APjAAAVOHbbEoNd+C4yGVq18ETKRqczFJ60yDyBthyOoa0UXekNPkbQe
        SW5L79P4p2vWug/CTsCQbKtxYMwNw0A=
X-Google-Smtp-Source: APXvYqxVbqKkRSj13YpXtRMfY6DfYjnMS14uUnsjRtQCUoWs/D3df7ELFBdKLVFDfUXRwJkqYw0qnw==
X-Received: by 2002:a50:a5ed:: with SMTP id b42mr39459672edc.178.1557330832259;
        Wed, 08 May 2019 08:53:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i45sm1359848eda.67.2019.05.08.08.53.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 08:53:51 -0700 (PDT)
Date:   Wed, 08 May 2019 08:53:51 -0700 (PDT)
X-Google-Original-Date: Wed, 08 May 2019 15:53:34 GMT
Message-Id: <74e40970e0dfe00404a8ef52f0d38389a6e4a987.1557330826.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.git.gitgitgadget@gmail.com>
References: <pull.184.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 05/17] commit-graph: create write_commit_graph_context
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

The write_commit_graph() method is too large and complex. To simplify
it, we should extract several small methods. However, we will risk
repeating a lot of declarations related to progress incidators and
object id or commit lists.

Create a new write_commit_graph_context struct that contains the
core data structures used in this process. Replace the other local
variables with the values inside the context object. Following this
change, we will start to lift code segments wholesale out of the
write_commit_graph() method and into their own methods.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 390 ++++++++++++++++++++++++-------------------------
 1 file changed, 194 insertions(+), 196 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 8bbd50658c..58f0f0ae34 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -518,14 +518,38 @@ struct tree *get_commit_tree_in_graph(struct repository *r, const struct commit
 	return get_commit_tree_in_graph_one(r, r->objects->commit_graph, c);
 }
 
+struct packed_commit_list {
+	struct commit **list;
+	int nr;
+	int alloc;
+};
+
+struct packed_oid_list {
+	struct object_id *list;
+	int nr;
+	int alloc;
+};
+
+struct write_commit_graph_context {
+	struct repository *r;
+	const char *obj_dir;
+	char *graph_name;
+	struct packed_oid_list oids;
+	struct packed_commit_list commits;
+	int num_extra_edges;
+	unsigned long approx_nr_objects;
+	struct progress *progress;
+	int progress_done;
+	uint64_t progress_cnt;
+	unsigned append:1,
+		 report_progress:1;
+};
+
 static void write_graph_chunk_fanout(struct hashfile *f,
-				     struct commit **commits,
-				     int nr_commits,
-				     struct progress *progress,
-				     uint64_t *progress_cnt)
+				     struct write_commit_graph_context *ctx)
 {
 	int i, count = 0;
-	struct commit **list = commits;
+	struct commit **list = ctx->commits.list;
 
 	/*
 	 * Write the first-level table (the list is sorted,
@@ -533,10 +557,10 @@ static void write_graph_chunk_fanout(struct hashfile *f,
 	 * having to do eight extra binary search iterations).
 	 */
 	for (i = 0; i < 256; i++) {
-		while (count < nr_commits) {
+		while (count < ctx->commits.nr) {
 			if ((*list)->object.oid.hash[0] != i)
 				break;
-			display_progress(progress, ++*progress_cnt);
+			display_progress(ctx->progress, ++ctx->progress_cnt);
 			count++;
 			list++;
 		}
@@ -546,14 +570,12 @@ static void write_graph_chunk_fanout(struct hashfile *f,
 }
 
 static void write_graph_chunk_oids(struct hashfile *f, int hash_len,
-				   struct commit **commits, int nr_commits,
-				   struct progress *progress,
-				   uint64_t *progress_cnt)
+				   struct write_commit_graph_context *ctx)
 {
-	struct commit **list = commits;
+	struct commit **list = ctx->commits.list;
 	int count;
-	for (count = 0; count < nr_commits; count++, list++) {
-		display_progress(progress, ++*progress_cnt);
+	for (count = 0; count < ctx->commits.nr; count++, list++) {
+		display_progress(ctx->progress, ++ctx->progress_cnt);
 		hashwrite(f, (*list)->object.oid.hash, (int)hash_len);
 	}
 }
@@ -565,19 +587,17 @@ static const unsigned char *commit_to_sha1(size_t index, void *table)
 }
 
 static void write_graph_chunk_data(struct hashfile *f, int hash_len,
-				   struct commit **commits, int nr_commits,
-				   struct progress *progress,
-				   uint64_t *progress_cnt)
+				   struct write_commit_graph_context *ctx)
 {
-	struct commit **list = commits;
-	struct commit **last = commits + nr_commits;
+	struct commit **list = ctx->commits.list;
+	struct commit **last = ctx->commits.list + ctx->commits.nr;
 	uint32_t num_extra_edges = 0;
 
 	while (list < last) {
 		struct commit_list *parent;
 		int edge_value;
 		uint32_t packedDate[2];
-		display_progress(progress, ++*progress_cnt);
+		display_progress(ctx->progress, ++ctx->progress_cnt);
 
 		parse_commit_no_graph(*list);
 		hashwrite(f, get_commit_tree_oid(*list)->hash, hash_len);
@@ -588,8 +608,8 @@ static void write_graph_chunk_data(struct hashfile *f, int hash_len,
 			edge_value = GRAPH_PARENT_NONE;
 		else {
 			edge_value = sha1_pos(parent->item->object.oid.hash,
-					      commits,
-					      nr_commits,
+					      ctx->commits.list,
+					      ctx->commits.nr,
 					      commit_to_sha1);
 
 			if (edge_value < 0)
@@ -609,8 +629,8 @@ static void write_graph_chunk_data(struct hashfile *f, int hash_len,
 			edge_value = GRAPH_EXTRA_EDGES_NEEDED | num_extra_edges;
 		else {
 			edge_value = sha1_pos(parent->item->object.oid.hash,
-					      commits,
-					      nr_commits,
+					      ctx->commits.list,
+					      ctx->commits.nr,
 					      commit_to_sha1);
 			if (edge_value < 0)
 				BUG("missing parent %s for commit %s",
@@ -642,19 +662,16 @@ static void write_graph_chunk_data(struct hashfile *f, int hash_len,
 }
 
 static void write_graph_chunk_extra_edges(struct hashfile *f,
-					  struct commit **commits,
-					  int nr_commits,
-					  struct progress *progress,
-					  uint64_t *progress_cnt)
+					  struct write_commit_graph_context *ctx)
 {
-	struct commit **list = commits;
-	struct commit **last = commits + nr_commits;
+	struct commit **list = ctx->commits.list;
+	struct commit **last = ctx->commits.list + ctx->commits.nr;
 	struct commit_list *parent;
 
 	while (list < last) {
 		int num_parents = 0;
 
-		display_progress(progress, ++*progress_cnt);
+		display_progress(ctx->progress, ++ctx->progress_cnt);
 
 		for (parent = (*list)->parents; num_parents < 3 && parent;
 		     parent = parent->next)
@@ -668,8 +685,8 @@ static void write_graph_chunk_extra_edges(struct hashfile *f,
 		/* Since num_parents > 2, this initializer is safe. */
 		for (parent = (*list)->parents->next; parent; parent = parent->next) {
 			int edge_value = sha1_pos(parent->item->object.oid.hash,
-						  commits,
-						  nr_commits,
+						  ctx->commits.list,
+						  ctx->commits.nr,
 						  commit_to_sha1);
 
 			if (edge_value < 0)
@@ -693,125 +710,111 @@ static int commit_compare(const void *_a, const void *_b)
 	return oidcmp(a, b);
 }
 
-struct packed_commit_list {
-	struct commit **list;
-	int nr;
-	int alloc;
-};
-
-struct packed_oid_list {
-	struct object_id *list;
-	int nr;
-	int alloc;
-	struct progress *progress;
-	int progress_done;
-};
-
 static int add_packed_commits(const struct object_id *oid,
 			      struct packed_git *pack,
 			      uint32_t pos,
 			      void *data)
 {
-	struct packed_oid_list *list = (struct packed_oid_list*)data;
+	struct write_commit_graph_context *ctx = (struct write_commit_graph_context*)data;
 	enum object_type type;
 	off_t offset = nth_packed_object_offset(pack, pos);
 	struct object_info oi = OBJECT_INFO_INIT;
 
-	if (list->progress)
-		display_progress(list->progress, ++list->progress_done);
+	if (ctx->progress)
+		display_progress(ctx->progress, ++ctx->progress_done);
 
 	oi.typep = &type;
-	if (packed_object_info(the_repository, pack, offset, &oi) < 0)
+	if (packed_object_info(ctx->r, pack, offset, &oi) < 0)
 		die(_("unable to get type of object %s"), oid_to_hex(oid));
 
 	if (type != OBJ_COMMIT)
 		return 0;
 
-	ALLOC_GROW(list->list, list->nr + 1, list->alloc);
-	oidcpy(&(list->list[list->nr]), oid);
-	list->nr++;
+	ALLOC_GROW(ctx->oids.list, ctx->oids.nr + 1, ctx->oids.alloc);
+	oidcpy(&(ctx->oids.list[ctx->oids.nr]), oid);
+	ctx->oids.nr++;
 
 	return 0;
 }
 
-static void add_missing_parents(struct packed_oid_list *oids, struct commit *commit)
+static void add_missing_parents(struct write_commit_graph_context *ctx, struct commit *commit)
 {
 	struct commit_list *parent;
 	for (parent = commit->parents; parent; parent = parent->next) {
 		if (!(parent->item->object.flags & UNINTERESTING)) {
-			ALLOC_GROW(oids->list, oids->nr + 1, oids->alloc);
-			oidcpy(&oids->list[oids->nr], &(parent->item->object.oid));
-			oids->nr++;
+			ALLOC_GROW(ctx->oids.list, ctx->oids.nr + 1, ctx->oids.alloc);
+			oidcpy(&ctx->oids.list[ctx->oids.nr], &(parent->item->object.oid));
+			ctx->oids.nr++;
 			parent->item->object.flags |= UNINTERESTING;
 		}
 	}
 }
 
-static void close_reachable(struct packed_oid_list *oids, int report_progress)
+static void close_reachable(struct write_commit_graph_context *ctx)
 {
 	int i;
 	struct commit *commit;
-	struct progress *progress = NULL;
 
-	if (report_progress)
-		progress = start_delayed_progress(
-			_("Loading known commits in commit graph"), oids->nr);
-	for (i = 0; i < oids->nr; i++) {
-		display_progress(progress, i + 1);
-		commit = lookup_commit(the_repository, &oids->list[i]);
+	if (ctx->report_progress)
+		ctx->progress = start_delayed_progress(
+					_("Loading known commits in commit graph"),
+					ctx->oids.nr);
+	for (i = 0; i < ctx->oids.nr; i++) {
+		display_progress(ctx->progress, i + 1);
+		commit = lookup_commit(ctx->r, &ctx->oids.list[i]);
 		if (commit)
 			commit->object.flags |= UNINTERESTING;
 	}
-	stop_progress(&progress);
+	stop_progress(&ctx->progress);
 
 	/*
-	 * As this loop runs, oids->nr may grow, but not more
+	 * As this loop runs, ctx->oids.nr may grow, but not more
 	 * than the number of missing commits in the reachable
 	 * closure.
 	 */
-	if (report_progress)
-		progress = start_delayed_progress(
-			_("Expanding reachable commits in commit graph"), oids->nr);
-	for (i = 0; i < oids->nr; i++) {
-		display_progress(progress, i + 1);
-		commit = lookup_commit(the_repository, &oids->list[i]);
+	if (ctx->report_progress)
+		ctx->progress = start_delayed_progress(
+					_("Expanding reachable commits in commit graph"),
+					ctx->oids.nr);
+	for (i = 0; i < ctx->oids.nr; i++) {
+		display_progress(ctx->progress, i + 1);
+		commit = lookup_commit(ctx->r, &ctx->oids.list[i]);
 
 		if (commit && !parse_commit_no_graph(commit))
-			add_missing_parents(oids, commit);
+			add_missing_parents(ctx, commit);
 	}
-	stop_progress(&progress);
+	stop_progress(&ctx->progress);
 
-	if (report_progress)
-		progress = start_delayed_progress(
-			_("Clearing commit marks in commit graph"), oids->nr);
-	for (i = 0; i < oids->nr; i++) {
-		display_progress(progress, i + 1);
-		commit = lookup_commit(the_repository, &oids->list[i]);
+	if (ctx->report_progress)
+		ctx->progress = start_delayed_progress(
+					_("Clearing commit marks in commit graph"),
+					ctx->oids.nr);
+	for (i = 0; i < ctx->oids.nr; i++) {
+		display_progress(ctx->progress, i + 1);
+		commit = lookup_commit(ctx->r, &ctx->oids.list[i]);
 
 		if (commit)
 			commit->object.flags &= ~UNINTERESTING;
 	}
-	stop_progress(&progress);
+	stop_progress(&ctx->progress);
 }
 
-static void compute_generation_numbers(struct packed_commit_list* commits,
-				       int report_progress)
+static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 {
 	int i;
 	struct commit_list *list = NULL;
-	struct progress *progress = NULL;
 
-	if (report_progress)
-		progress = start_progress(
-			_("Computing commit graph generation numbers"),
-			commits->nr);
-	for (i = 0; i < commits->nr; i++) {
-		display_progress(progress, i + 1);
-		if (commits->list[i]->generation != GENERATION_NUMBER_INFINITY &&
-		    commits->list[i]->generation != GENERATION_NUMBER_ZERO)
+	if (ctx->report_progress)
+		ctx->progress = start_progress(
+					_("Computing commit graph generation numbers"),
+					ctx->commits.nr);
+	for (i = 0; i < ctx->commits.nr; i++) {
+		display_progress(ctx->progress, i + 1);
+		if (ctx->commits.list[i]->generation != GENERATION_NUMBER_INFINITY &&
+		    ctx->commits.list[i]->generation != GENERATION_NUMBER_ZERO)
 			continue;
 
-		commit_list_insert(commits->list[i], &list);
+		commit_list_insert(ctx->commits.list[i], &list);
 		while (list) {
 			struct commit *current = list->item;
 			struct commit_list *parent;
@@ -838,7 +841,7 @@ static void compute_generation_numbers(struct packed_commit_list* commits,
 			}
 		}
 	}
-	stop_progress(&progress);
+	stop_progress(&ctx->progress);
 }
 
 static int add_ref_to_list(const char *refname,
@@ -869,8 +872,7 @@ int write_commit_graph(const char *obj_dir,
 		       struct string_list *commit_hex,
 		       unsigned int flags)
 {
-	struct packed_oid_list oids;
-	struct packed_commit_list commits;
+	struct write_commit_graph_context *ctx;
 	struct hashfile *f;
 	uint32_t i, count_distinct = 0;
 	char *graph_name = NULL;
@@ -878,44 +880,38 @@ int write_commit_graph(const char *obj_dir,
 	uint32_t chunk_ids[5];
 	uint64_t chunk_offsets[5];
 	int num_chunks;
-	int num_extra_edges;
 	struct commit_list *parent;
-	struct progress *progress = NULL;
 	const unsigned hashsz = the_hash_algo->rawsz;
-	uint64_t progress_cnt = 0;
 	struct strbuf progress_title = STRBUF_INIT;
-	unsigned long approx_nr_objects;
 	int res = 0;
-	int append = flags & COMMIT_GRAPH_APPEND;
-	int report_progress = flags & COMMIT_GRAPH_PROGRESS;
 
 	if (!commit_graph_compatible(the_repository))
 		return 0;
 
-	oids.nr = 0;
-	approx_nr_objects = approximate_object_count();
-	oids.alloc = approx_nr_objects / 32;
-	oids.progress = NULL;
-	oids.progress_done = 0;
-	commits.list = NULL;
-
-	if (append) {
-		prepare_commit_graph_one(the_repository, obj_dir);
-		if (the_repository->objects->commit_graph)
-			oids.alloc += the_repository->objects->commit_graph->num_commits;
+	ctx = xcalloc(1, sizeof(struct write_commit_graph_context));
+	ctx->r = the_repository;
+	ctx->obj_dir = obj_dir;
+	ctx->append = flags & COMMIT_GRAPH_APPEND ? 1 : 0;
+	ctx->report_progress = flags & COMMIT_GRAPH_PROGRESS ? 1 : 0;
+
+	ctx->approx_nr_objects = approximate_object_count();
+	ctx->oids.alloc = ctx->approx_nr_objects / 32;
+
+	if (ctx->append) {
+		prepare_commit_graph_one(ctx->r, ctx->obj_dir);
+		if (ctx->r->objects->commit_graph)
+			ctx->oids.alloc += ctx->r->objects->commit_graph->num_commits;
 	}
 
-	if (oids.alloc < 1024)
-		oids.alloc = 1024;
-	ALLOC_ARRAY(oids.list, oids.alloc);
-
-	if (append && the_repository->objects->commit_graph) {
-		struct commit_graph *commit_graph =
-			the_repository->objects->commit_graph;
-		for (i = 0; i < commit_graph->num_commits; i++) {
-			const unsigned char *hash = commit_graph->chunk_oid_lookup +
-				commit_graph->hash_len * i;
-			hashcpy(oids.list[oids.nr++].hash, hash);
+	if (ctx->oids.alloc < 1024)
+		ctx->oids.alloc = 1024;
+	ALLOC_ARRAY(ctx->oids.list, ctx->oids.alloc);
+
+	if (ctx->append && ctx->r->objects->commit_graph) {
+		struct commit_graph *g = ctx->r->objects->commit_graph;
+		for (i = 0; i < g->num_commits; i++) {
+			const unsigned char *hash = g->chunk_oid_lookup + g->hash_len * i;
+			hashcpy(ctx->oids.list[ctx->oids.nr++].hash, hash);
 		}
 	}
 
@@ -924,14 +920,14 @@ int write_commit_graph(const char *obj_dir,
 		int dirlen;
 		strbuf_addf(&packname, "%s/pack/", obj_dir);
 		dirlen = packname.len;
-		if (report_progress) {
+		if (ctx->report_progress) {
 			strbuf_addf(&progress_title,
 				    Q_("Finding commits for commit graph in %d pack",
 				       "Finding commits for commit graph in %d packs",
 				       pack_indexes->nr),
 				    pack_indexes->nr);
-			oids.progress = start_delayed_progress(progress_title.buf, 0);
-			oids.progress_done = 0;
+			ctx->progress = start_delayed_progress(progress_title.buf, 0);
+			ctx->progress_done = 0;
 		}
 		for (i = 0; i < pack_indexes->nr; i++) {
 			struct packed_git *p;
@@ -948,75 +944,76 @@ int write_commit_graph(const char *obj_dir,
 				res = 1;
 				goto cleanup;
 			}
-			for_each_object_in_pack(p, add_packed_commits, &oids,
+			for_each_object_in_pack(p, add_packed_commits, ctx,
 						FOR_EACH_OBJECT_PACK_ORDER);
 			close_pack(p);
 			free(p);
 		}
-		stop_progress(&oids.progress);
+		stop_progress(&ctx->progress);
 		strbuf_reset(&progress_title);
 		strbuf_release(&packname);
 	}
 
 	if (commit_hex) {
-		if (report_progress) {
+		if (ctx->report_progress) {
 			strbuf_addf(&progress_title,
 				    Q_("Finding commits for commit graph from %d ref",
 				       "Finding commits for commit graph from %d refs",
 				       commit_hex->nr),
 				    commit_hex->nr);
-			progress = start_delayed_progress(progress_title.buf,
-							  commit_hex->nr);
+			ctx->progress = start_delayed_progress(
+						progress_title.buf,
+						commit_hex->nr);
 		}
 		for (i = 0; i < commit_hex->nr; i++) {
 			const char *end;
 			struct object_id oid;
 			struct commit *result;
 
-			display_progress(progress, i + 1);
+			display_progress(ctx->progress, i + 1);
 			if (commit_hex->items[i].string &&
 			    parse_oid_hex(commit_hex->items[i].string, &oid, &end))
 				continue;
 
-			result = lookup_commit_reference_gently(the_repository, &oid, 1);
+			result = lookup_commit_reference_gently(ctx->r, &oid, 1);
 
 			if (result) {
-				ALLOC_GROW(oids.list, oids.nr + 1, oids.alloc);
-				oidcpy(&oids.list[oids.nr], &(result->object.oid));
-				oids.nr++;
+				ALLOC_GROW(ctx->oids.list, ctx->oids.nr + 1, ctx->oids.alloc);
+				oidcpy(&ctx->oids.list[ctx->oids.nr], &(result->object.oid));
+				ctx->oids.nr++;
 			}
 		}
-		stop_progress(&progress);
+		stop_progress(&ctx->progress);
 		strbuf_reset(&progress_title);
 	}
 
 	if (!pack_indexes && !commit_hex) {
-		if (report_progress)
-			oids.progress = start_delayed_progress(
+		if (ctx->report_progress)
+			ctx->progress = start_delayed_progress(
 				_("Finding commits for commit graph among packed objects"),
-				approx_nr_objects);
-		for_each_packed_object(add_packed_commits, &oids,
+				ctx->approx_nr_objects);
+		for_each_packed_object(add_packed_commits, ctx,
 				       FOR_EACH_OBJECT_PACK_ORDER);
-		if (oids.progress_done < approx_nr_objects)
-			display_progress(oids.progress, approx_nr_objects);
-		stop_progress(&oids.progress);
+		if (ctx->progress_done < ctx->approx_nr_objects)
+			display_progress(ctx->progress, ctx->approx_nr_objects);
+		stop_progress(&ctx->progress);
 	}
 
-	close_reachable(&oids, report_progress);
+	close_reachable(ctx);
 
-	if (report_progress)
-		progress = start_delayed_progress(
+	if (ctx->report_progress)
+		ctx->progress = start_delayed_progress(
 			_("Counting distinct commits in commit graph"),
-			oids.nr);
-	display_progress(progress, 0); /* TODO: Measure QSORT() progress */
-	QSORT(oids.list, oids.nr, commit_compare);
+			ctx->oids.nr);
+	display_progress(ctx->progress, 0); /* TODO: Measure QSORT() progress */
+	QSORT(ctx->oids.list, ctx->oids.nr, commit_compare);
 	count_distinct = 1;
-	for (i = 1; i < oids.nr; i++) {
-		display_progress(progress, i + 1);
-		if (!oideq(&oids.list[i - 1], &oids.list[i]))
+	for (i = 1; i < ctx->oids.nr; i++) {
+		display_progress(ctx->progress, i + 1);
+		if (!oideq(&ctx->oids.list[i - 1], &ctx->oids.list[i]))
 			count_distinct++;
 	}
-	stop_progress(&progress);
+	stop_progress(&ctx->progress);
 
 	if (count_distinct >= GRAPH_EDGE_LAST_MASK) {
 		error(_("the commit graph format cannot write %d commits"), count_distinct);
@@ -1024,54 +1021,54 @@ int write_commit_graph(const char *obj_dir,
 		goto cleanup;
 	}
 
-	commits.nr = 0;
-	commits.alloc = count_distinct;
-	ALLOC_ARRAY(commits.list, commits.alloc);
+	ctx->commits.alloc = count_distinct;
+	ALLOC_ARRAY(ctx->commits.list, ctx->commits.alloc);
 
-	num_extra_edges = 0;
-	if (report_progress)
-		progress = start_delayed_progress(
+	ctx->num_extra_edges = 0;
+	if (ctx->report_progress)
+		ctx->progress = start_delayed_progress(
 			_("Finding extra edges in commit graph"),
-			oids.nr);
-	for (i = 0; i < oids.nr; i++) {
+			ctx->oids.nr);
+	for (i = 0; i < ctx->oids.nr; i++) {
 		int num_parents = 0;
-		display_progress(progress, i + 1);
-		if (i > 0 && oideq(&oids.list[i - 1], &oids.list[i]))
+		display_progress(ctx->progress, i + 1);
+		if (i > 0 && oideq(&ctx->oids.list[i - 1], &ctx->oids.list[i]))
 			continue;
 
-		commits.list[commits.nr] = lookup_commit(the_repository, &oids.list[i]);
-		parse_commit_no_graph(commits.list[commits.nr]);
+		ctx->commits.list[ctx->commits.nr] = lookup_commit(ctx->r, &ctx->oids.list[i]);
+		parse_commit_no_graph(ctx->commits.list[ctx->commits.nr]);
 
-		for (parent = commits.list[commits.nr]->parents;
+		for (parent = ctx->commits.list[ctx->commits.nr]->parents;
 		     parent; parent = parent->next)
 			num_parents++;
 
 		if (num_parents > 2)
-			num_extra_edges += num_parents - 1;
+			ctx->num_extra_edges += num_parents - 1;
 
-		commits.nr++;
+		ctx->commits.nr++;
 	}
-	num_chunks = num_extra_edges ? 4 : 3;
-	stop_progress(&progress);
+	stop_progress(&ctx->progress);
 
-	if (commits.nr >= GRAPH_EDGE_LAST_MASK) {
+	if (ctx->commits.nr >= GRAPH_EDGE_LAST_MASK) {
 		error(_("too many commits to write graph"));
 		res = 1;
 		goto cleanup;
 	}
 
-	compute_generation_numbers(&commits, report_progress);
+	compute_generation_numbers(ctx);
 
-	graph_name = get_commit_graph_filename(obj_dir);
-	if (safe_create_leading_directories(graph_name)) {
-		UNLEAK(graph_name);
+	num_chunks = ctx->num_extra_edges ? 4 : 3;
+
+	ctx->graph_name = get_commit_graph_filename(ctx->obj_dir);
+	if (safe_create_leading_directories(ctx->graph_name)) {
+		UNLEAK(ctx->graph_name);
 		error(_("unable to create leading directories of %s"),
-			graph_name);
+			ctx->graph_name);
 		res = errno;
 		goto cleanup;
 	}
 
-	hold_lock_file_for_update(&lk, graph_name, LOCK_DIE_ON_ERROR);
+	hold_lock_file_for_update(&lk, ctx->graph_name, LOCK_DIE_ON_ERROR);
 	f = hashfd(lk.tempfile->fd, lk.tempfile->filename.buf);
 
 	hashwrite_be32(f, GRAPH_SIGNATURE);
@@ -1084,7 +1081,7 @@ int write_commit_graph(const char *obj_dir,
 	chunk_ids[0] = GRAPH_CHUNKID_OIDFANOUT;
 	chunk_ids[1] = GRAPH_CHUNKID_OIDLOOKUP;
 	chunk_ids[2] = GRAPH_CHUNKID_DATA;
-	if (num_extra_edges)
+	if (ctx->num_extra_edges)
 		chunk_ids[3] = GRAPH_CHUNKID_EXTRAEDGES;
 	else
 		chunk_ids[3] = 0;
@@ -1092,9 +1089,9 @@ int write_commit_graph(const char *obj_dir,
 
 	chunk_offsets[0] = 8 + (num_chunks + 1) * GRAPH_CHUNKLOOKUP_WIDTH;
 	chunk_offsets[1] = chunk_offsets[0] + GRAPH_FANOUT_SIZE;
-	chunk_offsets[2] = chunk_offsets[1] + hashsz * commits.nr;
-	chunk_offsets[3] = chunk_offsets[2] + (hashsz + 16) * commits.nr;
-	chunk_offsets[4] = chunk_offsets[3] + 4 * num_extra_edges;
+	chunk_offsets[2] = chunk_offsets[1] + hashsz * ctx->commits.nr;
+	chunk_offsets[3] = chunk_offsets[2] + (hashsz + 16) * ctx->commits.nr;
+	chunk_offsets[4] = chunk_offsets[3] + 4 * ctx->num_extra_edges;
 
 	for (i = 0; i <= num_chunks; i++) {
 		uint32_t chunk_write[3];
@@ -1105,32 +1102,33 @@ int write_commit_graph(const char *obj_dir,
 		hashwrite(f, chunk_write, 12);
 	}
 
-	if (report_progress) {
+	if (ctx->report_progress) {
 		strbuf_addf(&progress_title,
 			    Q_("Writing out commit graph in %d pass",
 			       "Writing out commit graph in %d passes",
 			       num_chunks),
 			    num_chunks);
-		progress = start_delayed_progress(
+		ctx->progress = start_delayed_progress(
 			progress_title.buf,
-			num_chunks * commits.nr);
+			num_chunks * ctx->commits.nr);
 	}
-	write_graph_chunk_fanout(f, commits.list, commits.nr, progress, &progress_cnt);
-	write_graph_chunk_oids(f, hashsz, commits.list, commits.nr, progress, &progress_cnt);
-	write_graph_chunk_data(f, hashsz, commits.list, commits.nr, progress, &progress_cnt);
-	if (num_extra_edges)
-		write_graph_chunk_extra_edges(f, commits.list, commits.nr, progress, &progress_cnt);
-	stop_progress(&progress);
+	write_graph_chunk_fanout(f, ctx);
+	write_graph_chunk_oids(f, hashsz, ctx);
+	write_graph_chunk_data(f, hashsz, ctx);
+	if (ctx->num_extra_edges)
+		write_graph_chunk_extra_edges(f, ctx);
+	stop_progress(&ctx->progress);
 	strbuf_release(&progress_title);
 
-	close_commit_graph(the_repository);
+	close_commit_graph(ctx->r);
 	finalize_hashfile(f, NULL, CSUM_HASH_IN_STREAM | CSUM_FSYNC);
 	commit_lock_file(&lk);
 
 cleanup:
 	free(graph_name);
-	free(commits.list);
-	free(oids.list);
+	free(ctx->commits.list);
+	free(ctx->oids.list);
+	free(ctx);
 
 	return res;
 }
-- 
gitgitgadget

