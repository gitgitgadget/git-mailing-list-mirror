Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B35E1FEAA
	for <e@80x24.org>; Sat, 25 Jun 2016 18:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751569AbcFYSrN (ORCPT <rfc822;e@80x24.org>);
	Sat, 25 Jun 2016 14:47:13 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:22323 "EHLO
	smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349AbcFYSrM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jun 2016 14:47:12 -0400
Received: from localhost.localdomain ([92.22.68.35])
	by smtp.talktalk.net with SMTP
	id Gsblbik3Xet93GsblbLeDJ; Sat, 25 Jun 2016 19:47:10 +0100
X-Originating-IP: [92.22.68.35]
X-Spam:	0
X-OAuthority: v=2.2 cv=TJwHcBta c=1 sm=1 tr=0 a=MvvZD7eUgq4fJAFIMo7fmA==:117
 a=MvvZD7eUgq4fJAFIMo7fmA==:17 a=xtxXYLxNAAAA:8 a=TSbVqHtbAAAA:8
 a=i4t7ondDDk18LRdoxMgA:9 a=xts0dhWdiJbonKbuqhAr:22 a=NJcUIoPEKLAEIzHnl83t:22
From:	Philip Oakley <philipoakley@iee.org>
To:	GitList <git@vger.kernel.org>
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH] doc: show the actual left, right, and boundary marks
Date:	Sat, 25 Jun 2016 19:47:02 +0100
Message-Id: <20160625184702.4796-1-philipoakley@iee.org>
X-Mailer: git-send-email 2.8.4.windows.1.3.ge328a54
In-Reply-To: <20160625164654.5192-1-philipoakley@iee.org>
References: <20160625164654.5192-1-philipoakley@iee.org>
X-CMAE-Envelope: MS4wfKm8mY0mdjH8QSi9CXn0erte40nLaT+FXdNg8ncgNqQKDFuJY8Fa1latkN1HzekthtwEmvxDodE/MMh3+x8k+rnXAT1tQNgeoNov7CPj2Bl4cn3Rk+kZ
 R4sIvw4N2uEF1wopc9Kl/YCzJxSKuo7QVoL37t/uEvF0NEIPaa7QXgkkbkMpgu/v94FODuy4fDYzCnn5wof6KTRhmBVVVag0GeJhhxF6MQ5f+8xtGQqMKDkJ
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
This is a quick follow on to the 'symmetric difference' documentation patches
http://thread.gmane.org/gmane.comp.version-control.git/297908/focus=298223
where I checked all the uses of 'left' to see if other terms had been used.

I noticed that the actual marks were not being shown here, leaving the reader
with a difficult seach.


---
 Documentation/pretty-formats.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 29b19b9..10719e1 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -166,7 +166,7 @@ endif::git-rev-list[]
   respecting the `auto` settings of the former if we are going to a
   terminal). `auto` alone (i.e. `%C(auto)`) will turn on auto coloring
   on the next placeholders until the color is switched again.
-- '%m': left, right or boundary mark
+- '%m': left (`<`), right (`>`) or boundary (`-`) mark
 - '%n': newline
 - '%%': a raw '%'
 - '%x00': print a byte from a hex code
-- 
2.8.4.windows.1.3.ge328a54

