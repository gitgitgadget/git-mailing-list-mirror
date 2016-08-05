Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 803512018E
	for <e@80x24.org>; Fri,  5 Aug 2016 20:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2995614AbcHEUW4 (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 16:22:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:55547 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S2995475AbcHEUWx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 16:22:53 -0400
Received: (qmail 9583 invoked by uid 102); 5 Aug 2016 20:22:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 05 Aug 2016 16:22:53 -0400
Received: (qmail 30051 invoked by uid 107); 5 Aug 2016 20:23:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 05 Aug 2016 16:23:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Aug 2016 16:22:50 -0400
Date:	Fri, 5 Aug 2016 16:22:50 -0400
From:	Jeff King <peff@peff.net>
To:	Eric Wong <e@80x24.org>
Cc:	git@vger.kernel.org
Subject: Re: [ANNOUNCE] more archives of this list
Message-ID: <20160805202250.d23na5xdkmtnjgey@sigill.intra.peff.net>
References: <20160710004813.GA20210@dcvr.yhbt.net>
 <20160805092805.w3nwv2l6jkbuwlzf@sigill.intra.peff.net>
 <20160805093544.scvl4yshkfg2l26p@sigill.intra.peff.net>
 <20160805181957.GA24535@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160805181957.GA24535@dcvr>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Aug 05, 2016 at 06:19:57PM +0000, Eric Wong wrote:

> Jeff King <peff@peff.net> wrote:
> > On Fri, Aug 05, 2016 at 05:28:05AM -0400, Jeff King wrote:
> > > I do find it visually a little harder to navigate through threads,
> > > because there's not much styling there, and the messages seem to run
> > > into one another. I don't know if a border around the divs or something
> > > would help. I'm really terrible at that kind of visual design.
> > 
> > I took a peek at doing something simple like:
> > 
> >   pre {
> >     border-style: solid;
> >     border-width: 1px;
> >     background: #dddddd;
> >   }
> > 
> > but it looks like there's no HTML structure at all to the current
> > output. It's just one big <pre> tag with various levels of indentation
> > to represent the messages.
> 
> I added an <hr> between each message so the /T/ view ought to be more
> readable:
> 
> https://public-inbox.org/meta/20160805181459.24420-1-e@80x24.org/

Thanks. That's definitely an improvement. I still think the styling
could go further, but I don't expect you to do it. It's something I may
look into, but I should probably try to clear out my backlog of
"to-review" patches before I go off spending time on it. :)

-Peff
