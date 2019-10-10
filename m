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
	by dcvr.yhbt.net (Postfix) with ESMTP id C7BF71F4BD
	for <e@80x24.org>; Thu, 10 Oct 2019 16:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbfJJQNs (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 12:13:48 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39477 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfJJQNr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Oct 2019 12:13:47 -0400
Received: by mail-wm1-f68.google.com with SMTP id v17so7402077wml.4
        for <git@vger.kernel.org>; Thu, 10 Oct 2019 09:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VeHUiI42FrQp6wbepnXUQJLoVSlzgFJZk0le1Rvphbc=;
        b=kxUj/CjofhA5V5R+67XxgRiuMkQslykSds84USF0N6WUUl0JphpBIcE7hS7VZ3VI+O
         /NGjKvw6L0Q6SPNx0mHZ351EpqIjWwHWk0p2lKvx8nMz1wJ5OQ0Sh1CxL19/7+61YQVf
         4qlYCnO7euXDFohpnAXkHbam1Ob1zyVcW4EX0fQe5YAOARdWLTqVCgksjnCIkuDyFLsK
         XOBJSFymG/l8EKwGbCNC3JreKrGbKSliqgJh2Op8fCMIE3tm8WDMc5KTMskovGwhXwIW
         rUsBvhiT8sgWlHiafAU/W0EZqH8BM/Aoz6qQ0rgs0Xa4nMZDdsMXtte0u6M4Pr57tkRd
         q7qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VeHUiI42FrQp6wbepnXUQJLoVSlzgFJZk0le1Rvphbc=;
        b=sv9O/IzhjbAmyQuEc9+1OVBbFVcqgSYgcGpn0g5MwtZWUmLfvv9w27ERQRGQ/BCJfG
         50GVcnBHyKkf+yphd5kIJvAvRAUhT9DPGcA9VQXYSOHaF5NGaB40SR/JRYrQfKUbybBK
         m7bqzNOW2MFj7ECxmqIBw5pSNYd/62zTYE005bxwKdxP97jv5MKXOayH1PgeReJ81vCC
         Bp9juKItUhNn3phRk+oxkxQgt4UITbWLfCXU+fgW3ENSzI7k9t/XrlHF6/GIUxDiiPOi
         zoL1sRkI31OotSRY1LYJH2lRWxhg/13ZJsNIxa2TOYR3bG4c5un4IHUU/GWKXv7DJDq4
         WSLw==
X-Gm-Message-State: APjAAAU6Swr0zEKkeITI7tfCxaA/SKz/WcFN+8zJiDO/dCrK2qAELxUn
        eqWUf3XiMwyJ7cb06u4uk1hGArZE
X-Google-Smtp-Source: APXvYqx62HOs4QRguNlThJhM0wjjpFwAj33wqT5BjEEFeEcqUrT4k7VwbqDuiWR/6YBcoXopPs9wqQ==
X-Received: by 2002:a1c:a8c7:: with SMTP id r190mr8255794wme.162.1570724025774;
        Thu, 10 Oct 2019 09:13:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q15sm9665137wrg.65.2019.10.10.09.13.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 09:13:45 -0700 (PDT)
Date:   Thu, 10 Oct 2019 09:13:45 -0700 (PDT)
X-Google-Original-Date: Thu, 10 Oct 2019 16:13:32 GMT
Message-Id: <21a36efd7bc405ea01be8ecfd9775ebdf68946ad.1570724021.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.383.git.gitgitgadget@gmail.com>
References: <pull.383.git.gitgitgadget@gmail.com>
From:   "James Coglan via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 03/11] graph: reduce duplication in
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
index a890c9d8bb..1cd30f80e6 100644
--- a/graph.c
+++ b/graph.c
@@ -459,23 +459,17 @@ static void graph_insert_into_new_columns(struct git_graph *graph,
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

