Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F1331F463
	for <e@80x24.org>; Wed, 11 Sep 2019 15:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbfIKPMx (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Sep 2019 11:12:53 -0400
Received: from mout.gmx.net ([212.227.15.15]:57875 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728362AbfIKPMx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Sep 2019 11:12:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1568214766;
        bh=77k1FTJcPZf18UQOwxBRDBtQjcSBo4Gh4ZoGnJ2DitA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Gmctw6IvBKiDpIwahrOqAfXXLPnF9/N2o6hexJXNCXbJtSM5LUaAKK1FOYK/1S4kt
         MQyW/+kiCuzzK5XR00YA3SE6anU+nHdaF7bQmBi8gvGEk0SUXYmetLKHmXWprGjVuq
         xmXqTSR/wm3T8AkZxb0GmgfUok9RyvnyTlDNNzbc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MQ2zr-1i3xZF0ixP-005KWG; Wed, 11
 Sep 2019 17:12:46 +0200
Date:   Wed, 11 Sep 2019 17:12:31 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>,
        Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] ci: install P4 from package to fix build error
In-Reply-To: <20190910122455.GH32087@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.1909111710050.5377@tvgsbejvaqbjf.bet>
References: <20190906102711.6401-1-szeder.dev@gmail.com> <20190906105825.GD32087@szeder.dev> <nycvar.QRO.7.76.6.1909100049180.5377@tvgsbejvaqbjf.bet> <20190910122455.GH32087@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-14213178-1568214767=:5377"
X-Provags-ID: V03:K1:XvlUldNBJjBKs1dLbOvOYmVCUstJWDmPQiaRudENY/ozrqWlzJM
 Yhujz/KRr1kZK5vDsMfl4OfauHd+UrMLao73JzTldHAIQXs+wSgnrBQj8EZ/nAchA3kgvFZ
 9UrS1f/Jk3HVm6gAnqn3LNR7h4Zb3nEajhRURNy+6u37SrVppMN9Q1vM8RD9NZoK0TmYk2n
 mXIRPrt3m34ovStIbb8Jw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dMS3g1rKi+8=:6Zhw6AMNhhfFd4Q3wUqGq4
 r7QCUHNYqDDXMG6e2Tv0GrqE+xnI3phFjkscf0e8jbeh0IHodHoqNtGdaBLYqZsHcvQpwaF7l
 s5gaB4MKaoHo+hUzs0b4RZz1u7ftR+1ingbSbyc8CeBoIyFYvSgU64dOOHlCJ4xKd8uAklChR
 wFrRFhLQO/5sEzqW5Ewrrcaom1ll/SoOlvgKPn/UY1IswaXkYlGBHsLBirQP1UAYm2djnlwsH
 khggHTZ7mYiO1GESdzkv/8crb2EgQXxjGKwZ8lz8RRjXPWXLeDIJPCvbgGW0vgRwQ4MxwpR2Z
 Rsdr+fCKUpxFrBLti8GPrW9ASfLFV5OFwOS80v2fNiPoiVN8hWj+Jc0eiVPGW8mrWuIwO7P/b
 emX5Wk0DAR+XWVIxYtAYII00vIVIczCqD9oU55dWVvl1PRXnogpiQbRC/nfrU/EOCaRQHNC56
 0JPcGOCZ0NmFaEVKELCCeti9qeItzta4zVN62fNDl/lveDSz2AcITGqea5WxBcgaTKM+dOONq
 6zknlfotWQkFNHVrA2Z6xCOdj2G7hejCbHlzWuWnJ6uIA6ZBZqHq6t0O3rhTE3PShL8LnICGQ
 npaOLMHh4YkiE0/FO5R0sxfa6ycnA30HQwrLIRdRBgi8OkWTjYmLb0PXe1Fxh+1LjfxgDNhKW
 kOxMBpFo1xQDWeOKU5lz30yv5pDkk+NMKIj26DzowwAaehrN2JV+ryOkkCHyG5k/DUAqfgosv
 wvWOoIFp1OnguOtTRknI2txL1fFoYbcLushuTdmHvXTLCiyC+SpxRA+t8MOCuU89uFyNdAyRU
 Sr2PlnAFODdqz8lR8xmnDd51ZUavbedlpSZmFxSn2JYrymzFOCD+d7V8M1PLWYDdKVsMQu0qv
 5crno9JU5vDOdU3+Ef+UqToFySW391qsWjC2jyXeEs2z8ZD9FcW9tZyXq3cfxa+mSG80m2qpm
 CN5vd9I631vqKLeD4VmSFa5Nd5CRUTQO151/RQ+SUmOREiMcbhcwEK9eCfgecOwDHtImV2DHc
 q8szrTy5iujiPHP7ooA7P+n63x5HvEOToDUCrSXl+DoESatlUfwoEto5mX+hi9F9SWHNpcaiw
 ojLPO4KnYsTTkfildE8JAV08oEd5F0yPtYEpv61u0OPl2ZkWik5rJiGAqBCrkdDuIRVNO2WMU
 Ey4z8l8jNr2v+xBozau4x5bHDnEWYxV9QQHPRce5ZzufVmVBtUUoO422nTrD8L2ZTmF0OfG8B
 6tWYOL2/nmmE+4sMA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-14213178-1568214767=:5377
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, 10 Sep 2019, SZEDER G=C3=A1bor wrote:

> On Tue, Sep 10, 2019 at 12:51:01AM +0200, Johannes Schindelin wrote:
> > On Fri, 6 Sep 2019, SZEDER G=C3=A1bor wrote:
> >
> > > On Fri, Sep 06, 2019 at 12:27:11PM +0200, SZEDER G=C3=A1bor wrote:
>
> > > > Let's install P4 from the package repository, because this
> > > > approach seems to be simpler and more future proof.
> > > >
> > > > Note that we used to install an old P4 version (2016.2) in the
> > > > Linux build jobs, but with this change we'll install the most
> > > > recent version available in the Perforce package repository
> > > > (currently 2019.1).
> > >
> > > So I'm not quite sure whether we really want this patch.  It
> > > depends on how important it is to test 'git-p4' with an old P4
> > > version, but I don't really have an opinion on that.
> >
> > I'd rather have that patch. It seems to be a much better idea to use
> > the package management system than to rely on one host, especially
> > when said host already displayed hiccups.
>
> Well, I'm not so sure.  As far as I remember this was the first time
> that this Perforce filehost was inaccessible and a simple "Restart
> job" could not rectify the situation, because it was inaccessible for
> about a day or more.

Right.

> OTOH, transient errors or timeouts from 'apt-get update' or 'install'
> from the official Ubuntu package repositories are not uncommon (at
> least on Travis CI), although in those cases it's usually enough to
> just restart the errored job.

My impression precisely. I trust the Ubuntu package servers to have
transient, _short-lived_ problems ;-)

Ciao,
Dscho

--8323328-14213178-1568214767=:5377--
