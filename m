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
	by dcvr.yhbt.net (Postfix) with ESMTP id 6857B1F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 23:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387897AbfJOXsG (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 19:48:06 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40093 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727439AbfJOXsG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 19:48:06 -0400
Received: by mail-wm1-f65.google.com with SMTP id b24so748019wmj.5
        for <git@vger.kernel.org>; Tue, 15 Oct 2019 16:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HXmfTzuGDcxSZRem1KTJTPVU/hP7EWsRKyXZZcwlY/4=;
        b=OjQzIZGRT4FBU2ybGHX046Nwj5dA/SkrkDoLvpyr/QqhbZlhiAUj+iSAlhL733SfQq
         YWlCML//BfnG7ZXfPwCXIF/GQabvSd2NE7ogZqE8zCRMTLC1OLwr0XHXFLPj6rhZeyOL
         +zI0/HdC037gvr+qWxIJMBkK3D72F85sVXkLz2q8nNifLfhFE+cQFqoP6sMHO7HnZXC8
         eELTMfscVcn7wGuc0UiByu5I80DuhPPTEwlw0fc8nS0sK5ax2du6gSotK0OI3Df5oiux
         0I8d0E5mBl3MnnpMU1Rn8JCvaMT4rK1DTrH/v0vh7VdKtltqaXjnlzEgq6xxrsF/y5Rr
         bOgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HXmfTzuGDcxSZRem1KTJTPVU/hP7EWsRKyXZZcwlY/4=;
        b=DQqNkKtmGLWMz07F6t8aWeguBDKsSfS36w1TYK9uIqG86SAkktI8Pa0NSGXIEPHzNk
         gO3Kv9Q54gDCxi7ooM49SqJZ8eeKM+6zfLli42uoDf4zyg8bTcoCAKFd6J9bsgQZXHWs
         XZAxWVuTgUOgiEGtkRNQ34/ADKnvvnGeoyyeR4sQhmGwVFKrDF7jKRt1gmYD8SDjqBtk
         lTlc9xAe5K5aiSMgu6aZktSMbtk1PXkqB0dAYxSPTYVq2TcPo18Bcvw9TXYG6KvFAEFa
         R9HwcSqAU+GjEtVlp0oZH9GKlPUSLz+LHExFWdAPCTiSNnnFsZ3DAoVg1X8SJKA4yBzQ
         cqhA==
X-Gm-Message-State: APjAAAUePityzK2XsSkceNk8Dy4Dgp29vmRa4GrUHEWSYYj+/+RNb9y9
        0Glm9RaM50yC6VAeEFUkJKgKeIxO
X-Google-Smtp-Source: APXvYqwro1yj0UXhnnTZZgskZzu1Z9WLI3aTBOezxyPCUr6o7aeqpF/QQPJdrOEqF62qDxG+cf4L7A==
X-Received: by 2002:a1c:ed0d:: with SMTP id l13mr831707wmh.54.1571183283947;
        Tue, 15 Oct 2019 16:48:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 36sm30766308wrp.30.2019.10.15.16.48.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 16:48:03 -0700 (PDT)
Message-Id: <376236ab0bc0f4b3711c994f2e0029f50899edf1.1571183279.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.383.v3.git.1571183279.gitgitgadget@gmail.com>
References: <pull.383.v2.git.1571182864.gitgitgadget@gmail.com>
        <pull.383.v3.git.1571183279.gitgitgadget@gmail.com>
From:   "James Coglan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Oct 2019 23:47:49 +0000
Subject: [PATCH v3 03/13] graph: reuse `find_new_column_by_commit()`
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
index 4c68557b17..c9646d9e00 100644
--- a/graph.c
+++ b/graph.c
@@ -460,22 +460,31 @@ static unsigned short graph_find_commit_color(const struct git_graph *graph,
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
@@ -963,17 +972,6 @@ static void graph_output_commit_line(struct git_graph *graph, struct graph_line
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
 static void graph_output_post_merge_line(struct git_graph *graph, struct graph_line *line)
 {
 	int seen_this = 0;
@@ -1001,20 +999,20 @@ static void graph_output_post_merge_line(struct git_graph *graph, struct graph_l
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
 
-			graph_line_write_column(line, par_column, '|');
+			graph_line_write_column(line, &graph->new_columns[par_column], '|');
 			for (j = 0; j < graph->num_parents - 1; j++) {
 				parents = next_interesting_parent(graph, parents);
 				assert(parents);
-				par_column = find_new_column_by_commit(graph, parents->item);
-				assert(par_column);
-				graph_line_write_column(line, par_column, '\\');
+				par_column = graph_find_new_column_by_commit(graph, parents->item);
+				assert(par_column >= 0);
+				graph_line_write_column(line, &graph->new_columns[par_column], '\\');
 				graph_line_addch(line, ' ');
 			}
 		} else if (seen_this) {
-- 
gitgitgadget

