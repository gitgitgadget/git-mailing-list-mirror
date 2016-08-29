Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DD101F6C1
	for <e@80x24.org>; Mon, 29 Aug 2016 11:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932295AbcH2LUG (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 07:20:06 -0400
Received: from mout.gmx.net ([212.227.15.18]:53302 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932346AbcH2LUE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 07:20:04 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0M5cMq-1auJaw1BZw-00xZ5J; Mon, 29 Aug 2016 13:19:34
 +0200
Date:   Mon, 29 Aug 2016 13:19:32 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/22] sequencer: future-proof remove_sequencer_state()
In-Reply-To: <alpine.DEB.2.20.1608291258280.129229@virtualbox>
Message-ID: <alpine.DEB.2.20.1608291317370.129229@virtualbox>
References: <cover.1472457609.git.johannes.schindelin@gmx.de>  <2245e7db4d4c028f63b2f4c41097559f91756f2c.1472457609.git.johannes.schindelin@gmx.de> <1472462696.4265.23.camel@kaarsemaker.net> <alpine.DEB.2.20.1608291258280.129229@virtualbox>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-990687973-1472469574=:129229"
X-Provags-ID: V03:K0:JuDTPrqtuwijqzqPMOtRIUWrGhaXRKAedLZGG6BHyxtSre4P+El
 y6E44ybz0YChHVoGy4Avyph/kItGaDy3Lmlt0PyZg5/iDx4CqWp6I650GtbCh7mkluFC7U3
 9ociIr4IaN5fqJ93LotoeDGPPnDtCyKcR9p+twtWM+rkIcPe33C3Z5ao+Ot6IohYUOQi6QN
 kvD/CMFgELO68VdED0Usw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PTUb36PW994=:HGbdck+/T5xWCwBqoc/jAH
 ze1RX/75Hvg1tLDlAVfC9b8VWr2/UA6KfpY7jV7yD/q5mk2Vso9ww1PAF48/a/uW7al6yMreB
 cjlLNtpqukTo2xafvi0vlDKJlsbFiXjWUm9dbtc4Q2t5LyM+DaUeHB0tpZL12ERZNDqvjLqbB
 4S7n1LC7b3suKG48XZs7K/e/J/aoBUuFMllm5n8RuHktIABlgvEbdy+0pUwYMmtG+wdN7/kTw
 2GkrKWAl7KzyTfPu7guEys/N0cfBLCmuJvT7mlqjUp0vYeu0y+3qhJZu8piGeWKpGa+7XYohg
 nimQHuH75lePQNjlIC1FWpNFdJ6+CsOh7nBlildd0lQPbxFxO7GjPEbwXAZW/UQIkNCaXr6ao
 VDAHFHp6xTDIFcjuCQaq/Q+RsBLwFITeO9Wp8A49JzKldY6hMzaoPEDDZABDIBy+cFKyxPnzj
 aYIkHSFYOfxMJkXbGv3UChIeJxZj4rEsoYJd4E1Gk1TTZtGVC4iFrNNp70RbbWgDQpxuaQdDl
 oyTVRX0O93S0PoSoAcmai8IFg089OXF7rQsZxjPTPigEC/vjc/UZpRQkyf2M5yNynqapeI6yg
 MKTB+gyovcWvh1Aw8JkK9hEzXgy3JV35frjjxFeaQGQLK3IPZaYN/xWQTkXyjlArdtOHv5jVS
 bpqg9DeD8/Y3tN/+4j8/C05emUlGXG5TCVBmU24Geo9a96p6tZDVTw0KYf+ztHQYWNV2F3U5z
 6tgpUEsx7ooe7qMPazv5E+gUsDONTDXlTndVmHOac4uohRhGvdzYBWN0xKfE9A10qVWwMAypL
 zMJVTsp
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-990687973-1472469574=:129229
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Dennis,

On Mon, 29 Aug 2016, Johannes Schindelin wrote:

> On Mon, 29 Aug 2016, Dennis Kaarsemaker wrote:
>=20
> > On ma, 2016-08-29 at 10:04 +0200, Johannes Schindelin wrote:
> >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (read_and_refresh_cache=
(opts))
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return -1;
> > > +
> >=20
> > This doesn't seem to be related to the get_dir changes?
>=20
> Good eyes.
>=20
> Let me investigate why I have it here...

Unfortunately my reflogs got corrupted by the git-worktree
implementations, so I cannot back that far.

Looking at the code, and after running the tests, I am convinced that it
is a leftover of some misguided attempt to implement "git rebase -i
--abort" in sequencer_rollback().

I removed this hunk from the patch.

Again, Thank you so much for your review!
Dscho
--8323329-990687973-1472469574=:129229--
