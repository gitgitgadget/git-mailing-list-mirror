Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C34D72018E
	for <e@80x24.org>; Fri, 12 Aug 2016 07:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751858AbcHLHIy (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 03:08:54 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:20691 "EHLO
	smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257AbcHLHIu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 03:08:50 -0400
Received: from localhost.localdomain ([92.22.69.35])
	by smtp.talktalk.net with SMTP
	id Y6ZUbGDs4xR4bY6ZZbadhb; Fri, 12 Aug 2016 08:08:05 +0100
X-Originating-IP: [92.22.69.35]
X-Spam:	0
X-OAuthority: v=2.2 cv=JNN5iICb c=1 sm=1 tr=0 a=118V6UEFpCLMRzptT8w30g==:117
 a=118V6UEFpCLMRzptT8w30g==:17 a=xtxXYLxNAAAA:8 a=nOBXlB7yw2htNP6sz7oA:9
 a=xts0dhWdiJbonKbuqhAr:22
From:	Philip Oakley <philipoakley@iee.org>
To:	GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 09/12] doc: revisions  - define `reachable`
Date:	Fri, 12 Aug 2016 08:07:46 +0100
Message-Id: <20160812070749.2920-10-philipoakley@iee.org>
X-Mailer: git-send-email 2.9.0.windows.1
In-Reply-To: <20160812070749.2920-1-philipoakley@iee.org>
References: <20160720211007.5520-1-philipoakley@iee.org>
 <20160812070749.2920-1-philipoakley@iee.org>
X-CMAE-Envelope: MS4wfAPEIz5GC19mCUJ+RbwPPVl4n4H7JDNQIc2Gy7N4FsdFcYavWcNUiJNOpqtYHY3ey4sUqGOfwFGkWVNX7wRTazlns4RV4pnQLDQl9nv6RcvGTi0dkWnV
 e1VHl6tpHLcZ+S+zuanRs4Hc8uMmYzDZMzl2N7O+KNDmeBA4Ryf1686EA/uc51kLNipEDxdzOBKlC4PybU2Liq+H6CqYRyvlRa8=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Do not self-define `reachable`, which can lead to misunderstanding.
Instead define `reachability` explictly.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
unchanged
---
 Documentation/revisions.txt | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 934d071..238be45 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -237,10 +237,16 @@ SPECIFYING RANGES
 -----------------
 
 History traversing commands such as `git log` operate on a set
-of commits, not just a single commit.  To these commands,
-specifying a single revision with the notation described in the
-previous section means the set of commits reachable from that
-commit, following the commit ancestry chain.
+of commits, not just a single commit.
+
+For these commands,
+specifying a single revision, using the notation described in the
+previous section, means the set of commits `reachable` from the given
+commit.
+
+A commit's reachable set is the commit itself and the commits in
+its ancestry chain.
+
 
 Commit Exclusions
 ~~~~~~~~~~~~~~~~~
-- 
2.9.0.windows.1

