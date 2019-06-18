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
	by dcvr.yhbt.net (Postfix) with ESMTP id BF8001F462
	for <e@80x24.org>; Tue, 18 Jun 2019 18:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730073AbfFRSO0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 14:14:26 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45176 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729349AbfFRSOZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 14:14:25 -0400
Received: by mail-ed1-f68.google.com with SMTP id a14so22997929edv.12
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 11:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=K4hI5VzyEmN0pp2bYyiizZjGrxQByJ3B5DXoRbPUeiA=;
        b=qlUK0KIAQCVVdYLqU87GG0gZEv2c8OPNB0clrLCiRQMMAMkIk4Nu9dtr1PAoXtJRw3
         6xaBL0jaJK+H2kXpAtycFIO4Fix40XF+mgO7ETVCS2CgVFoqjjbEJ9ino/tgjpHEGeXo
         hukRD+i+8YSkzZBjnOMtDhqmFcg/zsNpvK9cWbaVrZjKHn8G6wPf74V5Kfqp55szcjjJ
         2d2ukhOic0hDTvGNcBahRK52SUjc1K9isd0WW7O8xf59f8hnuFnsTdrhj012Gap3YlB8
         THZaufv0G08+0Lt3LQsX7LH787NmBcWoa6+5fRjEOznwWVpHPfj3MwAvustkJ2FUTWn/
         95Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=K4hI5VzyEmN0pp2bYyiizZjGrxQByJ3B5DXoRbPUeiA=;
        b=F3TEkr7xiBOuo6QTZ4ZI8Qts/kmCC4fWUqf0jgxaIkMqSxJUnbxI8wYjesXKQ37E3Q
         DxiLGSavrjW9CECNJvWo9LPhsifq6op+rQkvGUcIUcC/NIcH0NFmFpxqKIAEKxwKhsi/
         Tdk4aIDljroEm8NKvnejJB3X3oQA2ASyWGaxpV+XAByCjwFrCEhshMPl5HmSXuahaQvl
         msYHj1xbM/Z9lGhpWnpYl8+mlb4Hf+3kgy6PE+Cpx6iH3tnFAQRMa5c8tDo4bgpIZY3/
         WLsCrVtHj+M2e28QO2MO76CQIUG+oh1j1FlEjeh4Mb9v6tGuXlkPZxS1DnyAvZrVqU30
         AbLQ==
X-Gm-Message-State: APjAAAWggdJ+hQ/kO3ZXuSVl4PcL9JuzDa9Dhif0LQ98GB1G4in0i6Eg
        4UoMpKzn3aoNr4Fd6KmF71h7fHcw
X-Google-Smtp-Source: APXvYqyK5QpkjtjFQo0+xpCxgSjzEaXiBZgV3a/mfswMvjawnqEG+H3G+5oh1U5sl1qHzM1Rz4WAoQ==
X-Received: by 2002:a50:8825:: with SMTP id b34mr49330490edb.22.1560881663757;
        Tue, 18 Jun 2019 11:14:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t25sm2468522ejt.19.2019.06.18.11.14.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 11:14:23 -0700 (PDT)
Date:   Tue, 18 Jun 2019 11:14:23 -0700 (PDT)
X-Google-Original-Date: Tue, 18 Jun 2019 18:14:03 GMT
Message-Id: <7c3c0df3cdbff9b6537adc2d46363c756aa7bd54.1560881661.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.v6.git.gitgitgadget@gmail.com>
References: <pull.184.v5.git.gitgitgadget@gmail.com>
        <pull.184.v6.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v6 01/18] commit-graph: document commit-graph chains
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, git@jeffhostetler.com,
        jrnieder@google.com, steadmon@google.com,
        johannes.schindelin@gmx.de, philipoakley@iee.org,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Add a basic description of commit-graph chains. More details about the
feature will be added as we add functionality. This introduction gives a
high-level overview to the goals of the feature and the basic layout of
commit-graph chains.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/technical/commit-graph.txt | 59 ++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/Documentation/technical/commit-graph.txt b/Documentation/technical/commit-graph.txt
index fb53341d5e..1dca3bd8fe 100644
--- a/Documentation/technical/commit-graph.txt
+++ b/Documentation/technical/commit-graph.txt
@@ -127,6 +127,65 @@ Design Details
   helpful for these clones, anyway. The commit-graph will not be read or
   written when shallow commits are present.
 
+Commit Graphs Chains
+--------------------
+
+Typically, repos grow with near-constant velocity (commits per day). Over time,
+the number of commits added by a fetch operation is much smaller than the
+number of commits in the full history. By creating a "chain" of commit-graphs,
+we enable fast writes of new commit data without rewriting the entire commit
+history -- at least, most of the time.
+
+## File Layout
+
+A commit-graph chain uses multiple files, and we use a fixed naming convention
+to organize these files. Each commit-graph file has a name
+`$OBJDIR/info/commit-graphs/graph-{hash}.graph` where `{hash}` is the hex-
+valued hash stored in the footer of that file (which is a hash of the file's
+contents before that hash). For a chain of commit-graph files, a plain-text
+file at `$OBJDIR/info/commit-graphs/commit-graph-chain` contains the
+hashes for the files in order from "lowest" to "highest".
+
+For example, if the `commit-graph-chain` file contains the lines
+
+```
+	{hash0}
+	{hash1}
+	{hash2}
+```
+
+then the commit-graph chain looks like the following diagram:
+
+ +-----------------------+
+ |  graph-{hash2}.graph  |
+ +-----------------------+
+	  |
+ +-----------------------+
+ |                       |
+ |  graph-{hash1}.graph  |
+ |                       |
+ +-----------------------+
+	  |
+ +-----------------------+
+ |                       |
+ |                       |
+ |                       |
+ |  graph-{hash0}.graph  |
+ |                       |
+ |                       |
+ |                       |
+ +-----------------------+
+
+Let X0 be the number of commits in `graph-{hash0}.graph`, X1 be the number of
+commits in `graph-{hash1}.graph`, and X2 be the number of commits in
+`graph-{hash2}.graph`. If a commit appears in position i in `graph-{hash2}.graph`,
+then we interpret this as being the commit in position (X0 + X1 + i), and that
+will be used as its "graph position". The commits in `graph-{hash2}.graph` use these
+positions to refer to their parents, which may be in `graph-{hash1}.graph` or
+`graph-{hash0}.graph`. We can navigate to an arbitrary commit in position j by checking
+its containment in the intervals [0, X0), [X0, X0 + X1), [X0 + X1, X0 + X1 +
+X2).
+
 Related Links
 -------------
 [0] https://bugs.chromium.org/p/git/issues/detail?id=8
-- 
gitgitgadget

