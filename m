Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D90911FCA9
	for <e@80x24.org>; Wed, 14 Sep 2016 23:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764328AbcINXzw (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Sep 2016 19:55:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:43460 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1762678AbcINXzv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2016 19:55:51 -0400
Received: (qmail 22730 invoked by uid 109); 14 Sep 2016 23:55:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Sep 2016 23:55:51 +0000
Received: (qmail 5243 invoked by uid 111); 14 Sep 2016 23:56:01 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Sep 2016 19:56:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Sep 2016 16:55:48 -0700
Date:   Wed, 14 Sep 2016 16:55:48 -0700
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: Journal of Failed Git Experiments, Volume 1
Message-ID: <20160914235547.h3n2otje2hec6u7k@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I try a lot of different experiments with git performance, some of them
more hare-brained than others. The ones that succeed end up as real
patches. But I hate for the ones that fail to die a quiet death. Then
nobody learns what _doesn't_ work, and nobody has the opportunity to
point out the spot where I made a stupid mistake that invalidates the
whole result.

Here are two performance experiments that did _not_ turn out. They
are in patch form, because I want to document exactly what I did
(especially because it helps in the "stupid mistake" case, or if
somebody wants to try building on my results).

So without further ado:

  [1/2]: obj_hash: convert to a critbit tree
  [2/2]: use zstd zlib wrapper

-Peff
