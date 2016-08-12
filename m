Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78A3F2018E
	for <e@80x24.org>; Fri, 12 Aug 2016 07:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752126AbcHLHJm (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 03:09:42 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:64153 "EHLO
	smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031AbcHLHIs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 03:08:48 -0400
Received: from localhost.localdomain ([92.22.69.35])
	by smtp.talktalk.net with SMTP
	id Y6ZUbGDs4xR4bY6ZVbadhH; Fri, 12 Aug 2016 08:08:02 +0100
X-Originating-IP: [92.22.69.35]
X-Spam:	0
X-OAuthority: v=2.2 cv=JNN5iICb c=1 sm=1 tr=0 a=118V6UEFpCLMRzptT8w30g==:117
 a=118V6UEFpCLMRzptT8w30g==:17 a=xtxXYLxNAAAA:8 a=O560aJCABnCqEozDy2QA:9
 a=xts0dhWdiJbonKbuqhAr:22
From:	Philip Oakley <philipoakley@iee.org>
To:	GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 02/12] doc: revisions - name the left and right sides
Date:	Fri, 12 Aug 2016 08:07:39 +0100
Message-Id: <20160812070749.2920-3-philipoakley@iee.org>
X-Mailer: git-send-email 2.9.0.windows.1
In-Reply-To: <20160812070749.2920-1-philipoakley@iee.org>
References: <20160720211007.5520-1-philipoakley@iee.org>
 <20160812070749.2920-1-philipoakley@iee.org>
X-CMAE-Envelope: MS4wfEoQKtNQBEtCd5pVQ8exkJ0Rz5j81saDuwMQM8U+w6KyCvXJmDCKqggxZUVuJS2fx6OIm1t++uZlZPqAO95AMJic6wW9uEf7sxgjNqJMUJ5sCFg/7ynV
 rJp4cNZifuMWGtbILg6HltvUtDOatzzA8Bc6GNOXdtYuiew3uM55mWwdP/z0ExsN6nv3hTftkhofz2IGRULktoH1F09IyfwESU0=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The terms left and right side originate from the symmetric
difference. Name them there.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
unchanged
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

