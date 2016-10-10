Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1788220989
	for <e@80x24.org>; Mon, 10 Oct 2016 20:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751743AbcJJUzY (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 16:55:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:55351 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751576AbcJJUzX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 16:55:23 -0400
Received: (qmail 16588 invoked by uid 109); 10 Oct 2016 20:55:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Oct 2016 20:55:23 +0000
Received: (qmail 1959 invoked by uid 111); 10 Oct 2016 20:55:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Oct 2016 16:55:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Oct 2016 16:55:21 -0400
Date:   Mon, 10 Oct 2016 16:55:21 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Tom Hale <tom@hale.ee>, git <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: %C(auto) not working as expected
Message-ID: <20161010205521.vxpwjrlelig3ilpe@sigill.intra.peff.net>
References: <cb81631e-9623-9020-f955-ec215b493a50@hale.ee>
 <f35965e9-2901-b9b5-92e5-9bc7fe673637@web.de>
 <65d8def3-df62-6c45-7d8f-79b6a8769bf5@hale.ee>
 <25c17e16-2456-7da3-ae22-2dc812a3aa0d@web.de>
 <20161009234617.y6xfjyv6xjkf2afi@sigill.intra.peff.net>
 <6689ae49-6095-7bb4-ea06-1aaded174811@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6689ae49-6095-7bb4-ea06-1aaded174811@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 10, 2016 at 10:52:47PM +0200, René Scharfe wrote:

> > I like the intent here, though I found "Values, color" hard to parse (it
> > was not immediately clear that you mean "the color paragraph of the
> > Values section", as commas are already being used in that sentence for
> > the parenthetical phrase).
> > 
> > I'm not sure how to say that succinctly, as we are four levels deep
> > (git-config -> configuration file -> values -> color). Too bad there is
> > no good link syntax for it. Maybe:
> > 
> >   ...color specification, as described in linkgit:git-config[1] (see the
> >   paragraph on colors in the "Values" section, under "CONFIGURATION
> >   FILE")
> > 
> > or something.
> 
> That's better.  Or we could remove the "color" part and trust readers to
> find the right paragraph in the Values sub-section?
> 
> -- '%C(...)': color specification, as described in color.branch.* config option;
> +- '%C(...)': color specification, as described under Values in the
> +  "CONFIGURATION FILE" section of linkgit:git-config[1];

Yeah, I think that is plenty of roadmap to give the user.

-Peff
