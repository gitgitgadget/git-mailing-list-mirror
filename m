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
	by dcvr.yhbt.net (Postfix) with ESMTP id AF95B1F462
	for <e@80x24.org>; Thu,  6 Jun 2019 14:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbfFFOPd (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jun 2019 10:15:33 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40898 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbfFFOPc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jun 2019 10:15:32 -0400
Received: by mail-ed1-f67.google.com with SMTP id r18so3555040edo.7
        for <git@vger.kernel.org>; Thu, 06 Jun 2019 07:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aJoUsfkOI1fhuOMGoTyVXCjVpWEVLD0dftfiT6TBwZs=;
        b=viMCt9ntw1ENKTIQtgC3TXepWecw/zVZ3fD6WW/VDdkY3j213xnmhMgrl/Hzo6mszr
         9KhVtC6T1yPcSHcKLiiJ/n89/wRWqTF8hZ5LB9eVBhQbg2NvB+YoYCOxbCeQED8ZjmJo
         xSaST3dEOLMUn5fDIgWCuLfZFtd9pbVsbL35j2tf4d/YMB8vm6a/T4BAmjr1Z+4NCIp4
         Da7qXPcB2rGp1s0wCvZXb8+5ngQir8+rCLyi9ORvajaG1czRtTExzKn1QN9kA+8rZYzh
         da7pkkpQCFYMMk7w505b/6J3MPctLCJSVZXBF85A/eDn0N63va/h5X6AYN57z3MlI+I0
         cO+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=aJoUsfkOI1fhuOMGoTyVXCjVpWEVLD0dftfiT6TBwZs=;
        b=MhXjCKdShDEtNx2b8sRdAc6QtRb9xDtLNXrVWdKDfoaxLNYqCH8fmfPglFUefph8Fm
         5oqQxwJosT0HAWWAz6sE49v2UXxhyDW6v8zxptKiu6WgvXLZjME8hWp/pcGP6c1QrC8n
         PYdpbiHvpRG8ymTcv0Lyy+I5D8aa660q/e2QEF604z2fNKT07ToOXH7hhsRnOff1NsgJ
         2GW2gPR13b0jhPWrgQi0s/fNxAvglZB3VtbK8hT5E54x2kegfhNAGyTRLBjQdkPAwXrl
         HuhwxWhpV+uf3/cfnwXtPjTrCUjS7ASttrlDklGyqYmm+rgQiFG1XKmDy1JWtyrHZDZM
         /lkg==
X-Gm-Message-State: APjAAAUT3KFitO03zb3VKC2qsfPzPNl6eukfdwoa9dfB2bduHG6pVBZM
        hbnFYujhFotAuDrJcNEsa5i5PATL
X-Google-Smtp-Source: APXvYqyGcnBK+zzJ7RoFyihvPEbFd1OAGQhZURUwmbGPdBYMhsUWX9VH+H+LcrIGC+TA1wkmofc3sA==
X-Received: by 2002:a17:906:498e:: with SMTP id p14mr12901254eju.49.1559830531087;
        Thu, 06 Jun 2019 07:15:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y8sm358099ejq.24.2019.06.06.07.15.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 07:15:30 -0700 (PDT)
Date:   Thu, 06 Jun 2019 07:15:30 -0700 (PDT)
X-Google-Original-Date: Thu, 06 Jun 2019 14:15:15 GMT
Message-Id: <d0dc154a27c80a8113ff47eb60a6b6f98fbeec91.1559830527.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.v4.git.gitgitgadget@gmail.com>
References: <pull.184.v3.git.gitgitgadget@gmail.com>
        <pull.184.v4.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 02/14] commit-graph: prepare for commit-graph chains
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, git@jeffhostetler.com,
        jrnieder@google.com, steadmon@google.com,
        johannes.schindelin@gmx.de, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

To prepare for a chain of commit-graph files, augment the
commit_graph struct to point to a base commit_graph. As we load
commits from the graph, we may actually want to read from a base
file according to the graph position.

The "graph position" of a commit is given by concatenating the
lexicographic commit orders from each of the commit-graph files in
the chain. This means that we must distinguish two values:

 * lexicographic index : the position within the lexicographic
   order in a single commit-graph file.

 * graph position: the posiiton within the concatenated order
   of multiple commit-graph files

Given the lexicographic index of a commit in a graph, we can
compute the graph position by adding the number of commits in
the lower-level graphs. To find the lexicographic index of
a commit, we subtract the number of commits in lower-level graphs.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 74 ++++++++++++++++++++++++++++++++++++++++++++------
 commit-graph.h |  3 ++
 2 files changed, 69 insertions(+), 8 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 7723156964..3afedcd7f5 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -371,6 +371,25 @@ static int bsearch_graph(struct commit_graph *g, struct object_id *oid, uint32_t
 			    g->chunk_oid_lookup, g->hash_len, pos);
 }
 
+static void load_oid_from_graph(struct commit_graph *g, int pos, struct object_id *oid)
+{
+	uint32_t lex_index;
+
+	if (!g)
+		BUG("NULL commit-graph");
+
+	while (pos < g->num_commits_in_base)
+		g = g->base_graph;
+
+	if (pos >= g->num_commits + g->num_commits_in_base)
+		BUG("position %d is beyond the scope of this commit-graph (%d local + %d base commits)",
+		    pos, g->num_commits, g->num_commits_in_base);
+
+	lex_index = pos - g->num_commits_in_base;
+
+	hashcpy(oid->hash, g->chunk_oid_lookup + g->hash_len * lex_index);
+}
+
 static struct commit_list **insert_parent_or_die(struct repository *r,
 						 struct commit_graph *g,
 						 uint64_t pos,
@@ -379,10 +398,10 @@ static struct commit_list **insert_parent_or_die(struct repository *r,
 	struct commit *c;
 	struct object_id oid;
 
-	if (pos >= g->num_commits)
+	if (pos >= g->num_commits + g->num_commits_in_base)
 		die("invalid parent position %"PRIu64, pos);
 
-	hashcpy(oid.hash, g->chunk_oid_lookup + g->hash_len * pos);
+	load_oid_from_graph(g, pos, &oid);
 	c = lookup_commit(r, &oid);
 	if (!c)
 		die(_("could not find commit %s"), oid_to_hex(&oid));
@@ -392,7 +411,14 @@ static struct commit_list **insert_parent_or_die(struct repository *r,
 
 static void fill_commit_graph_info(struct commit *item, struct commit_graph *g, uint32_t pos)
 {
-	const unsigned char *commit_data = g->chunk_commit_data + GRAPH_DATA_WIDTH * pos;
+	const unsigned char *commit_data;
+	uint32_t lex_index;
+
+	while (pos < g->num_commits_in_base)
+		g = g->base_graph;
+
+	lex_index = pos - g->num_commits_in_base;
+	commit_data = g->chunk_commit_data + GRAPH_DATA_WIDTH * lex_index;
 	item->graph_pos = pos;
 	item->generation = get_be32(commit_data + g->hash_len + 8) >> 2;
 }
@@ -405,10 +431,26 @@ static int fill_commit_in_graph(struct repository *r,
 	uint32_t *parent_data_ptr;
 	uint64_t date_low, date_high;
 	struct commit_list **pptr;
-	const unsigned char *commit_data = g->chunk_commit_data + (g->hash_len + 16) * pos;
+	const unsigned char *commit_data;
+	uint32_t lex_index;
 
-	item->object.parsed = 1;
+	while (pos < g->num_commits_in_base)
+		g = g->base_graph;
+
+	if (pos >= g->num_commits + g->num_commits_in_base)
+		BUG("position %d is beyond the scope of this commit-graph (%d local + %d base commits)",
+		    pos, g->num_commits, g->num_commits_in_base);
+
+	/*
+	 * Store the "full" position, but then use the
+	 * "local" position for the rest of the calculation.
+	 */
 	item->graph_pos = pos;
+	lex_index = pos - g->num_commits_in_base;
+
+	commit_data = g->chunk_commit_data + (g->hash_len + 16) * lex_index;
+
+	item->object.parsed = 1;
 
 	item->maybe_tree = NULL;
 
@@ -452,7 +494,18 @@ static int find_commit_in_graph(struct commit *item, struct commit_graph *g, uin
 		*pos = item->graph_pos;
 		return 1;
 	} else {
-		return bsearch_graph(g, &(item->object.oid), pos);
+		struct commit_graph *cur_g = g;
+		uint32_t lex_index;
+
+		while (cur_g && !bsearch_graph(cur_g, &(item->object.oid), &lex_index))
+			cur_g = cur_g->base_graph;
+
+		if (cur_g) {
+			*pos = lex_index + cur_g->num_commits_in_base;
+			return 1;
+		}
+
+		return 0;
 	}
 }
 
@@ -492,8 +545,13 @@ static struct tree *load_tree_for_commit(struct repository *r,
 					 struct commit *c)
 {
 	struct object_id oid;
-	const unsigned char *commit_data = g->chunk_commit_data +
-					   GRAPH_DATA_WIDTH * (c->graph_pos);
+	const unsigned char *commit_data;
+
+	while (c->graph_pos < g->num_commits_in_base)
+		g = g->base_graph;
+
+	commit_data = g->chunk_commit_data +
+			GRAPH_DATA_WIDTH * (c->graph_pos - g->num_commits_in_base);
 
 	hashcpy(oid.hash, commit_data);
 	c->maybe_tree = lookup_tree(r, &oid);
diff --git a/commit-graph.h b/commit-graph.h
index 70f4caf0c7..f9fe32ebe3 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -48,6 +48,9 @@ struct commit_graph {
 	uint32_t num_commits;
 	struct object_id oid;
 
+	uint32_t num_commits_in_base;
+	struct commit_graph *base_graph;
+
 	const uint32_t *chunk_oid_fanout;
 	const unsigned char *chunk_oid_lookup;
 	const unsigned char *chunk_commit_data;
-- 
gitgitgadget

