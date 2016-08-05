Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6546F2018E
	for <e@80x24.org>; Fri,  5 Aug 2016 18:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423070AbcHESUR (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 14:20:17 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:50942 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761979AbcHESUI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 14:20:08 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 480CD2018E;
	Fri,  5 Aug 2016 18:19:57 +0000 (UTC)
Date:	Fri, 5 Aug 2016 18:19:57 +0000
From:	Eric Wong <e@80x24.org>
To:	Jeff King <peff@peff.net>
Cc:	git@vger.kernel.org
Subject: Re: [ANNOUNCE] more archives of this list
Message-ID: <20160805181957.GA24535@dcvr>
References: <20160710004813.GA20210@dcvr.yhbt.net>
 <20160805092805.w3nwv2l6jkbuwlzf@sigill.intra.peff.net>
 <20160805093544.scvl4yshkfg2l26p@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160805093544.scvl4yshkfg2l26p@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> wrote:
> On Fri, Aug 05, 2016 at 05:28:05AM -0400, Jeff King wrote:
> > I do find it visually a little harder to navigate through threads,
> > because there's not much styling there, and the messages seem to run
> > into one another. I don't know if a border around the divs or something
> > would help. I'm really terrible at that kind of visual design.
> 
> I took a peek at doing something simple like:
> 
>   pre {
>     border-style: solid;
>     border-width: 1px;
>     background: #dddddd;
>   }
> 
> but it looks like there's no HTML structure at all to the current
> output. It's just one big <pre> tag with various levels of indentation
> to represent the messages.

I added an <hr> between each message so the /T/ view ought to be more
readable:

https://public-inbox.org/meta/20160805181459.24420-1-e@80x24.org/
