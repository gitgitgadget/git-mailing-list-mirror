Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27C582018E
	for <e@80x24.org>; Thu, 25 Aug 2016 13:08:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753655AbcHYNIe (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 09:08:34 -0400
Received: from mout.gmx.net ([212.227.17.22]:53622 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752917AbcHYNId (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 09:08:33 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MKcdH-1bbWwb1Xlf-0023HH; Thu, 25 Aug 2016 15:08:14
 +0200
Date:   Thu, 25 Aug 2016 15:08:11 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Eric Wong <e@80x24.org>
cc:     Philip Oakley <philipoakley@iee.org>,
        Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>, meta@public-inbox.org,
        git@vger.kernel.org,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Arif Khokar <arif_khokar@hotmail.com>
Subject: Re: Working with public-inbox.org [Was: [PATCH] rev-parse: respect
 core.hooksPath in --git-path]
In-Reply-To: <20160824191651.GC8578@whir>
Message-ID: <alpine.DEB.2.20.1608251504030.4924@virtualbox>
References: <CAGZ79kasebzJb=b2n=JQiVMrSfJKaVfZaaoaVJFkXWuqKjfYKw@mail.gmail.com> <alpine.DEB.2.20.1608181430280.4924@virtualbox> <20160819150340.725bejnps6474u2e@sigill.intra.peff.net> <alpine.DEB.2.20.1608221450250.4924@virtualbox>
 <CACsJy8BG63oaLbw0f7try3OpzdphLC7UGAaJ=vgikEB36Pagqg@mail.gmail.com> <B21604E7033C458EAC5EA0651CFEA8E9@PhilipOakley> <alpine.DEB.2.20.1608241459360.4924@virtualbox> <20160824191651.GC8578@whir>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ULANjYi7vCYuQpZCa7krffeQJV30WbEKCQK28splF+eZfuhmRAI
 VtTSp9cqRJQaDbnIf5OqQiM+vl3fSYGLDV56dBKoyxysg5jpyKWHTISm/Tg19J2I2997glJ
 a11i/IEYRvmCJyke1b8x5G7ODMKBMIya0LFGewJLwlhvvAwX6XSBhBN9omc1J44ol9HrLIG
 XyiX/uP7RYEUqEYEfZGfA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GOwDxg4+nJI=:g7R56YutjOJA2UEqYRKOvQ
 Pzp/ClwRtt1wt//Qeanyx3gl3uJd0piMQ8LeaOZweCwFU2Px5RxAMpqsMxT4D4CDaLvm5p+qu
 CzqjTiVGy1x4cJbbXKnzTkgOr1RnH55VrzbS72vVfB57F//SF9cl0A2U7qhzo/BaQtSTWL8G8
 alZzQUgHX84C948U9g7/px+fDJR5+0bEbEb8+yu7x8KaLRsL06pVt8InYtgk+q26tqBh+Hr1W
 VKvsDoJS1DGlV0XAkXeCk+FQLPuc682ZhEAUY0UxX+hc6W88re2hm2tLqBCTmV8p/rq2Crdf8
 deFJP+iXNjdT1enMPLFIjWrYDGO9gHAqFKFQ7LJ8/Imvq5obel4d1cLCbovjUSovenyTGlPLM
 ClGzbSl9tiBydC54IwXvh9Ez4z2A8JygGcTXohEDGeJg+YCEOA8hdweSPo7QndbdNy4a7+6vF
 zepEQoRiRYJwvdpxpAwDtO9VoOpVJhkLHvQqZ7nogeD0nkFA3txSFsQ/E+g8wRD772zlAz0TL
 cttPzZ9JMh8nEpJcrIx1x74WheMZ/brTbcbK9g3yuz7NDkOUnCRGuXvZjniiTdzsX/aHMrauH
 wvWJnA0H6yuL0k96puwPx8AHqI4IJxWFE2YnPb9sbkqS4nVKfw3bq39sT2EEln/J/U/TWCcoA
 l+OJ13DcTlK4ULV7IBa08rRcCRs4Z2qkPuWRIA59IkB9AX+BWRO8COHPyh7wjOkARsqJa7RR/
 H2vGR4DObHy/ko/XMokg2m7362PKNDwJy8cvltOK3ooXf1V38ORciiYfIsm6i8AEUMq/0kc75
 nDUSVJo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Wed, 24 Aug 2016, Eric Wong wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> > Now, with somebody like me who would lose a lot when destroying trust,
> > it is highly unlikely. But it is possible that in between the hundreds
> > of sincere contributors a bad apple tries to sneak in bad stuff.
> 
> Yes, I would never mix reviews + patch applications of emails vs
> git-fetched data.

Well, such a categorical statement seems to exclude all convenience I had
in mind.

My idea was that, say, a web service running on a trusted server with a
trusted code base could send mails that would be trusted to contain
correct SHA-1 information, allowing for a review in the mail, but still
use the much, much more convenient Git tools to actually work on the code.

I really hope that not everybody is so categorically against introducing
much needed convenience.

Ciao,
Dscho
