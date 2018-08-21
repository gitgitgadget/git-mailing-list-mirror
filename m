Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EACB61FAD3
	for <e@80x24.org>; Tue, 21 Aug 2018 19:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbeHUWul (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Aug 2018 18:50:41 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42694 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbeHUWul (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Aug 2018 18:50:41 -0400
Received: by mail-pg1-f196.google.com with SMTP id y4-v6so8897552pgp.9
        for <git@vger.kernel.org>; Tue, 21 Aug 2018 12:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ydvMjViGd1HV/ZhLpuZ8QYTYokR97jSzStMjAPx+6xg=;
        b=TjAP1PdIaTE/JQeWZqvuQ+GmNUbbTs5UqU6M3Sgq8ODLSsozlbqAsymqp3W/2PCcNt
         63Q/RA1QN4NdU9oL9D899F+1i/yptRDnrcrrQc9/WG+BwTXX9sgna/TVT+gS8l6bbiax
         Wnx0yCYGe3aMatd1QlWFG7vHo8RYU/+2MswG6jowrINgVoFVWnA4I//ABrVJi5oCQLaL
         P0EHBYCKxTUXBqpgFAsU8aKFy0fTfnOmNcV4qHrzL07HgzeUJEAr++c7iCQHatuOuAE7
         Sxp4klUY5CWFTA+dAW9rAxaxtojAiYcEori2sq7f/EZWMvjVyXJioryfZZMeCLHgt8kG
         hfnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ydvMjViGd1HV/ZhLpuZ8QYTYokR97jSzStMjAPx+6xg=;
        b=m76V8H0kk1WYVe1OPeCaNdM4rad8PMtPiL0YI4cwV+ymI8U2djYJvuk3S52p7kRsQ0
         VvYMKeD/6T0VjSfyLQhsTzC50S0o4dfd6tzrbuCCYHpSXD8IuV0jfgDVYghfp09FbL35
         CJS4RCmzOdN2mJzeIKDgOZQzlqYApWhSAeW+060GHjHd9fJowG9i2b+I1hSKcwin3YKt
         8KLsMMT2ZAPjP3rt6xHzR1qYe1E/U9w8OwJk47GA1kUa2TcnK1RtEpo0Ti//e97RoIVr
         BK3sZMSAVlR1J6ONXubjFiWF7qdahU9AuWMq1/wMLT322xzEfqU/vUeIcErw9SW4Ymtc
         kqNQ==
X-Gm-Message-State: AOUpUlEOXamzYw7X0RcQNpbdvr+zDXNUEvdvW9UUSIffLcutTs4MLrFR
        PruPXQo8WkqywK+4m69OK3XhneFW
X-Google-Smtp-Source: AA+uWPz3/znMHRgkyS8QjuFi3ce25+xKV7yg4eG6r2wFDdAYesM3iORdGr9TGBIJXrPOqEQJj3lhdA==
X-Received: by 2002:a63:cf4a:: with SMTP id b10-v6mr48998791pgj.235.1534879754385;
        Tue, 21 Aug 2018 12:29:14 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id f75-v6sm24087306pfk.85.2018.08.21.12.29.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 12:29:13 -0700 (PDT)
Date:   Tue, 21 Aug 2018 12:29:13 -0700 (PDT)
X-Google-Original-Date: Tue, 21 Aug 2018 19:29:07 GMT
Message-Id: <6cf253c2a6a091520e1376839dff8b97869c9808.1534879749.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.22.v2.git.gitgitgadget@gmail.com>
References: <pull.22.git.gitgitgadget@gmail.com>
        <pull.22.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 2/2] commit-graph.txt: improve formatting for asciidoc
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When viewing commit-graph.txt as a plain-text document, it makes
sense to keep paragraphs left-padded between bullet points.
However, asciidoc converts these left-padded paragraphs as monospace
fonts, creating an unpleasant document. Remove the padding.

The "Future Work" section includes a bulleted list of items, and one
item has sub-items. These do not render properly in asciidoc, so
remove the sub-list and incorporate them into the paragraph.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/technical/commit-graph.txt | 43 +++++++++++-------------
 1 file changed, 20 insertions(+), 23 deletions(-)

diff --git a/Documentation/technical/commit-graph.txt b/Documentation/technical/commit-graph.txt
index c664acbd7..bdc3eab9e 100644
--- a/Documentation/technical/commit-graph.txt
+++ b/Documentation/technical/commit-graph.txt
@@ -49,23 +49,23 @@ Equivalently, the generation number of a commit A is one more than the
 length of a longest path from A to a root commit. The recursive definition
 is easier to use for computation and observing the following property:
 
-    If A and B are commits with generation numbers N and M, respectively,
-    and N <= M, then A cannot reach B. That is, we know without searching
-    that B is not an ancestor of A because it is further from a root commit
-    than A.
+If A and B are commits with generation numbers N and M, respectively,
+and N <= M, then A cannot reach B. That is, we know without searching
+that B is not an ancestor of A because it is further from a root commit
+than A.
 
-    Conversely, when checking if A is an ancestor of B, then we only need
-    to walk commits until all commits on the walk boundary have generation
-    number at most N. If we walk commits using a priority queue seeded by
-    generation numbers, then we always expand the boundary commit with highest
-    generation number and can easily detect the stopping condition.
+Conversely, when checking if A is an ancestor of B, then we only need
+to walk commits until all commits on the walk boundary have generation
+number at most N. If we walk commits using a priority queue seeded by
+generation numbers, then we always expand the boundary commit with highest
+generation number and can easily detect the stopping condition.
 
 This property can be used to significantly reduce the time it takes to
 walk commits and determine topological relationships. Without generation
 numbers, the general heuristic is the following:
 
-    If A and B are commits with commit time X and Y, respectively, and
-    X < Y, then A _probably_ cannot reach B.
+If A and B are commits with commit time X and Y, respectively, and
+X < Y, then A _probably_ cannot reach B.
 
 This heuristic is currently used whenever the computation is allowed to
 violate topological relationships due to clock skew (such as "git log"
@@ -121,11 +121,8 @@ Future Work
 - After computing and storing generation numbers, we must make graph
   walks aware of generation numbers to gain the performance benefits they
   enable. This will mostly be accomplished by swapping a commit-date-ordered
-  priority queue with one ordered by generation number. The following
-  operations are important candidates:
-
-    - 'log --topo-order'
-    - 'tag --merged'
+  priority queue with one ordered by generation number. Commands that could
+  improve include 'git log --topo-order' and 'git tag --merged'.
 
 - A server could provide a commit graph file as part of the network protocol
   to avoid extra calculations by clients. This feature is only of benefit if
@@ -148,13 +145,13 @@ Related Links
     More discussion about generation numbers and not storing them inside
     commit objects. A valuable quote:
 
-    "I think we should be moving more in the direction of keeping
-     repo-local caches for optimizations. Reachability bitmaps have been
-     a big performance win. I think we should be doing the same with our
-     properties of commits. Not just generation numbers, but making it
-     cheap to access the graph structure without zlib-inflating whole
-     commit objects (i.e., packv4 or something like the "metapacks" I
-     proposed a few years ago)."
+"I think we should be moving more in the direction of keeping
+ repo-local caches for optimizations. Reachability bitmaps have been
+ a big performance win. I think we should be doing the same with our
+ properties of commits. Not just generation numbers, but making it
+ cheap to access the graph structure without zlib-inflating whole
+ commit objects (i.e., packv4 or something like the "metapacks" I
+ proposed a few years ago)."
 
 [4] https://public-inbox.org/git/20180108154822.54829-1-git@jeffhostetler.com/T/#u
     A patch to remove the ahead-behind calculation from 'status'.
-- 
gitgitgadget
