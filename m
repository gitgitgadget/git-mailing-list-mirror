Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A33DA1FF6D
	for <e@80x24.org>; Thu, 15 Dec 2016 14:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932192AbcLOORX (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Dec 2016 09:17:23 -0500
Received: from cloud.peff.net ([104.130.231.41]:56999 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752249AbcLOORX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2016 09:17:23 -0500
Received: (qmail 29191 invoked by uid 109); 15 Dec 2016 14:17:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Dec 2016 14:17:22 +0000
Received: (qmail 2177 invoked by uid 111); 15 Dec 2016 14:18:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Dec 2016 09:18:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Dec 2016 09:17:19 -0500
Date:   Thu, 15 Dec 2016 09:17:19 -0500
From:   Jeff King <peff@peff.net>
To:     Chiel ten Brinke <ctenbrinke@gmail.com>
Cc:     git@vger.kernel.org
Subject: [PATCH] README: replace gmane link with public-inbox
Message-ID: <20161215141719.52peppv5pbjk3nuf@sigill.intra.peff.net>
References: <CAFw20syajXbjCQRcrqCv8pS9JwSge7-V4Hsg96n8SpYv2jJneQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFw20syajXbjCQRcrqCv8pS9JwSge7-V4Hsg96n8SpYv2jJneQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 15, 2016 at 02:57:18PM +0100, Chiel ten Brinke wrote:

> Btw, the link in the README
> http://news.gmane.org/gmane.comp.version-control.git/ is dead.

Yes, the status of gmane was up in the air for a while, but I think we
can give it up as dead now (at least for our purposes).

-- >8 --
Subject: README: replace gmane link with public-inbox

The general status and future of gmane is unclear at this
point, but certainly it does not seem to be carrying
gmane.comp.version-control.git at all anymore. Let's point
to public-inbox.org, which seems to be the favored archive
on the list these days (and which uses message-ids in its
URLs, making the links somewhat future-proof).

Reported-by: Chiel ten Brinke <ctenbrinke@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 README.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/README.md b/README.md
index bd8a918a9..c0cd5580e 100644
--- a/README.md
+++ b/README.md
@@ -33,7 +33,7 @@ requests, comments and patches to git@vger.kernel.org (read
 [Documentation/SubmittingPatches][] for instructions on patch submission).
 To subscribe to the list, send an email with just "subscribe git" in
 the body to majordomo@vger.kernel.org. The mailing list archives are
-available at http://news.gmane.org/gmane.comp.version-control.git/,
+available at https://public-inbox.org/git,
 http://marc.info/?l=git and other archival sites.
 
 The maintainer frequently sends the "What's cooking" reports that
-- 
2.11.0.348.g960a0b554

