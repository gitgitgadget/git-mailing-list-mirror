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
	by dcvr.yhbt.net (Postfix) with ESMTP id 140951F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 23:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388022AbfJOXlN (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 19:41:13 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37828 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387879AbfJOXlM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 19:41:12 -0400
Received: by mail-wr1-f66.google.com with SMTP id p14so25786417wro.4
        for <git@vger.kernel.org>; Tue, 15 Oct 2019 16:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6e9aX7IEwCjnBgusYHs0U9RPMTaHhSHiWahJ3XWTD2k=;
        b=HtpHUOpFQ+orXgeoQGIkrMw2H9mA3qcu+WX/g2ZTGozloqKQU4zyLpwu4I6N/M75Xc
         zX6qcQlCclax69evOH1cYCGify654Q66CyjEfuKaUTfAmogUGZKopvaJ3ateFfOp+PDc
         kOdGBvYR5Cq8nT2aEsKNvGoNkj5U26A/fdsa2ZlsbS0aeZI8O9/K/rqMrW1k6h/Ji/Gu
         xZIv38LU2ASJ1bpnL7dJ1SczszVnGts2sOit8bPp/NEvQEfk0mjeGGyZd70TlD4liQec
         nJnOgAo+dJRSjKev9ufEx+QuE+oGiVg3bdIs21R8ZokHkqRljXfmei0r5MrvwmKTSrSi
         5UkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6e9aX7IEwCjnBgusYHs0U9RPMTaHhSHiWahJ3XWTD2k=;
        b=PFYxsT5atxqjn5/ltn1+wX3UIsBr83dzvMjggNIWZsheMKW6vYLl1Qze3lo06ro3pX
         gPcbITAa+zGkyx43jwl8JMzVCqH6b7g/24geM9VPF8Lo/1G1b1q9aW+zw+qqhAGtWrC1
         gYyBzU1yzQKkb69AhBC+8tEFcPykZPQyecWVE0GzL0L6kU+vI3c0VQaZD9y2uwVzRCE4
         0gxlqiCA8J5kIyU5Y1iVDxmzPdbuSumxR06HtW1AcHG/AmZUB1mmgNBvtAAVD3zKYSHQ
         fQ3SWLXkm0mBZzaMdRNYQognRS9nwzSexOvCjGj3HUwd85dtxAw0RC5pzf/F92sw4RXr
         vIKA==
X-Gm-Message-State: APjAAAVh7BjXKiiq9EJhQq3NZ1FFFCUfmgw8eP34w7UvdS40WZgXJKM3
        rGP+LcxiqFP2cFzZWigiSBY1UNE1
X-Google-Smtp-Source: APXvYqzSRNP2MyzRPlEydIhmGEwJbfbkkAVjDUa70jWRW2KPPmxYoeo++qxIql/zfG/U76YAs7Rmog==
X-Received: by 2002:adf:e78c:: with SMTP id n12mr21400wrm.351.1571182871126;
        Tue, 15 Oct 2019 16:41:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z9sm25203219wrp.26.2019.10.15.16.41.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 16:41:10 -0700 (PDT)
Message-Id: <163600585c4425d9173faac3a2807088335701c2.1571182864.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.383.v2.git.1571182864.gitgitgadget@gmail.com>
References: <pull.383.git.gitgitgadget@gmail.com>
        <pull.383.v2.git.1571182864.gitgitgadget@gmail.com>
From:   "James Coglan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Oct 2019 23:40:57 +0000
Subject: [PATCH v2 06/13] graph: extract logic for moving to GRAPH_PRE_COMMIT
 state
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

This computation is repeated in a couple of places and I need to add
another condition to it to implement a further improvement to the graph
rendering, so I'm extracting this into a function.

Signed-off-by: James Coglan <jcoglan@gmail.com>
---
 graph.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/graph.c b/graph.c
index d724ef25c3..bd7403065e 100644
--- a/graph.c
+++ b/graph.c
@@ -588,6 +588,12 @@ static void graph_update_columns(struct git_graph *graph)
 		graph->mapping_size--;
 }
 
+static int graph_needs_pre_commit_line(struct git_graph *graph)
+{
+	return graph->num_parents >= 3 &&
+	       graph->commit_index < (graph->num_columns - 1);
+}
+
 void graph_update(struct git_graph *graph, struct commit *commit)
 {
 	struct commit_list *parent;
@@ -643,8 +649,7 @@ void graph_update(struct git_graph *graph, struct commit *commit)
 	 */
 	if (graph->state != GRAPH_PADDING)
 		graph->state = GRAPH_SKIP;
-	else if (graph->num_parents >= 3 &&
-		 graph->commit_index < (graph->num_columns - 1))
+	else if (graph_needs_pre_commit_line(graph))
 		graph->state = GRAPH_PRE_COMMIT;
 	else
 		graph->state = GRAPH_COMMIT;
@@ -714,8 +719,7 @@ static void graph_output_skip_line(struct git_graph *graph, struct graph_line *l
 	 */
 	graph_line_addstr(line, "...");
 
-	if (graph->num_parents >= 3 &&
-	    graph->commit_index < (graph->num_columns - 1))
+	if (graph_needs_pre_commit_line(graph))
 		graph_update_state(graph, GRAPH_PRE_COMMIT);
 	else
 		graph_update_state(graph, GRAPH_COMMIT);
-- 
gitgitgadget

