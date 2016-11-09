Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B3292021E
	for <e@80x24.org>; Wed,  9 Nov 2016 16:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933995AbcKIQv3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Nov 2016 11:51:29 -0500
Received: from cloud.peff.net ([104.130.231.41]:40759 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752877AbcKIQv2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2016 11:51:28 -0500
Received: (qmail 3797 invoked by uid 109); 9 Nov 2016 16:51:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 09 Nov 2016 16:51:28 +0000
Received: (qmail 30309 invoked by uid 111); 9 Nov 2016 16:51:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 09 Nov 2016 11:51:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Nov 2016 11:51:25 -0500
Date:   Wed, 9 Nov 2016 11:51:25 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: 2.11.0-rc1 will not be tagged for a few days
Message-ID: <20161109165125.t4x2w7u5uxe57xm2@sigill.intra.peff.net>
References: <xmqqk2cgc95m.fsf@gitster.mtv.corp.google.com>
 <20161108004038.a7gyoe6wpucxjmvz@sigill.intra.peff.net>
 <65a1bb6d-e924-21aa-70d3-303ebdc499f1@kdbg.org>
 <20161108214825.yo37kvoqkeucuqgg@sigill.intra.peff.net>
 <xmqqoa1p9nf0.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqoa1p9nf0.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 08, 2016 at 10:29:07PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I'm collecting v2.11-rc1 topics in the "refs/heads/for-junio/" section
> > of git://github.com/peff/git.git.
> >
> > I've also got proposed merges for "master" there, though note that none
> > of the topics has actually cooked at all in next (the fixes are trivial
> > enough that it may be OK, though).
> 
> I am not quite back up at full steam yet, but I expect I'd be more
> or less functioning tomorrow, so I'll fetch them from your tree and
> continue.

It looks like Johannes prefers replacements for some of the fixes from
yesterday. Just FYI that you probably do not want to take the "master" I
pushed there literally, but instead just view it as a proposed list of
topics.

I did not really expect you to take it literally in the first place.
It's just that I found myself writing up notes like "this should be
merged", and it occurred to me that I could communicate the same things
by sending you a proposed history. So I'm curious if you find dissecting
it via "git log" more or less convenient than a list of notes. :)

-Peff
