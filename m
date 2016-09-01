Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9768C1F6BF
	for <e@80x24.org>; Thu,  1 Sep 2016 13:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932469AbcIANk0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 09:40:26 -0400
Received: from mout.gmx.net ([212.227.17.21]:50904 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753225AbcIANkZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 09:40:25 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0Lb90f-1bDDxc026j-00kdT9; Thu, 01 Sep 2016 15:40:21
 +0200
Date:   Thu, 1 Sep 2016 15:40:19 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 17/22] sequencer: allow editing the commit message on a
 case-by-case basis
In-Reply-To: <fa2a0783-afaa-0aa5-877c-24b3513d4bae@gmail.com>
Message-ID: <alpine.DEB.2.20.1609011540050.129229@virtualbox>
References: <cover.1472457609.git.johannes.schindelin@gmx.de> <96adba0eee05a7b2b46b726f7e231b6732e80882.1472457609.git.johannes.schindelin@gmx.de> <fa2a0783-afaa-0aa5-877c-24b3513d4bae@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1322969985-1472737221=:129229"
X-Provags-ID: V03:K0:4DZZhWwMY3Ko9Z2p/x/r56kJOn1gwYJ/P7zYKNcmacGBBxRwI2j
 0mFPbPzb/jSyTsLlo7VUKMhgBi9SWnfr2VOQWpFKFVVBY1vEMLDGkdT94VcXizX0HCGe2xU
 KCzpWWaSFW7fW9N6teko/vZDwMafQoevGRnLaTIbOrgUXNkR4XtwyJryy1XpNJLyM07gA1E
 Scj32EtXiJAFrUYgTeKjg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ELail5XA4zE=:3IP49JC6h/KtV7sTgFXvLw
 STT+WlxJ89G1FdgQfUWZu7irpPsOc0sd1becmvtaJP/+cOGTiEt+/fIs18Njjwq85UsdW804W
 tHvAjorLvcaF2UBBhrblX9P4I3l6YAYQ6arJ+VCJDRCDiTy3Bc32G8IhZkDxhHuHm+TUR3FtI
 umnJWiIuyu+UKg04Bpqd0cqykri29m1dgTzX7D1Zxbjg80PYpJp/bshTPcYFiV7eVvY+prV3o
 SFfWLUGWig80I6ZiqJA3L7eUN09XjUH6gFGsh3at6CvqEXuHgVQzveR3qqxItiQ52qMW1/JJt
 bxXEn4Rw5uOeCjPRxVKpL4cefB9f6dkl9ym1tYif0FCG591DJM0HLBjyql47Pd7td0awxGdC4
 PQRZVfjyFOyPFiSER/3impLuHusUD/E1Kt5bi2HxrMCdm7grkyGh6vhv6C7BiD9PMeYJ1EqY6
 SKZUjPIcuBbQAblDzOT7bKiPOqBKmUHEuyOcKu0I4gXbqc9O+f2uzxc+IbY+fMk10mKmum1P/
 YV/IvgvuLi1AJNRwN5Evxq6PnuEnhPNAJfNoljCUvsex5DO+eztDq0oqj5x98y+GtgPQlwzzG
 AMVu7LQnZYNf1QkJr4IvQKd9ojpkPmuIQjEh4crUYqi+U8r/cwHARRBDVvm1OBFThr4sYztU5
 70bM9GL4t8cfNl//fRr1h5Il2yNM4y8kTwGQoUTRSY5g4LodGlI4HpCEoGGX4ZBJ+V8v3rT5Q
 bYxc+GsMUZluzkiYKswjP9BHVTR5bznGSob/V6arQhMljTDm1EULFXPbY9m6bB7z/HROT0w4r
 llU2q/s
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1322969985-1472737221=:129229
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Kuba,

On Wed, 31 Aug 2016, Jakub Nar=C4=99bski wrote:

> W dniu 29.08.2016 o 10:06, Johannes Schindelin pisze:
>=20
> > In the upcoming commits, we will implement more and more of rebase
> > -i's functionality. One particular feature of the commands to come is
> > that some of them allow editing the commit message while others don't,
> > i.e. we cannot define in the replay_opts whether the commit message
> > should be edited or not.
>=20
> It's a nice, pretty and self contained refactoring step.  Small
> enough that it is easy to review.
>=20
> I would like to have in the commit message that it is sequencer_commit()
> function that needs to rely on new parameter, instead of on a property
> of command (of its replay_opts).  And that currently it simply passes
> the buck to caller, which uses opts->edit, but in the future the
> caller that is rebase -i would use todo_item and replay_opts based
> expression.

I enhanced the commit message.

Thanks for the review,
Dscho
--8323329-1322969985-1472737221=:129229--
