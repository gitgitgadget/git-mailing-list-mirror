Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 236821F437
	for <e@80x24.org>; Tue, 31 Jan 2017 12:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752018AbdAaMUk (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jan 2017 07:20:40 -0500
Received: from mout.gmx.net ([212.227.17.21]:56232 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752029AbdAaMUV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2017 07:20:21 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LjvV7-1c1wRv3p7Z-00bpq1; Tue, 31
 Jan 2017 13:13:31 +0100
Date:   Tue, 31 Jan 2017 13:13:29 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] add SWAP macro
In-Reply-To: <6760493c-3684-b8bb-2c01-6621b8417246@web.de>
Message-ID: <alpine.DEB.2.20.1701311305030.3469@virtualbox>
References: <8ef4c833-45bd-6831-0683-6d01f30aa518@web.de> <0bdb58a6-3a7f-2218-4b70-c591ae90e95e@web.de> <alpine.DEB.2.20.1701301637570.3469@virtualbox> <9bcae427-d654-a671-4368-030150168102@web.de> <alpine.DEB.2.20.1701301806591.3469@virtualbox>
 <6760493c-3684-b8bb-2c01-6621b8417246@web.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-2143509909-1485864811=:3469"
X-Provags-ID: V03:K0:jaD43E1gIPOOcCVsO0pdKuu9mN2XAiwNDQQzcBaS9VNO7rbtOKh
 Wbeny77njdjULrsP0DSCC1petm6y4uryrz4TToP9N0PtsbJMpE3StOIba4hucaavBph0cRH
 iw6kz6HOV20u0lhj//pzPQoKUWSKKQFBHC2lZpfIwhQKainRDJ/6Sf1dOpvbtlzLXC99a4X
 iFIK/typGNg6S9h1Tss9A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qlJgMgE6BK0=:X2t6W8UKMi8uY/LaLNQVV9
 TJjXLD49b7tZOmpB71t3kgov7fWCzTdo1CCLn5Bgb/15KD5VtcHIvQfzAOuC1xjpqdkluJ8fs
 9P0ngoCM3zarxQhxbgAjoj0+xVMmLpwOXcwUM4kKSkR3SoydhdVG6VQ52DxHb/xlVykzR+Uzu
 qkG2ydO3zrzBSklzPSDxeAfVXSplh5yC1RYESUdKW8hdJ6JKpsxgZUUSsM/NFUwfLZW/IdWQu
 av/9I+s5hQ1bjLqMRaaWzJyX/LKTlbukMMIRjjSmZKbBJfB09Ke8hMfVd2NFcA61z/3xcELSs
 HP0osB4/prW00MSEQ58Ll3GgMfVF4/1YlwM3lAsyZTgowtsxzcPh3NnD+/ex+yUkuLKKhOhZJ
 l4/SGUxeMpJK6yvUkW3dOyv0/Ak5aY7+wPDTGuTtcMgtpDFC6WXWD9ecvvMlVFNxwIjbinAQm
 uKmnUocyrAisVIjypuXsnAYDKylsjgbrO+3Z/x8Xe0Op9o+He5ECCKS0XBX3zy4H+fQ12zkfG
 2fjZneoqE4Z7QLd4qrmoMJ+Z/H52wTSymtm3bKPR61B1aszAM8neFC301JgBMrRRlQ7bLBNUp
 GQ/WyNDOXS+G33WYd4VFIlcTMjIe62ajVOH0qbEZynvM3WVn08Qs49gO1AJiDkRusdlp7xSSA
 bKefbMS9FWs4+Kw93x8L/RAsp8fxZ+C89sBtqaovjXxGHMgLrLSJlfE7R1tdFVml6Hl2aDvPR
 O/k7Hriqurrmy6sm44nkpw+p6lyaNBWqDUSnCA1epiNJt1vaVxYlkXXxQ5n86xpG1VxxUlawJ
 KtCIPivsvHDtgnH0c5R86eyms4f8PvN7sn0a3jY4ryiPjU3a+Rf1O6LeAnCYuXI2WDn9U0CP4
 TpR8u2tEEp2nqBjHsuxTPRUz4J1dY09SNvwrvLLdJK59Wpxfiwm2/wjLfMAfSWQtydBU96G7W
 WrNjxet1vTrjBUW8l8z3dhrvI64pI87jltS7U3Zg8psGzN/P9Cs/zBvEahxdpRAn3zU8cLc5H
 rf1M+wJNE77cihnIS1J4/Tgy0k0cGyBRoTKwe1xzm8qU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2143509909-1485864811=:3469
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Ren=C3=A9,

On Mon, 30 Jan 2017, Ren=C3=A9 Scharfe wrote:

> Am 30.01.2017 um 21:48 schrieb Johannes Schindelin:
>
> > The commit you quoted embarrasses me, and I have no excuse for it. I
> > would love to see that myswap() ugliness fixed by replacing it with a
> > construct that is simpler, and generates good code even without any
> > smart compiler.
>=20
> I don't see a way to do that without adding a type parameter.

Exactly. And you know what? I would be very okay with that type parameter.

Coccinelle [*1*] should be able to cope with that, too, mehtinks.

It would be trivially "optimized" out of the box, even when compiling with
Tiny C or in debug mode.

And it would even allow things like this:

#define SIMPLE_SWAP(T, a, b) do { T tmp_ =3D a; a =3D b; b =3D tmp_; } whil=
e (0)
=2E..
=09uint32_t large;
=09char nybble;

=09...

=09if (!(large & ~0xf)) {
=09=09SIMPLE_SWAP(char, nybble, large);
=09=09...
=09}

i.e. mixing types, when possible.

And while I do not necessarily expect that we need anything like this
anytime soon, merely the fact that it allows for this flexibility, while
being very readable at the same time, would make it a pretty good design
in my book.

Ciao,
Dscho

P.S.: I am sure glad they use the French name and do not translate it to
English.
--8323329-2143509909-1485864811=:3469--
