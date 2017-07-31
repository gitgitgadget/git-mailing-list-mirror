Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8263A1F991
	for <e@80x24.org>; Mon, 31 Jul 2017 17:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751913AbdGaRpN (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Jul 2017 13:45:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:53558 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750999AbdGaRpM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2017 13:45:12 -0400
Received: (qmail 437 invoked by uid 109); 31 Jul 2017 17:45:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 31 Jul 2017 17:45:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27356 invoked by uid 111); 31 Jul 2017 17:45:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 31 Jul 2017 13:45:31 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 31 Jul 2017 13:45:09 -0400
Date:   Mon, 31 Jul 2017 13:45:09 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH v2 00/10] tag: only respect `pager.tag` in list-mode
Message-ID: <20170731174509.w5hwujpsa4dt3jxv@sigill.intra.peff.net>
References: <cover.1499723297.git.martin.agren@gmail.com>
 <cover.1500321657.git.martin.agren@gmail.com>
 <xmqq379qkalj.fsf@gitster.mtv.corp.google.com>
 <CAN0heSokk9RAYx7pB_qC5dbZ3N1ZJQgKkrmhrPXmyHjFsnJu7Q@mail.gmail.com>
 <20170731034632.r5m3ncgb5scqvltb@sigill.intra.peff.net>
 <CAN0heSonTXWPf-iTbwRbUc8CpYHoX7GBS5uCFFXn3bEPmWtitA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSonTXWPf-iTbwRbUc8CpYHoX7GBS5uCFFXn3bEPmWtitA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 31, 2017 at 07:44:27PM +0200, Martin Ågren wrote:

> On 31 July 2017 at 05:46, Jeff King <peff@peff.net> wrote:
> > On Sun, Jul 23, 2017 at 08:17:42PM +0200, Martin Ågren wrote:
> >
> >> On 21 July 2017 at 00:27, Junio C Hamano <gitster@pobox.com> wrote:
> >> > I tend to agree with you that 1-3/10 may be better off being a
> >> > single patch (or 3/10 dropped, as Brandon is working on losing it
> >> > nearby).  I would have expected 7-8/10 to be a single patch, as by
> >> > the time a reader reaches 07/10, because of the groundwork laid by
> >> > 04-06/10, it is obvious that the general direction is to allow the
> >> > caller, i.e. cmd_tag(), to make a call to setup_auto_pager() only in
> >> > some but not all circumstances, and 07/10 being faithful to the
> >> > original behaviour (only to be updated in 08/10) is somewhat counter
> >> > intuitive.  It is not wrong per-se; it was just unexpected.
> >>
> >> Thanks for your comments. I will be away for a few days, but once I
> >> get back, I'll try to produce a v3 based on this and any further
> >> feedback.
> >
> > Overall it looks good to me. I left a few minor comments.
> >
> > I actually like the split. I found it pretty easy to follow (though
> > squashing as Junio suggested would be fine with me, too).
> 
> I assume that by "the split" you mean patches 7-8, not 1-3.  Anyway,
> I'll squash since you're fine with it and Junio prefers it.

I actually meant both, but as I said, I'm OK with it either way.

-Peff
