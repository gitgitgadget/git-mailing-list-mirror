Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0648D20401
	for <e@80x24.org>; Wed, 21 Jun 2017 18:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751133AbdFUSzW (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 14:55:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:47830 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751028AbdFUSzV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 14:55:21 -0400
Received: (qmail 4169 invoked by uid 109); 21 Jun 2017 18:55:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 21 Jun 2017 18:55:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26475 invoked by uid 111); 21 Jun 2017 18:55:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 21 Jun 2017 14:55:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Jun 2017 14:55:19 -0400
Date:   Wed, 21 Jun 2017 14:55:19 -0400
From:   Jeff King <peff@peff.net>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Using '--help' for aliases
Message-ID: <20170621185518.nhnqlkbt63hdoate@sigill.intra.peff.net>
References: <1498070489.32360.14.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1498070489.32360.14.camel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 22, 2017 at 12:11:29AM +0530, Kaartic Sivaraam wrote:

> I am yet another user of 'git alias' (who wouldn't ?). It has become so
> natural to me to use the aliased version that at some point of time I
> tried the following,
> 
> > $ git co --help
> > `git co' is aliased to `checkout'
> 
> That made me wonder. Git is able to inform the user that 'co' is
> aliased to 'checkout' but isn't it possible for it to take one step
> more to display help ? Just wondering if there were any reason for not
> doing it.

It could do that. I think we even discussed it at one point, but I
didn't dig up the thread. However, you have the problem that running
"man checkout" is likely to clobber the mention of the alias. So the
question is whether it is more important to tell the user that it's an
alias (and which options the alias is using!), or to show them the
referred command's manpage.

-Peff
