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
	by dcvr.yhbt.net (Postfix) with ESMTP id F28DF1F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 23:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388028AbfJOXlN (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 19:41:13 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40595 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbfJOXlN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 19:41:13 -0400
Received: by mail-wm1-f67.google.com with SMTP id b24so738210wmj.5
        for <git@vger.kernel.org>; Tue, 15 Oct 2019 16:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Qsf6Y33/qT8IAZoO3acCn17/33iV8MHglLr806+ayC4=;
        b=Awe6sx2IRgE166gvOCiQfF76jsQSib5VExY4/LaTD8NWV3vYKR5byuQ4rZhIm+MwAv
         0YVM9AYlpPf0n+yamrGLkd1g5Yp+g/StMYdf7SLR3prGzLquXqU93C4t8haEfm8TVKif
         6wZaxuk5woHdaP9iz7ZlDUhskP5eOZMmtoSyYJj3ojdKhVti38nNJajPrSbO42DCT4ij
         ZBczOlxpbwbFB6kqCyiU1GNu9x3nRknRS2m27skj/r2CoKfaFY4dpv24iTqsGZpOBBra
         SV2yGH/YOLnZOgeFRHQnaS/ZwdqO+nGQlIkpvrGP1T7RvCrQr4LU/SQHWYVEKzamhPd1
         5O4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Qsf6Y33/qT8IAZoO3acCn17/33iV8MHglLr806+ayC4=;
        b=hR5wjjTOoS1F8WDdvE8PmlyRv0tXEK+zz2h/K5tWCsZgSsta+jX5ekfucCwLHIOAM8
         ZrXZvADqgQKEdWXqUlpXjjUhTC+5kjnOXAxLxcRd1VjwK5wn0FkaT/GVsfEhbhMadbK+
         xU/hffsCqrCBINkuPJRMZL/LcuLRwN9LL7DaDTj2+AnCj/7EY9InwENR3R6LtK6bN5h+
         aJIiBmzMiMp6g1MWbvvqXMqt/VqldN9it/TJ0MzoWp9snF/fTJ+W7IPI6fE0kfxZElwY
         Ud0lQA+g8m8JG370sQquwM90MIrwhMSgye0dk58LUktxEMqhsGRdOLWRP83m/YcOcLmw
         zmoQ==
X-Gm-Message-State: APjAAAV8/MRdSC/OAiKyHKcu8Y4P7WBFYtq5+AkpKtht+pXC/GQ0xM3M
        uSJKRiviMol48ISb5xoEZlXVBkYe
X-Google-Smtp-Source: APXvYqyYWzxP4G4qYjhGNWDjDPb3VILqPCjIpSchvCqjekekwptCUAl57YSwovMQ8LEF4ra+Rrg6bw==
X-Received: by 2002:a7b:c387:: with SMTP id s7mr751409wmj.110.1571182870329;
        Tue, 15 Oct 2019 16:41:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p85sm780821wme.23.2019.10.15.16.41.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 16:41:09 -0700 (PDT)
Message-Id: <d2e8958eed3c51650de4b1dc18d3ec94df2cfe08.1571182864.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.383.v2.git.1571182864.gitgitgadget@gmail.com>
References: <pull.383.git.gitgitgadget@gmail.com>
        <pull.383.v2.git.1571182864.gitgitgadget@gmail.com>
From:   "James Coglan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Oct 2019 23:40:56 +0000
Subject: [PATCH v2 05/13] graph: remove `mapping_idx` and
 `graph_update_width()`
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
index 512ae16535..d724ef25c3 100644
--- a/graph.c
+++ b/graph.c
@@ -472,8 +472,7 @@ static int graph_find_new_column_by_commit(struct git_graph *graph,
 }
 
 static void graph_insert_into_new_columns(struct git_graph *graph,
-					  struct commit *commit,
-					  int *mapping_index)
+					  struct commit *commit)
 {
 	int i = graph_find_new_column_by_commit(graph, commit);
 
@@ -487,50 +486,14 @@ static void graph_insert_into_new_columns(struct git_graph *graph,
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
@@ -563,6 +526,8 @@ static void graph_update_columns(struct git_graph *graph)
 	for (i = 0; i < graph->mapping_size; i++)
 		graph->mapping[i] = -1;
 
+	graph->width = 0;
+
 	/*
 	 * Populate graph->new_columns and graph->mapping
 	 *
@@ -573,7 +538,6 @@ static void graph_update_columns(struct git_graph *graph)
 	 * supposed to end up after the collapsing is performed.
 	 */
 	seen_this = 0;
-	mapping_idx = 0;
 	is_commit_in_columns = 1;
 	for (i = 0; i <= graph->num_columns; i++) {
 		struct commit *col_commit;
@@ -587,7 +551,6 @@ static void graph_update_columns(struct git_graph *graph)
 		}
 
 		if (col_commit == graph->commit) {
-			int old_mapping_idx = mapping_idx;
 			seen_this = 1;
 			graph->commit_index = i;
 			for (parent = first_interesting_parent(graph);
@@ -602,21 +565,18 @@ static void graph_update_columns(struct git_graph *graph)
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
 
@@ -626,11 +586,6 @@ static void graph_update_columns(struct git_graph *graph)
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

