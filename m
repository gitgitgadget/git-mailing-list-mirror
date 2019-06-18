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
	by dcvr.yhbt.net (Postfix) with ESMTP id B42861F462
	for <e@80x24.org>; Tue, 18 Jun 2019 18:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730069AbfFRSO2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 14:14:28 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45177 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729642AbfFRSO0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 14:14:26 -0400
Received: by mail-ed1-f65.google.com with SMTP id a14so22997997edv.12
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 11:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SaFXBRvwt5xGUpk98XzTYwt/45A9HM0Np8Vyy5/Yze0=;
        b=QpKPiOvFycsho+7+ET/okmcpDLDxb06eR0CBUiL7sdhn4NzuzNSs7w3t7k/31pPKl/
         KMFERojfAhDZlD+cXCM2yVTnOt/tM0tTggQUmlSllQKBe34K0M30D55cnT3l02+kXyWK
         JktK9pvKYeOA+SIw/ZZe5m6rcLdPVh56ZYcBvjr56p39M5lRZdQQHfIWpLkpkWqFDDgS
         MdyiyXb45Rad1fR7WHD3kRHu0jm2FSOmn06bW4YdkjOn72J7QxWm0cqW1zLtuaw9vAy2
         Q88qHkZeKkSBkknynqUv2C5h19ER1+P/DGJ4I9lNm4CaGQOBqoaS95A9za/4+r+8MhJ3
         4lJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SaFXBRvwt5xGUpk98XzTYwt/45A9HM0Np8Vyy5/Yze0=;
        b=bRV7EzOuNuduAjlnIWCp6hEkJvxDsl69u7KXybDc6o0VWxh1Uddm7Bm0xmg0c7zygk
         RQvCvGPFtGa8BBYD0ick2D7t8NUicds3RRI4DE5U2WbaVxROrZ/FR+LZUkwtobItmvGn
         RU1nCEtC4z7SiDrejur3UQ4slgFB+QzsWL7+cMIoxjomtN9rBv3q4ltlAdENPugClWWm
         OfhSkLvrqhOROYX4CznlmCISODMoZS5mBH87pAn9EdusllZqLcFuB39TfvpXsDVTSZWf
         d+hyseogk2r+x6vxQ98/9ZEYtF8evSWdii235r+x87Jtnv4TUZJhGNw0TQnLRaT13bX9
         w2Lg==
X-Gm-Message-State: APjAAAVQvOA5MI12q957Jjqq6nC6Mhk3s13qO7oEf+IWQ+R4MzPJmheo
        XMe8mlGfchUoNs/G7zNBd80nt+eI
X-Google-Smtp-Source: APXvYqwlX1ffGPLyx1s3hLF3Pmxg6HZ98IeVDOQee9dMKxRLTq2s0GLqG/Bmck6+fUjTFxs2rcgTng==
X-Received: by 2002:a50:b34a:: with SMTP id r10mr35385697edd.84.1560881664557;
        Tue, 18 Jun 2019 11:14:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x10sm4904578edd.73.2019.06.18.11.14.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 11:14:24 -0700 (PDT)
Date:   Tue, 18 Jun 2019 11:14:24 -0700 (PDT)
X-Google-Original-Date: Tue, 18 Jun 2019 18:14:04 GMT
Message-Id: <a06428d749198c180fe0cade50251e0c6b048658.1560881661.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.v6.git.gitgitgadget@gmail.com>
References: <pull.184.v5.git.gitgitgadget@gmail.com>
        <pull.184.v6.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v6 02/18] commit-graph: prepare for commit-graph chains
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

To prepare for a chain of commit-graph files, augment the
commit_graph struct to point to a base commit_graph. As we load
commits from the graph, we may actually want to read from a base
file according to the graph position.

The "graph position" of a commit is given by concatenating the
lexicographic commit orders from each of the commit-graph files in
the chain. This means that we must distinguish two values:

 * lexicographic index : the position within the lexicographic
   order in a single commit-graph file.

 * graph position: the position within the concatenated order
   of multiple commit-graph files

Given the lexicographic index of a commit in a graph, we can
compute the graph position by adding the number of commits in
the lower-level graphs. To find the lexicographic index of
a commit, we subtract the number of commits in lower-level graphs.

While here, change insert_parent_or_die() to take a uint32_t
position, as that is the type used by its only caller and that
makes more sense with the limits in the commit-graph format.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 89 +++++++++++++++++++++++++++++++++++++++++++-------
 commit-graph.h |  3 ++
 2 files changed, 81 insertions(+), 11 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 76d189de45..8f5c09363c 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -359,9 +359,18 @@ int generation_numbers_enabled(struct repository *r)
 	return !!first_generation;
 }
 
+static void close_commit_graph_one(struct commit_graph *g)
+{
+	if (!g)
+		return;
+
+	close_commit_graph_one(g->base_graph);
+	free_commit_graph(g);
+}
+
 void close_commit_graph(struct raw_object_store *o)
 {
-	free_commit_graph(o->commit_graph);
+	close_commit_graph_one(o->commit_graph);
 	o->commit_graph = NULL;
 }
 
@@ -371,18 +380,38 @@ static int bsearch_graph(struct commit_graph *g, struct object_id *oid, uint32_t
 			    g->chunk_oid_lookup, g->hash_len, pos);
 }
 
+static void load_oid_from_graph(struct commit_graph *g,
+				uint32_t pos,
+				struct object_id *oid)
+{
+	uint32_t lex_index;
+
+	while (g && pos < g->num_commits_in_base)
+		g = g->base_graph;
+
+	if (!g)
+		BUG("NULL commit-graph");
+
+	if (pos >= g->num_commits + g->num_commits_in_base)
+		die(_("invalid commit position. commit-graph is likely corrupt"));
+
+	lex_index = pos - g->num_commits_in_base;
+
+	hashcpy(oid->hash, g->chunk_oid_lookup + g->hash_len * lex_index);
+}
+
 static struct commit_list **insert_parent_or_die(struct repository *r,
 						 struct commit_graph *g,
-						 uint64_t pos,
+						 uint32_t pos,
 						 struct commit_list **pptr)
 {
 	struct commit *c;
 	struct object_id oid;
 
-	if (pos >= g->num_commits)
-		die("invalid parent position %"PRIu64, pos);
+	if (pos >= g->num_commits + g->num_commits_in_base)
+		die("invalid parent position %"PRIu32, pos);
 
-	hashcpy(oid.hash, g->chunk_oid_lookup + g->hash_len * pos);
+	load_oid_from_graph(g, pos, &oid);
 	c = lookup_commit(r, &oid);
 	if (!c)
 		die(_("could not find commit %s"), oid_to_hex(&oid));
@@ -392,7 +421,14 @@ static struct commit_list **insert_parent_or_die(struct repository *r,
 
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
@@ -405,10 +441,25 @@ static int fill_commit_in_graph(struct repository *r,
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
+		die(_("invalid commit position. commit-graph is likely corrupt"));
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
 
@@ -452,7 +503,18 @@ static int find_commit_in_graph(struct commit *item, struct commit_graph *g, uin
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
 
@@ -492,8 +554,13 @@ static struct tree *load_tree_for_commit(struct repository *r,
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
index 390c7f6961..5819910a5b 100644
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

