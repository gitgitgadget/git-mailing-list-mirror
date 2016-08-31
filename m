Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD0E31FBB0
	for <e@80x24.org>; Wed, 31 Aug 2016 05:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755631AbcHaFC7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 01:02:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:35722 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750980AbcHaFC7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 01:02:59 -0400
Received: (qmail 4908 invoked by uid 109); 31 Aug 2016 05:02:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 31 Aug 2016 05:02:58 +0000
Received: (qmail 2991 invoked by uid 111); 31 Aug 2016 05:03:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 31 Aug 2016 01:03:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 31 Aug 2016 01:02:53 -0400
Date:   Wed, 31 Aug 2016 01:02:53 -0400
From:   Jeff King <peff@peff.net>
To:     Brian Henderson <henderson.bj@gmail.com>
Cc:     git@vger.kernel.org, e@80x24.org, gitster@pobox.com
Subject: [PATCH 1/3] diff-highlight: ignore test cruft
Message-ID: <20160831050253.5diq5coyedgpaiil@sigill.intra.peff.net>
References: <20160831050229.cabhfzqcpcpvkugl@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160831050229.cabhfzqcpcpvkugl@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These are the same as in the normal t/.gitignore, with the
exception of ".prove", as our Makefile does not support it.

Signed-off-by: Jeff King <peff@peff.net>
---
 contrib/diff-highlight/t/.gitignore | 2 ++
 1 file changed, 2 insertions(+)
 create mode 100644 contrib/diff-highlight/t/.gitignore

diff --git a/contrib/diff-highlight/t/.gitignore b/contrib/diff-highlight/t/.gitignore
new file mode 100644
index 0000000..7dcbb23
--- /dev/null
+++ b/contrib/diff-highlight/t/.gitignore
@@ -0,0 +1,2 @@
+/trash directory*
+/test-results
-- 
2.10.0.rc2.125.gcfb3d08

