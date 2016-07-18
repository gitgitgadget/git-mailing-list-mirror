Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62A862018B
	for <e@80x24.org>; Mon, 18 Jul 2016 18:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751717AbcGRS6c (ORCPT <rfc822;e@80x24.org>);
	Mon, 18 Jul 2016 14:58:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:46537 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751560AbcGRS6a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2016 14:58:30 -0400
Received: (qmail 27396 invoked by uid 102); 18 Jul 2016 18:58:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 18 Jul 2016 14:58:30 -0400
Received: (qmail 6095 invoked by uid 107); 18 Jul 2016 18:58:52 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 18 Jul 2016 14:58:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Jul 2016 12:58:26 -0600
Date:	Mon, 18 Jul 2016 12:58:26 -0600
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Eric Wong <e@80x24.org>, norm@dad.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, l.s.r@web.de,
	git@vger.kernel.org
Subject: Re: [PATCH] pager: disable color when pager is "more"
Message-ID: <20160718185826.GB24726@sigill.intra.peff.net>
References: <201607171726.u6HHQShO005227@shell1.rawbw.com>
 <alpine.DEB.2.20.1607180922580.28832@virtualbox>
 <20160718091907.GA13588@starla>
 <20160718131653.GC19751@sigill.intra.peff.net>
 <xmqq8twylv8y.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8twylv8y.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jul 18, 2016 at 10:19:09AM -0700, Junio C Hamano wrote:

> > This is the tip of a smaller iceberg. See
> >
> >   http://public-inbox.org/git/52D87A79.6060600%40rawbw.com/t/#u
> >
> > for more discussion, and some patches that fix more cases (like "LESS"
> > without "R", or "more" that _does_ understand "R"). I think it was
> > discarded as being a little too intimate with the details of pagers, but
> > it does suck that the out-of-the-box experience on FreeBSD is not good.
> > Maybe we should revisit it.
> 
> Yup, the three-patch series at
> 
>     http://public-inbox.org/git/20140117041430.GB19551%40sigill.intra.peff.net/
> 
> would be a safe starting point that is low-impact.  I think what
> ended up being discarded was a more elaborate side topic that
> started from exploring the possibility of checking if LESS has 'R'
> in it to see if it is possible to help people with LESS that does
> not allow coloring explicitly exported.

Yeah, I only re-skimmed the thread, but I had the same impression. I am
traveling the next few days, so I will probably not get to it soon.  If
anybody wants to pick up and rebase/polish those patches as necessary,
be my guest.

-Peff
