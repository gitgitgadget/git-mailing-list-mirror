Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5893B1F991
	for <e@80x24.org>; Mon, 31 Jul 2017 23:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751816AbdGaXzH (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Jul 2017 19:55:07 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:43616 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751763AbdGaXzE (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 31 Jul 2017 19:55:04 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id DC0CA280AD;
        Mon, 31 Jul 2017 23:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1501545303;
        bh=xzg729WTtDL2juP8tZ54vnaRFzZ/SjX/6tc6VF9aXPo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=msEqaN3/q4WpFAJ8l+gTmPh17QM1ukdijUYBau04mkUn2oHTBhU62yiap0UZOrKb/
         UiURZ0F4auWqNpW0cb5cx3Qt/YrOb21+mkGyEeiDgq9ZPMc1mj3vfqjDe5G4kFtEYr
         +rUnljLqMHJsi+dM/ZouymE4m/cLBLop3AJvKVeCVlF+7YIMuZVeEb8EtEMZgnSyof
         OwcFt3KCDCwnbkFeNjh63gNml15K7S2m7yNG/MJsVPNwLcnYk4oiExlve6/zmivr1M
         OPuw5vPgytCKYBkp8FZrkVQTAM/0wJ6A7eaGF0N8gGUw8flBZs92Ie6ceqJjlJ2lZ8
         FobwRYXAz+wEPtDcndht0zYBbfSnLadlTnT5LNWJA5vuu6VH2wY1WsZlpMeXdmyyaN
         OR6b88CMtALUaSrNreTk+jJVZ8dmimKUa7ioV6z2NSt/nuVvn0yoNrf9565q1vjKrH
         JWGP1ADyU2NKMo/ZW0ba3ji36Od6mGG6UbzC1bviKnymgJGDepX
Date:   Mon, 31 Jul 2017 23:54:59 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] t6500: mark tests as SHA1 reliant
Message-ID: <20170731235459.stlzm6wpi6adf7v2@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <20170728171817.21458-1-sbeller@google.com>
 <20170728171817.21458-3-sbeller@google.com>
 <xmqq379gmco6.fsf@gitster.mtv.corp.google.com>
 <20170729175833.4idan3befldn5vgp@genre.crustytoothpaste.net>
 <xmqqini9k4cx.fsf@gitster.mtv.corp.google.com>
 <20170730230019.ch74ska6wgbrh7ql@genre.crustytoothpaste.net>
 <20170730232427.vrqrrhlsap55ax7t@genre.crustytoothpaste.net>
 <CAGZ79kaBUpVwymjmzmOtHgfiWyxPQZCtFOX_Zm5v7N-H+C9cNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wlws4g2amsuf6n6a"
Content-Disposition: inline
In-Reply-To: <CAGZ79kaBUpVwymjmzmOtHgfiWyxPQZCtFOX_Zm5v7N-H+C9cNA@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.11.0-2-amd64)
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--wlws4g2amsuf6n6a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 31, 2017 at 01:26:40PM -0700, Stefan Beller wrote:
> On Sun, Jul 30, 2017 at 4:24 PM, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > I realize this was worded poorly.  So for my example, in this case, we'd
> > do:
> >
> > test-helper-hash-string "263 410"
> >
> > For SHA-1, we'd get "263 410".  For SHA-256, we'd get "313 481" (which,
> > as SHA-256 blobs, both start with "17" in their hex representation).
> > Presumably we'd read some environment variable to determine the proper
> > value.
>=20
> This is what Junio proposed in the first message, except that we defer th=
at
> to a shell script as for each test we may need different things, so a hel=
per may
> be of little value?

I think a shell script may end up being a fine helper for our needs.  In
any case, I think we're in violent agreement.  My proposal was just an
idea I had considered when thinking about how to do this, and any
suitable solution is fine with me.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--wlws4g2amsuf6n6a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.21 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAll/w1MACgkQv1NdgR9S
9osYfA//aHRjYPaJVghzcfW1V3CCHCI0TQtBJMYJraRFob55ypZZxzS8oXG+pldW
OiBzifDaKUvIblbnueFHAQO4pQaWnIZfbeR6VrMA80ew1/r/R8kzIFLiBf6v+XeA
us0zB2MzP3jSssQD9/dGzbaZ+DArpmmfzkYRmDVXek3TbhDIPmqSYOsck8dwsRII
nLQ96+dys5mjlL3ixUHDyl9WGkche2mY+RIL2/3EaU+5fpf2nknHIf4/XrkYpnp1
E7Dwxsxzor26JsKzygkxsXpavNw00ODtDCGwwPpA7ZULX6OhK5zlsb2tIpl6tT0X
+omGMUQPaIIjzJND8nedVwh9nBYhq5b+ssZRCyxUogG3PWA+hFsKH+wV8gD29rNP
hY1IVALE30f/U7LoRMIlEPmfG2V2q5zfHFeK5QLYsobLvuGzGptEVPMdADG3j8kb
vkuyu26dE1Eu/m+hIo4xBw/zlbcUZOosDTzpxRJDOx3Pb1OVVCZjUotQrXIezF+q
yqSt/3H26bQXkhhWV/mbZ8tk2NPl0BtLHbD41ARQ+gusMHofKU2eH0BWKAqSkb3V
Q0fqMaDbDlo8g3AkY0T6yANorRR7iVTFh0jmolRghYx/fVKjrqLAWzCwIW3Ciekq
/9F4ok+hJn6mD2DUKoXEhaRUPUgSbecOVscqmUJnukyfAcsNX/c=
=AWl9
-----END PGP SIGNATURE-----

--wlws4g2amsuf6n6a--
