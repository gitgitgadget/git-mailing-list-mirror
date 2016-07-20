Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43A2D202F3
	for <e@80x24.org>; Wed, 20 Jul 2016 21:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755072AbcGTVKU (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 17:10:20 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:15239 "EHLO
	smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754861AbcGTVKS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 17:10:18 -0400
Received: from localhost.localdomain ([92.22.79.77])
	by smtp.talktalk.net with SMTP
	id PykwbXvjRHGLwPykzbEmcj; Wed, 20 Jul 2016 22:10:17 +0100
X-Originating-IP: [92.22.79.77]
X-Spam:	0
X-OAuthority: v=2.2 cv=dsCZMBo4 c=1 sm=1 tr=0 a=YfJyJ16zsu2qLTmLoX9DvA==:117
 a=YfJyJ16zsu2qLTmLoX9DvA==:17 a=xtxXYLxNAAAA:8 a=O560aJCABnCqEozDy2QA:9
 a=xts0dhWdiJbonKbuqhAr:22
From:	Philip Oakley <philipoakley@iee.org>
To:	GitList <git@vger.kernel.org>
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	=?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v4 2/8] doc: revisions - name the left and right sides
Date:	Wed, 20 Jul 2016 22:10:01 +0100
Message-Id: <20160720211007.5520-3-philipoakley@iee.org>
X-Mailer: git-send-email 2.9.0.windows.1
In-Reply-To: <20160720211007.5520-1-philipoakley@iee.org>
References: <20160711202518.532-1-philipoakley@iee.org>
 <20160720211007.5520-1-philipoakley@iee.org>
X-CMAE-Envelope: MS4wfEdtb9l/j5ZqJiRy6mUS9UCi3a6rGRjBAbA0rfzjDP/KDnVyhP7EPH5t78I6ZnbdcidHauRbGaeAhtO/+vfkLFVPnSldZhVn13vmaSretOzPWwzO0ktL
 JvR0H//OwluXcdWNc8xF1xM/p8kChVOnUq3rubTHyu+6EBiD2BPJSrViRwrnIbHfd7lGiMI3pyM1VA+t3NaYb1AZo+FhdO23Q39B8AlOm0jBm6caWEDMaYKK
 qQd0YaDT1UwqIW7zyDDtoKpET76iv1FMZsY1xqt0znztDMUX7ywbd3NouQ+R0ztF
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The terms left and right side originate from the symmetric
difference. Name them there.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 Documentation/revisions.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 19314e3..6e9cd41 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -256,7 +256,7 @@ A similar notation 'r1\...r2' is called symmetric difference
 of 'r1' and 'r2' and is defined as
 'r1 r2 --not $(git merge-base --all r1 r2)'.
 It is the set of commits that are reachable from either one of
-'r1' or 'r2' but not from both.
+'r1' (left side) or 'r2' (right side) but not from both.
 
 In these two shorthands, you can omit one end and let it default to HEAD.
 For example, 'origin..' is a shorthand for 'origin..HEAD' and asks "What
-- 
2.9.0.windows.1

