Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69D3A208E9
	for <e@80x24.org>; Fri, 20 Jul 2018 21:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbeGTVzH (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 17:55:07 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33822 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727412AbeGTVzH (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 20 Jul 2018 17:55:07 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:f1fc:eee3:60de:bdd8])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id EBAB560734;
        Fri, 20 Jul 2018 21:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1532120705;
        bh=xMflttdBMQE/oIgB7z8C8j06xox/D0NcslweWkGQ3wU=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=x433oEb2VUAfV2yrpU55bUM8L0c2W4J/k6MzC15Z0lUYqYcFoWPfLXHiSV4EwEOPs
         1uE5309zKb5qWXuKQcbvw3oXjVeUo6q3W/P7MDBTmheKsVk62FYp+/AiUIL0k8LfqQ
         p+awqr1MwHSVzCearEweBBhhb/GE/ncFduRPZZHT2cM3i7vgJXkPqHCJ1EWUn9Dxkp
         nvoOFWTB45f9NVKCUd2VLCfioqscPhhZLE2ydMFv1LjrilOIeihWWUdEFoGacKr/Iq
         jg1HXnhLixkLlbsr530BhIki+P7QVtYX2i8CIs20CKeRMmNe7dtf1mt6X8kgQQQMN0
         vqbJ5gZfrKhuX6NMJvLx8qqacIwHI/l9AB6q064cWk2FEh464VaYRDBRCBMOksGhiX
         UbYdeX6kGccDcR7NLifPWqPrW1pvDsf5WWNAjSl5dxfZmC0VSKlLblrbyriUIEuBO1
         GPbKFVHat5jM7X0TFcLukbjErzWqVqSp+m5L52rTSulXLK0q5x5
Date:   Fri, 20 Jul 2018 21:04:59 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: No rule to make target `git-daemon'
Message-ID: <20180720210459.GA18502@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeffrey Walton <noloader@gmail.com>, Git List <git@vger.kernel.org>
References: <CAH8yC8=oruFBtkndQ0p9N4s23SMvjjrAC_E7zzKRSVbjEwL0FQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
In-Reply-To: <CAH8yC8=oruFBtkndQ0p9N4s23SMvjjrAC_E7zzKRSVbjEwL0FQ@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 19, 2018 at 09:37:08PM -0400, Jeffrey Walton wrote:
> Hi Everyone,
>=20
> I'm working from the 2.18 tarball on Solaris 11.3 x86_64. I'm catching
> the following when building from sources. This appears to be a new
> issue. It was not present in 2.17.1.
>=20
>     gmake: *** No rule to make target `git-daemon'.  Stop.
>     gmake: *** Waiting for unfinished jobs....
>     Failed to build Git
>=20
> There does not appear to be an option to control building the daemon:
>=20
>     $ ./configure --help | grep -i daemon
>     $
>=20
> Any ideas on how to side-step it?

I also don't see this issue, and I didn't see anything between 2.17.1
and 2.18 that stood out to me as a potential cause of this problem.  Can
you tell us a bit more about what version of GNU make you're using and
the configuration you're trying to build (say, the config.mak.autogen)?
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.8 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAltSTnsACgkQv1NdgR9S
9ospGhAAn+LbVKagA2IbHpTRXREXXElC+UJCP0fvHUCJFLfmdGJatLwXRh0Kq+k7
tunJmAoyaCyjjq5UOx+CM+c7fGID53pDL6LWAqO8wj9CcZslZ9dx5G9rZ5zL8kfO
lWxi1oUH+1VytKCuz1TvTJtn7BQAB+hYsQRkgUxvxmxGo5bzLOrp3eJ/UY/Iwyh5
FZQatZ6mJloCii7so23hzNeZ/5JrpcDMnUvWYPN0YUbVBAuJ5b3MT8YNLzliZX94
DQsymmE4nqPGxsIM1EgOlKx1UEIELKspKb71RNLQR8dk3RMToFJKPsP8kIhizdWa
EnGnBXXN/Im238ohMiSeoHGsOfbEbNd2L3HosLSD4V+q5iQ00X/mBIM3d0j7Ax1i
yamXdfdcCXx5OQNSTEU6xqnbBW4oKiFXz4VpvNbQbAu6Dt/lUst9XD6JlfjTn7UU
OdS5Q9dP0JDSN6O8XHQrPeo3wukr7040toQGepz1v2DIevHegFku5mOHOUzM5PVS
AM3HyXhVpuqc8iFE1HAnHWMzDJ+3N8zhSwDoFs1O8td/s6hXOcBMGt5VRu7IXczh
cq/QeNEUOFR109Jb41QkWbIR2Nk0ekK1jFi4Ac3wJHHiBycWpawuBcxKurLUdmUB
dUg8fxpAxK4c1Ga+eXhY1BU4dfE4pvZG4oKKkO/Whir6vLTFjEk=
=tAmE
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
