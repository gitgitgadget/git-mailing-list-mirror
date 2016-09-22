Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C460B207EC
	for <e@80x24.org>; Thu, 22 Sep 2016 07:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752426AbcIVH0M (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Sep 2016 03:26:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:46542 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751263AbcIVH0L (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2016 03:26:11 -0400
Received: (qmail 20033 invoked by uid 109); 22 Sep 2016 07:26:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 22 Sep 2016 07:26:10 +0000
Received: (qmail 6694 invoked by uid 111); 22 Sep 2016 07:26:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 22 Sep 2016 03:26:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Sep 2016 03:26:07 -0400
Date:   Thu, 22 Sep 2016 03:26:07 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     esr@thyrsus.com
Subject: [PATCH 2/3] docs/cvs-migration: update link to cvsps homepage
Message-ID: <20160922072607.jptzsuew3l7q6wmu@sigill.intra.peff.net>
References: <20160922072350.ivjrfuedodd2rezn@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160922072350.ivjrfuedodd2rezn@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The old page gives a 404 now. Searching for "cvsps" via
Google returns a GitHub project page as the top hit.

Reported-by: Dan Pritts
Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/gitcvs-migration.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gitcvs-migration.txt b/Documentation/gitcvs-migration.txt
index b06e852..faee5c2 100644
--- a/Documentation/gitcvs-migration.txt
+++ b/Documentation/gitcvs-migration.txt
@@ -117,7 +117,7 @@ Importing a CVS archive
 -----------------------
 
 First, install version 2.1 or higher of cvsps from
-http://www.cobite.com/cvsps/[http://www.cobite.com/cvsps/] and make
+https://github.com/andreyvit/cvsps[https://github.com/andreyvit/cvsps] and make
 sure it is in your path.  Then cd to a checked out CVS working directory
 of the project you are interested in and run linkgit:git-cvsimport[1]:
 
-- 
2.10.0.482.gae5a597

