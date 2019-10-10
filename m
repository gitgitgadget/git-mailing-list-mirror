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
	by dcvr.yhbt.net (Postfix) with ESMTP id 6461A1F4BD
	for <e@80x24.org>; Thu, 10 Oct 2019 16:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbfJJQNv (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 12:13:51 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54567 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbfJJQNt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Oct 2019 12:13:49 -0400
Received: by mail-wm1-f67.google.com with SMTP id p7so7585975wmp.4
        for <git@vger.kernel.org>; Thu, 10 Oct 2019 09:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=i+n1jZ9IWq6XPPmNuBifZlMFmJSg+PMu0QvfLp0lz/U=;
        b=PYLaNmXPczryNJmMf0hSNr1C/a3aAS9V+nootvOsMdqGU0hahZI10ZiMxCXQk8zMEz
         Log43L1rOXqonRYFEqOopJxpZTqrOK3svACY2GykSos1JVHST4r7KakG6B1FS2dpb2Th
         nWK/85l7jI7d3N/QmgCyZ/ED1mDOgObcRi+ObmykZy9/1ePZEFfV50VWphpbqt33KPd5
         y5DsYa5tplfZ1pApf8SSIN2WqUufk5kzrAGYAVIWRFb8gQAcMCry2xNsgoWrFHrzSPwc
         yiFoc9VcXcfCCm1JUCXejYQXssCbWU5LbyVpmAGnExu5meNYc1gL6XcfvA+TlVx5oAI1
         6NYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=i+n1jZ9IWq6XPPmNuBifZlMFmJSg+PMu0QvfLp0lz/U=;
        b=SEHLCquw15T9a9sQal4+P+hows3UjKwBGxJiq7FnaIGJkXAsy/b0spP2uM3lfkprNr
         NcTJ1oc04kWERLn8txroDPbqZ+P8LTjEI/qPnLFXRakvx2owzcd/CpwD/QuZlUiC6IrN
         BgnPjA+NdB5VPlVeyFzANqP+XqpYtpAbI0VlKg8lzNenZ9zySqrhppmZA6y1MiWeck0e
         T2bz2KADrFrXQMZwLGJ/wA/xjleEjt7Q180//gVAZCMNl0rbDCNDbZU2KJ80+dwYdzSo
         ddYG4XNQZ9+wv9aq8lfo302EylHoEE23woePAs870qwDolvYrAcDdQxg/ODhmB5qsiBA
         u+tQ==
X-Gm-Message-State: APjAAAWAiXz6H3SYycWqImfEMNM38bUpQcIXegrc1iu7DWof1D49lvH8
        XsnjPjW9kb6hrRbNlerkfmpTYDKj
X-Google-Smtp-Source: APXvYqwEASdq67akpYN0eFsP9jplqBJHTEfHRwhosYQAvC1Dyq3iSLxcGHlpg9fQ+lqm6gJ9+QNnug==
X-Received: by 2002:a05:600c:143:: with SMTP id w3mr7778405wmm.35.1570724027437;
        Thu, 10 Oct 2019 09:13:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i5sm4460516wmd.21.2019.10.10.09.13.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 09:13:47 -0700 (PDT)
Date:   Thu, 10 Oct 2019 09:13:47 -0700 (PDT)
X-Google-Original-Date: Thu, 10 Oct 2019 16:13:34 GMT
Message-Id: <d5d60ca9a280bb02c09c1e8e13b5b9c185cc09f9.1570724021.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.383.git.gitgitgadget@gmail.com>
References: <pull.383.git.gitgitgadget@gmail.com>
From:   "James Coglan via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 05/11] graph: extract logic for moving to GRAPH_PRE_COMMIT
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
index a71ae5cd61..98e8777db4 100644
--- a/graph.c
+++ b/graph.c
@@ -569,6 +569,12 @@ static void graph_update_columns(struct git_graph *graph)
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
@@ -624,8 +630,7 @@ void graph_update(struct git_graph *graph, struct commit *commit)
 	 */
 	if (graph->state != GRAPH_PADDING)
 		graph->state = GRAPH_SKIP;
-	else if (graph->num_parents >= 3 &&
-		 graph->commit_index < (graph->num_columns - 1))
+	else if (graph_needs_pre_commit_line(graph))
 		graph->state = GRAPH_PRE_COMMIT;
 	else
 		graph->state = GRAPH_COMMIT;
@@ -708,8 +713,7 @@ static void graph_output_skip_line(struct git_graph *graph, struct strbuf *sb)
 	strbuf_addstr(sb, "...");
 	graph_pad_horizontally(graph, sb);
 
-	if (graph->num_parents >= 3 &&
-	    graph->commit_index < (graph->num_columns - 1))
+	if (graph_needs_pre_commit_line(graph))
 		graph_update_state(graph, GRAPH_PRE_COMMIT);
 	else
 		graph_update_state(graph, GRAPH_COMMIT);
-- 
gitgitgadget

