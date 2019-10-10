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
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DDCC1F4BD
	for <e@80x24.org>; Thu, 10 Oct 2019 16:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbfJJQN4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 12:13:56 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33105 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfJJQNx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Oct 2019 12:13:53 -0400
Received: by mail-wr1-f65.google.com with SMTP id b9so8655790wrs.0
        for <git@vger.kernel.org>; Thu, 10 Oct 2019 09:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PzlKoMI1Emv7Fk2J7CVEN01D82qCeV2EyySb3bZ+Dx8=;
        b=s+7tAzNg/HxDeaIuyHxaB2Tdu712R+Xzq72WGQR97p1yfmdDJZ+ZUgNJ+DjXubS0oN
         juGNGWBNCnPuHTxeLYlHlA21A0CiYvSH+jFJuGeyAV2giyvvUokVgN29jjK09blnEddC
         iDeROGB4KbgBTYfIPWLiaEyzUA+pILqUiCauIFiT/tUuHcomr2Lg2DK0GjEjwW8TblMY
         ctpqNdRIDVFf9RoMQiUJYlAzetHBP6lX9fD0glAQ6DQBA4xQly2zXjvQV62VRNaB8sX7
         H3Jtqm/oRIOyRRttk6pnHGADyLygVuXxyaZZVPbhK0JoA9FTw9gW3vaBNgWmGDPNXVxG
         sjMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PzlKoMI1Emv7Fk2J7CVEN01D82qCeV2EyySb3bZ+Dx8=;
        b=r8FnzYyvzR1PzuLU0LEwYvAsjpkbG+dqpvNtOWJ2crK5wW4Jm/JyhB5F3THedK1SL2
         M6kAkjTwju2WvQMlQiYsPjD2cjBDhEwfUOB2AMcplc/Zabwgs5NqpURODCTI886BSEV4
         9X36Pe6bd6C6E2Jq2jvMfHBXmockk8AyQ7RVQwcSX8GLuj5cUDDC3ztOvFCsRr1SWSAI
         exSaD01vW4J2LLxZlnfmDU518C86D3WrZ/0aaz63EzF4PhfkQ8JdHMQNp2kwtdcithdm
         +b/1vcUHnA5ERJY4lKstpCO112OPNCF+YJJW/oY6B1pqDfHoWBCuo8PwCq5qKNCgEA5d
         nvjw==
X-Gm-Message-State: APjAAAV1KCTTk2voZfOPWhwXJlaU6gvzioCryDksyeJaMnU0LcM+hkwd
        1sge7XJliYdOkijVlyU5lucgEw4X
X-Google-Smtp-Source: APXvYqyV9lBZC5hBS8SeMNQ/qSsLHNYonIDxiWWoUwiil9wzHRF2TjoiiKkgLtIoM5qCjTx3PDfoWQ==
X-Received: by 2002:a5d:5646:: with SMTP id j6mr877546wrw.396.1570724030434;
        Thu, 10 Oct 2019 09:13:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w18sm7076198wmc.9.2019.10.10.09.13.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 09:13:49 -0700 (PDT)
Date:   Thu, 10 Oct 2019 09:13:49 -0700 (PDT)
X-Google-Original-Date: Thu, 10 Oct 2019 16:13:37 GMT
Message-Id: <23f13bbefaaccde4b914813a0ab7965ab1f83c04.1570724021.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.383.git.gitgitgadget@gmail.com>
References: <pull.383.git.gitgitgadget@gmail.com>
From:   "James Coglan via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 08/11] graph: rename `new_mapping` to `old_mapping`
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
index fb2e42850f..b0e31e23ca 100644
--- a/graph.c
+++ b/graph.c
@@ -240,7 +240,7 @@ struct git_graph {
 	/*
 	 * The maximum number of columns that can be stored in the columns
 	 * and new_columns arrays.  This is also half the number of entries
-	 * that can be stored in the mapping and new_mapping arrays.
+	 * that can be stored in the mapping and old_mapping arrays.
 	 */
 	int column_capacity;
 	/*
@@ -283,7 +283,7 @@ struct git_graph {
 	 * of the git_graph simply so we don't have to allocate a new
 	 * temporary array each time we have to output a collapsing line.
 	 */
-	int *new_mapping;
+	int *old_mapping;
 	/*
 	 * The current default column color being used.  This is
 	 * stored as an index into the array column_colors.
@@ -369,7 +369,7 @@ struct git_graph *graph_init(struct rev_info *opt)
 	ALLOC_ARRAY(graph->columns, graph->column_capacity);
 	ALLOC_ARRAY(graph->new_columns, graph->column_capacity);
 	ALLOC_ARRAY(graph->mapping, 2 * graph->column_capacity);
-	ALLOC_ARRAY(graph->new_mapping, 2 * graph->column_capacity);
+	ALLOC_ARRAY(graph->old_mapping, 2 * graph->column_capacity);
 
 	/*
 	 * The diff output prefix callback, with this we can make
@@ -399,7 +399,7 @@ static void graph_ensure_capacity(struct git_graph *graph, int num_columns)
 	REALLOC_ARRAY(graph->columns, graph->column_capacity);
 	REALLOC_ARRAY(graph->new_columns, graph->column_capacity);
 	REALLOC_ARRAY(graph->mapping, graph->column_capacity * 2);
-	REALLOC_ARRAY(graph->new_mapping, graph->column_capacity * 2);
+	REALLOC_ARRAY(graph->old_mapping, graph->column_capacity * 2);
 }
 
 /*
@@ -1116,13 +1116,18 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct strbuf
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
 
@@ -1143,14 +1148,14 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct strbuf
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
@@ -1166,9 +1171,9 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct strbuf
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
@@ -1176,7 +1181,7 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct strbuf
 			 * the same parent commit.
 			 *
 			 * We don't have to add anything to the
-			 * output or new_mapping, since the
+			 * output or mapping, since the
 			 * existing branch line has already taken
 			 * care of it.
 			 */
@@ -1192,10 +1197,10 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct strbuf
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
@@ -1209,14 +1214,14 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct strbuf
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
 			strbuf_addch(sb, ' ');
 		else if (target * 2 == i)
@@ -1229,12 +1234,12 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct strbuf
 				 * won't continue into the next line.
 				 */
 				if (i != (target * 2)+3)
-					graph->new_mapping[i] = -1;
+					graph->mapping[i] = -1;
 				used_horizontal = 1;
 			strbuf_write_column(sb, &graph->new_columns[target], '_');
 		} else {
 			if (used_horizontal && i < horizontal_edge)
-				graph->new_mapping[i] = -1;
+				graph->mapping[i] = -1;
 			strbuf_write_column(sb, &graph->new_columns[target], '/');
 
 		}
@@ -1242,11 +1247,6 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct strbuf
 
 	graph_pad_horizontally(graph, sb);
 
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

