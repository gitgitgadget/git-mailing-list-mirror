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
	by dcvr.yhbt.net (Postfix) with ESMTP id B4AFA1F4BD
	for <e@80x24.org>; Thu, 10 Oct 2019 16:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfJJQN6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 12:13:58 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:35985 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfJJQN4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Oct 2019 12:13:56 -0400
Received: by mail-wm1-f48.google.com with SMTP id m18so7419506wmc.1
        for <git@vger.kernel.org>; Thu, 10 Oct 2019 09:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IOaD5IHlIM0x+QdzkRgkgP5/vrzTBReoSyidKYaCpnk=;
        b=e7wgc1aNWn68kpcUeLmnnxWLlLEOSb7sOfo11KuSDLDkGWgooADm7F453hdxc0CPC9
         7aFS6FgbolDz51PC5cx3z8EcBzfsFexrQwinwsDXhIgknI94oD7t49E6JsCsuBXAuiBB
         gNKat8kC6eYGmoOt0ySbuXWVXOBpiIPsC6fLzZ9vxh05Nx5AnxSDIZMlSbCOlBGrCLr+
         FZGMsb8MtD/4M9EZY9Up/HJC64CXLtAw/C2AWHn+piQl69hBzF8JYRi3JfmQyGSIJQn7
         CAb7CRPm6wiVl0Lm/YkAAZ/JGQYDoD6lm59KfDjxFKGJ8PVD/e4ywCFC9XP00ONZ4lzC
         suNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IOaD5IHlIM0x+QdzkRgkgP5/vrzTBReoSyidKYaCpnk=;
        b=POFt7t0rTAMEoCzq451Wia9zvThlCuZar28iP2PtgpH06SuKlauQNLEqB6ICNgB6ti
         97IucIAOsQn+6AR3hJwIBEMc3WBb0ZpwXWH1uUA+UXvHp3ppbmiIPPwYytdNzIx3OL5+
         jpTH72lN2HolLLZmeVFUfkoXDHKyp9xfpJWlOVgEJ2DrJ03OBJj4vJL7GeKBgVhbokO1
         mTerVqMaSX6/+l0H60IkXS4bdFSXvlTv6XDa0e+/47Tlm8N4z6uhRgUt/cv5VpSEO3j4
         rdfyI/L4GkOC8bd+Ofpv266nEyFO3ZtBdemIWAeOETMxjGJzlDoYkEEnl7Ay3tR2PbWz
         FHbA==
X-Gm-Message-State: APjAAAWU055nahbvq4EbSRfRRPSF4fO9Odx8TqC0SIVWuSa/STut/5Dq
        HA7I1X1ZWiXlIpbWfypq2F29IwJt
X-Google-Smtp-Source: APXvYqwZWCPbp9sgX/OpnOYNl/C2XOJgoSmLuw5rcH8xX8+4HbZ3HY5n/X0530lLraOsfbCkWT7CGw==
X-Received: by 2002:a1c:2e94:: with SMTP id u142mr8506806wmu.69.1570724033089;
        Thu, 10 Oct 2019 09:13:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e15sm8297397wrt.94.2019.10.10.09.13.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 09:13:52 -0700 (PDT)
Date:   Thu, 10 Oct 2019 09:13:52 -0700 (PDT)
X-Google-Original-Date: Thu, 10 Oct 2019 16:13:40 GMT
Message-Id: <ea0df1d94aa6c42eb00d59b268a90a8724322452.1570724021.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.383.git.gitgitgadget@gmail.com>
References: <pull.383.git.gitgitgadget@gmail.com>
From:   "James Coglan via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 11/11] graph: fix coloring of octopus dashes
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
 t/t4214-log-graph-octopus.sh | 59 ++++++++++++++++++++++++++++--
 2 files changed, 92 insertions(+), 38 deletions(-)

diff --git a/graph.c b/graph.c
index 7dd2fab625..908f257018 100644
--- a/graph.c
+++ b/graph.c
@@ -665,6 +665,11 @@ static void graph_update_columns(struct git_graph *graph)
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
@@ -687,7 +692,7 @@ static int graph_num_expansion_rows(struct git_graph *graph)
 	 * 		| * \
 	 * 		|/|\ \
 	 */
-	return (graph->num_parents + graph->merge_layout - 3) * 2;
+	return graph_num_dashed_parents(graph) * 2;
 }
 
 static int graph_needs_pre_commit_line(struct git_graph *graph)
@@ -930,47 +935,45 @@ static void graph_output_commit_char(struct git_graph *graph, struct strbuf *sb)
 static void graph_draw_octopus_merge(struct git_graph *graph, struct strbuf *sb)
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
-		strbuf_write_column(sb, &graph->new_columns[i+first_col], '-');
-		strbuf_write_column(sb, &graph->new_columns[i+first_col],
-				    i == dashful_parents-1 ? '.' : '-');
+	int dashed_parents = graph_num_dashed_parents(graph);
+
+	for (i = 0; i < dashed_parents; i++) {
+		j = graph->mapping[(graph->commit_index + i + 2) * 2];
+		col = &graph->new_columns[j];
+
+		strbuf_write_column(sb, col, '-');
+		strbuf_write_column(sb, col, (i == dashed_parents - 1) ? '.' : '-');
 	}
+
+	return;
 }
 
 static void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
diff --git a/t/t4214-log-graph-octopus.sh b/t/t4214-log-graph-octopus.sh
index 9ada687628..fbd485d83a 100755
--- a/t/t4214-log-graph-octopus.sh
+++ b/t/t4214-log-graph-octopus.sh
@@ -42,23 +42,74 @@ test_expect_success 'set up merge history' '
 	test_tick &&
 	git merge -m octopus-merge 1 2 3 4 &&
 	git checkout 1 -b L &&
-	test_commit left
+	test_commit left &&
+	git checkout 4 -b R &&
+	test_commit right
 '
 
 test_expect_success 'log --graph with tricky octopus merge with colors' '
 	test_config log.graphColors red,green,yellow,blue,magenta,cyan &&
-	git log --color=always --graph --date-order --pretty=tformat:%s --all >actual.colors.raw &&
+	git log --color=always --graph --date-order --pretty=tformat:%s L merge >actual.colors.raw &&
 	test_decode_color <actual.colors.raw | sed "s/ *\$//" >actual.colors &&
 	test_cmp expect.colors actual.colors
 '
 
 test_expect_success 'log --graph with tricky octopus merge, no color' '
-	git log --color=never --graph --date-order --pretty=tformat:%s --all >actual.raw &&
+	git log --color=never --graph --date-order --pretty=tformat:%s L merge >actual.raw &&
 	sed "s/ *\$//" actual.raw >actual &&
 	test_cmp expect.uncolored actual
 '
 
-# Repeat the previous two tests with "normal" octopus merge (i.e.,
+# Repeat the previous two tests with an octopus merge whose final parent skews left
+
+test_expect_success 'log --graph with left-skewed final parent, no color' '
+	cat >expect.uncolored <<-\EOF &&
+	* right
+	| *---.   octopus-merge
+	| |\ \ \
+	| |_|_|/
+	|/| | |
+	* | | | 4
+	| | | * 3
+	| |_|/
+	|/| |
+	| | * 2
+	| |/
+	|/|
+	| * 1
+	|/
+	* initial
+	EOF
+	git log --color=never --graph --date-order --pretty=tformat:%s R merge >actual.raw &&
+	sed "s/ *\$//" actual.raw >actual &&
+	test_cmp expect.uncolored actual
+'
+
+test_expect_success 'log --graph with left-skewed final parent with colors' '
+	cat >expect.colors <<-\EOF &&
+	* right
+	<RED>|<RESET> *<BLUE>-<RESET><BLUE>-<RESET><RED>-<RESET><RED>.<RESET>   octopus-merge
+	<RED>|<RESET> <GREEN>|<RESET><YELLOW>\<RESET> <BLUE>\<RESET> <RED>\<RESET>
+	<RED>|<RESET> <GREEN>|<RESET><RED>_<RESET><YELLOW>|<RESET><RED>_<RESET><BLUE>|<RESET><RED>/<RESET>
+	<RED>|<RESET><RED>/<RESET><GREEN>|<RESET> <YELLOW>|<RESET> <BLUE>|<RESET>
+	* <GREEN>|<RESET> <YELLOW>|<RESET> <BLUE>|<RESET> 4
+	<MAGENTA>|<RESET> <GREEN>|<RESET> <YELLOW>|<RESET> * 3
+	<MAGENTA>|<RESET> <GREEN>|<RESET><MAGENTA>_<RESET><YELLOW>|<RESET><MAGENTA>/<RESET>
+	<MAGENTA>|<RESET><MAGENTA>/<RESET><GREEN>|<RESET> <YELLOW>|<RESET>
+	<MAGENTA>|<RESET> <GREEN>|<RESET> * 2
+	<MAGENTA>|<RESET> <GREEN>|<RESET><MAGENTA>/<RESET>
+	<MAGENTA>|<RESET><MAGENTA>/<RESET><GREEN>|<RESET>
+	<MAGENTA>|<RESET> * 1
+	<MAGENTA>|<RESET><MAGENTA>/<RESET>
+	* initial
+	EOF
+	test_config log.graphColors red,green,yellow,blue,magenta,cyan &&
+	git log --color=always --graph --date-order --pretty=tformat:%s R merge >actual.colors.raw &&
+	test_decode_color <actual.colors.raw | sed "s/ *\$//" >actual.colors &&
+	test_cmp expect.colors actual.colors
+'
+
+# Repeat the first two tests with "normal" octopus merge (i.e.,
 # without the first parent skewing to the "left" branch column).
 
 test_expect_success 'log --graph with normal octopus merge, no color' '
-- 
gitgitgadget
