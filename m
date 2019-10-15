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
	by dcvr.yhbt.net (Postfix) with ESMTP id A57691F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 23:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390298AbfJOXsR (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 19:48:17 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33393 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390282AbfJOXsP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 19:48:15 -0400
Received: by mail-wm1-f65.google.com with SMTP id r17so3403332wme.0
        for <git@vger.kernel.org>; Tue, 15 Oct 2019 16:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XXWvqmnP6+XJ40KDy4pBtr6vSbAz8qKtRqaQstdwxyI=;
        b=ZbA6+pN1rQBwiXWaxbTnAXzpWe0ASDHwXyjls7Ok6Y/DBXF/i3/qIcHAZ5YGY9tcfS
         9DFVwi7UGH1+oCGfaKL2plbTn8YuGzSULtCS5K8Q1hNqVTKh8J6jGhWVFM3FIgv4tNwH
         2lqzFclVhWwwOVCx6SEzPM04UWRBuPxvb80KEpJnLam0wnkvvVlJh3tihlEBO9tWmGSl
         mafU0xxqI7YKq7Ri70ZJrd1WUD+4GXqY1d8dGBsenTFhFefn3Xy/bOr8q/QvUJejMYaG
         lg4c+D4Jcu3TYSINk+N5omJHXf5c0f3tjoyRajN9GrMHd7+HtvtvNWhgikfxAW+AhK6P
         AIgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XXWvqmnP6+XJ40KDy4pBtr6vSbAz8qKtRqaQstdwxyI=;
        b=cq0d60PsSR7qOKCJR3g9yE8PIgbztY2xpMqkQI7YYgs4JwZbuLEQWqIm7ky8GcIcWR
         kLtRO4XxIk7SZ71D46nGm9RsBskkjXtJ57wnzOZAxE97aaplfGEa+46rnVINZ/k+XzJ4
         8/58zJf2k7FefNFbbudbqcrLGec+xsGXKWIJ2a1f3l2Z/BztXCcf7LVD+bI/fXhMLjgA
         Wrc7pVLFEBY+VlUx7rhaGx4fkyCitMGX19CfyLiCK8Pkqd0n0C3rrl2oiemWJsIqDupb
         te8Ag52b78Ghp0/k40+Dw46G1vCdp1DGiRAKaHFHBP6HEA4By9V8HTw6c3GHMbIyZbKQ
         LrfQ==
X-Gm-Message-State: APjAAAVJQ77zdqbNxB+PQikZK37PSMD4lMHy4FwbEPzI7+6zzpO/gs32
        PVdNDWRpBKWJPQtU8X+4h/1o8vFY
X-Google-Smtp-Source: APXvYqxQV5MjB4r0l8+bAkA36MuUQuoy4WnO0SvzBihIQzWTJOtqVI/17MlSNYx338ppIiiQVNZp1A==
X-Received: by 2002:a05:600c:2:: with SMTP id g2mr702564wmc.163.1571183292928;
        Tue, 15 Oct 2019 16:48:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n14sm19575918wro.83.2019.10.15.16.48.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 16:48:12 -0700 (PDT)
Message-Id: <cd761b3a320c4f4285021bfa3ff04bb0a67ee688.1571183279.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.383.v3.git.1571183279.gitgitgadget@gmail.com>
References: <pull.383.v2.git.1571182864.gitgitgadget@gmail.com>
        <pull.383.v3.git.1571183279.gitgitgadget@gmail.com>
From:   "James Coglan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Oct 2019 23:47:59 +0000
Subject: [PATCH v3 13/13] graph: fix coloring of octopus dashes
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
