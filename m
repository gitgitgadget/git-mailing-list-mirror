Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FB3620365
	for <e@80x24.org>; Tue,  3 Oct 2017 10:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751454AbdJCKKc (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 06:10:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:58854 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750820AbdJCKKb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 06:10:31 -0400
Received: (qmail 17986 invoked by uid 109); 3 Oct 2017 10:10:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Oct 2017 10:10:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6383 invoked by uid 111); 3 Oct 2017 10:10:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Oct 2017 06:10:30 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Oct 2017 06:10:29 -0400
Date:   Tue, 3 Oct 2017 06:10:29 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 Outreachy] mru: use double-linked list from list.h
Message-ID: <20171003101029.i6frkaipi5dq5bvr@sigill.intra.peff.net>
References: <0102015ec7a3424b-529be659-bdb6-42c4-a48f-db264f33d53a-000000@eu-west-1.amazonses.com>
 <0102015ed3e9b1a8-74821a55-aa9a-4e5a-b267-c3d2462e3eed-000000@eu-west-1.amazonses.com>
 <20171002082020.c7ravpwgz45osrmz@sigill.intra.peff.net>
 <CAL21Bmn+-2PwkXtK19fvVw-kEx_nftAx9QwvR=h-B-O-ofTqQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL21Bmn+-2PwkXtK19fvVw-kEx_nftAx9QwvR=h-B-O-ofTqQQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 02, 2017 at 12:37:53PM +0300, Оля Тележная wrote:

> >> Simplify mru.[ch] and related code by reusing the double-linked list
> >> implementation from list.h instead of a custom one.
> >> This commit is an intermediate step. Our final goal is to get rid of
> >> mru.[ch] at all and inline all logic.
> >
> > Thanks, this version looks correct to me.
> 
> Great! What is better - to complete my application now (and say only
> about this patch) or to complete it in last days (and say about
> everything that I've done. Maybe there would be something new).

I think it's good to get it started now. You can always make changes to
it later. And in particular, you should fill out the eligibility section
s we can make sure that part is good before going further.

> > I think you've done a good job here, and this would count for your
> > Outreachy application's contribution. But if you'd like to do that next
> > step, you are welcome to.
> 
> I was thinking about starting my small research about main task of the
> internship. I could postpone it and end with this task, there's no
> problem for me.

I do think you should spend some time thinking about and researching the
main task. I'd hope to see in the applications that the candidate has
a sense of the problem space and a realistic plan for approaching the
work.

> Or, if someone from the newbies wants to have a small simple task -
> it's a great opportunity for him/her. By the way, I am ready to help
> if he/she will have questions or difficulties.

Wonderful. :) I do hope to get Outreachy interns involve in normal list
activities like discussion and review, not just producing their own
patches.

> So please make a decision on your own, I will be happy in any scenario.

Why don't we give it a week or so to see if anybody else picks it up.

-Peff
