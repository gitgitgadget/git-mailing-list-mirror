Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42F511F453
	for <e@80x24.org>; Wed, 17 Oct 2018 18:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbeJRCKo (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 22:10:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:43706 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727082AbeJRCKn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 22:10:43 -0400
Received: (qmail 6956 invoked by uid 109); 17 Oct 2018 18:13:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 17 Oct 2018 18:13:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21694 invoked by uid 111); 17 Oct 2018 18:13:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 17 Oct 2018 14:13:03 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Oct 2018 14:13:51 -0400
Date:   Wed, 17 Oct 2018 14:13:51 -0400
From:   Jeff King <peff@peff.net>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     git@vger.kernel.org, Bob Peterson <rpeterso@redhat.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] revision: Add --sticky-default option
Message-ID: <20181017181350.GB28326@sigill.intra.peff.net>
References: <20181016212438.30176-1-agruenba@redhat.com>
 <20181017091215.GA2052@sigill.intra.peff.net>
 <CAHc6FU5mXL2j=jL=LqtRt30uBt8tGop350FnwK845fci-Qc=tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHc6FU5mXL2j=jL=LqtRt30uBt8tGop350FnwK845fci-Qc=tg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 17, 2018 at 03:53:41PM +0200, Andreas Gruenbacher wrote:

> On Wed, 17 Oct 2018 at 11:12, Jeff King <peff@peff.net> wrote:
> > On Tue, Oct 16, 2018 at 11:24:38PM +0200, Andreas Gruenbacher wrote:
> > > here's a long-overdue update of my proposal from August 29:
> > >
> > >   [RFC] revision: Don't let ^<rev> cancel out the default <rev>
> > >
> > > Does this look more acceptable that my first shot?
> >
> > I think it's going in the right direction.
> >
> > The name "--sticky-default" did not immediately make clear to me what it
> > does. Is there some name that would be more obvious?
> 
> It's the best I could think of. Better ideas, anyone?

I'd probably call it something verbose and boring like
--use-default-with-uninteresting or --default-on-negative.
I dunno.

-Peff
