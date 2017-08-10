Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9875320899
	for <e@80x24.org>; Thu, 10 Aug 2017 07:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751469AbdHJH7G (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 03:59:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:34176 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750735AbdHJH7F (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 03:59:05 -0400
Received: (qmail 26886 invoked by uid 109); 10 Aug 2017 07:59:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 Aug 2017 07:59:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2332 invoked by uid 111); 10 Aug 2017 07:59:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 Aug 2017 03:59:28 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Aug 2017 03:59:03 -0400
Date:   Thu, 10 Aug 2017 03:59:03 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 5/5] interpret-trailers: add --parse convenience option
Message-ID: <20170810075903.2f4jsaog4ttvaf4p@sigill.intra.peff.net>
References: <20170809122147.g44nwaitzctbadzm@sigill.intra.peff.net>
 <20170809122642.uwhv2epmgmr7wrk5@sigill.intra.peff.net>
 <CAGZ79kZ8_bx3M6vac9MDLJjZCS5vqosPhO51dmGjC=3Fiz3O6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kZ8_bx3M6vac9MDLJjZCS5vqosPhO51dmGjC=3Fiz3O6Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 09, 2017 at 11:20:12AM -0700, Stefan Beller wrote:

> > +--parse::
> > +       A convenience alias for `--only-trailers --only-existing
> > +       --normalize`.
> 
> Somewhere in this series, we'd want to not just describe each
> of the new knobs, but reword the initial description, too?
> 
>     git-interpret-trailers - help add structured information
>         into commit messages
> 
> Maybe a s/add/handle/ s/into// is enough?

Thanks, my initial attempt actually included that, when I thought I was
going to have a unique "parsing mode". But then as it grew into
individual options, I dropped it. And forgot how modification-centric
the rest of the manpage description is. I'll try to include something in
the final commit, which is where the parsing mode is all tied together.

-Peff
