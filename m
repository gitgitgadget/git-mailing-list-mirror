Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A6B020229
	for <e@80x24.org>; Fri, 21 Oct 2016 00:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754784AbcJUAW4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 20:22:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:60414 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753359AbcJUAWz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 20:22:55 -0400
Received: (qmail 16450 invoked by uid 109); 21 Oct 2016 00:22:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Oct 2016 00:22:55 +0000
Received: (qmail 31755 invoked by uid 111); 21 Oct 2016 00:23:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Oct 2016 20:23:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Oct 2016 20:22:52 -0400
Date:   Thu, 20 Oct 2016 20:22:52 -0400
From:   Jeff King <peff@peff.net>
To:     Philip Oakley <philipoakley@iee.org>
Cc:     GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] doc: fix merge-base ASCII art tab spacing
Message-ID: <20161021002252.u5v3mwjopvsdcexg@sigill.intra.peff.net>
References: <20161020234009.1768-1-philipoakley@iee.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161020234009.1768-1-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 21, 2016 at 12:40:09AM +0100, Philip Oakley wrote:

> The doc-tool stack does not always respect the 'tab = 8 spaces' rule,
> particularly the git-scm doc pages https://git-scm.com/docs/git-merge-base
> and the Git generated html pages.

Hmm, I thought git-scm.com was fixed by:

  https://github.com/git/git-scm.com/commit/1e13397edccdecd0e06ff851cffaa1c44e140bf3

Not that I mind using spaces consistently here on principle. I just
didn't think it was a problem anymore (my asciidoc seems to get it
right, too).

-Peff
