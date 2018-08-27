Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FBE01F404
	for <e@80x24.org>; Mon, 27 Aug 2018 19:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbeH0X2D (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Aug 2018 19:28:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:57716 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727077AbeH0X2D (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Aug 2018 19:28:03 -0400
Received: (qmail 28271 invoked by uid 109); 27 Aug 2018 19:40:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 27 Aug 2018 19:40:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24527 invoked by uid 111); 27 Aug 2018 19:40:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 27 Aug 2018 15:40:12 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Aug 2018 15:40:02 -0400
Date:   Mon, 27 Aug 2018 15:40:02 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: worktree duplicates, was: [PATCH] SubmittingPatches: mention
 doc-diff
Message-ID: <20180827194002.GA27158@sigill.intra.peff.net>
References: <20180821192321.GA720@sigill.intra.peff.net>
 <20180821193556.GA859@sigill.intra.peff.net>
 <CAPig+cT+LBSJHoR1kUi+S2h96y_qmVEpK0xAy6sRUGQj6GQEyg@mail.gmail.com>
 <20180821204341.GA24431@sigill.intra.peff.net>
 <CAPig+cTghgbBo5VfZN+VP2VM00nPkhUqm0dOUqO37arxraxBKw@mail.gmail.com>
 <CACsJy8BxxyRxqCj5ZoOmPaiwmFRKHU72yTxyC_eHXS+cEa94zw@mail.gmail.com>
 <CAPig+cQNkMEUj=6e=6czbkWeozJQ-Go09C6bZwVJUTpM3JJiiw@mail.gmail.com>
 <20180824232502.GA21265@sigill.intra.peff.net>
 <CAPig+cQMv=ByvmH=+V3hZ1NC-=eT+CShuM7g+Y4evD1nVFr4XQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cQMv=ByvmH=+V3hZ1NC-=eT+CShuM7g+Y4evD1nVFr4XQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 27, 2018 at 05:55:43AM -0400, Eric Sunshine wrote:

> On Fri, Aug 24, 2018 at 7:25 PM Jeff King <peff@peff.net> wrote:
> > On Fri, Aug 24, 2018 at 06:55:24PM -0400, Eric Sunshine wrote:
> > > On Fri, Aug 24, 2018 at 10:47 AM Duy Nguyen <pclouds@gmail.com> wrote:
> > > > > I was thinking that "worktree add" could start respecting the --force
> > > > > option as an escape hatch.
> > > >
> > > > Sounds good. Eric are you going to implement this? Just checking so
> > > > that I can (hopefully) cross this off my backlog ;-)
> > >
> > > It wasn't something I was planning on working on (at least not
> > > immediately) [...]
> > > As for the actual implementation, I haven't yet looked at how much
> > > surgery will be needed to make 'add' respect --force.
> >
> > Me either. I may take a look this weekend. [...]
> 
> Okay, I got an implementation up and running. It didn't require too
> much code, but neither was it a simple 1- or 2-liner.
> 
> I still need to update documentation, write tests, and compose the
> actual patch series (which will probably run to about 5 patches), so
> it's not quite ready to send out, but hopefully soon.

Great, and thanks for letting me know before we duplicated effort.

-Peff
