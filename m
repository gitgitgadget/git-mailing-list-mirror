Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA6BF1FAAD
	for <e@80x24.org>; Wed,  1 Feb 2017 11:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751399AbdBAL2e (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Feb 2017 06:28:34 -0500
Received: from mout.gmx.net ([212.227.17.20]:56950 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751266AbdBAL2d (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2017 06:28:33 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MOTRh-1cVKJJ268T-005s7L; Wed, 01
 Feb 2017 12:28:16 +0100
Date:   Wed, 1 Feb 2017 12:28:13 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Brandon Williams <bmwill@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] add SWAP macro
In-Reply-To: <20170131213507.uiwmkkcg7umvd3f4@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1702011225250.3469@virtualbox>
References: <8ef4c833-45bd-6831-0683-6d01f30aa518@web.de> <0bdb58a6-3a7f-2218-4b70-c591ae90e95e@web.de> <alpine.DEB.2.20.1701301643260.3469@virtualbox> <aa653d57-4a97-ac50-b20c-f94ed43a22fb@kdbg.org> <alpine.DEB.2.20.1701302158110.3469@virtualbox>
 <77098ac8-1084-a5c4-a5e6-fb382e3dc3a0@web.de> <20170130222157.GC35626@google.com> <8e94756a-c3a5-9b81-268d-d0f36876f710@web.de> <20170131213507.uiwmkkcg7umvd3f4@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-2147181406-1485948496=:3469"
X-Provags-ID: V03:K0:9odisgLk++Oy2qK+VX6osWKC2s7p4P58Em0U1Ej8QPliP6Eilvd
 7lgfh0oICbGKeTXMI/WG7OfP4KiW3P3lV5Mu4oZ9IJoQm21tRzsAzPbTL+SRIV9LtmUQ0t6
 whCOVOxhhC8QCi7c639/iHx87YAT70g1p6mBdB+/JYnk7O0/i2k1TlYd4OqiK7e+OVoKvfo
 q7qAC8nUar1xXKOnXN2pw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/NFnjhrM1qc=:4d3RRmiD4jDiPjqbazlWho
 JyTR04n30yHtUMd9Hui+rK6bAfRriAWE4jo980iNnRcxG/LYP5oFrhSUVM7PWQMYG/cBCCtuO
 39UEsqK8/PVAReVi0zGy6TOJ7wTLZm4wp3ZCTeUC5b2KhNCduf6S+Tx8xV7JFZxBwXwM9V5wI
 SoSzkVjYgYgfD02xlz57U7/i+11kTV7zDCxluEVEuvuZstFYuQPfxax7qUgS3MPw+H6KrXKDj
 qcFnSFK/2clLK+UfNSc/B7TB1S1Ac9FjFkm1D59GwAytBzQogB+x38jzgAhfAbYsnl1X7eKZz
 XFjhuHetSzTKkbwOAjKPKOIfTBYJ5SUIqtGQcS5aBVgctnx38afFA9r5yBWAyDbr0RhuPfA7z
 9HQ7LE0c39rSUDnyT30sgc3qGMzRNYMoD9XBkjos33XBVw/G5OoV2yUTor/+jD4Mi8GlNVXlI
 SNo5uAjzokbFGvDIIxVBmFY8s++2wZET//6cEqMKFesYCcY1EM/H1BElnUtQKRiv+Fsa5gO0h
 RoTj8pPDdjET31Nda0gimkWAKk9khfu0R0sHVjhGUaSmb253/ZmAttDIDYw68YbsDJxT9U+37
 PFxq7wT9cbFukPwKQNfmvoBwPfXIHuIEQrMV3hMOu1aQVIXtVur3vD6lZmXcRoHneuqOlgXID
 hO+VtZEK8PvlvdnLFKih47ZBWd7NpAGuRKSHQYPbVIyR8+ZI9gmtl8qyqk7wa0khijGgUiYxc
 qy6q1zbFlap7Zrz5/K+hjXUyDkFSBYbOziN9zVDqKpR7FNmTpbH4ByT1x39h6lv5S3A90i0Gz
 8QksHodNvF9rWv4xqG81HJAkPimRg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2147181406-1485948496=:3469
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Peff,

On Tue, 31 Jan 2017, Jeff King wrote:

> On Tue, Jan 31, 2017 at 10:03:01PM +0100, Ren=C3=A9 Scharfe wrote:
>=20
> > > Perhaps we could disallow a side-effect operator in the macro.  By
> > > disallow I mean place a comment at the definition to the macro and
> > > hopefully catch something like that in code-review.  We have the
> > > same issue with the `ALLOC_GROW()` macro.
> >=20
> > SWAP(a++, ...) is caught by the compiler, SWAP(*a++, ...) works fine.
> > Technically that should be enough. :)  A comment wouldn't hurt, of
> > course.
>=20
> One funny thing is that your macro takes address-of itself, behind the
> scenes. I wonder if it would be more natural for it to take
> pointers-to-objects, making it look more like a real function (i.e.,
> SWAP(&a, &b) instead of SWAP(a, b)". And then these funny corner cases
> become quite obvious in the caller, because the caller is the one who
> has to type "&".

But forcing SWAP(&a, &b) would make it even more cumbersome to use, and it
would also make it harder to optimize, say, by using registers instead of
addressable memory (think swapping two 32-bit integers: there is *no* need
to write them into memory just to swap them).

And I think I should repeat my point that this discussion veers towards
making simple swaps *more* complicated, rather than less complicated. Bad
direction.

Ciao,
Dscho
--8323329-2147181406-1485948496=:3469--
