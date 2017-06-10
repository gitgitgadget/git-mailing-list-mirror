Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D1641FAEB
	for <e@80x24.org>; Sat, 10 Jun 2017 10:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751980AbdFJKWU (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Jun 2017 06:22:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:37636 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751890AbdFJKWT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2017 06:22:19 -0400
Received: (qmail 10627 invoked by uid 109); 10 Jun 2017 10:22:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 10 Jun 2017 10:22:19 +0000
Received: (qmail 30462 invoked by uid 111); 10 Jun 2017 10:22:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 10 Jun 2017 06:22:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Jun 2017 06:22:17 -0400
Date:   Sat, 10 Jun 2017 06:22:17 -0400
From:   Jeff King <peff@peff.net>
To:     Samuel Lijin <sxlijin@gmail.com>
Cc:     Houston Fortney <houstonfortney@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Feature Request: Show status of the stash in git status command
Message-ID: <20170610102217.vxf6tsrdfp6srupr@sigill.intra.peff.net>
References: <CA+B9myHRahTd+FDgzK5AhXW+hq_Y_czMX9X6MXYBcr9WSPeiDw@mail.gmail.com>
 <20170610082534.6437ifexzly4oqg6@sigill.intra.peff.net>
 <CAJZjrdXCHVKQOxR=+z5cOkieKzE-iSMta--kHVjSYXuansb34Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJZjrdXCHVKQOxR=+z5cOkieKzE-iSMta--kHVjSYXuansb34Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 10, 2017 at 06:12:28AM -0400, Samuel Lijin wrote:

> On Sat, Jun 10, 2017 at 4:25 AM, Jeff King <peff@peff.net> wrote:
> > On Wed, Jun 07, 2017 at 06:46:18PM -0400, Houston Fortney wrote:
> >
> >> I sometimes forget about something that I stashed. It would be nice if
> >> the git status command would just say "There are x entries in the
> >> stash." It can say nothing if there is nothing stashed so it is
> >> usually not adding clutter.
> >
> > I think the clutter issue would depend on your workflow around stash.
> >
> > Some people carry tidbits in their stash for days or weeks. E.g., I
> > sometimes start on an idea and decide it's not worth pursuing (or more
> > likely, I post a snippet of a patch as a "how about this" to the mailing
> > list but don't plan on taking it further). Rather than run "git reset
> > --hard", I usually "git stash" the result. That means if I really do
> > decide I want it back, I can prowl through the stash list and find it.
> >
> > All of which is to say that if we had such a feature, it should probably
> > be optional. For some people it would be very useful, and for others it
> > would be a nuisance.
> 
> Perhaps there should be a flag for this if it is implemented, say
> status.showStash?

Yes, that was what I was thinking.

-Peff
