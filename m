Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A628A1F954
	for <e@80x24.org>; Sun, 19 Aug 2018 21:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbeHTAUw (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Aug 2018 20:20:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:60648 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726171AbeHTAUv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Aug 2018 20:20:51 -0400
Received: (qmail 14682 invoked by uid 109); 19 Aug 2018 21:08:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 19 Aug 2018 21:08:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8538 invoked by uid 111); 19 Aug 2018 21:08:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 19 Aug 2018 17:08:07 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 19 Aug 2018 17:08:00 -0400
Date:   Sun, 19 Aug 2018 17:08:00 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Michael =?utf-8?B?TXVyw6k=?= <batolettre@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-bug: Distributed bug tracker embedded in git
Message-ID: <20180819210800.GA17277@sigill.intra.peff.net>
References: <CACSZ0Pwzs2e7E5RUEPDcEUsa=inzCyBAptU7YaCUw+5=MutSsA@mail.gmail.com>
 <20180818054300.GB241538@aiede.svl.corp.google.com>
 <874lfrrhfp.fsf@evledraar.gmail.com>
 <20180818204243.GA136983@aiede.svl.corp.google.com>
 <8736vbqr2p.fsf@evledraar.gmail.com>
 <20180818220821.GC144170@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180818220821.GC144170@aiede.svl.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 18, 2018 at 03:08:21PM -0700, Jonathan Nieder wrote:

> > So we don't get to say "you never asked us about git-annex, we're using
> > that name now" without considering how widely used it is. It's us who
> > decided to expose the API of seamlessly integrating 3rd party tools.
> 
> I think we're talking past each other.  I haven't proposed any blanket
> policy.  I'm saying that "git bug" is a bad name for this tool:
> 
>  - it's hard to find with search engines
>  - it conflicts with some likely good future changes to Git
>  - it assumes that no one else will have some other refinement of the
>    Git bugtracker concept, that it is the only "git bug" tool
> 
> It's a namespace grab.  There's nothing stopping someone from naming a
> command "bug", either, but that doesn't make it a good idea.  (I'm not
> saying that was the intent --- that's just the effect.)

Right, I think this is a sensible way to think about it. When the time
comes later to call something "git bug", obviously we'd consider the
overall ecosystem and weigh that. But that does not make it a good idea
to pick a name that is likely to get stomped on.

And the most we can do is recommend against it and let them make the
decision.  The Microsoft GVFS folks are in a similar situation. They are
renaming the project and thinking about using git-vfs for the command
name. IMHO that is too generic, and I've mentioned that, but ultimately
I think it is their choice.

-Peff
