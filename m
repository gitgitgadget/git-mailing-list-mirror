Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B629207EC
	for <e@80x24.org>; Thu, 22 Sep 2016 07:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752263AbcIVH1D (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Sep 2016 03:27:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:46546 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750947AbcIVH1C (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2016 03:27:02 -0400
Received: (qmail 20088 invoked by uid 109); 22 Sep 2016 07:26:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 22 Sep 2016 07:26:30 +0000
Received: (qmail 6711 invoked by uid 111); 22 Sep 2016 07:26:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 22 Sep 2016 03:26:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Sep 2016 03:26:28 -0400
Date:   Thu, 22 Sep 2016 03:26:28 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     esr@thyrsus.com
Subject: [PATCH 3/3] docs/cvs-migration: mention cvsimport caveats
Message-ID: <20160922072628.rs47hfiowtobw46s@sigill.intra.peff.net>
References: <20160922072350.ivjrfuedodd2rezn@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160922072350.ivjrfuedodd2rezn@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Back when this guide was written, cvsimport was the only
game in town. These days it is probably not the best option.
Rather than go into details, let's point people to the note
at the top of cvsimport which gives other options.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/gitcvs-migration.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/gitcvs-migration.txt b/Documentation/gitcvs-migration.txt
index faee5c2..4c6143c 100644
--- a/Documentation/gitcvs-migration.txt
+++ b/Documentation/gitcvs-migration.txt
@@ -116,6 +116,10 @@ they create are writable and searchable by other group members.
 Importing a CVS archive
 -----------------------
 
+NOTE: These instructions use the `git-cvsimport` script which ships with
+git, but other importers may provide better results. See the note in
+linkgit:git-cvsimport[1] for other options.
+
 First, install version 2.1 or higher of cvsps from
 https://github.com/andreyvit/cvsps[https://github.com/andreyvit/cvsps] and make
 sure it is in your path.  Then cd to a checked out CVS working directory
-- 
2.10.0.482.gae5a597
