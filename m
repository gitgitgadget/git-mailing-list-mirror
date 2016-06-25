Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EF541FEAA
	for <e@80x24.org>; Sat, 25 Jun 2016 16:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751585AbcFYQrH (ORCPT <rfc822;e@80x24.org>);
	Sat, 25 Jun 2016 12:47:07 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:47150 "EHLO
	smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751508AbcFYQrG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jun 2016 12:47:06 -0400
Received: from localhost.localdomain ([92.22.68.35])
	by smtp.talktalk.net with SMTP
	id GqjWbvjeqYIiqGqjXbpjXR; Sat, 25 Jun 2016 17:47:04 +0100
X-Originating-IP: [92.22.68.35]
X-Spam:	0
X-OAuthority: v=2.2 cv=P/l4vWIu c=1 sm=1 tr=0 a=MvvZD7eUgq4fJAFIMo7fmA==:117
 a=MvvZD7eUgq4fJAFIMo7fmA==:17 a=xtxXYLxNAAAA:8 a=gt0LKDO9OWbvjQJcSk0A:9
 a=xts0dhWdiJbonKbuqhAr:22
From:	Philip Oakley <philipoakley@iee.org>
To:	GitList <git@vger.kernel.org>
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH 1/2] doc: use 'symmetric difference' consistently
Date:	Sat, 25 Jun 2016 17:46:53 +0100
Message-Id: <20160625164654.5192-2-philipoakley@iee.org>
X-Mailer: git-send-email 2.8.4.windows.1.3.ge328a54
In-Reply-To: <20160625164654.5192-1-philipoakley@iee.org>
References: <E61B46FFA8874DD3973AA96BE5B36790@PhilipOakley>
 <20160625164654.5192-1-philipoakley@iee.org>
X-CMAE-Envelope: MS4wfE2gho3hODbY6xiCNmlC/bjHolZrFJ2LNEqC9kGuUEmZoOH9ZOuvpj00UYtn0Dm9N4MKBr4EHvaAvMEaRqxuuRezlJqRp6EMbSjQO98Ll+ZIDOh/CjVd
 R2QxX3nzfZ+bP5uGzVGJdpDojd6wG3QHtma9QSCQzyQnwMQ3EkD4CqU8+bXyOr6E9H5QLrbDZhCULTFp1Tvb8QS1o81kBgNGegDcwr8rJ6p+lNXzkaTcn4Cj
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

