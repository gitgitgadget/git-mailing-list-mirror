Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 714E020323
	for <e@80x24.org>; Wed, 22 Mar 2017 21:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751363AbdCVVls (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 17:41:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:49711 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750812AbdCVVlr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 17:41:47 -0400
Received: (qmail 28007 invoked by uid 109); 22 Mar 2017 21:41:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Mar 2017 21:41:44 +0000
Received: (qmail 32038 invoked by uid 111); 22 Mar 2017 21:41:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Mar 2017 17:41:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Mar 2017 17:41:39 -0400
Date:   Wed, 22 Mar 2017 17:41:39 -0400
From:   Jeff King <peff@peff.net>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] stash: don't show internal implementation details
Message-ID: <20170322214139.3nqxdzfxar5nqawo@sigill.intra.peff.net>
References: <20170319202351.8825-1-t.gummerer@gmail.com>
 <20170321221219.28041-1-t.gummerer@gmail.com>
 <20170321221219.28041-2-t.gummerer@gmail.com>
 <20170321221445.3jpaoce7qbshtdoq@sigill.intra.peff.net>
 <20170322213347.GF27158@hank>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170322213347.GF27158@hank>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 22, 2017 at 09:33:47PM +0000, Thomas Gummerer wrote:

> > > -	sed -e 1,2d >actual && # drop "Saved..." and "HEAD is now..."
> > > +	sed -e 1,1d >actual && # drop "Saved..."
> > >  	test_i18ncmp expect actual
> > >  '
> > 
> > This too, though I think "1d" would be the more usual way to say it.
> 
> Right thanks, I'll keep that in mind for another time. (I guess just
> changing this doesn't warrant a re-roll?)

Nah, I don't think it's important enough (and I give even odds that
Junio may just tweak it while applying).

-Peff
