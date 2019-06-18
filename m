Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDBE81F462
	for <e@80x24.org>; Tue, 18 Jun 2019 18:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730337AbfFRSOg (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 14:14:36 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:44374 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730317AbfFRSOd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 14:14:33 -0400
Received: by mail-ed1-f42.google.com with SMTP id k8so23016828edr.11
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 11:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XgtfZ7atL2KmCxrXylzStOnI5mhqR3dS9hizuGV2I5Q=;
        b=dWGsMu6ggRKWZG6eZAOevQXqZ6UORKZXGLd2FAuHh6AF11zFFMF5EFCQcYxnU8vgU8
         NELurzsxB13NdPvta1zKnHuMecrM2Z3U29TkGWdvHiaLspxhNoRG1Y7n2XGB2v5EQXH9
         IWjXavj25cpZldl32cgEmyalMq03bilSVNRC8WJBi+g5zcMMQnII3AtLUsp+pf/uvDo9
         lvKP5+TOA8iW49NoG9mquZr8vPf6CZjZ1tDOZj5+yzWsS0O0hcobITd2yKLQq9Q2JNH7
         2n9a0q55xBSCNCdnAGRCEyI2yHe5EYG63ZgTLQ76aZHF1KVCAS/StPHoK3NxarbLmU1x
         S6mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XgtfZ7atL2KmCxrXylzStOnI5mhqR3dS9hizuGV2I5Q=;
        b=G8+mzUzIGvy9Bh7jvUXo7ZdPV1BPBtEJKDDJI0aADN8YuOks1caKUufUDlQv48BZKN
         p7hJSZcGtS0VNDx+J91Oj/Ic+f7gOcuNkbzFa38CVyLhh2yBCs0VB7c0E/ZodcPvfeo7
         c6f6ZyBq4LQY2/FZv9fp0g08t5oW5exsx9F1TUqYKAl+sjf+DLjqG+943CbafXx7Gr3b
         Cu/Fdfbty7m+N51YVuYg1kEfhiurXmM0tKj+UHxdzHOPsPKPj16Dm767U6Qr8z8PeLog
         gCEBrVG7mBRdnqXUn+d9TiNtk3fPIAFPTySz51PyKlbPlOmKMqbUOiAK/bOf2kwS9z3Q
         Frkg==
X-Gm-Message-State: APjAAAXyO7PrvTmkIuqz+5uALnqYUVGBJZ1x7Wlgj1hx/hZlDrWKCqSF
        YdahbqgTfjOSTHwV1OK2VYDnbVrC
X-Google-Smtp-Source: APXvYqxIAEekzrFnQI5jy2gsaGX56gn/KTCrlFeZE3Vy7E0PM/zSxv3ohbPAQ8aqCPxeXwx9xA9+Ng==
X-Received: by 2002:a05:6402:1459:: with SMTP id d25mr13135226edx.235.1560881670962;
        Tue, 18 Jun 2019 11:14:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e22sm4920980edd.25.2019.06.18.11.14.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 11:14:30 -0700 (PDT)
Date:   Tue, 18 Jun 2019 11:14:30 -0700 (PDT)
X-Google-Original-Date: Tue, 18 Jun 2019 18:14:12 GMT
Message-Id: <65b1cc6ae98fb801e43780439795e319396c1ce0.1560881661.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.v6.git.gitgitgadget@gmail.com>
References: <pull.184.v5.git.gitgitgadget@gmail.com>
        <pull.184.v6.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v6 10/18] commit-graph: allow cross-alternate chains
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, git@jeffhostetler.com,
        jrnieder@google.com, steadmon@google.com,
        johannes.schindelin@gmx.de, philipoakley@iee.org,
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
   "commit-graphs/graph-{hash}.graph".

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/technical/commit-graph.txt | 40 +++++++++++++++++
 commit-graph.c                           | 56 +++++++++++++++++++-----
 commit-graph.h                           |  1 +
 t/t5324-split-commit-graph.sh            | 37 ++++++++++++++++
 4 files changed, 123 insertions(+), 11 deletions(-)

diff --git a/Documentation/technical/commit-graph.txt b/Documentation/technical/commit-graph.txt
index d9c6253b0a..473032e476 100644
--- a/Documentation/technical/commit-graph.txt
+++ b/Documentation/technical/commit-graph.txt
@@ -266,6 +266,42 @@ The merge strategy values (2 for the size multiple, 64,000 for the maximum
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
@@ -292,3 +328,7 @@ Related Links
 
 [4] https://public-inbox.org/git/20180108154822.54829-1-git@jeffhostetler.com/T/#u
     A patch to remove the ahead-behind calculation from 'status'.
+
+[5] https://public-inbox.org/git/f27db281-abad-5043-6d71-cbb083b1c877@gmail.com/
+    A discussion of a "two-dimensional graph position" that can allow reading
+    multiple commit-graph chains at the same time.
diff --git a/commit-graph.c b/commit-graph.c
index fb3100921c..fba705bc51 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -320,6 +320,9 @@ static struct commit_graph *load_commit_graph_v1(struct repository *r, const cha
 	struct commit_graph *g = load_commit_graph_one(graph_name);
 	free(graph_name);
 
+	if (g)
+		g->obj_dir = obj_dir;
+
 	return g;
 }
 
@@ -379,9 +382,10 @@ static struct commit_graph *load_commit_graph_chain(struct repository *r, const
 	count = st.st_size / (the_hash_algo->hexsz + 1);
 	oids = xcalloc(count, sizeof(struct object_id));
 
-	for (i = 0; i < count && valid; i++) {
-		char *graph_name;
-		struct commit_graph *g;
+	prepare_alt_odb(r);
+
+	for (i = 0; i < count; i++) {
+		struct object_directory *odb;
 
 		if (strbuf_getline_lf(&line, fp) == EOF)
 			break;
@@ -393,14 +397,29 @@ static struct commit_graph *load_commit_graph_chain(struct repository *r, const
 			break;
 		}
 
-		graph_name = get_split_graph_filename(obj_dir, line.buf);
-		g = load_commit_graph_one(graph_name);
-		free(graph_name);
+		valid = 0;
+		for (odb = r->objects->odb; odb; odb = odb->next) {
+			char *graph_name = get_split_graph_filename(odb->path, line.buf);
+			struct commit_graph *g = load_commit_graph_one(graph_name);
 
-		if (g && add_graph_to_chain(g, graph_chain, oids, i))
-			graph_chain = g;
-		else
-			valid = 0;
+			free(graph_name);
+
+			if (g) {
+				g->obj_dir = odb->path;
+
+				if (add_graph_to_chain(g, graph_chain, oids, i)) {
+					graph_chain = g;
+					valid = 1;
+				}
+
+				break;
+			}
+		}
+
+		if (!valid) {
+			warning(_("unable to find all commit-graph files"));
+			break;
+		}
 	}
 
 	free(oids);
@@ -1418,7 +1437,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 
 	if (ctx->split && ctx->base_graph_name && ctx->num_commit_graphs_after > 1) {
 		char *new_base_hash = xstrdup(oid_to_hex(&ctx->new_base_graph->oid));
-		char *new_base_name = get_split_graph_filename(ctx->obj_dir, new_base_hash);
+		char *new_base_name = get_split_graph_filename(ctx->new_base_graph->obj_dir, new_base_hash);
 
 		free(ctx->commit_graph_filenames_after[ctx->num_commit_graphs_after - 2]);
 		free(ctx->commit_graph_hash_after[ctx->num_commit_graphs_after - 2]);
@@ -1493,6 +1512,9 @@ static void split_graph_merge_strategy(struct write_commit_graph_context *ctx)
 
 	while (g && (g->num_commits <= split_strategy_size_mult * num_commits ||
 		     num_commits > split_strategy_max_commits)) {
+		if (strcmp(g->obj_dir, ctx->obj_dir))
+			break;
+
 		num_commits += g->num_commits;
 		g = g->base_graph;
 
@@ -1501,6 +1523,18 @@ static void split_graph_merge_strategy(struct write_commit_graph_context *ctx)
 
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
index c321834533..802d35254f 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -48,6 +48,7 @@ struct commit_graph {
 	uint32_t num_commits;
 	struct object_id oid;
 	char *filename;
+	const char *obj_dir;
 
 	uint32_t num_commits_in_base;
 	struct commit_graph *base_graph;
diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index 5cb5663a30..46f0832f68 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -90,6 +90,21 @@ test_expect_success 'add more commits, and write a new base graph' '
 	graph_read_expect 12
 '
 
+test_expect_success 'fork and fail to base a chain on a commit-graph file' '
+	test_when_finished rm -rf fork &&
+	git clone . fork &&
+	(
+		cd fork &&
+		rm .git/objects/info/commit-graph &&
+		echo "$(pwd)/../.git/objects" >.git/objects/info/alternates &&
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
+		echo "$(pwd)/../.git/objects" >.git/objects/info/alternates &&
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

