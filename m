Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF1EA20756
	for <e@80x24.org>; Tue, 17 Jan 2017 20:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751192AbdAQUwe (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 15:52:34 -0500
Received: from cloud.peff.net ([104.130.231.41]:40454 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751188AbdAQUw1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 15:52:27 -0500
Received: (qmail 25492 invoked by uid 109); 17 Jan 2017 20:51:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Jan 2017 20:51:29 +0000
Received: (qmail 21273 invoked by uid 111); 17 Jan 2017 20:52:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Jan 2017 15:52:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Jan 2017 15:51:27 -0500
Date:   Tue, 17 Jan 2017 15:51:27 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2017, #02; Sun, 15)
Message-ID: <20170117205126.sckxwrchlzzmsqui@sigill.intra.peff.net>
References: <xmqqh94zbwlu.fsf@gitster.mtv.corp.google.com>
 <257b4175-9879-7814-5d8d-02050792574d@kdbg.org>
 <alpine.DEB.2.20.1701161251100.3469@virtualbox>
 <20170116160456.ltbb7ofe47xos7xo@sigill.intra.peff.net>
 <alpine.DEB.2.20.1701161746200.3469@virtualbox>
 <20170116220014.bwi5xi2br56lyqsw@sigill.intra.peff.net>
 <xmqqk29tfq79.fsf@gitster.mtv.corp.google.com>
 <20170117193639.mt3x3md3nbh2qgws@sigill.intra.peff.net>
 <xmqqtw8xe8bp.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtw8xe8bp.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 17, 2017 at 12:32:26PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > That was my general impression, too. But I seem to recall it was you in
> > a nearby thread saying that:
> >
> >   if (foo)
> > 	bar();
> >   else {
> >         one();
> > 	two();
> >   }
> >
> > was wrong. Maybe I misunderstood.
> 
> If it were a new code written like the above, that would have been
> fine.  If a new code written with both sides inside {}, that would
> have been fine, too.
> 
> IIRC, it was that the original had {} on both, and a patch tried to
> turn that into the above, triggering "why are we churning between
> two acceptable forms?"

Ah, OK. I didn't follow that discussion closely enough to realize that.

-Peff
