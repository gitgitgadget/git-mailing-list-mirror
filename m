Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0C23202CA
	for <e@80x24.org>; Tue, 28 Feb 2017 21:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751883AbdB1V2O (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 16:28:14 -0500
Received: from mout.gmx.net ([212.227.15.18]:62392 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751531AbdB1V2O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 16:28:14 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LhOO8-1bwGYu0H1k-00medp; Tue, 28
 Feb 2017 21:55:00 +0100
Date:   Tue, 28 Feb 2017 21:54:58 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 0/6] Use time_t
In-Reply-To: <xmqqa896kuve.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1702282149160.3767@virtualbox>
References: <cover.1488231002.git.johannes.schindelin@gmx.de>        <20170228142802.hu5esthnqdsgc2po@sigill.intra.peff.net>        <f6b57868-0173-48d9-86cb-79780f7e301b@web.de> <xmqqa896kuve.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-910223319-1488315300=:3767"
X-Provags-ID: V03:K0:tMDJ2pM0idyFw8NdnYAZtHNbEe0VnYUZsQ9D0AWa1srZZCTX0a/
 2WmmMawM9Yvpr3us503uFmqyB7pYbiAjFPwv5+fjGZZY4NdcidzhpTDQdQwdiQ8+Hqv9ck4
 CeaZeugmTmlhEWb5gsg0Y6q2ark6xVhZB3mYFZ/qND+szK69yS04kTnWkDj2taM8WgZpLvS
 jYq13pNNhVLjQqoWyhKBg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kNBMZgvWpaM=:loBfFnfXkAPRpcI+Ps0wgK
 tw7IRxk9IQ2St2yOuxSHQqK4ar3ygQeF4MXC12bfo8yi7U+W9ujsW246ry3I3eQNYHcFks+AS
 DnQz82OQnydlnObrVcZxrJsmuDE+zVf5auqbYUjtStbYBZ3RWmURcMPY+C1kWy5I56rz74itD
 gMfz8VcehxCIvRukBEDWKgSoIw3jXONBHOLmgSynHiwIEzTW5eKNuZMSEVedRAZMoIFKBuAPg
 /UBs74tr88acOK6BuDPFGeD5ei9Es1G7xw7DSP1SydIzg71Rn2PCk8QHR5MgyvJgcsrRKTxkS
 OQ+j2BM0pyCUaxfPXeXn2Kg39+2ZAO4Q4EJ01gASw4LUZnu7XqiQLHYkCPp+HCvfU2hRxwmRf
 Gcpa5wHoz66jljeZJOH8d114dUYpdNxDp3wzCPYm0tSWHZ+b8kewd95G2l9MDhawniiKLnqBH
 UknR8waJ6tKJZSzV0ITVvenqpX6YMaKNJY9xhoIi1Z2cdSXmb1C0jE9fO/JczsTS+PSMfKDy0
 zkrxcJcp1gqPqKNyI5s0sZLmjzLds/5QfoaJCgnqqmut/yo3j9QsT3mNozk505wVCcWLv5Qk9
 k1FNAvxyaNO8SoPF3WQdTUbTsgYmZcwtciZx4EqMBXP39pniprq4jvN2m9pqwgMtZOm7scxpy
 HSpSq860FquOa+bAt8rjScC5uentI4pdlR52UxHh0olYdN+Yl7ojwk1izwsqoxTdlhau64cU4
 xr+wRgCqI0dtAHoKb41Q1/G9deIXe6Kd2uNzlLI//x7eqvigl26CIDOgz26LQVa8VgirfGSmC
 p19c8eFkllN5RPF2hxHXVB0KnnAmA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-910223319-1488315300=:3767
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Junio,

On Tue, 28 Feb 2017, Junio C Hamano wrote:

> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>=20
> > Am 28.02.2017 um 15:28 schrieb Jeff King:
> >
> >> It looks from the discussion like the sanest path forward is our own
> >> signed-64bit timestamp_t. That's unfortunate compared to using the
> >> standard time_t, but hopefully it would reduce the number of knobs
> >> (like TIME_T_IS_INT64) in the long run.
> >
> > Glibc will get a way to enable 64-bit time_t on 32-bit platforms
> > eventually (https://sourceware.org/glibc/wiki/Y2038ProofnessDesign).
> > Can platforms that won't provide a 64-bit time_t by 2038 be actually
> > used at that point?  How would we get time information on them?  How
> > would a custom timestamp_t help us?
>=20
> That's a sensible "wait, let's step back a bit".  I take it that you are
> saying "time_t is just fine", and I am inclined to agree.
>=20
> Right now, they may be able to have future timestamps ranging to
> year 2100 and switching to time_t would limit their ability to
> express future time to 2038 but they would be able to express
> timestamp in the past to cover most of 20th century.  Given that
> these 32-bit time_t software platforms will die off before year 2038
> (either by underlying hardware getting obsolete, or software updated
> to handle 64-bit time_t), the (temporary) loss of 2038-2100 range
> would not be too big a deal to warrant additional complexity.

You seem to assume that time_t is required to be signed. But from my
understanding that is only guaranteed by POSIX, not by ISO C.

We may very well buy ourselves a ton of trouble if we decide to switch to
`time_t` rather than to `int64_t`.

Ciao,
Johannes
--8323329-910223319-1488315300=:3767--
