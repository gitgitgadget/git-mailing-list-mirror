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
	by dcvr.yhbt.net (Postfix) with ESMTP id 1252F1F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 23:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388134AbfJOXlW (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 19:41:22 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41970 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388122AbfJOXlV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 19:41:21 -0400
Received: by mail-wr1-f66.google.com with SMTP id p4so9925986wrm.8
        for <git@vger.kernel.org>; Tue, 15 Oct 2019 16:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XXWvqmnP6+XJ40KDy4pBtr6vSbAz8qKtRqaQstdwxyI=;
        b=iSTPZ0zKdQ+uJ9HvBlkeOHFEOektxtO9ziZgKSo5+/2Ns+z+8/Ui4Z/iiVj+KZw8mh
         QBhWsRSZJ2LgqXiagIOqzU4M7kPfgMq+X/TdKUy1g5vmYKluRWi9Om/69hlSmscsRMqL
         tbDyL1gcKuH8t+XHoQVMeef8TE4PlSi/+8rZ9IvX6WYzmRHCPM9rTiK9tuvn9iMRg4yb
         J0q6NED36u1f0LVjS1fNm7gWFzi0iEiZHiZXNfk2j9HG6XshYw6R8DD1aFHJpy8d30zK
         2G21SosK45LFse5/QBTOK1YlWLUrMeFswftrbcbAQAwEixOwB2gUQyXD3EsTL+lDXdI9
         jFKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XXWvqmnP6+XJ40KDy4pBtr6vSbAz8qKtRqaQstdwxyI=;
        b=oUWyGVqiIcqv/d4LTCXhATUv6A3m5PerpbAjyW7KdmGtlC8FUXoAvidmg0f0S8O6Fw
         SSoGz0Lpowa8acfak8PGyIOvt6m7TyXPFl1qjbUtJoMhujlxzK/4Bo93iYWxteDahliw
         I5i+o2LoTBJXqSXGixDRP2DCJsVC8mlmIRGUUoIaW9LEVMI/QKgXmi65XwAI1APIlWtz
         PDyXPHIceI2qrcqmHkTYzP4HCrShf3n8GNirAxbUGzyjUPrGcNu7WJ5itC4FLjzd+Vt0
         LM6vNo6ePjfpPKnUq+s/ATsgyJmJ7skLKGLIssir5+O6po2J6PY5G1Y7uoc9arMR4ZwD
         mtxw==
X-Gm-Message-State: APjAAAXZNqJoSAw7hiUBFua+HYfaje3lQQSR1ocrX2doNJO8WevnQg2g
        Gi6hFEoNfnxLB96iZNmMXgS+g6Et
X-Google-Smtp-Source: APXvYqyLBDIR4KR/SIyk0YXktKMpft41AfM0DIo27qQOjwAyXM6QPiyixzbwJ24uPBzyUJ1ZZaipzA==
X-Received: by 2002:adf:e8c6:: with SMTP id k6mr11202wrn.78.1571182877498;
        Tue, 15 Oct 2019 16:41:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a3sm655306wmj.35.2019.10.15.16.41.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 16:41:16 -0700 (PDT)
Message-Id: <07ddd509c5c9fb9cb4c5c5e1dc00594ffd109f73.1571182864.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.383.v2.git.1571182864.gitgitgadget@gmail.com>
References: <pull.383.git.gitgitgadget@gmail.com>
        <pull.383.v2.git.1571182864.gitgitgadget@gmail.com>
From:   "James Coglan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Oct 2019 23:41:04 +0000
Subject: [PATCH v2 13/13] graph: fix coloring of octopus dashes
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

In 04005834ed ("log: fix coloring of certain octopus merge shapes",
2018-09-01) there is a fix for the coloring of dashes following an
octopus merge. It makes a distinction between the case where all parents
introduce a new column, versus the case where the first parent collapses
into an existing column:

        | *-.           | *-.
        | |\ \          | |\ \
        | | | |         |/ / /

The latter case means that the columns for the merge parents begin one
place to the left in the `new_columns` array compared to the former
case.

However, the implementation only works if the commit's parents are kept
in order as they map onto the visual columns, as we get the colors by
iterating over `new_columns` as we print the dashes. In general, the
commit's parents can arbitrarily merge with existing columns, and change
their ordering in the process.

For example, in the following diagram, the number of each column
indicates which commit parent appears in each column.

        | | *---.
        | | |\ \ \
        | | |/ / /
        | |/| | /
        | |_|_|/
        |/| | |
        3 1 0 2

If the columns are colored (red, green, yellow, blue), then the dashes
will currently be colored yellow and blue, whereas they should be blue
and red.

To fix this, we need to look up each column in the `mapping` array,
which before the `GRAPH_COLLAPSING` state indicates which logical column
is displayed in each visual column. This implementation is simpler as it
doesn't have any edge cases, and it also handles how left-skewed first
parents are now displayed:

        | *-.
        |/|\ \
        | | | |
        0 1 2 3

The color of the first dashes is always the color found in `mapping` two
columns to the right of the commit symbol. Because commits are displayed
after all edges have been collapsed together and the visual columns
match the logical ones, we can find the visual offset of the commit
symbol using `commit_index`.

Signed-off-by: James Coglan <jcoglan@gmail.com>
---
 graph.c                      | 71 +++++++++++++++++++-----------------
 t/t4214-log-graph-octopus.sh | 10 ++---
 2 files changed, 42 insertions(+), 39 deletions(-)

diff --git a/graph.c b/graph.c
index 80db74aee6..e3fd0ea5f8 100644
--- a/graph.c
+++ b/graph.c
@@ -684,6 +684,11 @@ static void graph_update_columns(struct git_graph *graph)
 		graph->mapping_size--;
 }
 
+static int graph_num_dashed_parents(struct git_graph *graph)
+{
+	return graph->num_parents + graph->merge_layout - 3;
+}
+
 static int graph_num_expansion_rows(struct git_graph *graph)
 {
 	/*
@@ -706,7 +711,7 @@ static int graph_num_expansion_rows(struct git_graph *graph)
 	 * 		| * \
 	 * 		|/|\ \
 	 */
-	return (graph->num_parents + graph->merge_layout - 3) * 2;
+	return graph_num_dashed_parents(graph) * 2;
 }
 
 static int graph_needs_pre_commit_line(struct git_graph *graph)
@@ -934,47 +939,45 @@ static void graph_output_commit_char(struct git_graph *graph, struct graph_line
 static void graph_draw_octopus_merge(struct git_graph *graph, struct graph_line *line)
 {
 	/*
-	 * Here dashless_parents represents the number of parents which don't
-	 * need to have dashes (the edges labeled "0" and "1").  And
-	 * dashful_parents are the remaining ones.
+	 * The parents of a merge commit can be arbitrarily reordered as they
+	 * are mapped onto display columns, for example this is a valid merge:
 	 *
-	 * | *---.
-	 * | |\ \ \
-	 * | | | | |
-	 * x 0 1 2 3
+	 *	| | *---.
+	 *	| | |\ \ \
+	 *	| | |/ / /
+	 *	| |/| | /
+	 *	| |_|_|/
+	 *	|/| | |
+	 *	3 1 0 2
 	 *
-	 */
-	const int dashless_parents = 3 - graph->merge_layout;
-	int dashful_parents = graph->num_parents - dashless_parents;
-
-	/*
-	 * Usually, we add one new column for each parent (like the diagram
-	 * above) but sometimes the first parent goes into an existing column,
-	 * like this:
+	 * The numbers denote which parent of the merge each visual column
+	 * corresponds to; we can't assume that the parents will initially
+	 * display in the order given by new_columns.
 	 *
-	 * | *-.
-	 * |/|\ \
-	 * | | | |
-	 * x 0 1 2
+	 * To find the right color for each dash, we need to consult the
+	 * mapping array, starting from the column 2 places to the right of the
+	 * merge commit, and use that to find out which logical column each
+	 * edge will collapse to.
 	 *
-	 * In which case the number of parents will be one greater than the
-	 * number of added columns.
+	 * Commits are rendered once all edges have collapsed to their correct
+	 * logcial column, so commit_index gives us the right visual offset for
+	 * the merge commit.
 	 */
-	int added_cols = (graph->num_new_columns - graph->num_columns);
-	int parent_in_old_cols = graph->num_parents - added_cols;
 
-	/*
-	 * In both cases, commit_index corresponds to the edge labeled "0".
-	 */
-	int first_col = graph->commit_index + dashless_parents
-	    - parent_in_old_cols;
+	int i, j;
+	struct column *col;
 
-	int i;
-	for (i = 0; i < dashful_parents; i++) {
-		graph_line_write_column(line, &graph->new_columns[i+first_col], '-');
-		graph_line_write_column(line, &graph->new_columns[i+first_col],
-					  i == dashful_parents-1 ? '.' : '-');
+	int dashed_parents = graph_num_dashed_parents(graph);
+
+	for (i = 0; i < dashed_parents; i++) {
+		j = graph->mapping[(graph->commit_index + i + 2) * 2];
+		col = &graph->new_columns[j];
+
+		graph_line_write_column(line, col, '-');
+		graph_line_write_column(line, col, (i == dashed_parents - 1) ? '.' : '-');
 	}
+
+	return;
 }
 
 static void graph_output_commit_line(struct git_graph *graph, struct graph_line *line)
diff --git a/t/t4214-log-graph-octopus.sh b/t/t4214-log-graph-octopus.sh
index 21bc600a82..40d27db674 100755
--- a/t/t4214-log-graph-octopus.sh
+++ b/t/t4214-log-graph-octopus.sh
@@ -121,7 +121,7 @@ test_expect_success 'log --graph with normal octopus merge and child, no color'
 	test_cmp expect.uncolored actual
 '
 
-test_expect_failure 'log --graph with normal octopus and child merge with colors' '
+test_expect_success 'log --graph with normal octopus and child merge with colors' '
 	cat >expect.colors <<-\EOF &&
 	* after-merge
 	*<BLUE>-<RESET><BLUE>-<RESET><MAGENTA>-<RESET><MAGENTA>.<RESET>   octopus-merge
@@ -161,7 +161,7 @@ test_expect_success 'log --graph with tricky octopus merge and its child, no col
 	test_cmp expect.uncolored actual
 '
 
-test_expect_failure 'log --graph with tricky octopus merge and its child with colors' '
+test_expect_success 'log --graph with tricky octopus merge and its child with colors' '
 	test_config log.graphColors red,green,yellow,blue,magenta,cyan &&
 	cat >expect.colors <<-\EOF &&
 	* left
@@ -205,7 +205,7 @@ test_expect_success 'log --graph with crossover in octopus merge, no color' '
 	test_cmp expect.uncolored actual
 '
 
-test_expect_failure 'log --graph with crossover in octopus merge with colors' '
+test_expect_success 'log --graph with crossover in octopus merge with colors' '
 	test_config log.graphColors red,green,yellow,blue,magenta,cyan &&
 	cat >expect.colors <<-\EOF &&
 	* after-4
@@ -253,7 +253,7 @@ test_expect_success 'log --graph with crossover in octopus merge and its child,
 	test_cmp expect.uncolored actual
 '
 
-test_expect_failure 'log --graph with crossover in octopus merge and its child with colors' '
+test_expect_success 'log --graph with crossover in octopus merge and its child with colors' '
 	test_config log.graphColors red,green,yellow,blue,magenta,cyan &&
 	cat >expect.colors <<-\EOF &&
 	* after-4
@@ -349,7 +349,7 @@ test_expect_success 'log --graph with unrelated commit and octopus child, no col
 	test_cmp expect.uncolored actual
 '
 
-test_expect_failure 'log --graph with unrelated commit and octopus child with colors' '
+test_expect_success 'log --graph with unrelated commit and octopus child with colors' '
 	test_config log.graphColors red,green,yellow,blue,magenta,cyan &&
 	cat >expect.colors <<-\EOF &&
 	* after-initial
-- 
gitgitgadget
