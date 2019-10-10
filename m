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
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CC701F4BD
	for <e@80x24.org>; Thu, 10 Oct 2019 16:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbfJJQNs (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 12:13:48 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40230 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbfJJQNr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Oct 2019 12:13:47 -0400
Received: by mail-wr1-f65.google.com with SMTP id h4so8632768wrv.7
        for <git@vger.kernel.org>; Thu, 10 Oct 2019 09:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JCfRjhthfzXV4LQDK1+KzKfPOY0ZXJPV8sfl7ftyaoE=;
        b=Ra8/Q8psq2XkQXBWXEL97TB3jqbvalEVs+n5P0W7QDEN5FxJ/ndqGT/8Jrgsc7MRSS
         KY9q5MrCmnLDWTk+A98hKg0FngY9dnuDNJaEPgZBJShxCooj1nhHdsV1+p3x3tLfcWXH
         94Vq8oDHQI8oT59LN6qaG3JpoG/qLAgLAa7hTagfyD0cNh4eHUTq5h9kmWXtpmwlW9tx
         nDULraoTaIn08gaFyV7FWC8rPFz5Q4PV4N54VldXaTbpasSs/PVAXiNshLxiQGKPTrmD
         RHJrE4zkkRXS8ZDzHH0d3Rc21rfJUvm0nmR+cLNeN9jMM023HgT2gwJbw1WzvmpWshYS
         +zDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JCfRjhthfzXV4LQDK1+KzKfPOY0ZXJPV8sfl7ftyaoE=;
        b=VmjVEj/KwN90QvKf4miCTFs53MwhrXhTacPZz/y7AVRpY/Kv0VaFf+hBaEnGhMh1fo
         SlrSZghJfsa5FRgvbTDDS5j3c7SRTBf/1Gn8VVwCNG4TT9BYz3fQtYrEvSt3YnODHq6m
         t53OIoDs1pVoAOXaaLZyRMR4NUgsTdY8uCwTxgxBTuvj/oDaGmx98NP1R3/5L3TmvL26
         DBwHEpMTV4UZQtooxgp13oDqlaEBnE0MBPwUzF7ZnN2UaO52QAcCZgZZKTvVATziVFZ3
         WvPwjCReG+GTi4Jnllx/KISzRxICxm6BOsebi9eG+ZbMahk+p8yA6W4fYvD8oCxXquoi
         utBg==
X-Gm-Message-State: APjAAAUjFrqn5jmCgoeGH50xyC/y6dtg0CsgYiPyy8nL3m1/osJauUfx
        zM3QZzQDmwE29D7+FXb+39zrG74g
X-Google-Smtp-Source: APXvYqxgJpvUSySiYlMYx6cGkz3z4vwDm2gk6iUiXxMoJLhFBnU7VIfRvQtAvHYsGf3nY1vsfqo+/w==
X-Received: by 2002:a5d:6592:: with SMTP id q18mr9912768wru.382.1570724024949;
        Thu, 10 Oct 2019 09:13:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a2sm9887455wrt.45.2019.10.10.09.13.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 09:13:44 -0700 (PDT)
Date:   Thu, 10 Oct 2019 09:13:44 -0700 (PDT)
X-Google-Original-Date: Thu, 10 Oct 2019 16:13:31 GMT
Message-Id: <a1305741916f03f0cacf4f617ac8a76fd92b9240.1570724021.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.383.git.gitgitgadget@gmail.com>
References: <pull.383.git.gitgitgadget@gmail.com>
From:   "James Coglan via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 02/11] graph: reuse `find_new_column_by_commit()`
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

I will shortly be making some changes to
`graph_insert_into_new_columns()` and so am trying to simplify it. One
possible simplification is that we can extract the loop for finding the
element in `new_columns` containing the given commit.

`find_new_column_by_commit()` contains a very similar loop but it
returns a `struct column *` rather than an `int` offset into the array.
Here I'm introducing a version that returns `int` and using that in
`graph_insert_into_new_columns()` and `graph_output_post_merge_line()`.

Signed-off-by: James Coglan <jcoglan@gmail.com>
---
 graph.c | 48 +++++++++++++++++++++++-------------------------
 1 file changed, 23 insertions(+), 25 deletions(-)

diff --git a/graph.c b/graph.c
index c56fdec1fc..a890c9d8bb 100644
--- a/graph.c
+++ b/graph.c
@@ -441,22 +441,31 @@ static unsigned short graph_find_commit_color(const struct git_graph *graph,
 	return graph_get_current_column_color(graph);
 }
 
+static int graph_find_new_column_by_commit(struct git_graph *graph,
+					   struct commit *commit)
+{
+	int i;
+	for (i = 0; i < graph->num_new_columns; i++) {
+		if (graph->new_columns[i].commit == commit)
+			return i;
+	}
+	return -1;
+}
+
 static void graph_insert_into_new_columns(struct git_graph *graph,
 					  struct commit *commit,
 					  int *mapping_index)
 {
-	int i;
+	int i = graph_find_new_column_by_commit(graph, commit);
 
 	/*
 	 * If the commit is already in the new_columns list, we don't need to
 	 * add it.  Just update the mapping correctly.
 	 */
-	for (i = 0; i < graph->num_new_columns; i++) {
-		if (graph->new_columns[i].commit == commit) {
-			graph->mapping[*mapping_index] = i;
-			*mapping_index += 2;
-			return;
-		}
+	if (i >= 0) {
+		graph->mapping[*mapping_index] = i;
+		*mapping_index += 2;
+		return;
 	}
 
 	/*
@@ -961,17 +970,6 @@ static void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
 		graph_update_state(graph, GRAPH_COLLAPSING);
 }
 
-static struct column *find_new_column_by_commit(struct git_graph *graph,
-						struct commit *commit)
-{
-	int i;
-	for (i = 0; i < graph->num_new_columns; i++) {
-		if (graph->new_columns[i].commit == commit)
-			return &graph->new_columns[i];
-	}
-	return NULL;
-}
-
 static void graph_output_post_merge_line(struct git_graph *graph, struct strbuf *sb)
 {
 	int seen_this = 0;
@@ -999,20 +997,20 @@ static void graph_output_post_merge_line(struct git_graph *graph, struct strbuf
 			 * edges.
 			 */
 			struct commit_list *parents = NULL;
-			struct column *par_column;
+			int par_column;
 			seen_this = 1;
 			parents = first_interesting_parent(graph);
 			assert(parents);
-			par_column = find_new_column_by_commit(graph, parents->item);
-			assert(par_column);
+			par_column = graph_find_new_column_by_commit(graph, parents->item);
+			assert(par_column >= 0);
 
-			strbuf_write_column(sb, par_column, '|');
+			strbuf_write_column(sb, &graph->new_columns[par_column], '|');
 			for (j = 0; j < graph->num_parents - 1; j++) {
 				parents = next_interesting_parent(graph, parents);
 				assert(parents);
-				par_column = find_new_column_by_commit(graph, parents->item);
-				assert(par_column);
-				strbuf_write_column(sb, par_column, '\\');
+				par_column = graph_find_new_column_by_commit(graph, parents->item);
+				assert(par_column >= 0);
+				strbuf_write_column(sb, &graph->new_columns[par_column], '\\');
 				strbuf_addch(sb, ' ');
 			}
 		} else if (seen_this) {
-- 
gitgitgadget

