Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B720C1F45F
	for <e@80x24.org>; Wed,  8 May 2019 15:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbfEHPyE (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 11:54:04 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42954 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727633AbfEHPyB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 11:54:01 -0400
Received: by mail-ed1-f67.google.com with SMTP id l25so22545226eda.9
        for <git@vger.kernel.org>; Wed, 08 May 2019 08:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ibXD4VXTMXGnlMM9YEUkI0HK/qlR9EFckprf4R02f8E=;
        b=Rf1xIHUzhbRJRQOlFKxhIhWvOprq1inDZEYrpyeSBvxKzh3NBHGyx6u0lhZDf1DZcO
         0xnpPP1nyGkaJd3hkbyRUEzDGLgt2FLnhVnyx+H7l6XBPsrNgXU2KTsQMFXgzPvRJ1II
         Wy0v2FlUfqV13yo6jjHV8tV3wtG1EZMlgDeT7N1CRdNYEpGH8Lc3e3Y45Y5k36E5b2LV
         K/t7HQ8qjPQFllr/TEkOIBkwQ4gkIdkHVwMCsgdLYEgQHKI4KMNEBxuN2ig5hr1PcHKp
         yxDzdt8XZCY8Ok7CBn1rbKLBE7TowfavwBqzFrpGvBm+cXSBC9TxpwX6BCR2TsAdIn7d
         NaAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ibXD4VXTMXGnlMM9YEUkI0HK/qlR9EFckprf4R02f8E=;
        b=m4XRQeJ4C6YbkddsOfW51NQh8gPwSIWrwOrHCL900il+M44KvjC+8Rd+aV84lsbmJb
         8rNDUSmAI9aobI4EvBR7sjXe+ulkAbiAGZtilQ9VpPulFPekGdlKJYkIz69afybEY43f
         oUxogGRH6J9FknsHD5QmTkQedZtXWgbZl1t1iRUw8ZBxEE002KZ76maIPSP8jP4XdXe3
         zbnYq5wkOdckyypZxvW3rPbLs/5cVndPq/5wfKH84HEdEmNBdARYrSmH6dI7ngSVlXi1
         IsO+qmJTzb96b/YzkxI0gCLAM0z7i6FyqctEwlnYCQ26INnPjPTonMtTxlacOPHHLE1z
         Lhfg==
X-Gm-Message-State: APjAAAXTq6WR5ODVsCwHHUxmYVkDktxUa7hGqbIPVicOwwucHQ4uRGdL
        MHBQTc3gAIDObF65TKUyFD10hiaKJ28=
X-Google-Smtp-Source: APXvYqxRyRt2NUAZpuU4gAHg99g1yto+fuuLyQovDKh3+XFAG3/iEoM346YKQTRwZnDFNYtShGdl3w==
X-Received: by 2002:a17:906:7201:: with SMTP id m1mr4716706ejk.96.1557330838885;
        Wed, 08 May 2019 08:53:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x37sm725766edb.75.2019.05.08.08.53.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 08:53:58 -0700 (PDT)
Date:   Wed, 08 May 2019 08:53:58 -0700 (PDT)
X-Google-Original-Date: Wed, 08 May 2019 15:53:42 GMT
Message-Id: <9d0e966a3d47a0dff2cb5ec24f8225f5f63c6e8f.1557330827.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.git.gitgitgadget@gmail.com>
References: <pull.184.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 13/17] commit-graph: lay groundwork for incremental files
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
 commit-graph.c | 66 ++++++++++++++++++++++++++++++++++++++++++++------
 commit-graph.h |  4 +++
 2 files changed, 62 insertions(+), 8 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 7723156964..f790f44a9c 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -371,6 +371,25 @@ static int bsearch_graph(struct commit_graph *g, struct object_id *oid, uint32_t
 			    g->chunk_oid_lookup, g->hash_len, pos);
 }
 
+static void load_oid_from_graph(struct commit_graph *g, int pos, struct object_id *oid)
+{
+	if (!g)
+		BUG("NULL commit-graph");
+
+	if (pos < g->num_commits_in_base) {
+		load_oid_from_graph(g->base_graph, pos, oid);
+		return;
+	}
+
+	if (pos >= g->num_commits + g->num_commits_in_base)
+		BUG("position %d is beyond the scope of this commit-graph (%d local + %d base commits)",
+		    pos, g->num_commits, g->num_commits_in_base);
+
+	pos -= g->num_commits_in_base;
+
+	hashcpy(oid->hash, g->chunk_oid_lookup + g->hash_len * pos);
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
@@ -393,7 +412,7 @@ static struct commit_list **insert_parent_or_die(struct repository *r,
 static void fill_commit_graph_info(struct commit *item, struct commit_graph *g, uint32_t pos)
 {
 	const unsigned char *commit_data = g->chunk_commit_data + GRAPH_DATA_WIDTH * pos;
-	item->graph_pos = pos;
+	item->graph_pos = pos + g->num_commits_in_base;
 	item->generation = get_be32(commit_data + g->hash_len + 8) >> 2;
 }
 
@@ -405,10 +424,25 @@ static int fill_commit_in_graph(struct repository *r,
 	uint32_t *parent_data_ptr;
 	uint64_t date_low, date_high;
 	struct commit_list **pptr;
-	const unsigned char *commit_data = g->chunk_commit_data + (g->hash_len + 16) * pos;
+	const unsigned char *commit_data;
 
-	item->object.parsed = 1;
+	if (pos < g->num_commits_in_base)
+		return fill_commit_in_graph(r, item, g->base_graph, pos);
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
+	pos -= g->num_commits_in_base;
+
+	commit_data = g->chunk_commit_data + (g->hash_len + 16) * pos;
+
+	item->object.parsed = 1;
 
 	item->maybe_tree = NULL;
 
@@ -452,7 +486,18 @@ static int find_commit_in_graph(struct commit *item, struct commit_graph *g, uin
 		*pos = item->graph_pos;
 		return 1;
 	} else {
-		return bsearch_graph(g, &(item->object.oid), pos);
+		struct commit_graph *cur_g = g;
+		uint32_t pos_in_g;
+
+		while (cur_g && !bsearch_graph(cur_g, &(item->object.oid), &pos_in_g))
+			cur_g = cur_g->base_graph;
+
+		if (cur_g) {
+			*pos = pos_in_g + cur_g->num_commits_in_base;
+			return 1;
+		}
+
+		return 0;
 	}
 }
 
@@ -492,8 +537,13 @@ static struct tree *load_tree_for_commit(struct repository *r,
 					 struct commit *c)
 {
 	struct object_id oid;
-	const unsigned char *commit_data = g->chunk_commit_data +
-					   GRAPH_DATA_WIDTH * (c->graph_pos);
+	const unsigned char *commit_data;
+
+	if (c->graph_pos < g->num_commits_in_base)
+		return load_tree_for_commit(r, g->base_graph, c);
+
+	commit_data = g->chunk_commit_data +
+			GRAPH_DATA_WIDTH * (c->graph_pos - g->num_commits_in_base);
 
 	hashcpy(oid.hash, commit_data);
 	c->maybe_tree = lookup_tree(r, &oid);
diff --git a/commit-graph.h b/commit-graph.h
index 70f4caf0c7..170920720d 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -48,10 +48,14 @@ struct commit_graph {
 	uint32_t num_commits;
 	struct object_id oid;
 
+	uint32_t num_commits_in_base;
+	struct commit_graph *base_graph;
+
 	const uint32_t *chunk_oid_fanout;
 	const unsigned char *chunk_oid_lookup;
 	const unsigned char *chunk_commit_data;
 	const unsigned char *chunk_extra_edges;
+	const unsigned char *chunk_base_graph;
 };
 
 struct commit_graph *load_commit_graph_one_fd_st(int fd, struct stat *st);
-- 
gitgitgadget

