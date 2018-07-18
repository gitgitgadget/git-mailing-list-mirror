Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A9B51F597
	for <e@80x24.org>; Wed, 18 Jul 2018 12:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbeGRMv5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 08:51:57 -0400
Received: from mout.gmx.net ([212.227.15.15]:37921 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726953AbeGRMv5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 08:51:57 -0400
Received: from [192.168.0.129] ([37.201.195.94]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MIMUZ-1fbcc93np9-004EOl; Wed, 18
 Jul 2018 14:14:11 +0200
Date:   Wed, 18 Jul 2018 14:13:54 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 0/4] Use oid_object_info() instead of
 read_object_file()
In-Reply-To: <CAL21BmmwRDwWc_4JmFKMA6ZYcx=A4biG+tmrBHPRNAxpSkt_NA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1807181413200.71@tvgsbejvaqbjf.bet>
References: <CAL21BmkBohTOVdCO_ENVfzL28aRjoh1MCCF6750AQEYsc7L54w@mail.gmail.com> <CAL21BmmwRDwWc_4JmFKMA6ZYcx=A4biG+tmrBHPRNAxpSkt_NA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-575473446-1531916050=:71"
X-Provags-ID: V03:K1:SDCnlTmFL25gKv2KzCV/ul7QWtvzvG1Raqd9pYoJ7gJfYrnS1k7
 B+E3mm8nIVxqk3ue4MhYyNnB1otlhT8FhaqJmGIeMW6JCpmanBgNC8T6lUqvodKJuq/fzaY
 nDw07QDooHdSUPUIU4hk4A+2wxVZ3uKbyhSzhQ5eVON/ZYpc1Ys1OrERYFXfcmmA5bYeZnr
 W6QR1020cJSKCWZbZSx2w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zZDi0D+Bu0Y=:eV46mcIN/Ep3NFYhUSBtWp
 yzjSOnk42p6CoLZbzkyIkie+o6gHHd0ixXSghMQNIgpHgZF2aTR1GxX+9CshbKNQq2AUIcqKY
 6USabVn3c1W50z55bJB+wkM8c2t49SSHfm+t2bCZnzl+3Wz3SPwvUn35V0ZYI17mUSxhTHskC
 ZHupcSJPVJp0MEYD6ET2aSTLd1t29V1jDl5nWbeLV8bAcDvN1MwqaQI5TCGmVW9W8Y3VhHXqO
 xuv+Zo+ea1b13H5mzK5NiLcbLxuEI+yUdsO4pO+my8ECGfM+gjXINEXNwtiwPrl2O4r2XEBlQ
 IOTIMP1G3FNvRTy0RrUTkX1EOUSNV63banK5IT90WgVkWW+nOfawMDGQKL016zDGJ8iiVmS16
 FkDmaEC3IZFx9vUQHENYRcQTmzgbFTnqHuwZvNEI+D6r7mkIn47cC9cAm4PL1V57Jn8eQk/rA
 VzTytUTbvQRpI0nmaF/wO8Jm1z2GPkU5C4mfWhGb4nIPfNHor445EU1kbSOTYrNiVCDc6iotz
 VZh7BHwTuwOxbu7p3CxRORDMVUpNiXH0fA4qdq1qlVhIH0p33sRWjtPHhaQITOwuYn5Fk9hhd
 K5/7GtMYc0Gc/Bqe4M6sQaNeU09schZ64WQ4wEHqtLT6FNwXzZZ71UDIw4DU1P1KLG591invt
 nmq99vd9qZ8Jk2wy2E0pLaSDAZpvxZt0TYk6mXgVR/EfColfSoXxNnMq19xhRwEC+Gk0S3x52
 L5cLbRXGDGU7r9IP1xv8RpMuqEXJkzdXmVSK/tXiigxZrUMM7KPLHk6LkopTORBrmTZKcMPgK
 a3Vyu42
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-575473446-1531916050=:71
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Olga,

On Fri, 13 Jul 2018, =D0=9E=D0=BB=D1=8F =D0=A2=D0=B5=D0=BB=D0=B5=D0=B6=D0=
=BD=D0=B0=D1=8F wrote:

> 2018-07-09 11:27 GMT+03:00 =D0=9E=D0=BB=D1=8F =D0=A2=D0=B5=D0=BB=D0=B5=D0=
=B6=D0=BD=D0=B0=D1=8F <olyatelezhnaya@gmail.com>:
> > Hello everyone,
> > This is my new attempt to start using oid_object_info_extended() in
> > ref-filter. You could look at previous one [1] [2] but it is not
> > necessary.
> >
> > The goal (still) is to improve performance by avoiding calling expensiv=
e
> > functions when we don't need the information they provide
> > or when we could get it by using a cheaper function.
> >
> > This patch is a middle step. In the end, I want to add new atoms
> > ("objectsize:disk" and "deltabase") and reuse ref-filter logic in
> > cat-file command.
> >
> > I also know about problems with memory leaks in ref-filter: that would
> > be my next task that I will work on. Since I did not generate any new
> > leaks in this patch (just use existing ones), I decided to put this
> > part on a review and fix leaks as a separate task.
>=20
> UPDATES since v1:
> add init to eaten variable (thanks to Szeder Gabor, Johannes Schindelin)
> improve second commit message (thanks to Junio C Hamano)
> add static keyword (thanks to Ramsay Jones)
>=20
> >
> > Thank you!
> >
> > [1] https://github.com/git/git/pull/493

Could you please populate the description of that PR so that SubmitGit
picks it up as cover letter?

Thanks,
Johannes

> > [2] https://public-inbox.org/git/010201637254c969-a346030e-0b75-41ad-8e=
f3-2ac7e04ba4fb-000000@eu-west-1.amazonses.com/
>=20
--8323328-575473446-1531916050=:71--
