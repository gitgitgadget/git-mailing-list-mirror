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
	by dcvr.yhbt.net (Postfix) with ESMTP id BD97D1F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 23:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390304AbfJOXsS (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 19:48:18 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51837 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727439AbfJOXsN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 19:48:13 -0400
Received: by mail-wm1-f68.google.com with SMTP id 7so844230wme.1
        for <git@vger.kernel.org>; Tue, 15 Oct 2019 16:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=K2sLCObK61J1vAfGhtXO3Z3duI3+qXEY8qtHSV+5oro=;
        b=bhHKJUVjD5FpvEz+4PE3udarakWgkZRElLxe49jKxfrx766l+hSa+ny5yTNzPuQNEp
         NEFSd4VRHQU9NJ4Rtcv6Wwnl/YFW230UA45g2oD73qSvjYkDYC9Oh/0bwzpQj0Pt7p93
         P7L01KsBlDMBNMs+GElg/RqSgtj8F2rBtqFPp44/Z3Ebu8sOd6nr2LBQtBnSvCiH/Ej3
         +QCRVjaDTMZ0ePkM6Vw+MEF6Nghz9VstWWwVI7zePtSgK8O54rIAdxa1HxzodxD0baJN
         wUFY3uabqOC6YVv6ERrPsoSZGeHRJ49ZfWYK7QT9piJYxanRUawIJYAv16YM/TMSn2Zi
         76MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=K2sLCObK61J1vAfGhtXO3Z3duI3+qXEY8qtHSV+5oro=;
        b=i8LxUjTGdCthlm1qU0jpGSsTij6ulHOuUiD8zIcaRmsnin1uag7GswSy5csqoUU36C
         purbmZQC6zibK2xjCHYNGBilk6mpSSxx/D6FNTOoGzxAQsJRku6J/4kt8hew8N0eVP4/
         etJ+7YIiOdfkxe7IWr8Cb+Alc4kdMeoZ+5zoIw89iIvHNcXSIQpbgHBQjP8u4J0GZoZq
         Q6B5aYZrJeXNfwuIBvDwU87/gWho8BVSeYA5NHFdJmGMP319MJgM1BuP9wdysyWrcgfY
         CWh56QTEEpzqyNByTCpHwBqr5EQEagO1cA+ZFUVOy6m0h4+mFnPYQO/fcouGRq3Zvp+H
         U/Cw==
X-Gm-Message-State: APjAAAWDjRGCOK+6cAdSAPvrURJxQWVgDd0Wh5XYVfzJ7lCD5dSq4aHN
        5RNLwrBhTAlVALLlHzxiETc5UdsX
X-Google-Smtp-Source: APXvYqxlw3C31r5F0UiTzyDoBEePAPur+0IuZZL2zP0Ld8H6c/eVF3cMzqdPc3IPfvBAECQnC5ayPw==
X-Received: by 2002:a1c:f00a:: with SMTP id a10mr789607wmb.89.1571183288649;
        Tue, 15 Oct 2019 16:48:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z22sm866716wmf.2.2019.10.15.16.48.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 16:48:08 -0700 (PDT)
Message-Id: <c34a5eb160310613cbde6313cda6cff753d6d7fd.1571183279.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.383.v3.git.1571183279.gitgitgadget@gmail.com>
References: <pull.383.v2.git.1571182864.gitgitgadget@gmail.com>
        <pull.383.v3.git.1571183279.gitgitgadget@gmail.com>
From:   "James Coglan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Oct 2019 23:47:54 +0000
Subject: [PATCH v3 08/13] graph: tidy up display of left-skewed merges
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

Currently, when we display a merge whose first parent is already present
in a column to the left of the merge commit, we display the first parent
as a vertical pipe `|` in the GRAPH_POST_MERGE line and then immediately
enter the GRAPH_COLLAPSING state. The first-parent line tracks to the
left and all the other parent lines follow it; this creates a "kink" in
those lines:

        | *---.
        | |\ \ \
        |/ / / /
        | | | *

This change tidies the display of such commits such that if the first
parent appears to the left of the merge, we render it as a `/` and the
second parent as a `|`. This reduces the horizontal and vertical space
needed to render the merge, and makes the resulting lines easier to
read.

        | *-.
        |/|\ \
        | | | *

If the first parent is separated from the merge by several columns, a
horizontal line is drawn in a similar manner to how the GRAPH_COLLAPSING
state displays the line.

        | | | *-.
        | |_|/|\ \
        |/| | | | *

This effect is applied to both "normal" two-parent merges, and to
octopus merges. It also reduces the vertical space needed for pre-commit
lines, as the merge occupies one less column than usual.

        Before:         After:

        | *             | *
        | |\            | |\
        | | \           | * \
        | |  \          |/|\ \
        | *-. \
        | |\ \ \

Signed-off-by: James Coglan <jcoglan@gmail.com>
---
 graph.c                      | 125 +++++++++++++++++++++++++++--------
 t/t4214-log-graph-octopus.sh |  20 +++---
 t/t4215-log-skewed-merges.sh |  45 +++++++++++--
 3 files changed, 144 insertions(+), 46 deletions(-)

diff --git a/graph.c b/graph.c
index bd7403065e..e37127f5ab 100644
--- a/graph.c
+++ b/graph.c
@@ -202,6 +202,20 @@ struct git_graph {
 	 * previous commit.
 	 */
 	int prev_commit_index;
+	/*
+	 * Which layout variant to use to display merge commits. If the
+	 * commit's first parent is known to be in a column to the left of the
+	 * merge, then this value is 0 and we use the layout on the left.
+	 * Otherwise, the value is 1 and the layout on the right is used. This
+	 * field tells us how many columns the first parent occupies.
+	 *
+	 * 		0)			1)
+	 *
+	 * 		| | | *-.		| | *---.
+	 * 		| |_|/|\ \		| | |\ \ \
+	 * 		|/| | | | |		| | | | | *
+	 */
+	int merge_layout;
 	/*
 	 * The maximum number of columns that can be stored in the columns
 	 * and new_columns arrays.  This is also half the number of entries
@@ -313,6 +327,7 @@ struct git_graph *graph_init(struct rev_info *opt)
 	graph->prev_state = GRAPH_PADDING;
 	graph->commit_index = 0;
 	graph->prev_commit_index = 0;
+	graph->merge_layout = 0;
 	graph->num_columns = 0;
 	graph->num_new_columns = 0;
 	graph->mapping_size = 0;
@@ -472,9 +487,11 @@ static int graph_find_new_column_by_commit(struct git_graph *graph,
 }
 
 static void graph_insert_into_new_columns(struct git_graph *graph,
-					  struct commit *commit)
+					  struct commit *commit,
+					  int idx)
 {
 	int i = graph_find_new_column_by_commit(graph, commit);
+	int mapping_idx;
 
 	/*
 	 * If the commit is not already in the new_columns array, then add it
@@ -486,8 +503,26 @@ static void graph_insert_into_new_columns(struct git_graph *graph,
 		graph->new_columns[i].color = graph_find_commit_color(graph, commit);
 	}
 
-	graph->mapping[graph->width] = i;
-	graph->width += 2;
+	if (graph->num_parents > 1 && idx > -1 && graph->merge_layout == -1) {
+		/*
+		 * If this is the first parent of a merge, choose a layout for
+		 * the merge line based on whether the parent appears in a
+		 * column to the left of the merge
+		 */
+		int dist, shift;
+
+		dist = idx - i;
+		shift = (dist > 1) ? 2 * dist - 3 : 1;
+
+		graph->merge_layout = (dist > 0) ? 0 : 1;
+		mapping_idx = graph->width + (graph->merge_layout - 1) * shift;
+		graph->width += 2 * graph->merge_layout;
+	} else {
+		mapping_idx = graph->width;
+		graph->width += 2;
+	}
+
+	graph->mapping[mapping_idx] = i;
 }
 
 static void graph_update_columns(struct git_graph *graph)
@@ -553,6 +588,7 @@ static void graph_update_columns(struct git_graph *graph)
 		if (col_commit == graph->commit) {
 			seen_this = 1;
 			graph->commit_index = i;
+			graph->merge_layout = -1;
 			for (parent = first_interesting_parent(graph);
 			     parent;
 			     parent = next_interesting_parent(graph, parent)) {
@@ -565,7 +601,7 @@ static void graph_update_columns(struct git_graph *graph)
 				    !is_commit_in_columns) {
 					graph_increment_column_color(graph);
 				}
-				graph_insert_into_new_columns(graph, parent->item);
+				graph_insert_into_new_columns(graph, parent->item, i);
 			}
 			/*
 			 * We always need to increment graph->width by at
@@ -576,7 +612,7 @@ static void graph_update_columns(struct git_graph *graph)
 			if (graph->num_parents == 0)
 				graph->width += 2;
 		} else {
-			graph_insert_into_new_columns(graph, col_commit);
+			graph_insert_into_new_columns(graph, col_commit, -1);
 		}
 	}
 
@@ -588,10 +624,36 @@ static void graph_update_columns(struct git_graph *graph)
 		graph->mapping_size--;
 }
 
+static int graph_num_expansion_rows(struct git_graph *graph)
+{
+	/*
+	 * Normally, we need two expansion rows for each dashed parent line from
+	 * an octopus merge:
+	 *
+	 * 		| *
+	 * 		| |\
+	 * 		| | \
+	 * 		| |  \
+	 * 		| *-. \
+	 * 		| |\ \ \
+	 *
+	 * If the merge is skewed to the left, then its parents occupy one less
+	 * column, and we don't need as many expansion rows to route around it;
+	 * in some cases that means we don't need any expansion rows at all:
+	 *
+	 * 		| *
+	 * 		| |\
+	 * 		| * \
+	 * 		|/|\ \
+	 */
+	return (graph->num_parents + graph->merge_layout - 3) * 2;
+}
+
 static int graph_needs_pre_commit_line(struct git_graph *graph)
 {
 	return graph->num_parents >= 3 &&
-	       graph->commit_index < (graph->num_columns - 1);
+	       graph->commit_index < (graph->num_columns - 1) &&
+	       graph->expansion_row < graph_num_expansion_rows(graph);
 }
 
 void graph_update(struct git_graph *graph, struct commit *commit)
@@ -728,7 +790,6 @@ static void graph_output_skip_line(struct git_graph *graph, struct graph_line *l
 static void graph_output_pre_commit_line(struct git_graph *graph,
 					 struct graph_line *line)
 {
-	int num_expansion_rows;
 	int i, seen_this;
 
 	/*
@@ -739,14 +800,13 @@ static void graph_output_pre_commit_line(struct git_graph *graph,
 	 * We need 2 extra rows for every parent over 2.
 	 */
 	assert(graph->num_parents >= 3);
-	num_expansion_rows = (graph->num_parents - 2) * 2;
 
 	/*
 	 * graph->expansion_row tracks the current expansion row we are on.
 	 * It should be in the range [0, num_expansion_rows - 1]
 	 */
 	assert(0 <= graph->expansion_row &&
-	       graph->expansion_row < num_expansion_rows);
+	       graph->expansion_row < graph_num_expansion_rows(graph));
 
 	/*
 	 * Output the row
@@ -786,7 +846,7 @@ static void graph_output_pre_commit_line(struct git_graph *graph,
 	 * and move to state GRAPH_COMMIT if necessary
 	 */
 	graph->expansion_row++;
-	if (graph->expansion_row >= num_expansion_rows)
+	if (!graph_needs_pre_commit_line(graph))
 		graph_update_state(graph, GRAPH_COMMIT);
 }
 
@@ -824,7 +884,7 @@ static void graph_draw_octopus_merge(struct git_graph *graph, struct graph_line
 	 * x 0 1 2 3
 	 *
 	 */
-	const int dashless_parents = 2;
+	const int dashless_parents = 3 - graph->merge_layout;
 	int dashful_parents = graph->num_parents - dashless_parents;
 
 	/*
@@ -832,9 +892,9 @@ static void graph_draw_octopus_merge(struct git_graph *graph, struct graph_line
 	 * above) but sometimes the first parent goes into an existing column,
 	 * like this:
 	 *
-	 * | *---.
-	 * | |\ \ \
-	 * |/ / / /
+	 * | *-.
+	 * |/|\ \
+	 * | | | |
 	 * x 0 1 2
 	 *
 	 * In which case the number of parents will be one greater than the
@@ -925,10 +985,15 @@ static void graph_output_commit_line(struct git_graph *graph, struct graph_line
 		graph_update_state(graph, GRAPH_COLLAPSING);
 }
 
+const char merge_chars[] = {'/', '|', '\\'};
+
 static void graph_output_post_merge_line(struct git_graph *graph, struct graph_line *line)
 {
 	int seen_this = 0;
-	int i, j;
+	int i;
+
+	struct commit_list *first_parent = first_interesting_parent(graph);
+	int seen_parent = 0;
 
 	/*
 	 * Output the post-merge row
@@ -951,30 +1016,34 @@ static void graph_output_post_merge_line(struct git_graph *graph, struct graph_l
 			 * new_columns and use those to format the
 			 * edges.
 			 */
-			struct commit_list *parents = NULL;
+			struct commit_list *parents = first_parent;
 			int par_column;
+			int idx = graph->merge_layout;
+			char c;
 			seen_this = 1;
-			parents = first_interesting_parent(graph);
-			assert(parents);
-			par_column = graph_find_new_column_by_commit(graph, parents->item);
-			assert(par_column >= 0);
-
-			graph_line_write_column(line, &graph->new_columns[par_column], '|');
-			for (j = 0; j < graph->num_parents - 1; j++) {
-				parents = next_interesting_parent(graph, parents);
-				assert(parents);
+
+			for (; parents; parents = next_interesting_parent(graph, parents)) {
 				par_column = graph_find_new_column_by_commit(graph, parents->item);
 				assert(par_column >= 0);
-				graph_line_write_column(line, &graph->new_columns[par_column], '\\');
-				graph_line_addch(line, ' ');
+
+				c = merge_chars[idx];
+				graph_line_write_column(line, &graph->new_columns[par_column], c);
+				if (idx == 2)
+					graph_line_addch(line, ' ');
+				else
+					idx++;
 			}
 		} else if (seen_this) {
 			graph_line_write_column(line, col, '\\');
 			graph_line_addch(line, ' ');
 		} else {
 			graph_line_write_column(line, col, '|');
-			graph_line_addch(line, ' ');
+			if (graph->merge_layout != 0 || i != graph->commit_index - 1)
+				graph_line_addch(line, seen_parent ? '_' : ' ');
 		}
+
+		if (col_commit == first_parent->item)
+			seen_parent = 1;
 	}
 
 	/*
diff --git a/t/t4214-log-graph-octopus.sh b/t/t4214-log-graph-octopus.sh
index 3ae8e51e50..1b96276894 100755
--- a/t/t4214-log-graph-octopus.sh
+++ b/t/t4214-log-graph-octopus.sh
@@ -26,9 +26,8 @@ test_expect_success 'set up merge history' '
 test_expect_success 'log --graph with tricky octopus merge, no color' '
 	cat >expect.uncolored <<-\EOF &&
 	* left
-	| *---.   octopus-merge
-	| |\ \ \
-	|/ / / /
+	| *-.   octopus-merge
+	|/|\ \
 	| | | * 4
 	| | * | 3
 	| | |/
@@ -47,9 +46,8 @@ test_expect_success 'log --graph with tricky octopus merge with colors' '
 	test_config log.graphColors red,green,yellow,blue,magenta,cyan &&
 	cat >expect.colors <<-\EOF &&
 	* left
-	<RED>|<RESET> *<BLUE>-<RESET><BLUE>-<RESET><MAGENTA>-<RESET><MAGENTA>.<RESET>   octopus-merge
-	<RED>|<RESET> <RED>|<RESET><YELLOW>\<RESET> <BLUE>\<RESET> <MAGENTA>\<RESET>
-	<RED>|<RESET><RED>/<RESET> <YELLOW>/<RESET> <BLUE>/<RESET> <MAGENTA>/<RESET>
+	<RED>|<RESET> *<MAGENTA>-<RESET><MAGENTA>.<RESET>   octopus-merge
+	<RED>|<RESET><RED>/<RESET><YELLOW>|<RESET><BLUE>\<RESET> <MAGENTA>\<RESET>
 	<RED>|<RESET> <YELLOW>|<RESET> <BLUE>|<RESET> * 4
 	<RED>|<RESET> <YELLOW>|<RESET> * <MAGENTA>|<RESET> 3
 	<RED>|<RESET> <YELLOW>|<RESET> <MAGENTA>|<RESET><MAGENTA>/<RESET>
@@ -147,9 +145,8 @@ test_expect_success 'log --graph with tricky octopus merge and its child, no col
 	cat >expect.uncolored <<-\EOF &&
 	* left
 	| * after-merge
-	| *---.   octopus-merge
-	| |\ \ \
-	|/ / / /
+	| *-.   octopus-merge
+	|/|\ \
 	| | | * 4
 	| | * | 3
 	| | |/
@@ -169,9 +166,8 @@ test_expect_failure 'log --graph with tricky octopus merge and its child with co
 	cat >expect.colors <<-\EOF &&
 	* left
 	<RED>|<RESET> * after-merge
-	<RED>|<RESET> *<MAGENTA>-<RESET><MAGENTA>-<RESET><CYAN>-<RESET><CYAN>.<RESET>   octopus-merge
-	<RED>|<RESET> <RED>|<RESET><BLUE>\<RESET> <MAGENTA>\<RESET> <CYAN>\<RESET>
-	<RED>|<RESET><RED>/<RESET> <BLUE>/<RESET> <MAGENTA>/<RESET> <CYAN>/<RESET>
+	<RED>|<RESET> *<CYAN>-<RESET><CYAN>.<RESET>   octopus-merge
+	<RED>|<RESET><RED>/<RESET><BLUE>|<RESET><MAGENTA>\<RESET> <CYAN>\<RESET>
 	<RED>|<RESET> <BLUE>|<RESET> <MAGENTA>|<RESET> * 4
 	<RED>|<RESET> <BLUE>|<RESET> * <CYAN>|<RESET> 3
 	<RED>|<RESET> <BLUE>|<RESET> <CYAN>|<RESET><CYAN>/<RESET>
diff --git a/t/t4215-log-skewed-merges.sh b/t/t4215-log-skewed-merges.sh
index 4582ba066a..dc187b5caf 100755
--- a/t/t4215-log-skewed-merges.sh
+++ b/t/t4215-log-skewed-merges.sh
@@ -11,12 +11,8 @@ test_expect_success 'log --graph with merge fusing with its left and right neigh
 	| *   G
 	| |\
 	| | * F
-	| | |
-	| |  \
-	| *-. \   E
-	| |\ \ \
-	|/ / / /
-	| | | /
+	| * \   E
+	|/|\ \
 	| | |/
 	| | * D
 	| * | C
@@ -40,4 +36,41 @@ test_expect_success 'log --graph with merge fusing with its left and right neigh
 	test_cmp expect actual
 '
 
+test_expect_success 'log --graph with left-skewed merge' '
+	cat >expect <<-\EOF &&
+	*-----.   0_H
+	|\ \ \ \
+	| | | | * 0_G
+	| |_|_|/|
+	|/| | | |
+	| | | * \   0_F
+	| |_|/|\ \
+	|/| | | |/
+	| | | | * 0_E
+	| |_|_|/
+	|/| | |
+	| | * | 0_D
+	| | |/
+	| | * 0_C
+	| |/
+	|/|
+	| * 0_B
+	|/
+	* 0_A
+	EOF
+
+	git checkout --orphan 0_p && test_commit 0_A &&
+	git checkout -b 0_q 0_p && test_commit 0_B &&
+	git checkout -b 0_r 0_p &&
+	test_commit 0_C &&
+	test_commit 0_D &&
+	git checkout -b 0_s 0_p && test_commit 0_E &&
+	git checkout -b 0_t 0_p && git merge --no-ff 0_r^ 0_s -m 0_F &&
+	git checkout 0_p && git merge --no-ff 0_s -m 0_G &&
+	git checkout @^ && git merge --no-ff 0_q 0_r 0_t 0_p -m 0_H &&
+
+	git log --graph --pretty=tformat:%s | sed "s/ *$//" >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget

