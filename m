Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCA29207EC
	for <e@80x24.org>; Thu, 22 Sep 2016 07:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751496AbcIVHZb (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Sep 2016 03:25:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:46538 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751010AbcIVHZb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2016 03:25:31 -0400
Received: (qmail 20024 invoked by uid 109); 22 Sep 2016 07:25:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 22 Sep 2016 07:25:30 +0000
Received: (qmail 6676 invoked by uid 111); 22 Sep 2016 07:25:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 22 Sep 2016 03:25:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Sep 2016 03:25:28 -0400
Date:   Thu, 22 Sep 2016 03:25:28 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     esr@thyrsus.com
Subject: [PATCH 1/3] docs/cvsimport: prefer cvs-fast-export to parsecvs
Message-ID: <20160922072527.xy3q227ygs6orhfj@sigill.intra.peff.net>
References: <20160922072350.ivjrfuedodd2rezn@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160922072350.ivjrfuedodd2rezn@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

parsecvs maintenance was taken over by ESR, and the name
changed to cvs-fast-export as it learned to support that
output format. Let's point to cvs-fast-export, as it should
have additional bug-fixes and be more convenient to use.

Signed-off-by: Jeff King <peff@peff.net>
---
No opinion on how this compares to cvs2git these days, so I made the
minimal change here. Anyone may feel free to debate it, but kindly
remove me from the Cc of any flamewars. :)

 Documentation/git-cvsimport.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
index 41207a2..de1ebed 100644
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -22,7 +22,7 @@ DESCRIPTION
 deprecated; it does not work with cvsps version 3 and later.  If you are
 performing a one-shot import of a CVS repository consider using
 http://cvs2svn.tigris.org/cvs2git.html[cvs2git] or
-https://github.com/BartMassey/parsecvs[parsecvs].
+http://www.catb.org/esr/cvs-fast-export/[cvs-fast-export].
 
 Imports a CVS repository into Git. It will either create a new
 repository, or incrementally import into an existing one.
-- 
2.10.0.482.gae5a597

