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
	by dcvr.yhbt.net (Postfix) with ESMTP id B3A031F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 23:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387942AbfJOXsG (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 19:48:06 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33383 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729074AbfJOXsG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 19:48:06 -0400
Received: by mail-wm1-f65.google.com with SMTP id r17so3403129wme.0
        for <git@vger.kernel.org>; Tue, 15 Oct 2019 16:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zBe+Lml+w9LO2UQGup5++n8QfyXlenUM9LuYZGGGSJ8=;
        b=Hos4TR41rYk0WLQ2WKYmrMpQta3NR62Umw9s9C4X77vW2B+Ixskufi5aqkhhSJMZFd
         kV04+SlGvVllttcIfwcOtca6v3f2u0/DviJ9Zp5JcdEF2ZmUHUAp2S2lnQTIsQ5aKr46
         uqcrAHW1CbQk7AZMUiYcr/Rojc8jmgS8d3m4GBow/vJAozz0aeQDaCu0aLSoffORuYAf
         242LKQ/BfeBalkdoHANl6VDrUJGLFqUIrgKaMyU4ZMpb/KqlvuubiyQF2bdw+qFx14d1
         HO6f1w+F+Z7KtjgcItV0GPcma+oWVukfxM0kO83bG1u8Ru7Nm6DPWZOHTkAhP7RQ5pUY
         yZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zBe+Lml+w9LO2UQGup5++n8QfyXlenUM9LuYZGGGSJ8=;
        b=mvsLaudjaURzenaU2UWuJv+ms7wv2+SzekWPxf8kYWqLXMqZ3p8g8YYxmfPJ+Uj9t1
         B3LKKg0h5PB8sgOLuLpFlcoYC9rd5Hb25sKG+eSozduQr/2jUJ34TnwPlcWCdQ9IkClF
         KiDNsCF3rTOW0TD9Gis4YROPxrErPeBkYgydplPedJcvzkd7iy+tDvn5oixFjwOwH4nT
         ickn3C6sBHO+fN7+mqS+x3sFsW876cDL7sbyGG6o+Kw0D6UQSNT1Hhw9B372ZS72rNY8
         00ShSg1CoZ9yi0KZ2yr1WuAu2UbE0oFblzg8eQG2euwsXKIiIh/jYHwhEeXiItrcxus6
         wbEA==
X-Gm-Message-State: APjAAAWG/5Ly/LU8TgG4kcU/pX3weGDCMB+WadBqM3IA4opOQaL1EE0q
        cdImcF+HfOlKW4G/89MKEWcF/A+U
X-Google-Smtp-Source: APXvYqw1C7TMPB3riYPC7VUjv/HuaKURCyeSQZqhjNaBLgiIIJC9I6WpDH6IpmD8PTrNGiDLMLMHLw==
X-Received: by 2002:a1c:6709:: with SMTP id b9mr902752wmc.14.1571183282955;
        Tue, 15 Oct 2019 16:48:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s9sm763725wme.36.2019.10.15.16.48.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 16:48:02 -0700 (PDT)
Message-Id: <056c95d4edc8748c513db8c159c5e3d347ffc894.1571183279.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.383.v3.git.1571183279.gitgitgadget@gmail.com>
References: <pull.383.v2.git.1571182864.gitgitgadget@gmail.com>
        <pull.383.v3.git.1571183279.gitgitgadget@gmail.com>
From:   "James Coglan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Oct 2019 23:47:48 +0000
Subject: [PATCH v3 02/13] graph: handle line padding in `graph_next_line()`
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

Signed-off-by: James Coglan <jcoglan@gmail.com>
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

