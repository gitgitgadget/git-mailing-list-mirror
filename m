Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB2A01F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 18:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756631AbcHCSPN (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 14:15:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:54000 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754352AbcHCSPG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 14:15:06 -0400
Received: (qmail 10035 invoked by uid 102); 3 Aug 2016 18:08:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Aug 2016 14:08:24 -0400
Received: (qmail 3743 invoked by uid 107); 3 Aug 2016 18:08:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Aug 2016 14:08:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Aug 2016 14:08:20 -0400
Date:	Wed, 3 Aug 2016 14:08:20 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Michael Haggerty <mhagger@alum.mit.edu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Chris Packham <judge.packham@gmail.com>, git@vger.kernel.org
Subject: Re: [RFC/PATCH] rebase--interactive: Add "sign" command
Message-ID: <20160803180820.2raazmsfjavoaogo@sigill.intra.peff.net>
References: <20160803084743.3299-1-judge.packham@gmail.com>
 <alpine.DEB.2.20.1608031621590.107993@virtualbox>
 <xmqqr3a5al7z.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr3a5al7z.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 03, 2016 at 09:08:48AM -0700, Junio C Hamano wrote:

> > However, I could imagine that we actually want this to be more extensible.
> > After all, all you are doing is to introduce a new rebase -i command that
> > does nothing else than shelling out to a command.
> 
> Yup, I tend to agree.
> 
> Adding "sign" feature (i.e. make it pass -S to "commit [--amend]")
> may be a good thing, but adding "sign" command to do so is not a
> great design.

I'm not sure what you mean by "feature" here, but it reminded me of
Michael's proposal to allow options to todo lines:

  http://public-inbox.org/git/530DA00E.4090402@alum.mit.edu/

which would allow:

  pick -S 1234abcd

If that's what you meant, I think it is a good idea. :)

-Peff
