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
	by dcvr.yhbt.net (Postfix) with ESMTP id DD3351F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 23:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388044AbfJOXlN (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 19:41:13 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37825 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729617AbfJOXlN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 19:41:13 -0400
Received: by mail-wr1-f68.google.com with SMTP id p14so25786362wro.4
        for <git@vger.kernel.org>; Tue, 15 Oct 2019 16:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Q7b/i3Xb0kijYWup0bUqi2CCJrfOTxII6ebnsGHNGQ8=;
        b=qgX/w3IqAYi5vZ112Bn47bVliGUYqEKrqrkQ1glGj1aEzINaLDpBukw2mjT4ALpYWL
         sU7HaZGzJst0fVrgeT9ipcpZNIV14hrKy5nYjE03OjHnGWB1q5OJWKhB/Nz8K59SKYyD
         zwgpoJ7cGcTP8dsdn0zw1nD6CvFu3jqQ31O5qV77r5KZGQCmqhG+EeiqYUL+D+ovyZcu
         vU4rDaZ2DEUsgKfYgL/MyoOYbTzmTaqeQEnbJhDSSshkTGgm5QZWIcHkDTdoYglAT0HB
         tZSv9E14EvHOyPakKLeHV7DQzozEwA+0dW1BjCFz8AV2mRCaftfTKJKNpKBZZ5vv17Dt
         5Cvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Q7b/i3Xb0kijYWup0bUqi2CCJrfOTxII6ebnsGHNGQ8=;
        b=jd86SyOqHaCFn1eS8sD8RASzU0kIRm9pHeosNOkaR6TzpL+/J4zBsjA7hKWtoGKHgy
         uKXkTD67UWBjaTj5r+kRxqjj1+u/Lqeuw1ISxQEKHhBZDsICgQaG1oYpLqOpTBois5QW
         iZoS0eym6IV6+4VcICnfDUf09CPIpt/YT/LHaUMB52F2Fkfe/Oj2XOBOQqq8HufHPYft
         SJtczdDSP7KckuOzSmmR/deqFJFj/fAUJAoP+qRMZtAw0teli6BxHuhqysGDwoeBTSj3
         vISwqHtsnTJRlYvb2e6aB/Y/vf6LV7cmd0qDqFtf8CqWSz/XMFxhMueleNP8HZ2GnXBM
         P9bw==
X-Gm-Message-State: APjAAAUzGdzFmMHjEFkTPN1RZy3ZaRhQhhGzlYTQcMQx6S8MXxrezYYd
        nBxGNv7klqQcNFCEUDTpXUMDtr5r
X-Google-Smtp-Source: APXvYqxc+5E2T/bHrUXjti99jqrZkv+ovgbti6BW/k0jeI1NjWodm6G5Zn+M4b/rUUgtWghUJm2Hnw==
X-Received: by 2002:a5d:65c1:: with SMTP id e1mr44318wrw.364.1571182869520;
        Tue, 15 Oct 2019 16:41:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f13sm683242wmj.17.2019.10.15.16.41.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 16:41:09 -0700 (PDT)
Message-Id: <50ce875ed9d162dc62a8a21f08919068728774ff.1571182864.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.383.v2.git.1571182864.gitgitgadget@gmail.com>
References: <pull.383.git.gitgitgadget@gmail.com>
        <pull.383.v2.git.1571182864.gitgitgadget@gmail.com>
From:   "James Coglan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Oct 2019 23:40:55 +0000
Subject: [PATCH v2 04/13] graph: reduce duplication in
 `graph_insert_into_new_columns()`
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

I will shortly be making some changes to this function and so am trying
to simplify it. It currently contains some duplicated logic; both
branches the function can take assign the commit's column index into
the `mapping` array and increment `mapping_index`.

Here I change the function so that the only conditional behaviour is
that it appends the commit to `new_columns` if it's not present. All
manipulation of `mapping` now happens on a single code path.

Signed-off-by: James Coglan <jcoglan@gmail.com>
---
 graph.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/graph.c b/graph.c
index c9646d9e00..512ae16535 100644
--- a/graph.c
+++ b/graph.c
@@ -478,23 +478,17 @@ static void graph_insert_into_new_columns(struct git_graph *graph,
 	int i = graph_find_new_column_by_commit(graph, commit);
 
 	/*
-	 * If the commit is already in the new_columns list, we don't need to
-	 * add it.  Just update the mapping correctly.
+	 * If the commit is not already in the new_columns array, then add it
+	 * and record it as being in the final column.
 	 */
-	if (i >= 0) {
-		graph->mapping[*mapping_index] = i;
-		*mapping_index += 2;
-		return;
+	if (i < 0) {
+		i = graph->num_new_columns++;
+		graph->new_columns[i].commit = commit;
+		graph->new_columns[i].color = graph_find_commit_color(graph, commit);
 	}
 
-	/*
-	 * This commit isn't already in new_columns.  Add it.
-	 */
-	graph->new_columns[graph->num_new_columns].commit = commit;
-	graph->new_columns[graph->num_new_columns].color = graph_find_commit_color(graph, commit);
-	graph->mapping[*mapping_index] = graph->num_new_columns;
+	graph->mapping[*mapping_index] = i;
 	*mapping_index += 2;
-	graph->num_new_columns++;
 }
 
 static void graph_update_width(struct git_graph *graph,
-- 
gitgitgadget

