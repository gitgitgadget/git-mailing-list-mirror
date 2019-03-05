Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00B4620248
	for <e@80x24.org>; Tue,  5 Mar 2019 04:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbfCEEQT (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 23:16:19 -0500
Received: from cloud.peff.net ([104.130.231.41]:38788 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726590AbfCEEQT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 23:16:19 -0500
Received: (qmail 697 invoked by uid 109); 5 Mar 2019 04:16:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Mar 2019 04:16:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28545 invoked by uid 111); 5 Mar 2019 04:16:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 04 Mar 2019 23:16:36 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Mar 2019 23:16:17 -0500
Date:   Mon, 4 Mar 2019 23:16:17 -0500
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bartosz Baranowski <bbaranow@redhat.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH 0/3] prettier bisect output
Message-ID: <20190305041617.GD19800@sigill.intra.peff.net>
References: <CAEpy5fTnyPjH0sVyjnGHi1qxo+_dpaerxwaD7MmNPbmLx6qyJA@mail.gmail.com>
 <xmqq1s40u8gt.fsf@gitster-ct.c.googlers.com>
 <20190222061949.GA9875@sigill.intra.peff.net>
 <CAP8UFD1puPt2c+EJRaBZmd_Fi5uJn0e4fthw8cpKoj7k+5Oy4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD1puPt2c+EJRaBZmd_Fi5uJn0e4fthw8cpKoj7k+5Oy4g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 03, 2019 at 07:33:17PM +0100, Christian Couder wrote:

> > I've run across this many times, too. Since it's been bugging me for a
> > decade, I thought I'd finally try to address it. Here are some patches.
> >
> > There was some discussion about a year ago about just using "git show"
> > for this output:
> >
> >   https://public-inbox.org/git/CAP8UFD3QhTUj+j3vBGrm0sTQ2dSOLS-m2_PwFj6DZS4VZHKRTQ@mail.gmail.com/
> >
> > Christian seemed generally OK with tweaking the output, but preferred
> > not to move all the way to running an external "git show".
> 
> Yeah, I am still OK with tweaking the output, though I'd rather not go
> back to using an external process.

By the way, I've done a few bisects since writing this, and I've been
very happy with the result. So I endorse my own patch. ;)

-Peff
