Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_12_24,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1025F1FD99
	for <e@80x24.org>; Tue, 30 Aug 2016 06:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752677AbcH3GVs (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 02:21:48 -0400
Received: from mout.gmx.net ([212.227.17.20]:55688 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751804AbcH3GVs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 02:21:48 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MGip3-1brWa52a2r-00DTRI; Tue, 30 Aug 2016 08:21:40
 +0200
Date:   Mon, 29 Aug 2016 19:06:53 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
cc:     Dennis Kaarsemaker <dennis@kaarsemaker.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/22] sequencer: use static initializers for
 replay_opts
In-Reply-To: <8c36fb5f-42a2-e4a7-1b7d-c8e60de593e4@gmail.com>
Message-ID: <alpine.DEB.2.20.1608291906300.129229@virtualbox>
References: <cover.1472457609.git.johannes.schindelin@gmx.de> <66d69469a64bd80d3bf2b99a250ae04a649d94d1.1472457609.git.johannes.schindelin@gmx.de> <1472462360.4265.21.camel@kaarsemaker.net> <8c36fb5f-42a2-e4a7-1b7d-c8e60de593e4@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-277512886-1472490429=:129229"
X-Provags-ID: V03:K0:rXDsQx0NlmkROQwtSZkXWUKffEFtHq5yKBrvFKbM8P1q6EP8v7c
 lfiwHvqtEgp2LEZsQyVU1/WTZHC6Ji23qfiFln4wOVzmB5wv7LGoV+u/QdRb8mchYf04Rm/
 a7lJAtFflQ7jkALhOKjL1zaqxb4TUkBqsaUlcEHlhI4dL1kBklHfIws5PObbUxf6qnUCV46
 79qxXAUvkdlmiWk9xtHIA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sfnlJsoH9J8=:FPOKufAbgfEl79z5NxX4Lh
 b63HaUUuvzUsxakCHt8lz/05HWZLQ19ohjIk3E57UMsXqF+Cjiz/v7zbhs8wqE78iEEvfiDZ+
 8AyEppn7sjwSRXykEEc29dXzlpj5GiV+03b1sDT1hly5vU1O/G2v2cthGDVyvwPFVsi7qQPgn
 3qCZoMMhSzzA2sqX/mCLbIT4bXUnAJDzSpYcMA7wBEeW3yGH4J46hpqCpWknWmP0M0P0t+bp8
 GA0eP7r0y8edYabCmEGIHb0u0Y4mofLXdMSSwaMkbn6HxL/FD9myaZtPs5G+3o/iMVFeE2YML
 1Kx2IdCPjovySN9z1vbGFWyX31VXo9ULbputRVYEbYHgJv9tWry53VcWnBIunaup7gNieHjNc
 5Gw5c5JBa5IHMgXk6M17BBzmKs/ktFwyZnN+Se3oYvSHoz4+75jtD2fKe4N20w++lwwwi+zaI
 G4VeLHfecO/qljewjMRr60M2dPck4TsgMAhz7Zu394utWbsOv41WN5/HLQDIfEcKx+qcBskoq
 0Jzmjjsk9dv1TzBBMN/16Y+QrufuSbfNjs5gdyUpCmQaS+Ta+xgXpCudNI2vWVsvDZBUg+wuI
 zgPYcc/lB3o1E1hwp0JUOdZaaZTFBhyYEXlcfEr22CqlrFAmmvWWkggm0MsMWCj0hgFQniT79
 BbjUGiYlVeAThUXA9RtNpbJ+7TjroiaSxn7HGTj4qh4JSwb75gD9qIWPVv0dJl/WG3y2Tqcou
 vyyxlXGJF+qglVaIqRQMEJVRu+BGdlr6pBRQAmm975LoxK+0ybFYiIw+wDP14jxEJXHd5uFrV
 /6OWXZk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-277512886-1472490429=:129229
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Kuba,

On Mon, 29 Aug 2016, Jakub Nar=C4=99bski wrote:

> W dniu 29.08.2016 o 11:19, Dennis Kaarsemaker pisze:
> > On ma, 2016-08-29 at 10:03 +0200, Johannes Schindelin wrote:
> >=20
> >> +#define REPLAY_OPTS_INIT { -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL=
, NULL, NULL, 0, 0, NULL }
> >=20
> > This looked off to me, as it replaces memset(..., 0, ...) so is not
> > 100% equivalent. But the changed functions both set opts.action and
> > call parse_args which sets opts.subcommand.
>=20
> This information would be nice to have in the commit message.

Clarified in the commit message.

Ciao,
Johannes
--8323329-277512886-1472490429=:129229--
