Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3324207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 12:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941223AbcIZMLI (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 08:11:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:48061 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933347AbcIZMLH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 08:11:07 -0400
Received: (qmail 19314 invoked by uid 109); 26 Sep 2016 12:11:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 26 Sep 2016 12:11:06 +0000
Received: (qmail 4561 invoked by uid 111); 26 Sep 2016 12:11:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 26 Sep 2016 08:11:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Sep 2016 08:11:04 -0400
Date:   Mon, 26 Sep 2016 08:11:04 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 04/10] get_short_sha1: peel tags when looking for treeish
Message-ID: <20160926121104.nonvu7h3shygspi6@sigill.intra.peff.net>
References: <20160926115720.p2yb22lcq37gboon@sigill.intra.peff.net>
 <20160926115947.hksmtkqp3i4tfftx@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160926115947.hksmtkqp3i4tfftx@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 26, 2016 at 07:59:48AM -0400, Jeff King wrote:

> Subject: Re: [PATCH 04/10] get_short_sha1: peel tags when looking for treeish
>
> The treeish disambiguation function tries to peel tags, but
> it does so by calling:

Probably the subject should be "parse tags when...". We already try to
peel, we just don't do it right.

-Peff
