Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18B5820188
	for <e@80x24.org>; Fri, 12 May 2017 09:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933071AbdELJ2v (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 05:28:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:50231 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755605AbdELJ22 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 05:28:28 -0400
Received: (qmail 4295 invoked by uid 109); 12 May 2017 09:28:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 May 2017 09:28:27 +0000
Received: (qmail 22459 invoked by uid 111); 12 May 2017 09:28:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 May 2017 05:28:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 May 2017 05:28:25 -0400
Date:   Fri, 12 May 2017 05:28:25 -0400
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Sebastian Schuberth <sschuberth@gmail.com>,
        Raphael Stolt <raphael.stolt@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/4] docs/config: clarify include/includeIf relationship
Message-ID: <20170512092825.wfxnnlk4qiced5ow@sigill.intra.peff.net>
References: <20170511090905.tvkb4bk2ddjzjip4@sigill.intra.peff.net>
 <20170511091047.2dw52pnriulhjky3@sigill.intra.peff.net>
 <0013fb73-12f2-a365-963e-ed517ea53dc7@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0013fb73-12f2-a365-963e-ed517ea53dc7@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 11, 2017 at 05:47:28PM +0100, Ramsay Jones wrote:

> > diff --git a/Documentation/config.txt b/Documentation/config.txt
> > index 475e874d5..d5a453ed3 100644
> > --- a/Documentation/config.txt
> > +++ b/Documentation/config.txt
> > @@ -79,14 +79,20 @@ escape sequences) are invalid.
> >  Includes
> >  ~~~~~~~~
> >  
> > +The `include` and `includeIf` sections allow you include config
> 
> s/you include/you to include/

Oof, yeah. Too many revisions, not enough proofreading. I don't think
these otherwise need re-rolled, so hopefully Junio can just mark it up.

Thanks.

-Peff
