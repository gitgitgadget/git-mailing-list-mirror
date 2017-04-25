Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD607207BD
	for <e@80x24.org>; Tue, 25 Apr 2017 10:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1428976AbdDYKCA (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 06:02:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:39673 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758324AbdDYKB6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 06:01:58 -0400
Received: (qmail 9224 invoked by uid 109); 25 Apr 2017 10:01:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 25 Apr 2017 10:01:57 +0000
Received: (qmail 4104 invoked by uid 111); 25 Apr 2017 10:02:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 25 Apr 2017 06:02:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Apr 2017 06:01:55 -0400
Date:   Tue, 25 Apr 2017 06:01:55 -0400
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jiang Xin <worldhello.net@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] test suite broken with GETTEXT_POISON=YesPlease
Message-ID: <20170425100155.zvfxyvd3egw463xe@sigill.intra.peff.net>
References: <CACBZZX62+acvi1dpkknadTL827mtCm_QesGSZ=6+UnyeMpg8+Q@mail.gmail.com>
 <FDAE86E2-F607-4E82-8E0C-0E6DCEF7ED67@gmail.com>
 <CACsJy8BceB96D39gbjTFx=XQZ6ATHYYQGMRSeV=u4C3jEvTDbQ@mail.gmail.com>
 <20170424203710.cijg3bjdrb2eywmh@sigill.intra.peff.net>
 <054E67A2-56B0-4C91-89F5-F33E8C00ED61@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <054E67A2-56B0-4C91-89F5-F33E8C00ED61@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 25, 2017 at 10:51:20AM +0200, Lars Schneider wrote:

> >> Off topic, is it possible to receive mail notifications from Travis
> >> when a fault is found in either 'pu', 'next' or 'master'? I know how
> >> to do it in Jenkins, but I'm not familiar with Travis and there's no
> >> obvious button from the web page..
> > 
> > I looked into this a bit for my personal builds. Notification config has
> > to go into the .travis.yml file[1].  So I think the best we could do is
> > send a notification email to some mailing list, and then let people
> > subscribe to that (or it could go to git@vger; I don't know how noisy it
> > would be).
> 
> A separate mailing list sounds like a very good idea to me!
> Maybe "git-builds@vger.kernel.org" or something?
> What would it take to set something up like this?

I suspect that emailing the vger admins is the right place (or that they
can point us in the right direction, or tell us to get lost). The best
address is probably postmaster@vger.kernel.org.

(I resisted just cc-ing them here to see if other people had opinions on
just sending the output to the regular list).

-Peff
