Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 138551FAF4
	for <e@80x24.org>; Wed,  8 Feb 2017 15:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753221AbdBHPrr (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 10:47:47 -0500
Received: from mout.gmx.net ([212.227.17.20]:64366 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752278AbdBHPrk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 10:47:40 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LkTSx-1bzPFj2JYJ-00cO4s; Wed, 08
 Feb 2017 16:14:56 +0100
Date:   Wed, 8 Feb 2017 16:14:54 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/5] add SWAP macro
In-Reply-To: <xmqqr339y6q3.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1702081612130.3496@virtualbox>
References: <8ef4c833-45bd-6831-0683-6d01f30aa518@web.de> <0bdb58a6-3a7f-2218-4b70-c591ae90e95e@web.de> <alpine.DEB.2.20.1701301643260.3469@virtualbox> <aa653d57-4a97-ac50-b20c-f94ed43a22fb@kdbg.org> <alpine.DEB.2.20.1701302158110.3469@virtualbox>
 <77098ac8-1084-a5c4-a5e6-fb382e3dc3a0@web.de> <20170130222157.GC35626@google.com> <8e94756a-c3a5-9b81-268d-d0f36876f710@web.de> <20170131213507.uiwmkkcg7umvd3f4@sigill.intra.peff.net> <alpine.DEB.2.20.1702011225250.3469@virtualbox>
 <20170201114750.r5xdy6emdczmnh4j@sigill.intra.peff.net> <bfd0d758-a9c8-9792-6294-9f9ed632cc98@web.de> <xmqqd1f1pxqc.fsf@gitster.mtv.corp.google.com> <12e7db44-ff69-a38e-322a-6b5fc5f1fc29@web.de> <xmqqr339y6q3.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1982455492-1486566896=:3496"
X-Provags-ID: V03:K0:U4nJ7qxcYPvZPXncRdY43lQg+I8daqQHlgXDI6kLgqFGdas5K27
 8lNrGOPR9xu620a0kmX7T/TBuEsIdIRWBb3YvSNzKANZK2V+dwKxFcEvv6Nepf/88rzydHN
 DlXMM2eHSg7GrstiGipXiyEjBJg4yrOXQOgc/YvTcIQgwqQwxQh69uPLLttjHpXruIEzS7J
 k1ZE53QLmjK0UhRt4YVAw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qZCqhcEsUFM=:eSb4Jn8TBuOEaNMdFk+ewm
 9nP9YzCxqc3LzAs0hFavv5RW9janc2TbTaCIYTQGJUbtGUJ2sJ9xOkt7WJt8bixcUjE2IIqv5
 2I51mhhLpYiht6BPgvF3BrdfTY+4K2gl9/aYUWMRPMpSfuxVTV20zSRwgtIYGDEqPYfXNMaSW
 0ddA2fLJAuSfEuFmBzMtwnH2BQGXA2fqFg8uHEAdG8XGfS4+6r/ZqNJP0Clbigny6yjASZzoA
 KZPjAe9ivlSGgsD7F4TAHxG2NCrsm2X07N6PYOObmxfjIQotX/qijGs8USzR7ltBJNEP45GqQ
 VyLlhr6z3QZhOYOH3z0t6JtU21Rguy01rmohbmBxYpLXShg9mhI10aHFwVFNYNyX6Dmt46F0n
 Dp6fOCuwKGnRUfY60tOZElC3m6OiLZk6TTtPyKStGC+zTvAFhUicTOKAt5GVs7FjV/w/t0O3O
 6cGaRsF3eejET9MJGXVFI5xsAszbkz8W8zAXXEUq4fouJL7Dzt6LR5Dp4HeTKkpdTy8Am1m8M
 RZZNv73UD3G2UowSLajx0BkK8zCD+45ktEh8kg9TfspUn0kQK+t4jStp7HfaOFK127u/6AEAJ
 X6jU4cvIBGkW+G7XMn4o1Yc/S7WCGRU26Au1/aBRg+qniqMfoonhOUW9/PXj/TSRq6YkWP6Fq
 DMH/ha07joBl/oRKvVNS3d7ayK3WNlZm41FUzvI+YCYYszuwYpRCHxiQMOIQLtKPRMlCnwDFF
 fYeeQKzuRuOaN7I2OHhEXAjG1KLn2xobNo9s1fdsb8M0SkmdwYFSpOZjEnMUygaTeAf+0nVES
 cE3DH0W
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1982455492-1486566896=:3496
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Junio & Ren=C3=A9,

On Tue, 7 Feb 2017, Junio C Hamano wrote:

> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>=20
> > Swapping between different types would then still have to be done
> > manually, but I wonder how common that is -- couldn't find such a case
> > in our tree.
>=20
> I do not think it is a common thing to do, and more importantly, I doubt
> we want to hide such a swap inside a macro.  And that is why I said the
> seemingly extra "type" thing may be an improvement over your original
> SWAP() thing if it gives us more type safety.
>=20
> It seems that the thread has been quite for a while. Perhaps people are
> happy enough with your patches?  If so, let's move it forward, but I'll
> wait for a while in case follow-up discussion appears soonish.  The
> changes are fairly well isolated and I do not think we are in a hurry.

I am still unhappy about choosing to complicate things and lean heavily on
the compiler to make things right again.

But it appears that I am the only one with this concern, so go ahead. I
promise not to say "I told you so" in case that it breaks things or that
certain platforms are experiencing a disadvantage.

Ciao,
Johannes
--8323329-1982455492-1486566896=:3496--
