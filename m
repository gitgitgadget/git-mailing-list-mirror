Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9130E207BD
	for <e@80x24.org>; Thu, 20 Apr 2017 20:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033866AbdDTUeq (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 16:34:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:37203 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033862AbdDTUeo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 16:34:44 -0400
Received: (qmail 32360 invoked by uid 109); 20 Apr 2017 20:34:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Apr 2017 20:34:43 +0000
Received: (qmail 9069 invoked by uid 111); 20 Apr 2017 20:35:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Apr 2017 16:35:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Apr 2017 16:34:41 -0400
Date:   Thu, 20 Apr 2017 16:34:41 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 4/6] docs/archimport: quote sourcecontrol.net reference
Message-ID: <20170420203441.mrlwbkqinub7m225@sigill.intra.peff.net>
References: <20170420203203.xlbajdfzy7gp3hj3@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170420203203.xlbajdfzy7gp3hj3@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-archimport has an option to register archives at
mirrors.sourcecontrol.net. The sourcecontrol.net domain
still exists, but that hostname no longer exists.

That means this feature is presumably broken. I'll leave the
examination and modification of that to people who might
actually use archimport. But in the meantime, let's wrap the
reference in the documentation in backticks, which will
avoid turning it into a broken link (and thus polluting
linkchecker results).

Signed-off-by: Jeff King <peff@peff.net>
---
It seems unlikely to me that anybody is using "arch" at all in 2017, so
maybe this whole command could be put to rest. But I didn't want to step
on any toes.

 Documentation/git-archimport.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-archimport.txt b/Documentation/git-archimport.txt
index 163b9f6f4..ea7065336 100644
--- a/Documentation/git-archimport.txt
+++ b/Documentation/git-archimport.txt
@@ -96,7 +96,7 @@ OPTIONS
 	pruned.
 
 -a::
-	Attempt to auto-register archives at http://mirrors.sourcecontrol.net
+	Attempt to auto-register archives at `http://mirrors.sourcecontrol.net`
 	This is particularly useful with the -D option.
 
 -t <tmpdir>::
-- 
2.13.0.rc0.363.g8726c260e

