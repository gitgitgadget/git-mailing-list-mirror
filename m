Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 258A61F403
	for <e@80x24.org>; Fri, 15 Jun 2018 07:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755617AbeFOH0X (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Jun 2018 03:26:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:45520 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1755566AbeFOH0W (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jun 2018 03:26:22 -0400
Received: (qmail 28229 invoked by uid 109); 15 Jun 2018 07:26:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 15 Jun 2018 07:26:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19992 invoked by uid 111); 15 Jun 2018 07:26:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 15 Jun 2018 03:26:38 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jun 2018 03:26:20 -0400
Date:   Fri, 15 Jun 2018 03:26:20 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bryan Turner <bturner@atlassian.com>,
        Brandon Williams <bmwill@google.com>,
        Ben Humphreys <behumphreys@atlassian.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [ANNOUNCE] Git v2.16.0-rc0
Message-ID: <20180615072620.GA841@sigill.intra.peff.net>
References: <xmqqfu7ui2af.fsf@gitster.mtv.corp.google.com>
 <CAGyf7-FQp4q2vvH1ponQvmVDTu0hiMSK1JKytQZ4O1i0MCnz7g@mail.gmail.com>
 <20180103053516.GB87855@aiede.mtv.corp.google.com>
 <20180608045028.GA17528@sigill.intra.peff.net>
 <xmqqzi009deu.fsf@gitster-ct.c.googlers.com>
 <20180614183018.GA1911@sigill.intra.peff.net>
 <20180614185522.GA255581@aiede.svl.corp.google.com>
 <20180614193943.GA2226@sigill.intra.peff.net>
 <20180615042033.GB255581@aiede.svl.corp.google.com>
 <20180615051321.GA5840@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180615051321.GA5840@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 15, 2018 at 01:13:21AM -0400, Jeff King wrote:

> > The trouble is that GIT_SSH_VARIANT=simple is too... simple.  You
> > would like a variant that passes in [-p port] [-4] [-6] as well.  We
> > didn't implement that because we didn't have the attention of any
> > wrapper writer who wanted it; in absence of a potential user, we
> > decided to wait for a user to propose the interface they want.  Now we
> > can celebrate, since that day has come.
> 
> I'm not sure I'm celebrating. It seems like work for not much benefit.
> I'd just as soon use VARIANT=ssh and deal with any fallouts if my script
> does not behave exactly like openssh in all regards.

By the way, if this sounds like I'm crapping all over your ideas, I
really don't mean to. What I'm trying to say is that I think your
original patch may have hit a sweet spot between robustness and making
a simple-enough interface for users to configure.

-Peff
