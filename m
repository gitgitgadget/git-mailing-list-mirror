Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD54E1F453
	for <e@80x24.org>; Tue, 18 Sep 2018 18:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729907AbeIRX4O (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Sep 2018 19:56:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:52378 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729782AbeIRX4O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Sep 2018 19:56:14 -0400
Received: (qmail 10947 invoked by uid 109); 18 Sep 2018 18:22:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 18 Sep 2018 18:22:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9884 invoked by uid 111); 18 Sep 2018 18:22:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 18 Sep 2018 14:22:23 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Sep 2018 14:22:22 -0400
Date:   Tue, 18 Sep 2018 14:22:22 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     David Aguilar <davvid@gmail.com>, git <git@vger.kernel.org>,
        git@sfconservancy.org
Subject: Re: Git trademark status and policy
Message-ID: <20180918182222.GA24448@sigill.intra.peff.net>
References: <20170202022655.2jwvudhvo4hmueaw@sigill.intra.peff.net>
 <20180916101520.GC18517@gmail.com>
 <20180917032101.GD22024@sigill.intra.peff.net>
 <CAP8UFD2cC7VMu7Zp9NaXj4x0BMBPZ5CJ6prwEv+s24SuNG=7JA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD2cC7VMu7Zp9NaXj4x0BMBPZ5CJ6prwEv+s24SuNG=7JA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 17, 2018 at 11:25:31AM +0200, Christian Couder wrote:

> > (Also, to be clear, this is all _only_ about "Git Cola". The "git-cola"
> > command is explicitly OK in the policy because that's how commands
> > work).
> 
> I agree about "git-cola" though I wonder about "git-dag" as this is
> another command used by the project that is more generic. For example
> I could imagine that, if we wanted to provide a shortcut for `git log
> --graph --decorate --oneline`, we might want to use `git dag`.
> 
> I guess we can still recommend to change it if possible, though we can
> also acknowledge that, as our recommendation comes very late (too
> late?), it is just a "weak" recommendation.

Yeah, I agree with you, though I think it is a separate issue. "git-dag"
is explicitly OK in the trademark policy, and they are not using "Git
Dag" in any recognizable way.

So I think there is no trademark issue, but "git-dag" is probably just
not a great idea in general, because the namespace is open and it is
likely to get stomped by some other project. Or git itself. Or it may
even be annoying for users who have a "git dag" alias (on-disk commands
always override aliases).

So I think we should generally recommend against such generic names
during the naming phase. At this point, I'm not sure the pain of
changing now is any less than the pain of changing later if and when
there's a conflict.

I think I'm actually violently agreeing with you, but I wanted to make
it clear. :) (And everything else in your email seemed sensible, too).

-Peff
