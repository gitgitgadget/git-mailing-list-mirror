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
	by dcvr.yhbt.net (Postfix) with ESMTP id 6515F1F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 23:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388085AbfJOXsK (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 19:48:10 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45291 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387915AbfJOXsH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 19:48:07 -0400
Received: by mail-wr1-f65.google.com with SMTP id r5so25755821wrm.12
        for <git@vger.kernel.org>; Tue, 15 Oct 2019 16:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Q7b/i3Xb0kijYWup0bUqi2CCJrfOTxII6ebnsGHNGQ8=;
        b=GcaUK2Ys8Rd9Qdv/RzL16ZkxfN81RFtXeDdhHyXBN+ZjXF8/NUmGq7tJTIShvpMyd4
         0yZ5xsleTWjkx4Kl4FVYFCyOHlpxwzF+PDpqaiKUqhwqUxcdmJwqOGUcM28bYsMaVOG0
         a6Ct73xfOYMv938eUkq8/nazJNpajjYScG3QKlQgui4eo0EZVIMXlo0VzynC+bjCzCzt
         0eJkRHZNqgpr1MDhDo4+9FijzMoFxWhLoEoggk18/YL2LXfqZnb2aZw1jqL7ubYRIFEt
         ZdBgX3jjOB7lYwOnVvF4voZKdLtVMOBPxhg5rRya0m0o5fpRyqvNc9RvTxMrztEy2DAT
         w66g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Q7b/i3Xb0kijYWup0bUqi2CCJrfOTxII6ebnsGHNGQ8=;
        b=GWu1Fx2DApUko5hEH8sRiZeCF81URgaU6PGedbekxGn72xn67qsv1jh6yOEfYbv6RV
         QyEs/w+IKSWVZJnD6aEtjIvEhoi+JEFPr8NtR/P8SmlGP83RgGrCISWun8e2ql6yxcRh
         KHflUDoWWmqaRdapHjBC2I4hi9v6+N0t7IBFasFoDbJlJjib9Gaz7OrbsGDDyUgxCRS1
         C9sHpPj6uxpoCERStlQ1C7rzQbPJeUlngQl+kjD81XWp1gJITwLtNs6c4k/2/yETfQtR
         VG5X8zLj5A7GqyZAaucJoNZ3P4Gctch889RhA2hzNKhRYNdg55BJmk7bJ67crzg/CovA
         qWTg==
X-Gm-Message-State: APjAAAX3gzqm78FxFJ0AjUtbv/qgOCgI/owOZ/e2LDcaIdVKrKAGcpUq
        gwXivO8RxhqSQnKuDgcybPRaLjuM
X-Google-Smtp-Source: APXvYqyCkEfGLLXaNVobyeo/NaPzLCEaZZOujryqjK6zV+9ITV8i4CqLc1NE8y0PHcrjkOvc98rEWw==
X-Received: by 2002:adf:f4c2:: with SMTP id h2mr3429wrp.69.1571183284910;
        Tue, 15 Oct 2019 16:48:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z13sm17785624wrm.64.2019.10.15.16.48.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 16:48:04 -0700 (PDT)
Message-Id: <6a4717bf05d7cf9fa37fab824634c79394e76476.1571183279.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.383.v3.git.1571183279.gitgitgadget@gmail.com>
References: <pull.383.v2.git.1571182864.gitgitgadget@gmail.com>
        <pull.383.v3.git.1571183279.gitgitgadget@gmail.com>
From:   "James Coglan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Oct 2019 23:47:50 +0000
Subject: [PATCH v3 04/13] graph: reduce duplication in
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

