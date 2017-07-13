Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 575B8202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 14:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752503AbdGMO4Y (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 10:56:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:39086 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752378AbdGMO4Y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 10:56:24 -0400
Received: (qmail 23890 invoked by uid 109); 13 Jul 2017 14:56:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Jul 2017 14:56:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32048 invoked by uid 111); 13 Jul 2017 14:56:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Jul 2017 10:56:35 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Jul 2017 10:56:21 -0400
Date:   Thu, 13 Jul 2017 10:56:21 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 02/15] docs/for-each-ref: update pointer to color syntax
Message-ID: <20170713145620.pwsyvsudtnyfcvxg@sigill.intra.peff.net>
References: <20170713145553.3epnsw23zajwg3ee@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170713145553.3epnsw23zajwg3ee@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The documentation for the %(color) placeholder refers to the
color.branch.* config for more details. But those details
moved to their own section in b92c1a28f
(Documentation/config.txt: describe 'color' value type in
the "Values" section, 2015-03-03).  Let's update our
pointer. We can steal the text from 30cfe72d3 (pretty: fix
document link for color specification, 2016-10-11), which
fixed the same problem in a different place.

While we're at it, let's give an example, which makes the
syntax much more clear than just the text.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-for-each-ref.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 03e187a10..cc42c1283 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -156,8 +156,10 @@ HEAD::
 	otherwise.
 
 color::
-	Change output color.  Followed by `:<colorname>`, where names
-	are described in `color.branch.*`.
+	Change output color. Followed by `:<colorname>`, where color
+	names are described under Values in the "CONFIGURATION FILE"
+	section of linkgit:git-config[1].  For example,
+	`%(color:bold red)`.
 
 align::
 	Left-, middle-, or right-align the content between
-- 
2.13.2.1157.gc6daca446

