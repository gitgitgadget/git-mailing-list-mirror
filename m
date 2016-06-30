Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9DAE1FE4E
	for <e@80x24.org>; Thu, 30 Jun 2016 20:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752085AbcF3UlU (ORCPT <rfc822;e@80x24.org>);
	Thu, 30 Jun 2016 16:41:20 -0400
Received: from smtp-d-6.talktalk.net ([78.144.6.134]:22769 "EHLO
	smtp-d-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752004AbcF3UlT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2016 16:41:19 -0400
Received: from localhost.localdomain ([2.96.205.30])
	by smtp.talktalk.net with SMTP
	id IiWUbMHWfgKstIiWVbS4FX; Thu, 30 Jun 2016 21:25:19 +0100
X-Originating-IP: [2.96.205.30]
X-Spam:	0
X-OAuthority: v=2.2 cv=GdBVpkfL c=1 sm=1 tr=0 a=QTrtdgWXx+RZbj7kV87ZQA==:117
 a=QTrtdgWXx+RZbj7kV87ZQA==:17 a=xtxXYLxNAAAA:8 a=gt0LKDO9OWbvjQJcSk0A:9
 a=xts0dhWdiJbonKbuqhAr:22
From:	Philip Oakley <philipoakley@iee.org>
To:	GitList <git@vger.kernel.org>
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2 1/4] doc: use 'symmetric difference' consistently
Date:	Thu, 30 Jun 2016 21:25:06 +0100
Message-Id: <20160630202509.4472-2-philipoakley@iee.org>
X-Mailer: git-send-email 2.8.4.windows.1.3.ge328a54
In-Reply-To: <20160630202509.4472-1-philipoakley@iee.org>
References: <20160625164654.5192-1-philipoakley@iee.org>
 <20160630202509.4472-1-philipoakley@iee.org>
X-CMAE-Envelope: MS4wfGay74BJ6NxrQRIaQN0ICKAishAQIEJfsIf1DeE1TyPLVigAAxrsYBDvQPywbzDi2qMblB7go0KazU816RAFvY0GaSqWXh+1ABntPcGB/43ttRCiAf7E
 MAuDwW6QgG3Dy/2wcQvMTFlg32b/bV/6GPcY5mD0bb2NVV+kB9ANWTiqBpJ7ow56skGZI8kIiPHaWXvFyqYN22MvJrlbKM9kvilkcO+Y7avZuY/5Mdiiobhk
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 Documentation/gitk.txt             | 2 +-
 Documentation/rev-list-options.txt | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
index 6ade002..6c3eb15 100644
--- a/Documentation/gitk.txt
+++ b/Documentation/gitk.txt
@@ -70,7 +70,7 @@ linkgit:git-rev-list[1] for a complete list.
 
 --left-right::
 
-	Mark which side of a symmetric diff a commit is reachable
+	Mark which side of a symmetric difference a commit is reachable
 	from.  Commits from the left side are prefixed with a `<`
 	symbol and those from the right with a `>` symbol.
 
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 4f009d4..6dc0bb0 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -225,7 +225,7 @@ excluded from the output.
 
 --left-only::
 --right-only::
-	List only commits on the respective side of a symmetric range,
+	List only commits on the respective side of a symmetric difference,
 	i.e. only those which would be marked `<` resp. `>` by
 	`--left-right`.
 +
@@ -766,7 +766,7 @@ ifdef::git-rev-list[]
 endif::git-rev-list[]
 
 --left-right::
-	Mark which side of a symmetric diff a commit is reachable from.
+	Mark which side of a symmetric difference a commit is reachable from.
 	Commits from the left side are prefixed with `<` and those from
 	the right with `>`.  If combined with `--boundary`, those
 	commits are prefixed with `-`.
-- 
2.8.4.windows.1.3.ge328a54

