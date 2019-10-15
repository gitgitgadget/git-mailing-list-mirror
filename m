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
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A4301F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 23:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390302AbfJOXsR (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 19:48:17 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44824 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387977AbfJOXsO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 19:48:14 -0400
Received: by mail-wr1-f65.google.com with SMTP id z9so25794480wrl.11
        for <git@vger.kernel.org>; Tue, 15 Oct 2019 16:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ShHTqVuTALV1NDFIwgm+9t50EqMUUUa3s7YTYbvQkng=;
        b=AG9hLMGFOMti9ap4C/LJVGsQGUVWbdul7ko6cGknpY21pHys3u2UL/3OYFXb6FpgoR
         qkUaCDDl3kLJc2TwQXP0yQkxWYCUh4esgG2nRCTDByHXH6mbiC5oNUC0AcsPtUO4czCe
         4QZYN7J59+qPdoU86xChYvwRY/BjQWnKhnnSOPaTuo7pHlPZntEeG4Z+azC2ykfxQzp/
         czl2qftMcKmjO5GIzxsVVWjTowhGAElArDm+prX46uCBr2VRUDtIAb8gQfIr8fihiQ3M
         g14BFL4Gi2ecvony8xEeq3m5Ur/f99cv5cZPoHx88lcUtdMEGm5zcS5DRNmvw9LjEs0I
         hCFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ShHTqVuTALV1NDFIwgm+9t50EqMUUUa3s7YTYbvQkng=;
        b=L9g+yry+K7ytyhgE70WB2tDUtkaEfvI+1mxPvzowVr65nMaDToxYtdXNartIC9rlE/
         U7viDs+qwsMGTInYnocfrgaXhYem8f8DRjT0EBkq4GuHE+hqXTTRC7iBtLmqNAsTH5wK
         qhEZ5ZyidbtnX4y2ORJxMQ0ijyYsdsDZMQApqheLlD3otuhybzQp/QBHnqGzCXkHODK4
         gHV9J7s0MXMnf3BP80Be2b52sOk1otb9g1ULrSWVq60leKB6/SSJ8sgvwIzcp93bv+tv
         3BHvja8M7V4fzXQp41opkNQPx7kRHAsKipvhTFt6FCObjnyj0lABq8b3vUrzZRKe3nOT
         2RAw==
X-Gm-Message-State: APjAAAWvcrWtGABaCbY2Ivhsy5MQDe5cdrIBWlTgO8Moxn7Ufic1cL1F
        kZpfQ2qoqJKlStvvHiYHKLM6PKEJ
X-Google-Smtp-Source: APXvYqxQyjnwDylLeZRQ39ti5HBUm1Ll0SYvUa7FnJEpm0BTpASfRzpHwMOzzI7rAaLZJxHDP2DRBg==
X-Received: by 2002:adf:ab5b:: with SMTP id r27mr5619wrc.13.1571183290104;
        Tue, 15 Oct 2019 16:48:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f8sm545517wmb.37.2019.10.15.16.48.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 16:48:09 -0700 (PDT)
Message-Id: <f5c27914360e4f9139d676b777484fa55e87d78d.1571183279.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.383.v3.git.1571183279.gitgitgadget@gmail.com>
References: <pull.383.v2.git.1571182864.gitgitgadget@gmail.com>
        <pull.383.v3.git.1571183279.gitgitgadget@gmail.com>
From:   "James Coglan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Oct 2019 23:47:56 +0000
Subject: [PATCH v3 10/13] graph: rename `new_mapping` to `old_mapping`
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

The change I'm about to make requires being able to inspect the mapping
array that was used to render the last GRAPH_COLLAPSING line while
rendering a GRAPH_COMMIT line. The `new_mapping` array currently exists
as a pre-allocated space for computing the next `mapping` array during
`graph_output_collapsing_line()`, but we can repurpose it to let us see
the previous `mapping` state.

To support this use it will make more sense if this array is named
`old_mapping`, as it will contain the mapping data for the previous line
we rendered, at the point we're rendering a commit line.

Signed-off-by: James Coglan <jcoglan@gmail.com>
---
 graph.c | 54 +++++++++++++++++++++++++++---------------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/graph.c b/graph.c
index 21edad8085..2315f3604d 100644
--- a/graph.c
+++ b/graph.c
@@ -259,7 +259,7 @@ struct git_graph {
 	/*
 	 * The maximum number of columns that can be stored in the columns
 	 * and new_columns arrays.  This is also half the number of entries
-	 * that can be stored in the mapping and new_mapping arrays.
+	 * that can be stored in the mapping and old_mapping arrays.
 	 */
 	int column_capacity;
 	/*
@@ -302,7 +302,7 @@ struct git_graph {
 	 * of the git_graph simply so we don't have to allocate a new
 	 * temporary array each time we have to output a collapsing line.
 	 */
-	int *new_mapping;
+	int *old_mapping;
 	/*
 	 * The current default column color being used.  This is
 	 * stored as an index into the array column_colors.
@@ -388,7 +388,7 @@ struct git_graph *graph_init(struct rev_info *opt)
 	ALLOC_ARRAY(graph->columns, graph->column_capacity);
 	ALLOC_ARRAY(graph->new_columns, graph->column_capacity);
 	ALLOC_ARRAY(graph->mapping, 2 * graph->column_capacity);
-	ALLOC_ARRAY(graph->new_mapping, 2 * graph->column_capacity);
+	ALLOC_ARRAY(graph->old_mapping, 2 * graph->column_capacity);
 
 	/*
 	 * The diff output prefix callback, with this we can make
@@ -418,7 +418,7 @@ static void graph_ensure_capacity(struct git_graph *graph, int num_columns)
 	REALLOC_ARRAY(graph->columns, graph->column_capacity);
 	REALLOC_ARRAY(graph->new_columns, graph->column_capacity);
 	REALLOC_ARRAY(graph->mapping, graph->column_capacity * 2);
-	REALLOC_ARRAY(graph->new_mapping, graph->column_capacity * 2);
+	REALLOC_ARRAY(graph->old_mapping, graph->column_capacity * 2);
 }
 
 /*
@@ -1116,13 +1116,18 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct graph_l
 	int horizontal_edge_target = -1;
 
 	/*
-	 * Clear out the new_mapping array
+	 * Swap the mapping and old_mapping arrays
+	 */
+	SWAP(graph->mapping, graph->old_mapping);
+
+	/*
+	 * Clear out the mapping array
 	 */
 	for (i = 0; i < graph->mapping_size; i++)
-		graph->new_mapping[i] = -1;
+		graph->mapping[i] = -1;
 
 	for (i = 0; i < graph->mapping_size; i++) {
-		int target = graph->mapping[i];
+		int target = graph->old_mapping[i];
 		if (target < 0)
 			continue;
 
@@ -1143,14 +1148,14 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct graph_l
 			 * This column is already in the
 			 * correct place
 			 */
-			assert(graph->new_mapping[i] == -1);
-			graph->new_mapping[i] = target;
-		} else if (graph->new_mapping[i - 1] < 0) {
+			assert(graph->mapping[i] == -1);
+			graph->mapping[i] = target;
+		} else if (graph->mapping[i - 1] < 0) {
 			/*
 			 * Nothing is to the left.
 			 * Move to the left by one
 			 */
-			graph->new_mapping[i - 1] = target;
+			graph->mapping[i - 1] = target;
 			/*
 			 * If there isn't already an edge moving horizontally
 			 * select this one.
@@ -1166,9 +1171,9 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct graph_l
 				 * line.
 				 */
 				for (j = (target * 2)+3; j < (i - 2); j += 2)
-					graph->new_mapping[j] = target;
+					graph->mapping[j] = target;
 			}
-		} else if (graph->new_mapping[i - 1] == target) {
+		} else if (graph->mapping[i - 1] == target) {
 			/*
 			 * There is a branch line to our left
 			 * already, and it is our target.  We
@@ -1176,7 +1181,7 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct graph_l
 			 * the same parent commit.
 			 *
 			 * We don't have to add anything to the
-			 * output or new_mapping, since the
+			 * output or mapping, since the
 			 * existing branch line has already taken
 			 * care of it.
 			 */
@@ -1192,10 +1197,10 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct graph_l
 			 * The branch to the left of that space
 			 * should be our eventual target.
 			 */
-			assert(graph->new_mapping[i - 1] > target);
-			assert(graph->new_mapping[i - 2] < 0);
-			assert(graph->new_mapping[i - 3] == target);
-			graph->new_mapping[i - 2] = target;
+			assert(graph->mapping[i - 1] > target);
+			assert(graph->mapping[i - 2] < 0);
+			assert(graph->mapping[i - 3] == target);
+			graph->mapping[i - 2] = target;
 			/*
 			 * Mark this branch as the horizontal edge to
 			 * prevent any other edges from moving
@@ -1209,14 +1214,14 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct graph_l
 	/*
 	 * The new mapping may be 1 smaller than the old mapping
 	 */
-	if (graph->new_mapping[graph->mapping_size - 1] < 0)
+	if (graph->mapping[graph->mapping_size - 1] < 0)
 		graph->mapping_size--;
 
 	/*
 	 * Output out a line based on the new mapping info
 	 */
 	for (i = 0; i < graph->mapping_size; i++) {
-		int target = graph->new_mapping[i];
+		int target = graph->mapping[i];
 		if (target < 0)
 			graph_line_addch(line, ' ');
 		else if (target * 2 == i)
@@ -1229,22 +1234,17 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct graph_l
 				 * won't continue into the next line.
 				 */
 				if (i != (target * 2)+3)
-					graph->new_mapping[i] = -1;
+					graph->mapping[i] = -1;
 				used_horizontal = 1;
 			graph_line_write_column(line, &graph->new_columns[target], '_');
 		} else {
 			if (used_horizontal && i < horizontal_edge)
-				graph->new_mapping[i] = -1;
+				graph->mapping[i] = -1;
 			graph_line_write_column(line, &graph->new_columns[target], '/');
 
 		}
 	}
 
-	/*
-	 * Swap mapping and new_mapping
-	 */
-	SWAP(graph->mapping, graph->new_mapping);
-
 	/*
 	 * If graph->mapping indicates that all of the branch lines
 	 * are already in the correct positions, we are done.
-- 
gitgitgadget

