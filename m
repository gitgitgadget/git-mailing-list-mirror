Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4A5D1F404
	for <e@80x24.org>; Fri, 31 Aug 2018 21:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbeIABul (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 21:50:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:35900 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727201AbeIABul (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 21:50:41 -0400
Received: (qmail 1897 invoked by uid 109); 31 Aug 2018 21:41:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 31 Aug 2018 21:41:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9379 invoked by uid 111); 31 Aug 2018 21:41:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 31 Aug 2018 17:41:27 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 31 Aug 2018 17:41:16 -0400
Date:   Fri, 31 Aug 2018 17:41:16 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Jann Horn <jannh@google.com>,
        git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 2/5] t5303: test some corrupt deltas
Message-ID: <20180831214116.GA16999@sigill.intra.peff.net>
References: <20180830070548.GA15081@sigill.intra.peff.net>
 <20180830070932.GB15420@sigill.intra.peff.net>
 <xmqq8t4n69gy.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1808311155410.71@tvgsbejvaqbjf.bet>
 <xmqqh8ja360p.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1808312313210.71@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1808312313210.71@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 31, 2018 at 11:14:20PM +0200, Johannes Schindelin wrote:

> On Fri, 31 Aug 2018, Junio C Hamano wrote:
> [...]
> > So instead of typing 3 lines, you can just say "yes we use echo that
> > emulates Unix".
> 
> You could just express your gratitude that I do more than just answer a
> question, and impart more knowledge that will help you be a better
> maintainer.

It is my observation as a third party that there has been a lot of
bickering between you two lately (here and in other threads). Can you
both please try to make sure your comments are truly constructive?

I don't want to get into details of who I think has been unreasonable
when, or lay any kind of blame. I'm just concerned that exchanges like
this one worsen the general tone of the mailing list, and I'd like to:

  - make it clear to other observers that there's at least one person
    who hopes this is not the norm for this list

  - make a general reminder that collaborating on the Internet is hard,
    but it's worth spending the extra effort to consider how comments
    will be taken by the intended receiver, as well as others on the
    list

You're free to disagree, of course. And I'm sorry for being somewhat
vague. I really want to avoid opening up a specific flamewar, and just
make a general call for people to remember to be friendly.

If vger allowed HTML mail, I would link to a picture of a unicorn
running across a rainbow.

-Peff
