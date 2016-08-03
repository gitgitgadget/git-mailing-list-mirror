Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCA561F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 16:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754339AbcHCQ45 (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 12:56:57 -0400
Received: from cloud.peff.net ([50.56.180.127]:53907 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751351AbcHCQ44 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 12:56:56 -0400
Received: (qmail 6708 invoked by uid 102); 3 Aug 2016 16:56:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Aug 2016 12:56:55 -0400
Received: (qmail 2740 invoked by uid 107); 3 Aug 2016 16:57:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Aug 2016 12:57:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Aug 2016 12:56:52 -0400
Date:	Wed, 3 Aug 2016 12:56:52 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Sixt <j6t@kdbg.org>, Duy Nguyen <pclouds@gmail.com>,
	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: patch submission process, was Re: [PATCH v6 06/16]
 merge_recursive: abort properly upon errors
Message-ID: <20160803165652.zek5df7tv5reg6w4@sigill.intra.peff.net>
References: <cover.1469547160.git.johannes.schindelin@gmx.de>
 <cover.1470051326.git.johannes.schindelin@gmx.de>
 <8ff71aba37be979f05abf88f467ec932aa522bdd.1470051326.git.johannes.schindelin@gmx.de>
 <xmqqlh0gjpr6.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1608021004080.79248@virtualbox>
 <xmqqy44ec15p.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1608031021050.79248@virtualbox>
 <CAPc5daXJzMsJf5K84XBFuQ5=q_OwtYUW2FikZ2QsZWk8fa9jgg@mail.gmail.com>
 <20160803163449.iwjv4youmsf6okme@sigill.intra.peff.net>
 <xmqqbn19aj5t.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbn19aj5t.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 03, 2016 at 09:53:18AM -0700, Junio C Hamano wrote:

> > Leaving aside Dscho's questions of whether pulling patches from email is
> > convenient for most submitters (it certainly is for me, but I recognize
> > that it is not for many), I would much rather see incremental fixup
> > patches from you than whole "here's what I queued" responses.
> 
> Ah, yes, I misspoke.  It should be either an incremental diff or
> in-line comment to spell out what got changed as a response to the
> patch.
> 
> I find myself fixing the title the most often, which is part of the
> "log message" you pointed out that would not convey well with the
> "incremental diff" approach.

I mentioned a micro-format elsewhere in my message. And it certainly is
nice to have something that can be applied in an automatic way. But in
practice, most review comments, for the commit message _or_ the text,
are given in human-readable terms. And as a human, I read and apply them
in sequence.

That pushes work onto the submitter, but saves work from the reviewers,
who can quickly say "something like this..." without having to worry
about making a full change, formatting it as a diff, etc.

I do think that's the right time-tradeoff to be making, as we have more
submitters than reviewers.

-Peff
