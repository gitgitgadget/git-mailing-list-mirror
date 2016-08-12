Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 732522018E
	for <e@80x24.org>; Fri, 12 Aug 2016 07:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751979AbcHLHJU (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 03:09:20 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:16258 "EHLO
	smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751207AbcHLHIt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 03:08:49 -0400
Received: from localhost.localdomain ([92.22.69.35])
	by smtp.talktalk.net with SMTP
	id Y6ZUbGDs4xR4bY6ZYbadhZ; Fri, 12 Aug 2016 08:08:05 +0100
X-Originating-IP: [92.22.69.35]
X-Spam:	0
X-OAuthority: v=2.2 cv=JNN5iICb c=1 sm=1 tr=0 a=118V6UEFpCLMRzptT8w30g==:117
 a=118V6UEFpCLMRzptT8w30g==:17 a=xtxXYLxNAAAA:8 a=aPQgYVu9WxExC_ZTeUIA:9
 a=xts0dhWdiJbonKbuqhAr:22
From:	Philip Oakley <philipoakley@iee.org>
To:	GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 08/12] doc: gitrevisions - clarify 'latter case' is revision walk
Date:	Fri, 12 Aug 2016 08:07:45 +0100
Message-Id: <20160812070749.2920-9-philipoakley@iee.org>
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

The prior sentence has too many clauses for easy parsing.
Replace 'the latter case' with a direct quote.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
unchanged
---
 Documentation/gitrevisions.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/gitrevisions.txt b/Documentation/gitrevisions.txt
index 33039c6..27dec5b 100644
--- a/Documentation/gitrevisions.txt
+++ b/Documentation/gitrevisions.txt
@@ -16,8 +16,8 @@ DESCRIPTION
 Many Git commands take revision parameters as arguments. Depending on
 the command, they denote a specific commit or, for commands which
 walk the revision graph (such as linkgit:git-log[1]), all commits which are
-reachable from that commit. In the latter case one can also specify a
-range of revisions explicitly.
+reachable from that commit. For commands that walk the revision graph one can
+also specify a range of revisions explicitly.
 
 In addition, some Git commands (such as linkgit:git-show[1]) also take
 revision parameters which denote other objects than commits, e.g. blobs
-- 
2.9.0.windows.1

