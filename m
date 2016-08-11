Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8463420193
	for <e@80x24.org>; Thu, 11 Aug 2016 21:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932369AbcHKVus (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 17:50:48 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:43022 "EHLO
	smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752420AbcHKVup (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 17:50:45 -0400
Received: from localhost.localdomain ([92.22.69.35])
	by smtp.talktalk.net with SMTP
	id XxsAbUhKI0KuvXxsBbI2o9; Thu, 11 Aug 2016 22:50:43 +0100
X-Originating-IP: [92.22.69.35]
X-Spam:	0
X-OAuthority: v=2.2 cv=RZjSMBlv c=1 sm=1 tr=0 a=118V6UEFpCLMRzptT8w30g==:117
 a=118V6UEFpCLMRzptT8w30g==:17 a=xtxXYLxNAAAA:8 a=gt0LKDO9OWbvjQJcSk0A:9
 a=xts0dhWdiJbonKbuqhAr:22
From:	Philip Oakley <philipoakley@iee.org>
To:	GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Cc:	Self <philipoakley@iee.org>
Subject: [PATCH v5 01/12] doc: use 'symmetric difference' consistently
Date:	Thu, 11 Aug 2016 22:50:24 +0100
Message-Id: <20160811215035.4108-2-philipoakley@iee.org>
X-Mailer: git-send-email 2.9.0.windows.1
In-Reply-To: <20160811215035.4108-1-philipoakley@iee.org>
References: <20160720211007.5520-1-philipoakley@iee.org>
 <20160811215035.4108-1-philipoakley@iee.org>
X-CMAE-Envelope: MS4wfI537/nGpOBjd2YP9/Rjk+OUc+p23nnVYD6hj4jsJY7NvZdy0/iROqpyeR0RwbfzhHtHCA+p219sBRfi2urzLNYRJOatYlqJDrwBNu9B//Lz1tAvFSnw
 bRZlyuVyJFyGQ35686inslheBbAQYgp04GfNacgnnP2XM0/Z+7oiCzkq00qDHP+9GCFZZ+ilyQqSJwCK/EnIARl4dVdT6IMYzGfp6DasT2BEmAFL4X3w6S6l
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
unchanged
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
2.9.0.windows.1

