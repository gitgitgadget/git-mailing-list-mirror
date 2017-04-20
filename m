Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E254C207BD
	for <e@80x24.org>; Thu, 20 Apr 2017 20:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033860AbdDTUdy (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 16:33:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:37200 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033856AbdDTUdv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 16:33:51 -0400
Received: (qmail 32289 invoked by uid 109); 20 Apr 2017 20:33:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Apr 2017 20:33:51 +0000
Received: (qmail 9052 invoked by uid 111); 20 Apr 2017 20:34:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Apr 2017 16:34:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Apr 2017 16:33:49 -0400
Date:   Thu, 20 Apr 2017 16:33:49 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 3/6] gitcore-tutorial: update broken link
Message-ID: <20170420203348.g5b2ttxm7wray4vy@sigill.intra.peff.net>
References: <20170420203203.xlbajdfzy7gp3hj3@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170420203203.xlbajdfzy7gp3hj3@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The slides for the Linux-mentoring presentation are no
longer available. Let's point to the wayback version of the
page, which works.

Note that the referenced diagram is also available on page
15 of [1]. We could link to that instead, but it's not clear
from the URL scheme ("uploads") whether it's going to stick
around forever.

[1] https://www.linuxfoundation.jp/jp_uploads/seminar20070313/Randy.pdf

Signed-off-by: Jeff King <peff@peff.net>
---
TBH, I'm not sure this diagram is actually showing anything all that
useful, and maybe the paragraph could be re-worded, or a better diagram
found. I restricted myself here to a technical fix for the broken link,
but I'd be fine with somebody taking a more editorial pass.

 Documentation/gitcore-tutorial.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
index 3a0ec8c53..7577f27ec 100644
--- a/Documentation/gitcore-tutorial.txt
+++ b/Documentation/gitcore-tutorial.txt
@@ -1429,7 +1429,7 @@ Although Git is a truly distributed system, it is often
 convenient to organize your project with an informal hierarchy
 of developers. Linux kernel development is run this way. There
 is a nice illustration (page 17, "Merges to Mainline") in
-http://www.xenotime.net/linux/mentor/linux-mentoring-2006.pdf[Randy Dunlap's presentation].
+https://web.archive.org/web/20120915203609/http://www.xenotime.net/linux/mentor/linux-mentoring-2006.pdf[Randy Dunlap's presentation].
 
 It should be stressed that this hierarchy is purely *informal*.
 There is nothing fundamental in Git that enforces the "chain of
-- 
2.13.0.rc0.363.g8726c260e

