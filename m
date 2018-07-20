Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4146D1F597
	for <e@80x24.org>; Fri, 20 Jul 2018 22:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbeGTXDV (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 19:03:21 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33870 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728364AbeGTXDU (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 20 Jul 2018 19:03:20 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:f1fc:eee3:60de:bdd8])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id ACFB260734;
        Fri, 20 Jul 2018 22:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1532124784;
        bh=uYnZr3hgflQ7Sgw0aaggyUXwxtueLbvD9sopGY+zV/I=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=p+9iR8BcPldnbE1z8SaImUFckIxTpPAyq6F/qeQO07I+M+yQx/Hzmk7EkTo4/WhdW
         YqV7HX0rzM3so8MUl8L+oscIRWKzlMt7VQsqfJM2XzUo9P2+1CSTLCFQN5irc9JUsh
         ple2l0HJn12TtmyjJoIr216JWj68tFqPSrFhy6QIGErAleWrqShldirTR0RhFR3ad1
         3oiVEaxZY/jcDBhsW9ba3/NrU6Jom5OeXwBDS6fETS+donSm3MAEtOFPAxbL6q7CHL
         huKYEkNnSVpdGHzraL6Pz0Kk8lzChLSc70oi2G7CCdWXYauUyyDYpQTpDZ8xMjs0r5
         Z/qPyaWeLFPZkdDDdaNePnCzwdzfTmsNoDWO8cpc2MBvxH4HgojgdWGH5yRdIoNEjX
         WM478NU8QbXVpvf9pW+wzIZIs1FBVXWp0G+y6uVLMOZmwGco2moSLVsftD14T4f6i8
         Ph5OsMrZ5QYIE//U84iK7hrq1YDh45OBORm/sf1FQ9vhF08tzDd
Date:   Fri, 20 Jul 2018 22:13:00 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: No rule to make target `git-daemon'
Message-ID: <20180720221259.GC18502@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeffrey Walton <noloader@gmail.com>, Git List <git@vger.kernel.org>
References: <CAH8yC8=oruFBtkndQ0p9N4s23SMvjjrAC_E7zzKRSVbjEwL0FQ@mail.gmail.com>
 <20180720210459.GA18502@genre.crustytoothpaste.net>
 <CAH8yC8m7T8k8usGnV_OYp9G=2N4_jdzLT6frme2iBrLnt5iqnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xesSdrSSBC0PokLI"
Content-Disposition: inline
In-Reply-To: <CAH8yC8m7T8k8usGnV_OYp9G=2N4_jdzLT6frme2iBrLnt5iqnw@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--xesSdrSSBC0PokLI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 20, 2018 at 05:51:46PM -0400, Jeffrey Walton wrote:
> Sorry about the late reply. I meant to reply this morning.
>=20
> My shell script to patch things on Solaris was the cause of the problem.

Glad to hear you got it figured out.

> (If anyone is interested in first class Solaris support then I am
> happy to help. The patch set needed for the platform has been stable
> for the last couple of years).

I'd certainly be interested for you to send it to the list.  I'm not
sure I can provide a helpful review, since I don't run Solaris, but
having better support out of the box would definitely be nice.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--xesSdrSSBC0PokLI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.8 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAltSXmsACgkQv1NdgR9S
9osSDBAAxX31a6BsVLOc66jlreWDrxnxp9fiXHVJ4elOsIiP4nDqmr0iSomJMUcn
yUXSuADihRjOjLPLDZ+wZw/BEhTj9g0VixjQB/hpKoFK3zypokIQQml5bJUIWreZ
1Wyk7bFUo2ffEyqdXqBcIq7WAEf9yj1vfHEgT/JDClckg0AKEljuWvYght0hIcVy
mqkiHjRC+q2YQdzubpqPT+WGeV6i2qG57l9HNKYUcd4f6/VdUDPgjnD2qcvaxdtQ
Oh/WJmorSAHfdav0bMDAQBSng7Vw/Q0whooCAPntRc+l8mGBW+M+KhMyxWR5Ellz
nbex2OAOtcdIUw6iGpqMio92qsm0REUXNh/fcLUbl5vaDYrIQIIy6PzM4yAGvVFY
+HI9MXiIzQj2Hwq8BHhoLMxu/8UT0kNXAo7IWYNSwApQ03Iy9aLL9BDjCR9Yw6jf
mrqTIJYomnwe5vZl7cRfRCsXNLjvG4zBPAd03v61XXyyG758Pf+5KJYDZP4twy4r
PdpCAYXs54xX85Vpls5T4yLdtnW1CfdH3+xissrayQvxvp5R/gaRvcpyhpNv2Bi0
tUtscrN06ZIHEJzy4OWuoAB3tIDq72ReqyMjyi1XnRz7yVh9IS0/RV3k8yEzjHX4
nFveNUsGaCARKYNP9PfsB8IZjyf5curCMRXhjktEJDpWu824ttM=
=KI6d
-----END PGP SIGNATURE-----

--xesSdrSSBC0PokLI--
