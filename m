Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9F0B1F915
	for <e@80x24.org>; Sat, 14 Jul 2018 18:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbeGNSxN (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Jul 2018 14:53:13 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58070 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726960AbeGNSxN (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 14 Jul 2018 14:53:13 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:5996:38d5:9b31:ef84])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7579F6047B;
        Sat, 14 Jul 2018 18:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1531593197;
        bh=cbPy9nCt796oGfMYpsCd+XWRsJLuIaixEQg9dFZY6sQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Z0Idbr7G6/RIZ5ioq/nI5dunncr6kiyLD6lM0jyBJzZvk08gWrzqKh4dFDkwpt1T8
         BaTUvYYTg1f9YcwM86WmuzfqdKWJVOtiTHyUuXJ4o5XwYQytASBecEOyRK/hvcP2X9
         4pAUhru6qE+HHq/3EdfEKSQ50v2p211/6a+wsaCISS3W1PVGfvLPE94V8d3LnKpBx4
         MlPZZpKzTPrjmHEo0dN7ietKZSn7Ys4z2ddbPtiY3ZKf0bLOQ6Ano1sJeNj+U6A0y5
         U/hNeWuJT7kf4Qjp/3GBuzBrR2sXr1hrU0yIWTc8hM9HytyFbEDwC5+m8D1HTMgCdb
         NH/ZKg01TTAkuIYWnL1yHqA8xyYoabNX8NnQkATBT21pNlo9zMcfGTMKvAc+PeNpT1
         6nF+ekhpQLk+ecPVEtJS+hB/RSdCuFtzWvMDXOTa9ZEbKBk/5HFc+8I2gkAz3nCq3y
         r/lyDvBDm8K2DYhrQxUT3aYPfp6xnsJa7pxHfYbSlJ3oe890XU3
Date:   Sat, 14 Jul 2018 18:33:12 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Henning Schild <henning.schild@siemens.com>, git@vger.kernel.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 0/9] X509 (gpgsm) commit signing support
Message-ID: <20180714183312.GG1042117@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        Henning Schild <henning.schild@siemens.com>, git@vger.kernel.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>, Taylor Blau <me@ttaylorr.com>
References: <cover.1531208187.git.henning.schild@siemens.com>
 <20180710171224.GI23624@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KIzF6Cje4W/osXrF"
Content-Disposition: inline
In-Reply-To: <20180710171224.GI23624@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--KIzF6Cje4W/osXrF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 10, 2018 at 01:12:24PM -0400, Jeff King wrote:
> On Tue, Jul 10, 2018 at 10:52:22AM +0200, Henning Schild wrote:
> > This series can be seen as a follow up of a series that appeared under
> > the name "gpg-interface: Multiple signing tools" in april 2018 [1]. Aft=
er
> > that series was not merged i decided to get my patches ready. The
> > original series aimed at being generic for any sort of signing tool, wh=
ile
> > this series just introduced the X509 variant of gpg. (gpgsm)
> > I collected authors and reviewers of that first series and already put =
them
> > on cc.
>=20
> This series is a fine replacement for that earlier work. It's flexible
> enough to allow what we really wanted out of that series (gpgsm support,
> or another drop-in tool that uses the same interface). It doesn't lay
> any groundwork for further tools (like signify), but I think the
> consensus on the list was to punt on that until somebody had more
> concrete plans for adding such a tool.

I actually think this moves in a nice direction for adding support for
minisign/signify and other schemes.  There's a way to look up what
algorithm is in use in a particular context based on the first line and
a general interface for deciding what format to write.  Granted, it
currently still is very specific to gpg-style tools, but I think this is
an improvement in that regard.

As an OpenPGP user, I have no interest in adding support for other
tools, but I think this should make it easier if someone else wants to
do that.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--KIzF6Cje4W/osXrF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.8 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAltKQegACgkQv1NdgR9S
9os0Xg/+P9RklTYa5pelK9KOfc/zE4wYnaj+rnKYstXBYWygqUqeg+cHr3xpGWaN
d7r1gpl/dXvFVDRJgkRKMODf1if+jZQUUh6+Z6CpcSezss3rCNdr1GSP5w6v6z1G
a6fnwAQ7Vumwp3SZM52saLP1qD4bDa4TVwlezlX1xYTCSMbnp9ZeI4wSLEW+rS2M
7MlJjB268IGqbYQdYk8rgrbIBeZGsC1X9MO3wvmfP+pmHbDUpDrWAh0hdeR3fFlS
zOOSnywMdf+MX5dIpTWr04/VS86Fr8UU1eYS5k4WXDrr9b7BJOpDmKTXvEK/Emgn
saIx5RoRp0Dpcs/4py6ebxtQ7p/UmPzkjZHsgjJ/e4LQa8jWq2l3zeyUvSI9haIR
iKBlGxDNVrkh0GUGHwqJ3I4plLNkLetlf83zk/ED4gXG/n21mGFWxH0R1HYVpEI+
4bQXgdqito9EjZHA9ORikMlxzYXsK+odQaBOZ9iOsDobOPWUjOogH9B+DGCIqDC3
kxhf0A8kLkcvWfqfpDQn49y9Hv4n+Fd2KmAb2ER7M4sL2AFfB/44mH+3urFIC0D4
XcXIyU5myv5ODCim8HXmekVCLDaRbI6DrfFjbtG52r199r53FeGVJRaCkitufiRa
XqTbjaUv9npe52yi9UY/G8943BwQ96d4+t+5jE/G0DxfiAID9gM=
=1qpW
-----END PGP SIGNATURE-----

--KIzF6Cje4W/osXrF--
