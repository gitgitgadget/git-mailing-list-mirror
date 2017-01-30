Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5147F20D11
	for <e@80x24.org>; Mon, 30 Jan 2017 20:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754363AbdA3Ut1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jan 2017 15:49:27 -0500
Received: from mout.gmx.net ([212.227.17.20]:61861 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754438AbdA3UtV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2017 15:49:21 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MLi1v-1cXTf23qDb-000uCz; Mon, 30
 Jan 2017 21:48:32 +0100
Date:   Mon, 30 Jan 2017 21:48:29 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] add SWAP macro
In-Reply-To: <9bcae427-d654-a671-4368-030150168102@web.de>
Message-ID: <alpine.DEB.2.20.1701301806591.3469@virtualbox>
References: <8ef4c833-45bd-6831-0683-6d01f30aa518@web.de> <0bdb58a6-3a7f-2218-4b70-c591ae90e95e@web.de> <alpine.DEB.2.20.1701301637570.3469@virtualbox> <9bcae427-d654-a671-4368-030150168102@web.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1493625541-1485797863=:3469"
Content-ID: <alpine.DEB.2.20.1701302122560.3469@virtualbox>
X-Provags-ID: V03:K0:pKA7UcInywItg///F/RoJKchKl5sfD80L3P+Gv8KPCIP9eNG5AA
 pGeiWK6K3FlTjG6ubhgWNct7zNqsDnhqihJrfpJaKfAzt2aoGW7912DoC3pHs4JrY4OJfKv
 MrrJSD+KgopTXZb9/yPgCVk6iJR0j9U2tb7TyMRxZ/C3Eb/SkUOw3sdWeQ1bz4sqo75zXeC
 w27CrxK4wY8iq8R1vn3iw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Uo1bpKwGMRk=:MnhkbNurAdpjbygqQJ2Cns
 Z+4+a+WhM+jYOujF0CqtND3QyNjalxS7A9jMl3GS2cyGQpgCQOycc+xPLzD7rU3AjbTOiDJt1
 8ElH0FEtv9lbX2tAqbZGAb2R8jo5jY60a/HKfhjd2RuHrsvjb/m91xHoFdts2W9Q/aUb4OjyP
 +OVZnVLoQGXMJByXFRNethsHArx43LHn/WyOzpVYkFTp+tIe5jI8ANEhfA9HEslqp8hnm54rx
 004tyC2gFTIrDDnqo8o3vjOueLGC8AdXbcR6QRvnZ5gkocugpuQyc/hgLcMPldUjOW0ZW0r1s
 XUADol2UMm46BBB4BzU7dMgWxqiyBSTMiGSnSeOMoeYHCB6ScfB8FCm4dAm1JrNfdYA4Dr7AD
 sNeyTa/JBaU703zDx8pMRXSqx1VQ/JZkTkSrshA+Hd2uPnE159UtvXBOOufmMesZzHCakLaxe
 ca4t9VGERdyrSm7L3tfLePX6Op2NGEPaLL1Ck93Ni6h4OYY1qbxV0RA5db0U+/AJrl4qeI+Xe
 x/Ov+7qgwv8HgoeTGcyRnzQAN4Z6FyonsAJd9O+CLdL5VbU7YI+Mv7kvxz86h5KknNKKqivYi
 wShcD4k/bQMaxPMBheK1tjAbWDQ5poXA2b/yeJt6zbqYk9IUT/OvdF/4R1Sp4aTbbECNN+KxN
 w6WU4lTMkN3sAIPKzbyHY6PAm/8pccMWP1bnYynORV8xzPkvffjQcKpza574xxUDcwklNNmQn
 rKri9V5jmwvYsT05gPf0AJndDfzT4rPxw6fXnPGCOPMkdD6A8MjAhhdd4A2dlBFHMm6k+X93A
 fMuxURo3KkIsW6WgbV3BGR/N8jAqA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1493625541-1485797863=:3469
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.20.1701302122561.3469@virtualbox>

Hi Ren=C3=A9,

On Mon, 30 Jan 2017, Ren=C3=A9 Scharfe wrote:

> Am 30.01.2017 um 16:39 schrieb Johannes Schindelin:
>
> > On Sat, 28 Jan 2017, Ren=C3=A9 Scharfe wrote:
> >
> > > Add a macro for exchanging the values of variables.  It allows users
> > > to avoid repetition and takes care of the temporary variable for
> > > them.  It also makes sure that the storage sizes of its two
> > > parameters are the same.  Its memcpy(1) calls are optimized away by
> > > current compilers.
> >
> > How certain are we that "current compilers" optimize that away? And
> > about which "current compilers" are we talking? GCC? GCC 6? Clang?
> > Clang 3?  Clang 3.8.*? Visual C 2005+?
>=20
> GCC 4.4.7 and clang 3.2 on x86-64 compile the macro to the same object
> code as a manual swap ; see https://godbolt.org/g/F4b9M9.  Both were
> released 2012.

Good. Thank you.

> That website doesn't offer Visual C(++), but since you added the
> original macro in e5a94313c0 ("Teach git-apply about '-R'", 2006) I
> guess we have that part covered. ;)

Back then, I was not able to build Git using Visual C *at all*. It
required a Herculean effort to make that happen, and it did not happen
before the Git for Windows project was started in 2007.

So I tried to verify that Visual C optimizes this well, and oh my deity,
this was not easy. In Debug mode, it does not optimize, i.e. the memcpy()
will be called, even for simple 32-bit integers. In Release mode, Visual
Studio's defaults turn on "whole-program optimization" which means that
the only swapping that is going on in the end is that the meaning of two
registers is swapped, i.e. the SWAP() macro is expanded to... no assembler
code at all.

After trying this and that and something else, I finally ended up with the
file-scope optimized SWAP() resulting in this assembly code:

00007FF791311000  mov         eax,dword ptr [rcx] =20
00007FF791311002  mov         r8d,dword ptr [rdx] =20
00007FF791311005  mov         dword ptr [rcx],r8d =20
00007FF791311008  mov         dword ptr [rdx],eax =20

However, recent events (including some discussions on this mailing list
which had unfortunate consequences) made me trust my instincts more. And
my instincts tell me that it would be unwise to replace code that swaps
primitive types in the straight-forward way by code that relies on
advanced compiler optimization to generate efficient code, otherwise
producing very suboptimal code.

The commit you quoted embarrasses me, and I have no excuse for it. I would
love to see that myswap() ugliness fixed by replacing it with a construct
that is simpler, and generates good code even without any smart compiler.

Ciao,
Dscho
--8323329-1493625541-1485797863=:3469--
