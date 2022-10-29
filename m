Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA70FA3744
	for <git@archiver.kernel.org>; Sat, 29 Oct 2022 16:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiJ2Qlb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Oct 2022 12:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJ2QlZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Oct 2022 12:41:25 -0400
Received: from smtp-out-6.talktalk.net (smtp-out-6.talktalk.net [62.24.135.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6065E58B4B
        for <git@vger.kernel.org>; Sat, 29 Oct 2022 09:41:24 -0700 (PDT)
Received: from localhost.localdomain ([88.110.102.84])
        by smtp.talktalk.net with SMTP
        id ootdodzgpnO7EooteoWf2Q; Sat, 29 Oct 2022 17:41:22 +0100
X-Originating-IP: [88.110.102.84]
X-Spam: 0
X-OAuthority: v=2.3 cv=X8gs11be c=1 sm=1 tr=0 a=f4UhoLCnUTRb1HgAgoWw0g==:117
 a=f4UhoLCnUTRb1HgAgoWw0g==:17 a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10
 a=ldyaYNNxDcoA:10 a=zw-UjYAx6vlCfjrV0-gA:9
From:   Philip Oakley <philipoakley@iee.email>
To:     GitList <git@vger.kernel.org>
Cc:     Self <philipoakley@iee.email>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Taylor Blau <ttaylorr@github.com>
Subject: [PATCH v3 4/4] doc: use "commit-graph" hyphenation consistently
Date:   Sat, 29 Oct 2022 17:41:12 +0100
Message-Id: <20221029164112.2097-5-philipoakley@iee.email>
X-Mailer: git-send-email 2.38.1.windows.1
In-Reply-To: <20221029164112.2097-1-philipoakley@iee.email>
References: <20221022222539.2333-1-philipoakley@iee.email>
 <20221029164112.2097-1-philipoakley@iee.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfOKsCis3vDScwXOoU+93/5lVtlzNd3Dj8x6CzIUracups1vICUZRpsjtuwrIR1EK0mMVZuRy7Kv6idXopNzlr7ZO56RuNsyCvXphLtdanRddg32GaiUM
 cmF7PGytbO1myt8ofqqmM+iHG2b43QWL9zdvslSQ7n8zeKx1N+3wF6XVP93Da6sJZIUBHJoSCpvQ+l5KF7vWK/y5YuSvs0uUCOkmQcyx0zJTDMq08GEph58I
 yJQD4QtQbQBZ1RTaS7m5RqJH5x6LFJLG6hRu75rmN699TxaACh4u3e95Dm4eSAF4PFy+6iovh6iYrhiMrdlXYM2Y1B5+p/D2Bk93O1Zw2RW9qT7sT8Q+BANX
 5lXQYKv5
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Note, historical release notes have not been updated.

Signed-off-by: Philip Oakley <philipoakley@iee.email>

# Conflicts:
#	Documentation/gitformat-commit-graph.txt
---
 Documentation/config/core.txt            | 2 +-
 Documentation/gitformat-commit-graph.txt | 6 +++---
 Documentation/technical/commit-graph.txt | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index 37afbaf5a4..dfbdaf00b8 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -618,7 +618,7 @@ but risks losing recent work in the event of an unclean system shutdown.
 * `loose-object` hardens objects added to the repo in loose-object form.
 * `pack` hardens objects added to the repo in packfile form.
 * `pack-metadata` hardens packfile bitmaps and indexes.
-* `commit-graph` hardens the commit graph file.
+* `commit-graph` hardens the commit-graph file.
 * `index` hardens the index when it is modified.
 * `objects` is an aggregate option that is equivalent to
   `loose-object,pack`.
diff --git a/Documentation/gitformat-commit-graph.txt b/Documentation/gitformat-commit-graph.txt
index 7324665716..31cad585e2 100644
--- a/Documentation/gitformat-commit-graph.txt
+++ b/Documentation/gitformat-commit-graph.txt
@@ -3,7 +3,7 @@ gitformat-commit-graph(5)
 
 NAME
 ----
-gitformat-commit-graph - Git commit graph format
+gitformat-commit-graph - Git commit-graph format
 
 SYNOPSIS
 --------
@@ -14,7 +14,7 @@ $GIT_DIR/objects/info/commit-graphs/*
 DESCRIPTION
 -----------
 
-The Git commit graph stores a list of commit OIDs and some associated
+The Git commit-graph stores a list of commit OIDs and some associated
 metadata, including:
 
 - The generation number of the commit.
@@ -34,7 +34,7 @@ corresponding to the array position within the list of commit OIDs. Due
 to some special constants we use to track parents, we can store at most
 (1 << 30) + (1 << 29) + (1 << 28) - 1 (around 1.8 billion) commits.
 
-== Commit graph files have the following format:
+== Commit-graph files have the following format:
 
 In order to allow extensions that add extra data to the graph, we organize
 the body into "chunks" and provide a binary lookup table at the beginning
diff --git a/Documentation/technical/commit-graph.txt b/Documentation/technical/commit-graph.txt
index d2a6a13650..86fed0de0f 100644
--- a/Documentation/technical/commit-graph.txt
+++ b/Documentation/technical/commit-graph.txt
@@ -1,4 +1,4 @@
-Git Commit Graph Design Notes
+Git Commit-Graph Design Notes
 =============================
 
 Git walks the commit graph for many reasons, including:
@@ -95,7 +95,7 @@ with default order), but is not used when the topological order is
 required (such as merge base calculations, "git log --graph").
 
 In practice, we expect some commits to be created recently and not stored
-in the commit graph. We can treat these commits as having "infinite"
+in the commit-graph. We can treat these commits as having "infinite"
 generation number and walk until reaching commits with known generation
 number.
 
@@ -149,7 +149,7 @@ Design Details
   helpful for these clones, anyway. The commit-graph will not be read or
   written when shallow commits are present.
 
-Commit Graphs Chains
+Commit-Graphs Chains
 --------------------
 
 Typically, repos grow with near-constant velocity (commits per day). Over time,
-- 
2.38.1.windows.1

