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
	by dcvr.yhbt.net (Postfix) with ESMTP id F19891F4BD
	for <e@80x24.org>; Thu, 10 Oct 2019 16:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbfJJQNu (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 12:13:50 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34881 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfJJQNs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Oct 2019 12:13:48 -0400
Received: by mail-wm1-f65.google.com with SMTP id y21so7408495wmi.0
        for <git@vger.kernel.org>; Thu, 10 Oct 2019 09:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=W5QI22lTJFVbHqadkfJ+l8EwSQE3VlsI5z/yLetcA/E=;
        b=ouYXrz/Uf44T5PPGct3KZ/qLaqb9lmdrsNL3f7A3hzBpY54ZrN6hqvLyP31zVGXP0N
         9Watf6xRashS1AXlDsKOdaIEhpJBdywAe0sBsyyy0Cil3G6hQ5QlI4M1wq5ioiX8N2CB
         qwfZ2fiGXQMg2hM6NfQ8BWrjVkqKSgxxda2bzrGEi2i98D1rxoNdKWkQuCrDtMO+rAs5
         9HI851O3440Wtcaat0cF5qWuMZ7h35v8aLyaa/IozHwCIy6QxfxFANO5gd84ByqjnNtt
         ZynDHajt9Lojg13jeKSkb9wTPp9QANi37mLY+vkToD4K9SAqYm8oOQhAp3GlBSDxxjTN
         wagw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=W5QI22lTJFVbHqadkfJ+l8EwSQE3VlsI5z/yLetcA/E=;
        b=E/zyoO21zIq9mCCqhkeIS9cn6ESIXeEO0TWylDqg8buB2k3Pf7R6PfvvpCJN3ceQ2f
         cO2fFxU/+aZprjmuCntxE1G7HIQbOouD4KncOzYr2UxobsObuatntsztIzqZeve/DUkT
         5sE6DjOUZk4FWJhJhb3Lh3Q0S0ChRFd1xefg97Tj6lMqW+X5xwOgloBHZ1SHkmDDlVNR
         P7oaWo3fP2o7EQ0Qaa02x0LqbP1iYGsJ/cR4JuSmBg82D5MQKncSaQQ+ovPqErv+HQn+
         bzpRVmlQrYHQRCTT8Ree02El5yU+KIYITZdYEMNDJO+iqWRVPdUNTW8ydtMpkkF6bMXN
         bhMg==
X-Gm-Message-State: APjAAAWexxmOYHHPSWoHmYUsI61YURfN/vRmqrrQw2U4trk9NhlvLghm
        acauO++wmRop/RzftPf4cEeYwBWQ
X-Google-Smtp-Source: APXvYqwCWuHtTLBvBdcoEjO2SSpaQMcKgtQV2Q2HEXE69IZrDh/eoB1pP4/9Wv/wj4eAdlDkaqqMug==
X-Received: by 2002:a1c:6a05:: with SMTP id f5mr5061593wmc.121.1570724026611;
        Thu, 10 Oct 2019 09:13:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n1sm8759994wrg.67.2019.10.10.09.13.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 09:13:46 -0700 (PDT)
Date:   Thu, 10 Oct 2019 09:13:46 -0700 (PDT)
X-Google-Original-Date: Thu, 10 Oct 2019 16:13:33 GMT
Message-Id: <674b992371b791daa67a98aa157e5166b4e68037.1570724021.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.383.git.gitgitgadget@gmail.com>
References: <pull.383.git.gitgitgadget@gmail.com>
From:   "James Coglan via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 04/11] graph: remove `mapping_idx` and `graph_update_width()`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        James Coglan <jcoglan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: James Coglan <jcoglan@gmail.com>

There's a duplication of logic between `graph_insert_into_new_columns()`
and `graph_update_width()`. `graph_insert_into_new_columns()` is called
repeatedly by `graph_update_columns()` with an `int *` that tracks the
offset into the `mapping` array where we should write the next value.
Each call to `graph_insert_into_new_columns()` effectively pushes one
column index and one "null" value (-1) onto the `mapping` array and
therefore increments `mapping_idx` by 2.

`graph_update_width()` duplicates this process: the `width` of the graph
is essentially the initial width of the `mapping` array before edges
begin collapsing. The `graph_update_width()` function's logic
effectively works out how many times `graph_insert_into_new_columns()`
was called based on the relationship of the current commit to the rest
of the graph.

I'm about to make some changes that make the assignment of values into
the `mapping` array more complicated. Rather than make
`graph_update_width()` more complicated at the same time, we can simply
remove this function and use `graph->width` to track the offset into the
`mapping` array as we're building it. This removes the duplication and
makes sure that `graph->width` is the same as the visual width of the
`mapping` array once `graph_update_columns()` is complete.

Signed-off-by: James Coglan <jcoglan@gmail.com>
---
 graph.c | 65 +++++++++------------------------------------------------
 1 file changed, 10 insertions(+), 55 deletions(-)

diff --git a/graph.c b/graph.c
index 1cd30f80e6..a71ae5cd61 100644
--- a/graph.c
+++ b/graph.c
@@ -453,8 +453,7 @@ static int graph_find_new_column_by_commit(struct git_graph *graph,
 }
 
 static void graph_insert_into_new_columns(struct git_graph *graph,
-					  struct commit *commit,
-					  int *mapping_index)
+					  struct commit *commit)
 {
 	int i = graph_find_new_column_by_commit(graph, commit);
 
@@ -468,50 +467,14 @@ static void graph_insert_into_new_columns(struct git_graph *graph,
 		graph->new_columns[i].color = graph_find_commit_color(graph, commit);
 	}
 
-	graph->mapping[*mapping_index] = i;
-	*mapping_index += 2;
-}
-
-static void graph_update_width(struct git_graph *graph,
-			       int is_commit_in_existing_columns)
-{
-	/*
-	 * Compute the width needed to display the graph for this commit.
-	 * This is the maximum width needed for any row.  All other rows
-	 * will be padded to this width.
-	 *
-	 * Compute the number of columns in the widest row:
-	 * Count each existing column (graph->num_columns), and each new
-	 * column added by this commit.
-	 */
-	int max_cols = graph->num_columns + graph->num_parents;
-
-	/*
-	 * Even if the current commit has no parents to be printed, it
-	 * still takes up a column for itself.
-	 */
-	if (graph->num_parents < 1)
-		max_cols++;
-
-	/*
-	 * We added a column for the current commit as part of
-	 * graph->num_parents.  If the current commit was already in
-	 * graph->columns, then we have double counted it.
-	 */
-	if (is_commit_in_existing_columns)
-		max_cols--;
-
-	/*
-	 * Each column takes up 2 spaces
-	 */
-	graph->width = max_cols * 2;
+	graph->mapping[graph->width] = i;
+	graph->width += 2;
 }
 
 static void graph_update_columns(struct git_graph *graph)
 {
 	struct commit_list *parent;
 	int max_new_columns;
-	int mapping_idx;
 	int i, seen_this, is_commit_in_columns;
 
 	/*
@@ -544,6 +507,8 @@ static void graph_update_columns(struct git_graph *graph)
 	for (i = 0; i < graph->mapping_size; i++)
 		graph->mapping[i] = -1;
 
+	graph->width = 0;
+
 	/*
 	 * Populate graph->new_columns and graph->mapping
 	 *
@@ -554,7 +519,6 @@ static void graph_update_columns(struct git_graph *graph)
 	 * supposed to end up after the collapsing is performed.
 	 */
 	seen_this = 0;
-	mapping_idx = 0;
 	is_commit_in_columns = 1;
 	for (i = 0; i <= graph->num_columns; i++) {
 		struct commit *col_commit;
@@ -568,7 +532,6 @@ static void graph_update_columns(struct git_graph *graph)
 		}
 
 		if (col_commit == graph->commit) {
-			int old_mapping_idx = mapping_idx;
 			seen_this = 1;
 			graph->commit_index = i;
 			for (parent = first_interesting_parent(graph);
@@ -583,21 +546,18 @@ static void graph_update_columns(struct git_graph *graph)
 				    !is_commit_in_columns) {
 					graph_increment_column_color(graph);
 				}
-				graph_insert_into_new_columns(graph,
-							      parent->item,
-							      &mapping_idx);
+				graph_insert_into_new_columns(graph, parent->item);
 			}
 			/*
-			 * We always need to increment mapping_idx by at
+			 * We always need to increment graph->width by at
 			 * least 2, even if it has no interesting parents.
 			 * The current commit always takes up at least 2
 			 * spaces.
 			 */
-			if (mapping_idx == old_mapping_idx)
-				mapping_idx += 2;
+			if (graph->num_parents == 0)
+				graph->width += 2;
 		} else {
-			graph_insert_into_new_columns(graph, col_commit,
-						      &mapping_idx);
+			graph_insert_into_new_columns(graph, col_commit);
 		}
 	}
 
@@ -607,11 +567,6 @@ static void graph_update_columns(struct git_graph *graph)
 	while (graph->mapping_size > 1 &&
 	       graph->mapping[graph->mapping_size - 1] < 0)
 		graph->mapping_size--;
-
-	/*
-	 * Compute graph->width for this commit
-	 */
-	graph_update_width(graph, is_commit_in_columns);
 }
 
 void graph_update(struct git_graph *graph, struct commit *commit)
-- 
gitgitgadget

