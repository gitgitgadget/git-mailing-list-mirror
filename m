Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E84552018F
	for <e@80x24.org>; Sat,  9 Jul 2016 23:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933256AbcGIXf5 (ORCPT <rfc822;e@80x24.org>);
	Sat, 9 Jul 2016 19:35:57 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:39358 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933099AbcGIXf4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jul 2016 19:35:56 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 954A62018F;
	Sat,  9 Jul 2016 23:35:55 +0000 (UTC)
Date:	Sat, 9 Jul 2016 23:35:55 +0000
From:	Eric Wong <e@80x24.org>
To:	Michael J Gruber <git@drmicha.warpmail.net>
Cc:	Jacob Keller <jacob.keller@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	Git mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: Over-/underquoting, was Re: [PATCH] revert: clarify seemingly
 bogus OPT_END repetition
Message-ID: <20160709233555.GA8926@dcvr.yhbt.net>
References: <5b424bad41ca027b39eea4b1fa9d87df0a489e0f.1467719888.git.johannes.schindelin@gmx.de>
 <20160705202820.GA14496@sigill.intra.peff.net>
 <20160705204447.GB14496@sigill.intra.peff.net>
 <CA+P7+xqODaXn2NFY-=Ktr1stzR1mu6_ZO7Lfgj7AEzhzxhLAbw@mail.gmail.com>
 <alpine.DEB.2.20.1607060857240.6426@virtualbox>
 <d1e0e688-a309-2a01-4ee2-c1af9d71cea0@drmicha.warpmail.net>
 <alpine.DEB.2.20.1607061514200.6426@virtualbox>
 <CA+P7+xpVbSbHP-j1c+zQjMALb_C5eOb-c23290AbVjufxOHqoQ@mail.gmail.com>
 <CAA19uiQLBUyrdrk6w4kZ572cEdEDNqm30J6Ut3yemU4Rwx6Qcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA19uiQLBUyrdrk6w4kZ572cEdEDNqm30J6Ut3yemU4Rwx6Qcw@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Michael J Gruber <git@drmicha.warpmail.net> wrote:
> 2016-07-06 22:15 GMT+02:00 Jacob Keller <jacob.keller@gmail.com>:
> > On Wed, Jul 6, 2016 at 6:16 AM, Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> ...
> >>> It is not unheard of that a MUA can collapse and expand properly quoted
> >>> parts on request...
> >>
> >> Sure. Show me some kick-ass, scriptable mail client and I will have a
> >> look.

I like mutt since it lets me pipe stuff to arbitrary commands,
"T" works in the pager for toggling quoted text.

> > Yep, I haven't found a mail client that really works for me either :(
> 
> Every other day I want to get rid of Thunderbird... always on the
> verge of going (back) to mutt, though I do need some calendar
> integration and such.

It's possible to use both with IMAP (offlineimap + local dovecot works
well on slow connections).

I rely on at+atd to email myself and also maintain a text file over IMAP.

> Until the day when the scriptable mua we wish for comes upon us, may I
> recommend the "QuoteCollapse" extension to Thunderbird that transforms
> those huge quotes into neat short headlines with a twist(y).

The "T" (toggle-quoted) command in mutt hides quoted entirely, which
makes it a bit confusing, at times; but toggling again unhides it.
