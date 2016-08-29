Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCA831FD99
	for <e@80x24.org>; Mon, 29 Aug 2016 15:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757637AbcH2PoK (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 11:44:10 -0400
Received: from mout.gmx.net ([212.227.17.20]:60017 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751559AbcH2PoK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 11:44:10 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0M9fLX-1bp9gO3KWt-00D1Z2; Mon, 29 Aug 2016 17:43:43
 +0200
Date:   Mon, 29 Aug 2016 17:43:41 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Paul Tan <pyokagan@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 01/20] cache: convert struct cache_entry to use struct
 object_id
In-Reply-To: <577f6266-42ec-6c7b-8b21-1e4997f2b816@gmail.com>
Message-ID: <alpine.DEB.2.20.1608291743060.129229@virtualbox>
References: <20160828232757.373278-1-sandals@crustytoothpaste.net> <20160828232757.373278-2-sandals@crustytoothpaste.net> <577f6266-42ec-6c7b-8b21-1e4997f2b816@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1270475952-1472485423=:129229"
X-Provags-ID: V03:K0:R7LXvOUlEignCVZgBAndDPBxHZw7UlZzTkRs70sB2tcthKRBNpS
 Jj/x0BM8GCQctc+U43VXYG9oALPWVQGIBNYApP9fQ04+Ddy+NHQIIfgMkBGgKKm+XhiwLCv
 Nz5W/jRx86R00/o//joqgwDLoU6x2N/g3CKffwxR+3fsLnkQzzxw3X6gxVCXroyhkeOSX2z
 7siaWlDmhcAg0/tSskFxQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/4G89Tbb05M=:7PINNK4kpMT8ETNdAT5dA/
 Yh6o4aAtRNk5nKi/H8/10t1jvQCyg1LqsM+KZgak4e53dBEOH6YT34ZOb7tMqkxPNezrZznnT
 l6ugocTJttgaHwySwHwJk77KruUOPbdnA2pylidB3awcZo/lIUacO9WHyXNOC6AoXwBhABqsu
 OG9DaL7ZjW//cBDMvvrkf7naz7UW9X82ieE9kvSpVDV5O2I9K6PcdgSPPhaLjSeI8OZPzLok1
 9/botKgUbGuppY0FXRBYjgyWNxgeItJJNcQ4gFZcK5mC4UV6bMH/Ito1HyVRxqZ3PCs1CJz0v
 0G3aL8K0j2n8HN/Q04yyDIKFAXAM+G//l6cuBC20L0ZumxztZFaPNBeMfpD3d0lrqcV+GUDn4
 yZ8dWrs/nb30c9NcfxN5PLUE4ot0zmYjLKOuGL0zM1yZ3qEpma/df4FG23CASdpswF1yMC/Xs
 IdbF5biZ9t4Q/gCotQzMeih+c4TVBtEmhjA6zajIiOJ2dKUBC7p1AY15owD1eKXuwJdKOcvR3
 P0pqhNV4g7byGF8zgaveGBUG0yBf0qzfILYy27T75eEbRQan8EScobQUzumQNvSTwTn/6DzDo
 yL1Q/qLf3/av/VP+EotY7iwwCOsJY7SJGOzbchBZEsKobn2027haeuFlkzdVvpIjJpyydyVXI
 60seZRDREsSqUmVQfJg+blDa020g2Sjd64XvHxjqv271TJgzEGeKn8yoGEEHlaWd67M8xdWyY
 TaCYmO9BYxwFKF9Xti8F1Hh81jBl98mYMNwehikG6TEivu40k1OfQwv1KHVkABCHaN0/AoUg9
 uJX71wt
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1270475952-1472485423=:129229
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Kuba,

On Mon, 29 Aug 2016, Jakub Nar=C4=99bski wrote:

> W dniu 29.08.2016 o 01:27, brian m. carlson pisze:
>=20
> > Convert struct cache_entry to use struct object_id by applying the
> > following semantic patch and the object_id transforms from contrib:
> >=20
> > @@
> > struct cache_entry E1;
> > @@
> > - E1.sha1
> > + E1.oid.hash
> >=20
> > @@
> > struct cache_entry *E1;
> > @@
> > - E1->sha1
> > + E1->oid.hash
>=20
> I wonder if writing this patch series (or rather the following one)
> would be helped by using one of semantic patch tools, such as
> Coccinelle[1], spdiff[2], or Undebt[3]...
>=20
> [1]: http://coccinelle.lip6.fr/

If previous work by Brian is any indication, he did use Coccinelle and the
commit message actually shows the definition used for the transformation.

Ciao,
Johannes
--8323329-1270475952-1472485423=:129229--
