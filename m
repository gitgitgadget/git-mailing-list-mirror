Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1615B2018F
	for <e@80x24.org>; Mon, 11 Jul 2016 20:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753019AbcGKUZp (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 16:25:45 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:16975 "EHLO
	smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752931AbcGKUZ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2016 16:25:29 -0400
Received: from localhost.localdomain ([92.22.73.13])
	by smtp.talktalk.net with SMTP
	id MhlcbLEzMY8RwMhlebR8lt; Mon, 11 Jul 2016 21:25:27 +0100
X-Originating-IP: [92.22.73.13]
X-Spam:	0
X-OAuthority: v=2.2 cv=b+Xw2ZOx c=1 sm=1 tr=0 a=R5CpdR+gL2+IAQkTIkP0Ow==:117
 a=R5CpdR+gL2+IAQkTIkP0Ow==:17 a=O560aJCABnCqEozDy2QA:9
From:	Philip Oakley <philipoakley@iee.org>
To:	GitList <git@vger.kernel.org>
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 2/8] doc: revisions - name the Left and Right sides
Date:	Mon, 11 Jul 2016 21:25:12 +0100
Message-Id: <20160711202518.532-3-philipoakley@iee.org>
X-Mailer: git-send-email 2.8.4.windows.1.3.ge328a54
In-Reply-To: <20160711202518.532-1-philipoakley@iee.org>
References: <20160630202509.4472-1-philipoakley@iee.org>
 <20160711202518.532-1-philipoakley@iee.org>
X-CMAE-Envelope: MS4wfBSkiRusPY1ZuRcZcJIQf8w1arKIBdFfKgS8lW5Q+IhwEexanrc1Zyxl0UQARlfAfib6sm0tktcY4sWd0TRW/DSVR7ZtGzPk7jBx3RklM03cCfYOglVT
 hcVoaYN11NRkK+yrkKV7wDMOZLvJgD82mJARbMrp90P7UNQplpGOBYFxm/y3ltg9xIJxS7qe5JaJiQ+GT+xeBy0OtFngVTX8Fbgu2eolwPs7iL1D/EW588zy
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The terms Left and Right side originate from the symmetric
difference. Name them there.
---
 Documentation/revisions.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 19314e3..79f6d03 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -256,7 +256,7 @@ A similar notation 'r1\...r2' is called symmetric difference
 of 'r1' and 'r2' and is defined as
 'r1 r2 --not $(git merge-base --all r1 r2)'.
 It is the set of commits that are reachable from either one of
-'r1' or 'r2' but not from both.
+'r1' (Left side) or 'r2' (Right side) but not from both.
 
 In these two shorthands, you can omit one end and let it default to HEAD.
 For example, 'origin..' is a shorthand for 'origin..HEAD' and asks "What
-- 
2.8.4.windows.1.3.ge328a54

