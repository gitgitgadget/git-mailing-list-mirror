Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAC7D208CD
	for <e@80x24.org>; Sun, 20 Aug 2017 09:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752759AbdHTJrB (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Aug 2017 05:47:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:43984 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752752AbdHTJrA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Aug 2017 05:47:00 -0400
Received: (qmail 27773 invoked by uid 109); 20 Aug 2017 09:47:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 20 Aug 2017 09:46:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13005 invoked by uid 111); 20 Aug 2017 09:47:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sun, 20 Aug 2017 05:47:26 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 20 Aug 2017 05:46:57 -0400
Date:   Sun, 20 Aug 2017 05:46:57 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>, git@vger.kernel.org
Subject: [PATCH] doc: fix typo in sendemail.identity
Message-ID: <20170820094657.3uafp723ljg6o25p@sigill.intra.peff.net>
References: <xmqq60dkbma1.fsf@gitster.mtv.corp.google.com>
 <20170820094009.z23wclpku35txflg@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170820094009.z23wclpku35txflg@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 20, 2017 at 05:40:09AM -0400, Jeff King wrote:

> Subject: [PATCH] doc/interpret-trailers: fix "the this" typo

Looks like this is a not-uncommon error. Here's another one (not part of
the same patch since the interpret-trailers one isn't even in 'master'
yet).

-- >8 --
Subject: [PATCH] doc: fix typo in sendemail.identity

Saying "the this" is an obvious typo. But while we're here,
let's polish the English on the second half of the sentence,
too.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/config.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index a6a589a735..012919938f 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2895,8 +2895,8 @@ sendemail.smtpsslcertpath::
 
 sendemail.<identity>.*::
 	Identity-specific versions of the 'sendemail.*' parameters
-	found below, taking precedence over those when the this
-	identity is selected, through command-line or
+	found below, taking precedence over those when this
+	identity is selected, through either the command-line or
 	`sendemail.identity`.
 
 sendemail.aliasesFile::
-- 
2.14.1.495.ged40d10435

