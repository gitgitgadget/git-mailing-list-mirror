Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C5761FAAD
	for <e@80x24.org>; Wed,  1 Feb 2017 11:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751344AbdBALjY (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Feb 2017 06:39:24 -0500
Received: from mout.gmx.net ([212.227.15.18]:60877 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751311AbdBALjX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2017 06:39:23 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LaWlT-1cBxhD0qr9-00mHnN; Wed, 01
 Feb 2017 12:39:16 +0100
Date:   Wed, 1 Feb 2017 12:39:15 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] add SWAP macro
In-Reply-To: <676ed19c-0c4e-341e-ba30-1f4a23440088@web.de>
Message-ID: <alpine.DEB.2.20.1702011228290.3469@virtualbox>
References: <8ef4c833-45bd-6831-0683-6d01f30aa518@web.de> <0bdb58a6-3a7f-2218-4b70-c591ae90e95e@web.de> <alpine.DEB.2.20.1701301637570.3469@virtualbox> <9bcae427-d654-a671-4368-030150168102@web.de> <alpine.DEB.2.20.1701301806591.3469@virtualbox>
 <6760493c-3684-b8bb-2c01-6621b8417246@web.de> <alpine.DEB.2.20.1701311305030.3469@virtualbox> <676ed19c-0c4e-341e-ba30-1f4a23440088@web.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1841927702-1485949156=:3469"
X-Provags-ID: V03:K0:Nj+6f+SvKBupg3BRej6HAl6oQ1ftplMVmUyL6ghpihJ+NkqXdJc
 AhdZyCdcseSjJrndiqnQ6E2qFfg0HNvRRmoKomQNZJ8vKef5qcoVp3D5p2hhTRWFLIOWfDx
 pdVPVnqvwHi8CAqfVacfhb2Osob9wn1CEE2z5y6MmUh1Jh6a81DMzL/7+eeCuR52nnh+fiV
 BYBg/InglofDaIxDv8NKg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:w/wDrtgemzM=:4SiUmdK/0G7f0c9qYzvBpr
 SQIU4a0X19pYl74ogmnQ0qz3LqV/VWpvINfYNjPekXHV10oPxhM9tZH2BovquZbueo7x7nLp8
 p3jjYZDyIW6ZJG0kYQKlgrrD5q0OpkzmyUEgiMarOzxTvOu40XcEQkLG8AcZgmf55j7JSLvti
 z/ZvPB3E2rwoJRUuonw7kD2MJVIKeWDJVcOryWzFbmDlprkCOtVmoTqZFjS8REq/Wxc6oFy5P
 NA4wqo0RYfZPEimhD17+HIOJUuFUjHK/bzaricjL3lUK4EnJEPDUPKo5FnPkEnZs0yNCiDMBH
 NyTvMjjtH4EZFLHqyaHYT+qsbmwn2SEq7PbjcC6kNTe81VQr+mPswNPKvBFDRUuI7x6aO/yhU
 u7uiXa53Wf7k0kaGHKyoopGr7kMesf1TPQCGJ915Awv0V1cot5jTg7YPWikgBe8U+7KAKyV3q
 EdFE6VyNtON5Vg/5Oc+un5B+ctpS2UHTpZLiGZZtfWwOohH6ckqs0WZqXPlCzLOL5NsyFR8u1
 WwJgaXlqCMGF1sZUqePNH7ySbIQNNOMdtjnLacw8OqFMQ+Uwg5VGAnmjgo2Rqji8TGyv72euc
 tS573HmdH///nxGWMG/WIC/7i29LwyTxZXqYcttWgfsz0eBoPfD8AAQOc1SGzVjl+hPL5E7kG
 /+7t89XpkarF27mqQucACablh1gXAmZb9poq6IrKWDPL8hLM4ZmNgLApp5JdIG2legQWkUuue
 QvkP3FnWfosjcGqNXReLr/vvxa8V1Lhn2rwy04pZOwKcv5IQBfyQtmOyIY7R/cXY2PC5fZ4l6
 NHHjAoeFdvWCN02cRdQFYOka2/Y8Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1841927702-1485949156=:3469
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Ren=C3=A9,

On Tue, 31 Jan 2017, Ren=C3=A9 Scharfe wrote:

> Am 31.01.2017 um 13:13 schrieb Johannes Schindelin:
>
> > #define SIMPLE_SWAP(T, a, b) do { T tmp_ =3D a; a =3D b; b =3D tmp_; } =
while (0)
> > ...
> >  uint32_t large;
> >  char nybble;
> >
> >  ...
> >
> >  if (!(large & ~0xf)) {
> >   SIMPLE_SWAP(char, nybble, large);
> >   ...
> >  }
> >
> > i.e. mixing types, when possible.
> >
> > And while I do not necessarily expect that we need anything like this
> > anytime soon, merely the fact that it allows for this flexibility, whil=
e
> > being very readable at the same time, would make it a pretty good desig=
n
> > in my book.
>=20
> Such a skinny macro which only hides repetition is kind of attractive due=
 to
> its simplicity; I can't say the same about the mixed type example above,
> though.
>=20
> The fat version isn't that bad either even without inlining, includes a f=
ew
> safety checks and doesn't require us to tell the compiler something it
> already knows very well.  I'd rather let the machine do the work.

I am a big fan of letting the machine do the work. But I am not a big fan
of *creating* work for the machine.

So if you asked me what I would think of a script that, given a patch "in
mbox format", automatically fixes all formatting issues that typically
take up a sizable chunk of review time, I would say: yeah, let's get this
done! It would probably take away some fun because then reviewers could
bike-shed less, but I'd think that is a good thing.

If you asked me what my opinion is about a program you wrote that gathers
all the threads and sub threads of code^Wpatch reviews on the Git mailing
list, and cross-references them with public Git branches, and with Junio's
What's Cooking mail, and with the SHA-1s in `pu`: Great! That would
relieve me of a ton of really boring and grueling work, if the machine can
do it, all the better.

And if you ask me about adding a complex macro that adds a bunch of work
for the C compiler just to produce the same assembler code as a one-liner
macro would have produced much easier, I will reply that we could maybe
instead spend that time on letting the machine perform tasks that already
need to be done... :-)

Ciao,
Dscho
--8323329-1841927702-1485949156=:3469--
