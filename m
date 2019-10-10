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
	by dcvr.yhbt.net (Postfix) with ESMTP id 4587D1F4BD
	for <e@80x24.org>; Thu, 10 Oct 2019 16:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbfJJQN5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 12:13:57 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42832 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbfJJQNw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Oct 2019 12:13:52 -0400
Received: by mail-wr1-f67.google.com with SMTP id n14so8586857wrw.9
        for <git@vger.kernel.org>; Thu, 10 Oct 2019 09:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CNy1xTMHVsAy6mKLaIY8F8k2guin6Fxc9R6Rg30SXgY=;
        b=jAsP5939VaapDUL1Q7/XNyYgi7KuFXiTJkMaVcqV4zSElplV6eBz7B5IeTPJiOYTP3
         Y4sROAJaQ2J83u2p5zqlrDdz+FY839W5TYmmWRMBn4g7wU0eYVCOqKW/Fxz0hOYjcTyn
         cv/YIg6kenQ1vU7zu0zHIuUT9cYBVpl0I/oiQnibUB8Ecn6yKWPbfIkpSjWOZe9mNIXr
         3mR5KsxBSlnMfSJJvxDEQEHJJstgjNHr7Rbny8BOiZ9OcNmvLHA2pBn3E1201iM7AvJc
         0LuY4/wCpEkanbwToBEqcvvseD2//V8O43FlM0DQ2GFl/1xstbey6nTnQa0iccPZaXrn
         S1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CNy1xTMHVsAy6mKLaIY8F8k2guin6Fxc9R6Rg30SXgY=;
        b=NThwu82+qRV5hYn1UyqsndM9CZG3RXLDCHP7qiOl8+2jze+Ub7ruFsVRQ+i4pTi5lY
         N11MsvttDzhmv3CE7Ii+6d0mARomFr/mNE9whOrJxahchdwjnQ1ySAM318TRha58qBdw
         eignpGXSqB2FxW0+uHfOZj0SZbX8bvJVFjvRHvrix13d+UiOAXVclMhkMK/5IfwNk6x1
         RVop2Erz1TTdxVPm2RFrYMw7GeVBicNH8V7PfoLSNszuwlL469tRl9VEu7fgyx93AErT
         FjLNBvP9WoGxB6J6yCsLPqF2b+gjyS+YypxGvE9FaMNn2/eDilIXO6XNBzhYC3zFBxAJ
         dPzA==
X-Gm-Message-State: APjAAAXwWAjYrsIQqIx3CVjmO9XbYgdP8R7xE6IVN7+dDafWvErshuGG
        xV4V6wf0SpbUz9d27HlAO0NJ6Zqx
X-Google-Smtp-Source: APXvYqxVJYrwxGF5b4d/cos34Tf+ZLdLL5pStg/KLeBUicWxRyj8l6XtoSh1n65smRw7n6zo1GQxCg==
X-Received: by 2002:a5d:4b09:: with SMTP id v9mr8825530wrq.127.1570724028246;
        Thu, 10 Oct 2019 09:13:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j18sm5751016wrs.85.2019.10.10.09.13.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 09:13:47 -0700 (PDT)
Date:   Thu, 10 Oct 2019 09:13:47 -0700 (PDT)
X-Google-Original-Date: Thu, 10 Oct 2019 16:13:35 GMT
Message-Id: <12c0916cb1ef033f917dc065cc1f18c0477296b8.1570724021.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.383.git.gitgitgadget@gmail.com>
References: <pull.383.git.gitgitgadget@gmail.com>
From:   "James Coglan via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 06/11] graph: tidy up display of left-skewed merges
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
as a veritcal pipe `|` in the GRAPH_POST_MERGE line and then immediately
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
 t/t4214-log-graph-octopus.sh |  10 ++-
 t/t4215-log-skewed-merges.sh |  42 ++++++++++++
 3 files changed, 143 insertions(+), 34 deletions(-)
 create mode 100755 t/t4215-log-skewed-merges.sh

diff --git a/graph.c b/graph.c
index 98e8777db4..9136173e03 100644
--- a/graph.c
+++ b/graph.c
@@ -183,6 +183,20 @@ struct git_graph {
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
@@ -294,6 +308,7 @@ struct git_graph *graph_init(struct rev_info *opt)
 	graph->prev_state = GRAPH_PADDING;
 	graph->commit_index = 0;
 	graph->prev_commit_index = 0;
+	graph->merge_layout = 0;
 	graph->num_columns = 0;
 	graph->num_new_columns = 0;
 	graph->mapping_size = 0;
@@ -453,9 +468,11 @@ static int graph_find_new_column_by_commit(struct git_graph *graph,
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
@@ -467,8 +484,26 @@ static void graph_insert_into_new_columns(struct git_graph *graph,
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
@@ -534,6 +569,7 @@ static void graph_update_columns(struct git_graph *graph)
 		if (col_commit == graph->commit) {
 			seen_this = 1;
 			graph->commit_index = i;
+			graph->merge_layout = -1;
 			for (parent = first_interesting_parent(graph);
 			     parent;
 			     parent = next_interesting_parent(graph, parent)) {
@@ -546,7 +582,7 @@ static void graph_update_columns(struct git_graph *graph)
 				    !is_commit_in_columns) {
 					graph_increment_column_color(graph);
 				}
-				graph_insert_into_new_columns(graph, parent->item);
+				graph_insert_into_new_columns(graph, parent->item, i);
 			}
 			/*
 			 * We always need to increment graph->width by at
@@ -557,7 +593,7 @@ static void graph_update_columns(struct git_graph *graph)
 			if (graph->num_parents == 0)
 				graph->width += 2;
 		} else {
-			graph_insert_into_new_columns(graph, col_commit);
+			graph_insert_into_new_columns(graph, col_commit, -1);
 		}
 	}
 
@@ -569,10 +605,36 @@ static void graph_update_columns(struct git_graph *graph)
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
@@ -722,7 +784,6 @@ static void graph_output_skip_line(struct git_graph *graph, struct strbuf *sb)
 static void graph_output_pre_commit_line(struct git_graph *graph,
 					 struct strbuf *sb)
 {
-	int num_expansion_rows;
 	int i, seen_this;
 
 	/*
@@ -733,14 +794,13 @@ static void graph_output_pre_commit_line(struct git_graph *graph,
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
@@ -782,7 +842,7 @@ static void graph_output_pre_commit_line(struct git_graph *graph,
 	 * and move to state GRAPH_COMMIT if necessary
 	 */
 	graph->expansion_row++;
-	if (graph->expansion_row >= num_expansion_rows)
+	if (!graph_needs_pre_commit_line(graph))
 		graph_update_state(graph, GRAPH_COMMIT);
 }
 
@@ -820,7 +880,7 @@ static void graph_draw_octopus_merge(struct git_graph *graph, struct strbuf *sb)
 	 * x 0 1 2 3
 	 *
 	 */
-	const int dashless_parents = 2;
+	const int dashless_parents = 3 - graph->merge_layout;
 	int dashful_parents = graph->num_parents - dashless_parents;
 
 	/*
@@ -828,9 +888,9 @@ static void graph_draw_octopus_merge(struct git_graph *graph, struct strbuf *sb)
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
@@ -923,10 +983,15 @@ static void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
 		graph_update_state(graph, GRAPH_COLLAPSING);
 }
 
+const char merge_chars[] = {'/', '|', '\\'};
+
 static void graph_output_post_merge_line(struct git_graph *graph, struct strbuf *sb)
 {
 	int seen_this = 0;
-	int i, j;
+	int i;
+
+	struct commit_list *first_parent = first_interesting_parent(graph);
+	int seen_parent = 0;
 
 	/*
 	 * Output the post-merge row
@@ -949,30 +1014,34 @@ static void graph_output_post_merge_line(struct git_graph *graph, struct strbuf
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
-			strbuf_write_column(sb, &graph->new_columns[par_column], '|');
-			for (j = 0; j < graph->num_parents - 1; j++) {
-				parents = next_interesting_parent(graph, parents);
-				assert(parents);
+
+			for (; parents; parents = next_interesting_parent(graph, parents)) {
 				par_column = graph_find_new_column_by_commit(graph, parents->item);
 				assert(par_column >= 0);
-				strbuf_write_column(sb, &graph->new_columns[par_column], '\\');
-				strbuf_addch(sb, ' ');
+
+				c = merge_chars[idx];
+				strbuf_write_column(sb, &graph->new_columns[par_column], c);
+				if (idx == 2)
+					strbuf_addch(sb, ' ');
+				else
+					idx++;
 			}
 		} else if (seen_this) {
 			strbuf_write_column(sb, col, '\\');
 			strbuf_addch(sb, ' ');
 		} else {
 			strbuf_write_column(sb, col, '|');
-			strbuf_addch(sb, ' ');
+			if (graph->merge_layout != 0 || i != graph->commit_index - 1)
+				strbuf_addch(sb, seen_parent ? '_' : ' ');
 		}
+
+		if (col_commit == first_parent->item)
+			seen_parent = 1;
 	}
 
 	graph_pad_horizontally(graph, sb);
diff --git a/t/t4214-log-graph-octopus.sh b/t/t4214-log-graph-octopus.sh
index dab96c89aa..40f420877b 100755
--- a/t/t4214-log-graph-octopus.sh
+++ b/t/t4214-log-graph-octopus.sh
@@ -7,9 +7,8 @@ test_description='git log --graph of skewed left octopus merge.'
 test_expect_success 'set up merge history' '
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
@@ -21,9 +20,8 @@ test_expect_success 'set up merge history' '
 	EOF
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
diff --git a/t/t4215-log-skewed-merges.sh b/t/t4215-log-skewed-merges.sh
new file mode 100755
index 0000000000..cfaba40f97
--- /dev/null
+++ b/t/t4215-log-skewed-merges.sh
@@ -0,0 +1,42 @@
+#!/bin/sh
+
+test_description='git log --graph of skewed merges'
+
+. ./test-lib.sh
+
+test_expect_success 'setup left-skewed merge' '
+	git checkout --orphan _a && test_commit A &&
+	git branch _b &&
+	git branch _c &&
+	git branch _d &&
+	git branch _e &&
+	git checkout _b && test_commit B &&
+	git checkout _c && test_commit C &&
+	git checkout _d && test_commit D &&
+	git checkout _e && git merge --no-ff _d -m E &&
+	git checkout _a && git merge --no-ff _b _c _e -m F
+'
+
+cat > expect <<\EOF
+*---.   F
+|\ \ \
+| | | * E
+| |_|/|
+|/| | |
+| | | * D
+| |_|/
+|/| |
+| | * C
+| |/
+|/|
+| * B
+|/
+* A
+EOF
+
+test_expect_success 'log --graph with left-skewed merge' '
+	git log --graph --pretty=tformat:%s | sed "s/ *$//" > actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
gitgitgadget

