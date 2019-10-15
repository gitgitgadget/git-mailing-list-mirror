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
	by dcvr.yhbt.net (Postfix) with ESMTP id 761B51F4C1
	for <e@80x24.org>; Tue, 15 Oct 2019 23:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbfJOXlL (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 19:41:11 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:38513 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbfJOXlK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 19:41:10 -0400
Received: by mail-wr1-f46.google.com with SMTP id y18so16348297wrn.5
        for <git@vger.kernel.org>; Tue, 15 Oct 2019 16:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XBLSeEbCZJi3a97YnUR8SrXveD2f/uZSt7006TnKdzY=;
        b=tB3DEEdcFAWY2zsmBOvRVf6NWbGx5fQENUen5Iq8hYHEA5TdKz50gUo//nn85S1DiV
         QfSfdqBZXAYDPQklbNv9+6FoNQPhGcZWW9YoEA6G+MTBm6ewAFwXhFPX3TTGYUcE4cCO
         nt4Cy208FAsNUYIIRIlGObdMRGfy3DCdGU55BK2yLgxM38I2UsWyCh9tcecEIoQ8NBGn
         L7RS3ufjLqKiHOmfW9GFjouBRRx3Bkv3M7n3xFwsBrv9v4lCDJ6P0iuQAwXwC/tlcMr9
         y+Oj/6jM0RpXBWl7cstgkMFlWmuTkIu8mzCPB01lO3alvZzGgUK2tjDU+FER2Gvy+gj+
         18Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XBLSeEbCZJi3a97YnUR8SrXveD2f/uZSt7006TnKdzY=;
        b=nQ/CCBPFcatkqJ2EU9OXpSAKNfCE5a9net/ZcGC8wI9J8+UvbqBeTdb3njBEtHLcqW
         O9xpIJELv9stUvtFQlzkAdvuGHkjt5roti2HKTpBjO18U0YG7f+Bjiq4axyPwHvK06Jm
         CCaUHDwwbMH9ZXaio2CXZUHFaymJhCxOMvMf255csR5gW8RzoFm2OKqYFFN8ScgpTltJ
         C9wiUcCRHzOReTELqpDJbKL9szXYtHgUdUE1C2uoqM9Sz8qfYXiUYzgMzBixpoUk6chB
         tBA4E8MYII1mwyh//brtgdL4JJ2auolefzxYReOwAA9NVErc7zCpTzHCrUdNn33wxT3f
         pX9Q==
X-Gm-Message-State: APjAAAVESg9JvOv0QW7Vp6Id2XK8ZAGVX7qM/wLjBGnhElyEP1aQSr8B
        ZS361HgjAQ1C3AhFbAUdLPLkFec6
X-Google-Smtp-Source: APXvYqyxuVyk2P859DYDU5+NpeG6wHXh1U99epb7ETX34ubyDg4UZhEVH2JWzPPZTmUZPguktS1dZg==
X-Received: by 2002:a5d:6ac3:: with SMTP id u3mr1998wrw.206.1571182867840;
        Tue, 15 Oct 2019 16:41:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b144sm774921wmb.3.2019.10.15.16.41.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 16:41:07 -0700 (PDT)
Message-Id: <d962eb2e029fcee66dd25a59746d36cf953d2a2e.1571182864.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.383.v2.git.1571182864.gitgitgadget@gmail.com>
References: <pull.383.git.gitgitgadget@gmail.com>
        <pull.383.v2.git.1571182864.gitgitgadget@gmail.com>
From:   "James Coglan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Oct 2019 23:40:53 +0000
Subject: [PATCH v2 02/13] graph: handle line padding in `graph_next_line()`
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

Now that the display width of graph lines is implicitly tracked via the
`graph_line` interface, the calls to `graph_pad_horizontally()` no
longer need to be located inside the individual output functions, where
the character counting was previously being done.

All the functions called by `graph_next_line()` generate a line of
output, then call `graph_pad_horizontally()`, and finally change the
graph state if necessary. As padding is the final change to the output
done by all these functions, it can be removed from all of them and done
in `graph_next_line()` instead.

I've also moved the guard in `graph_output_padding_line()` that checks
the graph has a commit; this function is only called by
`graph_next_line()` and we must not pad the `graph_line` if no commit is
set.
---
 graph.c | 49 ++++++++++++++++++++-----------------------------
 1 file changed, 20 insertions(+), 29 deletions(-)

diff --git a/graph.c b/graph.c
index 2f81a5d23d..4c68557b17 100644
--- a/graph.c
+++ b/graph.c
@@ -732,16 +732,6 @@ static void graph_output_padding_line(struct git_graph *graph,
 {
 	int i;
 
-	/*
-	 * We could conceivable be called with a NULL commit
-	 * if our caller has a bug, and invokes graph_next_line()
-	 * immediately after graph_init(), without first calling
-	 * graph_update().  Return without outputting anything in this
-	 * case.
-	 */
-	if (!graph->commit)
-		return;
-
 	/*
 	 * Output a padding row, that leaves all branch lines unchanged
 	 */
@@ -749,8 +739,6 @@ static void graph_output_padding_line(struct git_graph *graph,
 		graph_line_write_column(line, &graph->new_columns[i], '|');
 		graph_line_addch(line, ' ');
 	}
-
-	graph_pad_horizontally(graph, line);
 }
 
 
@@ -767,7 +755,6 @@ static void graph_output_skip_line(struct git_graph *graph, struct graph_line *l
 	 * of the graph is missing.
 	 */
 	graph_line_addstr(line, "...");
-	graph_pad_horizontally(graph, line);
 
 	if (graph->num_parents >= 3 &&
 	    graph->commit_index < (graph->num_columns - 1))
@@ -832,8 +819,6 @@ static void graph_output_pre_commit_line(struct git_graph *graph,
 		graph_line_addch(line, ' ');
 	}
 
-	graph_pad_horizontally(graph, line);
-
 	/*
 	 * Increment graph->expansion_row,
 	 * and move to state GRAPH_COMMIT if necessary
@@ -967,8 +952,6 @@ static void graph_output_commit_line(struct git_graph *graph, struct graph_line
 		graph_line_addch(line, ' ');
 	}
 
-	graph_pad_horizontally(graph, line);
-
 	/*
 	 * Update graph->state
 	 */
@@ -1043,8 +1026,6 @@ static void graph_output_post_merge_line(struct git_graph *graph, struct graph_l
 		}
 	}
 
-	graph_pad_horizontally(graph, line);
-
 	/*
 	 * Update graph->state
 	 */
@@ -1186,8 +1167,6 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct graph_l
 		}
 	}
 
-	graph_pad_horizontally(graph, line);
-
 	/*
 	 * Swap mapping and new_mapping
 	 */
@@ -1204,31 +1183,43 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct graph_l
 
 int graph_next_line(struct git_graph *graph, struct strbuf *sb)
 {
+	int shown_commit_line = 0;
 	struct graph_line line = { .buf = sb, .width = 0 };
 
+	/*
+	 * We could conceivable be called with a NULL commit
+	 * if our caller has a bug, and invokes graph_next_line()
+	 * immediately after graph_init(), without first calling
+	 * graph_update().  Return without outputting anything in this
+	 * case.
+	 */
+	if (!graph->commit)
+		return -1;
+
 	switch (graph->state) {
 	case GRAPH_PADDING:
 		graph_output_padding_line(graph, &line);
-		return 0;
+		break;
 	case GRAPH_SKIP:
 		graph_output_skip_line(graph, &line);
-		return 0;
+		break;
 	case GRAPH_PRE_COMMIT:
 		graph_output_pre_commit_line(graph, &line);
-		return 0;
+		break;
 	case GRAPH_COMMIT:
 		graph_output_commit_line(graph, &line);
-		return 1;
+		shown_commit_line = 1;
+		break;
 	case GRAPH_POST_MERGE:
 		graph_output_post_merge_line(graph, &line);
-		return 0;
+		break;
 	case GRAPH_COLLAPSING:
 		graph_output_collapsing_line(graph, &line);
-		return 0;
+		break;
 	}
 
-	assert(0);
-	return 0;
+	graph_pad_horizontally(graph, &line);
+	return shown_commit_line;
 }
 
 static void graph_padding_line(struct git_graph *graph, struct strbuf *sb)
-- 
gitgitgadget

