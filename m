Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3A82207BD
	for <e@80x24.org>; Thu, 20 Apr 2017 20:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033766AbdDTUcJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 16:32:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:37191 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033763AbdDTUcH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 16:32:07 -0400
Received: (qmail 32211 invoked by uid 109); 20 Apr 2017 20:32:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Apr 2017 20:32:06 +0000
Received: (qmail 8990 invoked by uid 111); 20 Apr 2017 20:32:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Apr 2017 16:32:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Apr 2017 16:32:04 -0400
Date:   Thu, 20 Apr 2017 16:32:04 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/6] fix broken links in Documentation/
Message-ID: <20170420203203.xlbajdfzy7gp3hj3@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've been looking at running an automated link-checker on git-scm.com.
But as it hosts HTML rendered from our Documentation/ directory, it
inherits any broken links that we have here. :)

This series fixes all the issues I could find.

  [1/6]: doc: use https links to avoid http redirect
  [2/6]: doc: replace or.cz gitwiki link with git.wiki.kernel.org
  [3/6]: gitcore-tutorial: update broken link
  [4/6]: docs/archimport: quote sourcecontrol.net reference
  [5/6]: docs/bisect-lk2009: update nist report link
  [6/6]: docs/bisect-lk2009: update java code conventions link

 Documentation/git-archimport.txt                 |  2 +-
 Documentation/git-bisect-lk2009.txt              | 14 +++++++-------
 Documentation/git-tools.txt                      |  2 +-
 Documentation/gitcore-tutorial.txt               |  2 +-
 Documentation/gitweb.conf.txt                    |  4 ++--
 Documentation/howto/rebuild-from-update-hook.txt |  4 ++--
 6 files changed, 14 insertions(+), 14 deletions(-)

-Peff
