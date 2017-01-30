Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A6B61F9AF
	for <e@80x24.org>; Mon, 30 Jan 2017 21:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754474AbdA3VKb (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jan 2017 16:10:31 -0500
Received: from mout.gmx.net ([212.227.17.20]:60891 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752507AbdA3VKa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2017 16:10:30 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MYfJW-1d2bZT2Y42-00VMTP; Mon, 30
 Jan 2017 22:03:21 +0100
Date:   Mon, 30 Jan 2017 22:03:19 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Johannes Sixt <j6t@kdbg.org>
cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] add SWAP macro
In-Reply-To: <aa653d57-4a97-ac50-b20c-f94ed43a22fb@kdbg.org>
Message-ID: <alpine.DEB.2.20.1701302158110.3469@virtualbox>
References: <8ef4c833-45bd-6831-0683-6d01f30aa518@web.de> <0bdb58a6-3a7f-2218-4b70-c591ae90e95e@web.de> <alpine.DEB.2.20.1701301643260.3469@virtualbox> <aa653d57-4a97-ac50-b20c-f94ed43a22fb@kdbg.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-526191596-1485810201=:3469"
X-Provags-ID: V03:K0:2qEmpQT8fUtj1wFDyHGmKnR+q9vnWSZoVLzV9jzx3mxDgoQ4/V3
 c7iVDUuOM/orcdrqBsb5bN3koawNz+tiw89RvX+MwyrX6oundRNdUVdMPwpJWH5XxccUdD+
 aREvV62GdCDfUy7PpUynSthJsLRRPWzZ/EaXsTyx2E5QqEUNpjKpGLszSJIuCcr2vDhzGvJ
 Fk9pRacKmCjwG7Dd+wXIg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XX5MH6e7Olk=:rcMEjatjmUERU3agNAcZmF
 yisGVJjYInRq+Fehs+bOCeNlOZn0Op6nU7u4Ce4mtJOboV4YM0ZztcXtwSI1aLsD0Cvf39nwq
 ylT6aM5RhEIQb3qXe4cfPzJJQx0LrnJjLB3gTvQsr2M/h/spikloaY0EpE+0u4/857UgZz+Mr
 W0Fz74O2r34hGX2EH8W2IcE6GtwSpv3gWPAYOAL1MIbyl3HsPtaXZ0uvuNCogjCW7gjQMOoFM
 N1M3bZ5tSn70dn17zpd51AF0zNmZOBaVd7V4535YvsgGGKn/lSF3bIHpTUjPhR1Cj7YdFdVsF
 vtOBp1tg0Kh4i6fevAqDNbLEODj+LOmie8QjyaTsu1OcDamBLPYdzJrNX5CjhCkL65d1XmgvC
 M/0spJgtgQQk8SJoMg9y9G1d7+BnZ9uCNGFtR5muXxa/cpw2IMKzoUgxtDzEv0RlcnCkAPY0P
 T+EmBSqs+oIBaXMjCOekhXzkcBXi3GMeuBeml6ixHCZj60q0SRprPLhUxJQMwWxllWU8YaQFE
 LduqpbYsyLb8Oiw0NS5L6L7LY1Ub8ua5r199jYRmPJYvm1I9SUXyIG2W9LAsSzbHvitFhnuyR
 UAGEbIJ09yF9rbS23UVpw5wb/7KMoMm8xFUToQ59RuO/eY7I8NMQFlpQ7dqos3vbaew9p9w6J
 UC/vMuDg5Dam4mZLlJ7vhSx8B/Pl58h82eFgHUzTIO+jNGSvT+W9ddr9rkPaAfD7rczQRx2Yw
 zK0qChfmfGoR+t11xw6x4ZTf1O59lR5OqpOAIwu9liwy92/YgPe+UdpgevSon2y1HUn4YZcBK
 WHhMZcfqY3ENST1BpSic9TaDsCwdw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-526191596-1485810201=:3469
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Hannes,

On Mon, 30 Jan 2017, Johannes Sixt wrote:

> Am 30.01.2017 um 17:01 schrieb Johannes
> Schindelin:
> > On Sat, 28 Jan 2017, Ren=C3=A9 Scharfe wrote:
> > > diff --git a/git-compat-util.h
> > > b/git-compat-util.h
> > > index 87237b092b..66cd466eea 100644
> > > --- a/git-compat-util.h
> > > +++ b/git-compat-util.h
> > > @@ -527,6 +527,16 @@ static inline int
> > > @@ ends_with(const char *str, const char
> > > @@ *suffix)
> > >  =09return strip_suffix(str, suffix, &len);
> > >  }
> > >
> > > +#define SWAP(a, b) do {
> > > \
> > > +=09void *_swap_a_ptr =3D &(a);
> > > \
> > > +=09void *_swap_b_ptr =3D &(b);
> > > \
> > > +=09unsigned char _swap_buffer[sizeof(a)];
> > > \
> > > +=09memcpy(_swap_buffer, _swap_a_ptr,
> > > sizeof(a));=09=09\
> > > +=09memcpy(_swap_a_ptr, _swap_b_ptr,
> > > sizeof(a) +=09=09\
> > > +=09       BUILD_ASSERT_OR_ZERO(sizeof(a)
> > > =3D=3D sizeof(b)));=09\
> > > +=09memcpy(_swap_b_ptr, _swap_buffer,
> > > sizeof(a));=09=09\
> > > +} while (0)
> > > +
> > >  #if defined(NO_MMAP) ||
> > >  defined(USE_WIN32_MMAP)
> >
> > It may seem as a matter of taste, or maybe
> > not: I prefer this without the
> > _swap_a_ptr
>=20
> The purpose of these pointers is certainly to
> avoid that the macro arguments are evaluated
> more than once.

I mistook "a" being used in sizeof(a) for breaking that assumption, but of
course a is *not* evaluated in that case. It is curious, though, that an
expression like "sizeof(a++)" would not be rejected.

Further, what would SWAP(a++, b) do? Swap a and b, and *then* increment a?

Ciao,
Johannes
--8323329-526191596-1485810201=:3469--
