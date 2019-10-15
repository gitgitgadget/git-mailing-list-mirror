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
	by dcvr.yhbt.net (Postfix) with ESMTP id BA3901F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 23:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387998AbfJOXlM (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 19:41:12 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37822 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbfJOXlL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 19:41:11 -0400
Received: by mail-wr1-f67.google.com with SMTP id p14so25786316wro.4
        for <git@vger.kernel.org>; Tue, 15 Oct 2019 16:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pBVHUQfcbXJ0+aUhAl+os3cvPRIrF4FQJ8fRV871sfc=;
        b=Av8sIEcjw+uwDXpKkWH6/Qn5M7eDDDe1x3aPOTeRplQ+fIJvVVwZ0Jh5Cfj6+ydIMT
         WQn+GEsnR1QXlB2WBVuN1xL4SjsPd3pMpDgFHhqxPpFfQK1JnJPDbPJZBvm8TCdbddL4
         S5F1Cwsnxbgs04pA+hQyVTgGJHBZLfS1/WsoZBHukOZD655idph13W+rPGiWTA7lfxEb
         xiZjnncpqHrCHU6P3Rkr6qGviph9GgXV/1tOBLnSdHIR5/RJQPHEzQjHTdvE+98/EAOd
         SA+Is4OVezTjelLX5BkJkZnexfqG4wzLwym+uu+KLkWmgX/QL6SNzY/jDx1HTjkkKesq
         1IrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pBVHUQfcbXJ0+aUhAl+os3cvPRIrF4FQJ8fRV871sfc=;
        b=hfVlb303nn5c7wPKCAjBTLov2RiLtyy2JcLtCC09VWlUZeCd0uohokMCRxWWtHElKL
         7VxBCjD7PA0r6yBJhILtPbwN2ORksKvQ1/SvaguXpbjQx3oRfYSnSldksPDiYXRIQU26
         /VS1yZkpyEa5I36Dn9BlZSOs7eB6JLXrRv/BPqp5i/9Thj7i9gOuvIDYQNd/RKibAD1w
         zFbG+PdLamlgvZyWRIVp29SvVsnBfwUm/2EbhsPGQhJLOTNfb7s88jJP7Y48QhVQUUFv
         wGsabP/a6sfjfgXnEMCxit2c0xpaigplqFo0YIq6lmLxBKoYQY2WJjgYGC2LUkRZ8vEd
         J1Ow==
X-Gm-Message-State: APjAAAVQ6ONPRJgAE+bVyj4EUHbxcWRkWxWyXBRH9cXRyVfc+jkfdJ5B
        RsEbUMABM+YXUxjS7HMZYy3P16U/
X-Google-Smtp-Source: APXvYqyH1T+ui+4tIquV+Yt+8nZ7N4XeZ64O+NSNtBx9CmN2gnWR/DDQYYr54FoojzicNiHheJFjYQ==
X-Received: by 2002:a5d:5705:: with SMTP id a5mr6394wrv.112.1571182867197;
        Tue, 15 Oct 2019 16:41:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v6sm891265wma.24.2019.10.15.16.41.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 16:41:06 -0700 (PDT)
Message-Id: <c30f5bb43b485adf459fa8cc378c1c54ee5592f9.1571182864.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.383.v2.git.1571182864.gitgitgadget@gmail.com>
References: <pull.383.git.gitgitgadget@gmail.com>
        <pull.383.v2.git.1571182864.gitgitgadget@gmail.com>
From:   "James Coglan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Oct 2019 23:40:52 +0000
Subject: [PATCH v2 01/13] graph: automatically track display width of graph
 lines
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

All the output functions called by `graph_next_line()` currently keep
track of how many printable chars they've written to the buffer, before
calling `graph_pad_horizontally()` to pad the line with spaces. Some
functions do this by incrementing a counter whenever they write to the
buffer, and others do it by encoding an assumption about how many chars
are written, as in:

    graph_pad_horizontally(graph, sb, graph->num_columns * 2);

This adds a fair amount of noise to the functions' logic and is easily
broken if one forgets to increment the right counter or update the
calculations used for padding.

To make this easier to use, I'm introducing a new struct called
`graph_line` that wraps a `strbuf` and keeps count of its display width
implicitly. `graph_next_line()` wraps this around the `struct strbuf *`
it's given and passes a `struct graph_line *` to the output functions,
which use its interface.

The `graph_line` interface wraps the `strbuf_addch()`,
`strbuf_addchars()` and `strbuf_addstr()` functions, and adds the
`graph_line_write_column()` function for adding a single character with
color formatting. The `graph_pad_horizontally()` function can then use
the `width` field from the struct rather than taking a character count
as a parameter.

Signed-off-by: James Coglan <jcoglan@gmail.com>
---
 graph.c | 194 +++++++++++++++++++++++++++++---------------------------
 1 file changed, 99 insertions(+), 95 deletions(-)

diff --git a/graph.c b/graph.c
index f53135485f..2f81a5d23d 100644
--- a/graph.c
+++ b/graph.c
@@ -112,14 +112,42 @@ static const char *column_get_color_code(unsigned short color)
 	return column_colors[color];
 }
 
-static void strbuf_write_column(struct strbuf *sb, const struct column *c,
-				char col_char)
+struct graph_line {
+	struct strbuf *buf;
+	size_t width;
+};
+
+static inline void graph_line_addch(struct graph_line *line, int c)
+{
+	strbuf_addch(line->buf, c);
+	line->width++;
+}
+
+static inline void graph_line_addchars(struct graph_line *line, int c, size_t n)
+{
+	strbuf_addchars(line->buf, c, n);
+	line->width += n;
+}
+
+static inline void graph_line_addstr(struct graph_line *line, const char *s)
+{
+	strbuf_addstr(line->buf, s);
+	line->width += strlen(s);
+}
+
+static inline void graph_line_addcolor(struct graph_line *line, unsigned short color)
+{
+	strbuf_addstr(line->buf, column_get_color_code(color));
+}
+
+static void graph_line_write_column(struct graph_line *line, const struct column *c,
+				    char col_char)
 {
 	if (c->color < column_colors_max)
-		strbuf_addstr(sb, column_get_color_code(c->color));
-	strbuf_addch(sb, col_char);
+		graph_line_addcolor(line, c->color);
+	graph_line_addch(line, col_char);
 	if (c->color < column_colors_max)
-		strbuf_addstr(sb, column_get_color_code(column_colors_max));
+		graph_line_addcolor(line, column_colors_max);
 }
 
 struct git_graph {
@@ -686,8 +714,7 @@ static int graph_is_mapping_correct(struct git_graph *graph)
 	return 1;
 }
 
-static void graph_pad_horizontally(struct git_graph *graph, struct strbuf *sb,
-				   int chars_written)
+static void graph_pad_horizontally(struct git_graph *graph, struct graph_line *line)
 {
 	/*
 	 * Add additional spaces to the end of the strbuf, so that all
@@ -696,12 +723,12 @@ static void graph_pad_horizontally(struct git_graph *graph, struct strbuf *sb,
 	 * This way, fields printed to the right of the graph will remain
 	 * aligned for the entire commit.
 	 */
-	if (chars_written < graph->width)
-		strbuf_addchars(sb, ' ', graph->width - chars_written);
+	if (line->width < graph->width)
+		graph_line_addchars(line, ' ', graph->width - line->width);
 }
 
 static void graph_output_padding_line(struct git_graph *graph,
-				      struct strbuf *sb)
+				      struct graph_line *line)
 {
 	int i;
 
@@ -719,11 +746,11 @@ static void graph_output_padding_line(struct git_graph *graph,
 	 * Output a padding row, that leaves all branch lines unchanged
 	 */
 	for (i = 0; i < graph->num_new_columns; i++) {
-		strbuf_write_column(sb, &graph->new_columns[i], '|');
-		strbuf_addch(sb, ' ');
+		graph_line_write_column(line, &graph->new_columns[i], '|');
+		graph_line_addch(line, ' ');
 	}
 
-	graph_pad_horizontally(graph, sb, graph->num_new_columns * 2);
+	graph_pad_horizontally(graph, line);
 }
 
 
@@ -733,14 +760,14 @@ int graph_width(struct git_graph *graph)
 }
 
 
-static void graph_output_skip_line(struct git_graph *graph, struct strbuf *sb)
+static void graph_output_skip_line(struct git_graph *graph, struct graph_line *line)
 {
 	/*
 	 * Output an ellipsis to indicate that a portion
 	 * of the graph is missing.
 	 */
-	strbuf_addstr(sb, "...");
-	graph_pad_horizontally(graph, sb, 3);
+	graph_line_addstr(line, "...");
+	graph_pad_horizontally(graph, line);
 
 	if (graph->num_parents >= 3 &&
 	    graph->commit_index < (graph->num_columns - 1))
@@ -750,11 +777,10 @@ static void graph_output_skip_line(struct git_graph *graph, struct strbuf *sb)
 }
 
 static void graph_output_pre_commit_line(struct git_graph *graph,
-					 struct strbuf *sb)
+					 struct graph_line *line)
 {
 	int num_expansion_rows;
 	int i, seen_this;
-	int chars_written;
 
 	/*
 	 * This function formats a row that increases the space around a commit
@@ -777,14 +803,12 @@ static void graph_output_pre_commit_line(struct git_graph *graph,
 	 * Output the row
 	 */
 	seen_this = 0;
-	chars_written = 0;
 	for (i = 0; i < graph->num_columns; i++) {
 		struct column *col = &graph->columns[i];
 		if (col->commit == graph->commit) {
 			seen_this = 1;
-			strbuf_write_column(sb, col, '|');
-			strbuf_addchars(sb, ' ', graph->expansion_row);
-			chars_written += 1 + graph->expansion_row;
+			graph_line_write_column(line, col, '|');
+			graph_line_addchars(line, ' ', graph->expansion_row);
 		} else if (seen_this && (graph->expansion_row == 0)) {
 			/*
 			 * This is the first line of the pre-commit output.
@@ -797,22 +821,18 @@ static void graph_output_pre_commit_line(struct git_graph *graph,
 			 */
 			if (graph->prev_state == GRAPH_POST_MERGE &&
 			    graph->prev_commit_index < i)
-				strbuf_write_column(sb, col, '\\');
+				graph_line_write_column(line, col, '\\');
 			else
-				strbuf_write_column(sb, col, '|');
-			chars_written++;
+				graph_line_write_column(line, col, '|');
 		} else if (seen_this && (graph->expansion_row > 0)) {
-			strbuf_write_column(sb, col, '\\');
-			chars_written++;
+			graph_line_write_column(line, col, '\\');
 		} else {
-			strbuf_write_column(sb, col, '|');
-			chars_written++;
+			graph_line_write_column(line, col, '|');
 		}
-		strbuf_addch(sb, ' ');
-		chars_written++;
+		graph_line_addch(line, ' ');
 	}
 
-	graph_pad_horizontally(graph, sb, chars_written);
+	graph_pad_horizontally(graph, line);
 
 	/*
 	 * Increment graph->expansion_row,
@@ -823,7 +843,7 @@ static void graph_output_pre_commit_line(struct git_graph *graph,
 		graph_update_state(graph, GRAPH_COMMIT);
 }
 
-static void graph_output_commit_char(struct git_graph *graph, struct strbuf *sb)
+static void graph_output_commit_char(struct git_graph *graph, struct graph_line *line)
 {
 	/*
 	 * For boundary commits, print 'o'
@@ -831,22 +851,20 @@ static void graph_output_commit_char(struct git_graph *graph, struct strbuf *sb)
 	 */
 	if (graph->commit->object.flags & BOUNDARY) {
 		assert(graph->revs->boundary);
-		strbuf_addch(sb, 'o');
+		graph_line_addch(line, 'o');
 		return;
 	}
 
 	/*
 	 * get_revision_mark() handles all other cases without assert()
 	 */
-	strbuf_addstr(sb, get_revision_mark(graph->revs, graph->commit));
+	graph_line_addstr(line, get_revision_mark(graph->revs, graph->commit));
 }
 
 /*
- * Draw the horizontal dashes of an octopus merge and return the number of
- * characters written.
+ * Draw the horizontal dashes of an octopus merge.
  */
-static int graph_draw_octopus_merge(struct git_graph *graph,
-				    struct strbuf *sb)
+static void graph_draw_octopus_merge(struct git_graph *graph, struct graph_line *line)
 {
 	/*
 	 * Here dashless_parents represents the number of parents which don't
@@ -886,17 +904,16 @@ static int graph_draw_octopus_merge(struct git_graph *graph,
 
 	int i;
 	for (i = 0; i < dashful_parents; i++) {
-		strbuf_write_column(sb, &graph->new_columns[i+first_col], '-');
-		strbuf_write_column(sb, &graph->new_columns[i+first_col],
-				    i == dashful_parents-1 ? '.' : '-');
+		graph_line_write_column(line, &graph->new_columns[i+first_col], '-');
+		graph_line_write_column(line, &graph->new_columns[i+first_col],
+					  i == dashful_parents-1 ? '.' : '-');
 	}
-	return 2 * dashful_parents;
 }
 
-static void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
+static void graph_output_commit_line(struct git_graph *graph, struct graph_line *line)
 {
 	int seen_this = 0;
-	int i, chars_written;
+	int i;
 
 	/*
 	 * Output the row containing this commit
@@ -906,7 +923,6 @@ static void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
 	 * children that we have already processed.)
 	 */
 	seen_this = 0;
-	chars_written = 0;
 	for (i = 0; i <= graph->num_columns; i++) {
 		struct column *col = &graph->columns[i];
 		struct commit *col_commit;
@@ -920,15 +936,12 @@ static void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
 
 		if (col_commit == graph->commit) {
 			seen_this = 1;
-			graph_output_commit_char(graph, sb);
-			chars_written++;
+			graph_output_commit_char(graph, line);
 
 			if (graph->num_parents > 2)
-				chars_written += graph_draw_octopus_merge(graph,
-									  sb);
+				graph_draw_octopus_merge(graph, line);
 		} else if (seen_this && (graph->num_parents > 2)) {
-			strbuf_write_column(sb, col, '\\');
-			chars_written++;
+			graph_line_write_column(line, col, '\\');
 		} else if (seen_this && (graph->num_parents == 2)) {
 			/*
 			 * This is a 2-way merge commit.
@@ -945,19 +958,16 @@ static void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
 			 */
 			if (graph->prev_state == GRAPH_POST_MERGE &&
 			    graph->prev_commit_index < i)
-				strbuf_write_column(sb, col, '\\');
+				graph_line_write_column(line, col, '\\');
 			else
-				strbuf_write_column(sb, col, '|');
-			chars_written++;
+				graph_line_write_column(line, col, '|');
 		} else {
-			strbuf_write_column(sb, col, '|');
-			chars_written++;
+			graph_line_write_column(line, col, '|');
 		}
-		strbuf_addch(sb, ' ');
-		chars_written++;
+		graph_line_addch(line, ' ');
 	}
 
-	graph_pad_horizontally(graph, sb, chars_written);
+	graph_pad_horizontally(graph, line);
 
 	/*
 	 * Update graph->state
@@ -981,15 +991,14 @@ static struct column *find_new_column_by_commit(struct git_graph *graph,
 	return NULL;
 }
 
-static void graph_output_post_merge_line(struct git_graph *graph, struct strbuf *sb)
+static void graph_output_post_merge_line(struct git_graph *graph, struct graph_line *line)
 {
 	int seen_this = 0;
-	int i, j, chars_written;
+	int i, j;
 
 	/*
 	 * Output the post-merge row
 	 */
-	chars_written = 0;
 	for (i = 0; i <= graph->num_columns; i++) {
 		struct column *col = &graph->columns[i];
 		struct commit *col_commit;
@@ -1016,29 +1025,25 @@ static void graph_output_post_merge_line(struct git_graph *graph, struct strbuf
 			par_column = find_new_column_by_commit(graph, parents->item);
 			assert(par_column);
 
-			strbuf_write_column(sb, par_column, '|');
-			chars_written++;
+			graph_line_write_column(line, par_column, '|');
 			for (j = 0; j < graph->num_parents - 1; j++) {
 				parents = next_interesting_parent(graph, parents);
 				assert(parents);
 				par_column = find_new_column_by_commit(graph, parents->item);
 				assert(par_column);
-				strbuf_write_column(sb, par_column, '\\');
-				strbuf_addch(sb, ' ');
+				graph_line_write_column(line, par_column, '\\');
+				graph_line_addch(line, ' ');
 			}
-			chars_written += j * 2;
 		} else if (seen_this) {
-			strbuf_write_column(sb, col, '\\');
-			strbuf_addch(sb, ' ');
-			chars_written += 2;
+			graph_line_write_column(line, col, '\\');
+			graph_line_addch(line, ' ');
 		} else {
-			strbuf_write_column(sb, col, '|');
-			strbuf_addch(sb, ' ');
-			chars_written += 2;
+			graph_line_write_column(line, col, '|');
+			graph_line_addch(line, ' ');
 		}
 	}
 
-	graph_pad_horizontally(graph, sb, chars_written);
+	graph_pad_horizontally(graph, line);
 
 	/*
 	 * Update graph->state
@@ -1049,7 +1054,7 @@ static void graph_output_post_merge_line(struct git_graph *graph, struct strbuf
 		graph_update_state(graph, GRAPH_COLLAPSING);
 }
 
-static void graph_output_collapsing_line(struct git_graph *graph, struct strbuf *sb)
+static void graph_output_collapsing_line(struct git_graph *graph, struct graph_line *line)
 {
 	int i;
 	short used_horizontal = 0;
@@ -1159,9 +1164,9 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct strbuf
 	for (i = 0; i < graph->mapping_size; i++) {
 		int target = graph->new_mapping[i];
 		if (target < 0)
-			strbuf_addch(sb, ' ');
+			graph_line_addch(line, ' ');
 		else if (target * 2 == i)
-			strbuf_write_column(sb, &graph->new_columns[target], '|');
+			graph_line_write_column(line, &graph->new_columns[target], '|');
 		else if (target == horizontal_edge_target &&
 			 i != horizontal_edge - 1) {
 				/*
@@ -1172,16 +1177,16 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct strbuf
 				if (i != (target * 2)+3)
 					graph->new_mapping[i] = -1;
 				used_horizontal = 1;
-			strbuf_write_column(sb, &graph->new_columns[target], '_');
+			graph_line_write_column(line, &graph->new_columns[target], '_');
 		} else {
 			if (used_horizontal && i < horizontal_edge)
 				graph->new_mapping[i] = -1;
-			strbuf_write_column(sb, &graph->new_columns[target], '/');
+			graph_line_write_column(line, &graph->new_columns[target], '/');
 
 		}
 	}
 
-	graph_pad_horizontally(graph, sb, graph->mapping_size);
+	graph_pad_horizontally(graph, line);
 
 	/*
 	 * Swap mapping and new_mapping
@@ -1199,24 +1204,26 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct strbuf
 
 int graph_next_line(struct git_graph *graph, struct strbuf *sb)
 {
+	struct graph_line line = { .buf = sb, .width = 0 };
+
 	switch (graph->state) {
 	case GRAPH_PADDING:
-		graph_output_padding_line(graph, sb);
+		graph_output_padding_line(graph, &line);
 		return 0;
 	case GRAPH_SKIP:
-		graph_output_skip_line(graph, sb);
+		graph_output_skip_line(graph, &line);
 		return 0;
 	case GRAPH_PRE_COMMIT:
-		graph_output_pre_commit_line(graph, sb);
+		graph_output_pre_commit_line(graph, &line);
 		return 0;
 	case GRAPH_COMMIT:
-		graph_output_commit_line(graph, sb);
+		graph_output_commit_line(graph, &line);
 		return 1;
 	case GRAPH_POST_MERGE:
-		graph_output_post_merge_line(graph, sb);
+		graph_output_post_merge_line(graph, &line);
 		return 0;
 	case GRAPH_COLLAPSING:
-		graph_output_collapsing_line(graph, sb);
+		graph_output_collapsing_line(graph, &line);
 		return 0;
 	}
 
@@ -1227,7 +1234,7 @@ int graph_next_line(struct git_graph *graph, struct strbuf *sb)
 static void graph_padding_line(struct git_graph *graph, struct strbuf *sb)
 {
 	int i;
-	int chars_written = 0;
+	struct graph_line line = { .buf = sb, .width = 0 };
 
 	if (graph->state != GRAPH_COMMIT) {
 		graph_next_line(graph, sb);
@@ -1244,20 +1251,17 @@ static void graph_padding_line(struct git_graph *graph, struct strbuf *sb)
 	for (i = 0; i < graph->num_columns; i++) {
 		struct column *col = &graph->columns[i];
 
-		strbuf_write_column(sb, col, '|');
-		chars_written++;
+		graph_line_write_column(&line, col, '|');
 
 		if (col->commit == graph->commit && graph->num_parents > 2) {
 			int len = (graph->num_parents - 2) * 2;
-			strbuf_addchars(sb, ' ', len);
-			chars_written += len;
+			graph_line_addchars(&line, ' ', len);
 		} else {
-			strbuf_addch(sb, ' ');
-			chars_written++;
+			graph_line_addch(&line, ' ');
 		}
 	}
 
-	graph_pad_horizontally(graph, sb, chars_written);
+	graph_pad_horizontally(graph, &line);
 
 	/*
 	 * Update graph->prev_state since we have output a padding line
-- 
gitgitgadget

