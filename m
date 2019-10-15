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
	by dcvr.yhbt.net (Postfix) with ESMTP id 270541F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 23:48:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388179AbfJOXsL (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 19:48:11 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38027 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387977AbfJOXsK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 19:48:10 -0400
Received: by mail-wm1-f67.google.com with SMTP id 3so760371wmi.3
        for <git@vger.kernel.org>; Tue, 15 Oct 2019 16:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6e9aX7IEwCjnBgusYHs0U9RPMTaHhSHiWahJ3XWTD2k=;
        b=Tqyv1HTFtlvBWFApIE+a5Ya9TSdAKjAW77l8QxvrjV6h/oqt4PyOKqY2slk97YMNbz
         9AMC5L3m2Qk8kbb7dZjDd4YMvD+HVfPL+rvY+Fyutcfb/itL9FfsoJNgULBPKPRBZBeH
         CmwrFg8WAkPObLdQgrhkvWdyjsGbf1NYvkqxkgXlSAN8dCMU0Hy7Px8Mk3LgX6Wj8+LT
         00b/1onYLeL8ay/1SrmPupdTqN1mCL6TqbXuUUhjWoly2VAbKycmEtQ5Al+Ys+j1RE8p
         ZTRMpJUYCkD5Lzp0ltRcNlKfYEyLRRWt/hNMSIP95kkbx6Sxrkse7IlPzZMHQzFaRcWl
         1C2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6e9aX7IEwCjnBgusYHs0U9RPMTaHhSHiWahJ3XWTD2k=;
        b=f89k8xcru11j+xglcnkiR37SqaihF42QFkFoB4B1O+7yNe6cd2OTYj93U5V/q0+Or8
         EUjqgHwS991xcEnj7NinSXCyrzVO8Qqojy5/smZY3dyb01XyfdVGFhIjNkRZqGUdMQ1v
         TI6Lhmpagm54VrzANlsNsr2KIoqCJ6aBG1GBEtQd0Nmg13EtPLG7aFa7f+OnjyTjLDQA
         VdxFTei3sfrmaxoKljRDV7KfuDJ+/VmN+YytZIBD8aBoAZJO062gCcTayGuq5cPdbESi
         PemxIVRFTrBUhh5JZiLfWp7HNLfwiHRThbs1n5GxZczP5t9aATRZuruz2JAtRPToTtuf
         8aQA==
X-Gm-Message-State: APjAAAXbreJF760bfNCS2q82wFipyGdhqXfz/SX1Xe97WQ2tf52krX+E
        gSMVAhY8e8L6/I2mmJbI43AG+UAq
X-Google-Smtp-Source: APXvYqwHrREPMPwbaOaTAv6mfbXJaK9tZAVOM7pm8rbDboxbm+FZZC3bp0fSz3PlKio+oyZsyk95Hg==
X-Received: by 2002:a1c:1d15:: with SMTP id d21mr749477wmd.5.1571183286613;
        Tue, 15 Oct 2019 16:48:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b5sm609983wmj.18.2019.10.15.16.48.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 16:48:06 -0700 (PDT)
Message-Id: <8ed32b1c743282716bd2bc1f2ce19218119629d9.1571183279.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.383.v3.git.1571183279.gitgitgadget@gmail.com>
References: <pull.383.v2.git.1571182864.gitgitgadget@gmail.com>
        <pull.383.v3.git.1571183279.gitgitgadget@gmail.com>
From:   "James Coglan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Oct 2019 23:47:52 +0000
Subject: [PATCH v3 06/13] graph: extract logic for moving to GRAPH_PRE_COMMIT
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

