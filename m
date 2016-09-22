Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC02F207EC
	for <e@80x24.org>; Thu, 22 Sep 2016 07:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752336AbcIVHXz (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Sep 2016 03:23:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:46534 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752277AbcIVHXy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2016 03:23:54 -0400
Received: (qmail 19903 invoked by uid 109); 22 Sep 2016 07:23:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 22 Sep 2016 07:23:52 +0000
Received: (qmail 6646 invoked by uid 111); 22 Sep 2016 07:24:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 22 Sep 2016 03:24:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Sep 2016 03:23:50 -0400
Date:   Thu, 22 Sep 2016 03:23:50 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     esr@thyrsus.com
Subject: [PATCH 0/3] update git cvs import documentation
Message-ID: <20160922072350.ivjrfuedodd2rezn@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I dreamed a dream that I would never have to think about git-cvsimport
again. And yet. Somebody reported[1] that the link to cvsps in
gitcvs-migration is broken. While fixing it, I noticed a few other
out-of-date items. I haven't used any of these tools myself in years,
but hopefully these changes are minimal no-brainers.

  [1/3]: docs/cvsimport: prefer cvs-fast-export to parsecvs
  [2/3]: docs/cvs-migration: update link to cvsps homepage
  [3/3]: docs/cvs-migration: mention cvsimport caveats

-Peff

[1] https://github.com/git/git-scm.com/issues/851
