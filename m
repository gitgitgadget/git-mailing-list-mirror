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
	by dcvr.yhbt.net (Postfix) with ESMTP id 4121D1F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 23:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390300AbfJOXsR (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 19:48:17 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50855 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389633AbfJOXsP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 19:48:15 -0400
Received: by mail-wm1-f66.google.com with SMTP id 5so845796wmg.0
        for <git@vger.kernel.org>; Tue, 15 Oct 2019 16:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4HWzS42gDslrEMEPts01ANOxNN/KrukGvv6KInxFUdo=;
        b=jH37+fNY77oDvCsB21D64YostD5x5uYqwMIGsS2lludVqJ1g402lE0oUOLTnbaQH9r
         SRbwCbzgh1q/xrDxTFQngKc/mLyUYzlLfjcSsI90jf492Tsc+HN5JMLNNLURFLGvEy5B
         SIKZAjqC3MEbgvarCvjdNkNFCVgtVGfv0cCEysQI/xFYuMTx3pVnc28PFMHm9VuikxJx
         N9axLDfz3TAHmL0qNwZRXCGShYsQEod8fepbgcm2ie5IoYlZRjtMGRjEOLQeY2pPkP9w
         ZIWgtDurrbEP89tlW43nfdHSVO6llxJ327+lLen9Rn38YMw3e32+z3ubO4Uo6ZfHrpj6
         C0VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4HWzS42gDslrEMEPts01ANOxNN/KrukGvv6KInxFUdo=;
        b=hnlp1H4DEvQtS7Bszr4rwiPsMOkcd6fWXuzNgXDNFOm2lXUyLZ4gJzErR3ZVdibOPZ
         G26vmKuzLCH806G8yoi0XNOkyiUp4A972ieFqoNXllrBkqTD+XHqv1X3Nc2ulJ0YVDeV
         dSUqe2MYPBIYJcUil2b37xF0q5CyWFoaaBxN4YysgLxa3Y1u7kLlR9wPTldZqdVZEuwB
         c6NfXf4W+mEzMA8YbX0yNBYQx8HBZ4XVR2ODz6mZKT0Xs3tJzZxjT1v/3CjS13l6BQQY
         vSXQmc/yjMa2u3OR3qX+oM2UyD725xVYU0nM24p0CIYsyVMFt/8hwEW7YfxeW73z6naT
         M/xw==
X-Gm-Message-State: APjAAAUx5sLWu0BK76OIsH+MDc9GAz9A2tMQkQ0CZq8wIGsKUvm7FGHh
        MhUfzd/WY+ofLVkansvXW4Zwv0Bj
X-Google-Smtp-Source: APXvYqzsAoF5q24KzNCDugdgx9PkT5d+WBJsuu8KcT73G/CZ3euAX9Oee24lzQs0d6dynxsNpZzwcg==
X-Received: by 2002:a1c:3284:: with SMTP id y126mr793705wmy.164.1571183292065;
        Tue, 15 Oct 2019 16:48:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u1sm591936wmc.38.2019.10.15.16.48.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 16:48:11 -0700 (PDT)
Message-Id: <04ba5169bc855ae4a65c33a0484926c22e68714a.1571183279.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.383.v3.git.1571183279.gitgitgadget@gmail.com>
References: <pull.383.v2.git.1571182864.gitgitgadget@gmail.com>
        <pull.383.v3.git.1571183279.gitgitgadget@gmail.com>
From:   "James Coglan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Oct 2019 23:47:58 +0000
Subject: [PATCH v3 12/13] graph: flatten edges that fuse with their right
 neighbor
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

When a merge commit is printed and its final parent is the same commit
that occupies the column to the right of the merge, this results in a
kink in the displayed edges:

        * |
        |\ \
        | |/
        | *

Graphs containing these shapes can be hard to read, as the expansion to
the right followed immediately by collapsing back to the left creates a
lot of zig-zagging edges, especially when many columns are present.

We can improve this by eliminating the zig-zag and having the merge's
final parent edge fuse immediately with its neighbor:

        * |
        |\|
        | *

This reduces the horizontal width for the current commit by 2, and
requires one less row, making the graph display more compact. Taken in
combination with other graph-smoothing enhancements, it greatly
compresses the space needed to display certain histories:

        *
        |\
        | *                       *
        | |\                      |\
        | | *                     | *
        | | |                     | |\
        | |  \                    | | *
        | *-. \                   | * |
        | |\ \ \        =>        |/|\|
        |/ / / /                  | | *
        | | | /                   | * |
        | | |/                    | |/
        | | *                     * /
        | * |                     |/
        | |/                      *
        * |
        |/
        *

One of the test cases here cannot be correctly rendered in Git v2.23.0;
it produces this output following commit E:

        | | *-. \   5_E
        | | |\ \ \
        | |/ / / /
        | | | / _
        | |_|/
        |/| |

The new implementation makes sure that the rightmost edge in this
history is not left dangling as above.

Signed-off-by: James Coglan <jcoglan@gmail.com>
---
 graph.c                                    | 34 +++++++++----
 t/t4215-log-skewed-merges.sh               | 56 ++++++++++++++++++----
 t/t6016-rev-list-graph-simplify-history.sh | 30 +++++-------
 3 files changed, 86 insertions(+), 34 deletions(-)

diff --git a/graph.c b/graph.c
index 63f8d18baa..80db74aee6 100644
--- a/graph.c
+++ b/graph.c
@@ -557,8 +557,24 @@ static void graph_insert_into_new_columns(struct git_graph *graph,
 		shift = (dist > 1) ? 2 * dist - 3 : 1;
 
 		graph->merge_layout = (dist > 0) ? 0 : 1;
+		graph->edges_added = graph->num_parents + graph->merge_layout  - 2;
+
 		mapping_idx = graph->width + (graph->merge_layout - 1) * shift;
 		graph->width += 2 * graph->merge_layout;
+
+	} else if (graph->edges_added > 0 && i == graph->mapping[graph->width - 2]) {
+		/*
+		 * If some columns have been added by a merge, but this commit
+		 * was found in the last existing column, then adjust the
+		 * numbers so that the two edges immediately join, i.e.:
+		 *
+		 *		* |		* |
+		 *		|\ \	=>	|\|
+		 *		| |/		| *
+		 *		| *
+		 */
+		mapping_idx = graph->width - 2;
+		graph->edges_added = -1;
 	} else {
 		mapping_idx = graph->width;
 		graph->width += 2;
@@ -604,6 +620,8 @@ static void graph_update_columns(struct git_graph *graph)
 		graph->mapping[i] = -1;
 
 	graph->width = 0;
+	graph->prev_edges_added = graph->edges_added;
+	graph->edges_added = 0;
 
 	/*
 	 * Populate graph->new_columns and graph->mapping
@@ -731,9 +749,6 @@ void graph_update(struct git_graph *graph, struct commit *commit)
 	 */
 	graph_update_columns(graph);
 
-	graph->prev_edges_added = graph->edges_added;
-	graph->edges_added = graph->num_parents + graph->merge_layout - 2;
-
 	graph->expansion_row = 0;
 
 	/*
@@ -1041,7 +1056,7 @@ const char merge_chars[] = {'/', '|', '\\'};
 static void graph_output_post_merge_line(struct git_graph *graph, struct graph_line *line)
 {
 	int seen_this = 0;
-	int i;
+	int i, j;
 
 	struct commit_list *first_parent = first_interesting_parent(graph);
 	int seen_parent = 0;
@@ -1073,16 +1088,19 @@ static void graph_output_post_merge_line(struct git_graph *graph, struct graph_l
 			char c;
 			seen_this = 1;
 
-			for (; parents; parents = next_interesting_parent(graph, parents)) {
+			for (j = 0; j < graph->num_parents; j++) {
 				par_column = graph_find_new_column_by_commit(graph, parents->item);
 				assert(par_column >= 0);
 
 				c = merge_chars[idx];
 				graph_line_write_column(line, &graph->new_columns[par_column], c);
-				if (idx == 2)
-					graph_line_addch(line, ' ');
-				else
+				if (idx == 2) {
+					if (graph->edges_added > 0 || j < graph->num_parents - 1)
+						graph_line_addch(line, ' ');
+				} else {
 					idx++;
+				}
+				parents = next_interesting_parent(graph, parents);
 			}
 			if (graph->edges_added == 0)
 				graph_line_addch(line, ' ');
diff --git a/t/t4215-log-skewed-merges.sh b/t/t4215-log-skewed-merges.sh
index 1745b3b64c..d33c6438d8 100755
--- a/t/t4215-log-skewed-merges.sh
+++ b/t/t4215-log-skewed-merges.sh
@@ -11,9 +11,8 @@ test_expect_success 'log --graph with merge fusing with its left and right neigh
 	| *   G
 	| |\
 	| | * F
-	| * |   E
-	|/|\ \
-	| | |/
+	| * | E
+	|/|\|
 	| | * D
 	| * | C
 	| |/
@@ -43,9 +42,9 @@ test_expect_success 'log --graph with left-skewed merge' '
 	| | | | * 0_G
 	| |_|_|/|
 	|/| | | |
-	| | | * |   0_F
-	| |_|/|\ \
-	|/| | | |/
+	| | | * | 0_F
+	| |_|/|\|
+	|/| | | |
 	| | | | * 0_E
 	| |_|_|/
 	|/| | |
@@ -153,9 +152,8 @@ test_expect_success 'log --graph with nested right-skewed merge following left-s
 	| | * 3_G
 	| * | 3_F
 	|/| |
-	| * |   3_E
-	| |\ \
-	| | |/
+	| * | 3_E
+	| |\|
 	| | * 3_D
 	| * | 3_C
 	| |/
@@ -216,4 +214,44 @@ test_expect_success 'log --graph with right-skewed merge following a left-skewed
 	test_cmp expect actual
 '
 
+test_expect_success 'log --graph with octopus merge with column joining its penultimate parent' '
+	cat >expect <<-\EOF &&
+	*   5_H
+	|\
+	| *-.   5_G
+	| |\ \
+	| | | * 5_F
+	| | * |   5_E
+	| |/|\ \
+	| |_|/ /
+	|/| | /
+	| | |/
+	* | | 5_D
+	| | * 5_C
+	| |/
+	|/|
+	| * 5_B
+	|/
+	* 5_A
+	EOF
+
+	git checkout --orphan 5_p &&
+	test_commit 5_A &&
+	git branch 5_q &&
+	git branch 5_r &&
+	test_commit 5_B &&
+	git checkout 5_q && test_commit 5_C &&
+	git checkout 5_r && test_commit 5_D &&
+	git checkout 5_p &&
+	git merge --no-ff 5_q 5_r -m 5_E &&
+	git checkout 5_q && test_commit 5_F &&
+	git checkout -b 5_s 5_p^ &&
+	git merge --no-ff 5_p 5_q -m 5_G &&
+	git checkout 5_r &&
+	git merge --no-ff 5_s -m 5_H &&
+
+	git log --graph --pretty=tformat:%s | sed "s/ *$//" >actual &&
+	test_cmp expect actual
+'
+
 test_done
diff --git a/t/t6016-rev-list-graph-simplify-history.sh b/t/t6016-rev-list-graph-simplify-history.sh
index ca1682f29b..f5e6e92f5b 100755
--- a/t/t6016-rev-list-graph-simplify-history.sh
+++ b/t/t6016-rev-list-graph-simplify-history.sh
@@ -67,11 +67,10 @@ test_expect_success '--graph --all' '
 	echo "| * $C4" >> expected &&
 	echo "| * $C3" >> expected &&
 	echo "* | $A5" >> expected &&
-	echo "| |     " >> expected &&
-	echo "|  \\    " >> expected &&
-	echo "*-. \\   $A4" >> expected &&
-	echo "|\\ \\ \\  " >> expected &&
-	echo "| | |/  " >> expected &&
+	echo "| |   " >> expected &&
+	echo "|  \\  " >> expected &&
+	echo "*-. | $A4" >> expected &&
+	echo "|\\ \\| " >> expected &&
 	echo "| | * $C2" >> expected &&
 	echo "| | * $C1" >> expected &&
 	echo "| * | $B2" >> expected &&
@@ -97,11 +96,10 @@ test_expect_success '--graph --simplify-by-decoration' '
 	echo "| * $C4" >> expected &&
 	echo "| * $C3" >> expected &&
 	echo "* | $A5" >> expected &&
-	echo "| |     " >> expected &&
-	echo "|  \\    " >> expected &&
-	echo "*-. \\   $A4" >> expected &&
-	echo "|\\ \\ \\  " >> expected &&
-	echo "| | |/  " >> expected &&
+	echo "| |   " >> expected &&
+	echo "|  \\  " >> expected &&
+	echo "*-. | $A4" >> expected &&
+	echo "|\\ \\| " >> expected &&
 	echo "| | * $C2" >> expected &&
 	echo "| | * $C1" >> expected &&
 	echo "| * | $B2" >> expected &&
@@ -131,9 +129,8 @@ test_expect_success '--graph --simplify-by-decoration prune branch B' '
 	echo "| * $C4" >> expected &&
 	echo "| * $C3" >> expected &&
 	echo "* | $A5" >> expected &&
-	echo "* |   $A4" >> expected &&
-	echo "|\\ \\  " >> expected &&
-	echo "| |/  " >> expected &&
+	echo "* | $A4" >> expected &&
+	echo "|\\| " >> expected &&
 	echo "| * $C2" >> expected &&
 	echo "| * $C1" >> expected &&
 	echo "* | $A3" >> expected &&
@@ -151,10 +148,9 @@ test_expect_success '--graph --full-history -- bar.txt' '
 	echo "|\\  " >> expected &&
 	echo "| * $C4" >> expected &&
 	echo "* | $A5" >> expected &&
-	echo "* |   $A4" >> expected &&
-	echo "|\\ \\  " >> expected &&
-	echo "| |/  " >> expected &&
-	echo "* / $A3" >> expected &&
+	echo "* | $A4" >> expected &&
+	echo "|\\| " >> expected &&
+	echo "* | $A3" >> expected &&
 	echo "|/  " >> expected &&
 	echo "* $A2" >> expected &&
 	git rev-list --graph --full-history --all -- bar.txt > actual &&
-- 
gitgitgadget

