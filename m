Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 505591F97E
	for <e@80x24.org>; Sun, 14 Oct 2018 23:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbeJOHAR (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 03:00:17 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:50490 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726098AbeJOHAR (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 15 Oct 2018 03:00:17 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:90d0:bd19:fb95:28cb])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A9AA661B73;
        Sun, 14 Oct 2018 23:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1539559059;
        bh=xiYtQJv5A8SkcRZDDoCCJ3jlwf6/Okha6cktvhUsUYU=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=rTm+eNi4SaLHY4rtYR38ngKRx9HDoLkOJT4+ieXtRpC+scSf71LXxLCHVc5wi9EBT
         8OheEv13OXgRUug95Y/06G6GG4uVa++2lEspXvBOqK60zh22neAWQGTwCRv4kaqT26
         OHgVsNINxDxJFb/uokiw7NwJ976DYFnE2OCpO58eq0sgB/eaFs+iQYAKwKeaKIJpGQ
         ZOIiz89MgboVsxiyMyyZAYGtOJ+A5JQQdPeDnG8nR38RXSt8gTtASo05z5VW5sd3Z/
         x0VfF4nMNjZG6XKBYB4OI5bi338cDJx/vRC6BbcweADNjwwhW7f9rONeD13IAt8lkI
         VdYtTC4yKecQWt1BS4fk69pgxVZnNCaMYr1YWv1/QOhL4SRISPqhdLaV8y0y6eDHas
         2xJd43h7gIp7yC3ybi/5JxWPIJEIZj6ib1kpB5lJItjGK7ItsU5TPrXV1lscKahMFD
         0qHWbcesNqD0QSP7C4uEFgRMRT4WbxA+F95MEv+Aqgyrig1YTmz
Date:   Sun, 14 Oct 2018 23:17:32 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [RFC/PATCH] headers: normalize the spelling of some header guards
Message-ID: <20181014231731.GA432229@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        GIT Mailing-list <git@vger.kernel.org>
References: <2804aa4e-c078-c981-be93-27e6e58b2042@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BN+Sv8yD/qqrpTrl"
Content-Disposition: inline
In-Reply-To: <2804aa4e-c078-c981-be93-27e6e58b2042@ramsayjones.plus.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--BN+Sv8yD/qqrpTrl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 14, 2018 at 09:13:09PM +0100, Ramsay Jones wrote:
>=20
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>=20
> Hi Junio,
>=20
> This patch is marked RFC because I am not aware of any policy with
> regard to header guard spelling. Having said that, apart from the
> fetch-negotiator.h header, all of these headers are using a reserved
> identifier (see C99 Standard 7.1.3).
>=20
> These headers were found, thus:
>=20
>   $ git grep -n -E '^#ifn?def ' -- '*.h' | grep 'h\:1\:' | grep -v '^comp=
at' | grep -v -E '[A-Z_]*_H$'
>   alias.h:1:#ifndef __ALIAS_H__
>   commit-reach.h:1:#ifndef __COMMIT_REACH_H__
>   fetch-negotiator.h:1:#ifndef FETCH_NEGOTIATOR
>   midx.h:1:#ifndef __MIDX_H__
>   t/helper/test-tool.h:1:#ifndef __TEST_TOOL_H__
>   vcs-svn/fast_export.h:1:#ifndef FAST_EXPORT_H_
>   vcs-svn/line_buffer.h:1:#ifndef LINE_BUFFER_H_
>   vcs-svn/sliding_window.h:1:#ifndef SLIDING_WINDOW_H_
>   vcs-svn/svndiff.h:1:#ifndef SVNDIFF_H_
>   vcs-svn/svndump.h:1:#ifndef SVNDUMP_H_
>=20

I think this is a good change.  We should definitely get rid of the
reserved identifiers, but I'm definitely not opposed to tidying things
up.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--BN+Sv8yD/qqrpTrl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.10 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlvDzosACgkQv1NdgR9S
9ot3rxAAlCa0EBhUQkOTArlTRKK8WZDWaF9VJpoCW3hkRDWHL7wxJkuKHYmlBSG2
Q1h9WthOl20kXsiIYcMAEg2bVypaGZFudQUj4MTFRAv3fV74eIvRM96YKhIaRAEM
kMA88sAl7X8/sdES3ndsHPYLvASmwBobms00l4atZK5OZyHshdY+tGU5uhX1z0TP
YMeuWXHYJH/K3MR3cH6mXKbDpCwRzang+SZue/wXmuA31wS4VJDqAhaLue3sjQ5S
1Cqi0VVyVzvf2x1IOHZoB8esQwPRxIqX+aj2R9TdFLyir7Xc+dIptr8/9+5snczd
gBTvbPmsRj3XJWmpR03FTZ161JF5WiE9mder1N9gp8OCLPG9aKrPMzgKaLAlgDYg
Jb3u0pT7709qZhHKaxd3sBNLLxPNciPv/cr/QiOJVz+0XdH5gx+6CEryJ9Dz8ucw
SuLnXNIBHL9ebtp1w6rY5IUcFp3cl8PByOJpUVwBDO0CG0Ur50iUnU1VHEJc/39y
PPKBugnlF3K2j+SGWHVKTLBq/NRhz+gdQKK4Hj34zW1avCIGEKC2uoG9T8f4TLX/
EdVG7I1likTkgMnACA8rt5+spSwTWTl84erj1zD8OWDtN/PwbybVU0LPy91FtpQQ
H8xfD1qkGeVSawDoIk1wYt8BCQllTDcE3BM9B6GImMli2+2VMe0=
=2cVs
-----END PGP SIGNATURE-----

--BN+Sv8yD/qqrpTrl--
