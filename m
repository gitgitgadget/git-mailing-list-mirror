Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55C4D1F4DD
	for <e@80x24.org>; Sat, 26 Aug 2017 19:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751116AbdHZTBA (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Aug 2017 15:01:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:50062 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751063AbdHZTA7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Aug 2017 15:00:59 -0400
Received: (qmail 25447 invoked by uid 109); 26 Aug 2017 19:00:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 26 Aug 2017 19:00:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24753 invoked by uid 111); 26 Aug 2017 19:01:28 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with SMTP; Sat, 26 Aug 2017 15:01:28 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 26 Aug 2017 12:00:57 -0700
Date:   Sat, 26 Aug 2017 12:00:57 -0700
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     Ivan Vyshnevskyi <sainaen@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH/RFC] push: anonymize URL in error output
Message-ID: <20170826190056.f53htagkoz6ydboe@sigill.intra.peff.net>
References: <20170823094929.13541-1-sainaen@gmail.com>
 <20170823155826.m4s5y55x2esfoass@sigill.intra.peff.net>
 <82741094-19a6-e071-227d-f92b3b077a69@gmail.com>
 <20170825193743.GD103659@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170825193743.GD103659@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 25, 2017 at 12:37:43PM -0700, Brandon Williams wrote:

> > > My knee-jerk reaction is if it's worth writing after the dashes, it's
> > > worth putting in the commit message.
> > > 
> > > However, in the case I think it is OK as-is (the motivation of "we
> > > already avoid leaking auth info to stdout, so we should do the same for
> > > error messages" seems self-contained and reasonable)
> > Well, I tend to be wordy, and most of the commit messages I saw were
> > rather short, so decided to split. Wonder, if maybe example command
> > should be included without the rest of it. Would it be useful?
> 
> I'm guilty of writing short commit messages (something I need to work
> on) but when looking through logs I much prefer to see longer messages
> explaining rationals and trade-offs.

I think as with all writing, there is both "too short" and "too long".
I like having those extra bits in the commit message, too, but you have
to make sure they don't drown out the main points.

I find that when a message gets long, it often benefits from revising
and re-ordering. E.g., having an intro paragraph that explains the
motivation and solution in one sentence, and _then_ go into the details
for people who are really digging into the details. Good organization
lets readers get just the level they need and skip the rest.

Easier said than done, of course. :)

-Peff
