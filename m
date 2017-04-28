Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C8C71FC3E
	for <e@80x24.org>; Fri, 28 Apr 2017 08:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1035036AbdD1Ioi (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 04:44:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:41593 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938014AbdD1Ioc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 04:44:32 -0400
Received: (qmail 4528 invoked by uid 109); 28 Apr 2017 08:44:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 28 Apr 2017 08:44:20 +0000
Received: (qmail 17661 invoked by uid 111); 28 Apr 2017 08:44:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 28 Apr 2017 04:44:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Apr 2017 04:44:19 -0400
Date:   Fri, 28 Apr 2017 04:44:19 -0400
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jiang Xin <worldhello.net@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] test suite broken with GETTEXT_POISON=YesPlease
Message-ID: <20170428084418.kfovri32rpy3wet2@sigill.intra.peff.net>
References: <CACBZZX62+acvi1dpkknadTL827mtCm_QesGSZ=6+UnyeMpg8+Q@mail.gmail.com>
 <FDAE86E2-F607-4E82-8E0C-0E6DCEF7ED67@gmail.com>
 <CACsJy8BceB96D39gbjTFx=XQZ6ATHYYQGMRSeV=u4C3jEvTDbQ@mail.gmail.com>
 <20170424203710.cijg3bjdrb2eywmh@sigill.intra.peff.net>
 <054E67A2-56B0-4C91-89F5-F33E8C00ED61@gmail.com>
 <20170425100155.zvfxyvd3egw463xe@sigill.intra.peff.net>
 <73F100B8-776A-4FF8-B23B-8DF413AB3288@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <73F100B8-776A-4FF8-B23B-8DF413AB3288@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 28, 2017 at 10:42:10AM +0200, Lars Schneider wrote:

> >> A separate mailing list sounds like a very good idea to me!
> >> Maybe "git-builds@vger.kernel.org" or something?
> >> What would it take to set something up like this?
> > 
> > I suspect that emailing the vger admins is the right place (or that they
> > can point us in the right direction, or tell us to get lost). The best
> > address is probably postmaster@vger.kernel.org.
> > 
> > (I resisted just cc-ing them here to see if other people had opinions on
> > just sending the output to the regular list).
> 
> OK, I'll send them an email. I just realized a strong reason for a
> separate mailing list: I haven't found a knob to make TravisCI
> send plain text emails.

I think that's going to be a problem for any list on vger. I suspect the
spam filtering all happens at an early stage.

You might consider just setting up a google group or some other list as
an initial experiment. It wouldn't be that hard to switch the list
later (people will need to resubscribe, but you can notify them by
sending an email to...the list).

-Peff
