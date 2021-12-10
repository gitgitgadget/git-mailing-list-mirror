Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D939FC433F5
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 09:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239433AbhLJJmb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 04:42:31 -0500
Received: from cloud.peff.net ([104.130.231.41]:48582 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236758AbhLJJmb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 04:42:31 -0500
Received: (qmail 18117 invoked by uid 109); 10 Dec 2021 09:38:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Dec 2021 09:38:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28552 invoked by uid 111); 10 Dec 2021 09:38:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Dec 2021 04:38:58 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Dec 2021 04:38:55 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 00/19] tests: fix broken &&-chains & abort loops on error
Message-ID: <YbMgL6A+/12GTeuf@coredump.intra.peff.net>
References: <20211209051115.52629-1-sunshine@sunshineco.com>
 <CABPp-BFM5ZbFAzVfvDE3=zm6Q4LN2fWthPP8WH5kbgVPSxomtA@mail.gmail.com>
 <CAPig+cRD_DzisMo-8ZuT4NzESEe4i2vPk_1Y-_JTeV9rbdwkLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cRD_DzisMo-8ZuT4NzESEe4i2vPk_1Y-_JTeV9rbdwkLg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 09, 2021 at 02:17:32PM -0500, Eric Sunshine wrote:

> > I have to admit to starting to skim once I got to the last four
> > patches, since they were a bit longer and all the same type of change.
> 
> Understandable. Those bulk-change patches tend to be mind-numbing to
> review, though `git diff --color-words` helps out somewhat (at least
> by making it easier to skim the changes).

I likewise think I may have phased in and out of consciousness on those
last four.

> > You did an excellent job of explaining the changes and presented them
> > in a logical fashion.  The few things I thought I caught, you've
> > already answered were already correct.  I do think making the second
> > commit message be a bit clearer about the importance of the ordering
> > would be helpful.  Anyway:
> >
> > Reviewed-by: Elijah Newren <newren@gmail.com>
> 
> Thanks. I'll wait a couple days and resend with a clarified commit
> message for the second patch unless, perhaps, Junio would accept a
> resend of just that patch so I don't have to spam the list again.

These looked good to me. I left a few comments, but nothing that I think
would trigger a re-roll.

-Peff
