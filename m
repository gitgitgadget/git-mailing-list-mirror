Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 394A21F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 23:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752447AbdAYXlH (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 18:41:07 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:38006 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751728AbdAYXlG (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 25 Jan 2017 18:41:06 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 7BCE5280AD;
        Wed, 25 Jan 2017 23:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1485387665;
        bh=yBtbJxPVnpFeQQmBHv/rJS9DctWGjZCOFpeGurv1XLo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WjIzDruzEBUv0VWFfTvyiK/IJr+v9mdaTrdTYKBYz0xuFIHkrKKwRW/kWvZ0/yMy3
         9hLBY7LdITTe2u6bb4Ou2qoIwL499H3nf1klnB9QiAQCF4ENSRgxgx57/1dJLV7LNZ
         4+u8UJDI2TIT76aEvY6CTf/6VWDW2+BCcgWYRkHnW2NEWfOVB2acglY931QHGdYVSW
         B7vswEO0k3uMm3EsO3r27VLrz5BXDSDM8dHPzLIlhHHmjtJQd1n15noc/9wIcEbSfY
         ZPbOwcjN8waaABsZNv9tzgPC4glY9gKOp15Sf2aOJvMNgQG9RKhdbEPBoy5V+AtKS6
         Yp6sXth4+bTeiYRiBEgOaDOckyPyn6X35WZtWNR57aKxMlfcN5cLPDlSIWLYTAF3jf
         9kNg8iYNqDR200dpqvvknJO7QFVRb7a1/Xd1umcCu1UQ40n4/fuQrEcVFatAO/g+zR
         H7dL3z1ZdNIJfSGzM91Ec+joTkLb5d3u77QaLIKlZ3eTdFpYdgp
Date:   Wed, 25 Jan 2017 23:41:01 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 0/7] Macros for Asciidoctor support
Message-ID: <20170125234101.n2pzrp77df4zycv7@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
References: <20170122024156.284180-1-sandals@crustytoothpaste.net>
 <alpine.DEB.2.20.1701251425080.3469@virtualbox>
 <20170125213544.eelk4pjhrhshi6zh@sigill.intra.peff.net>
 <20170125231926.usufhlugjotjw5zw@genre.crustytoothpaste.net>
 <20170125232959.zdbf3n3ey7qtnv7j@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gfutzrsxpsmqvzcd"
Content-Disposition: inline
In-Reply-To: <20170125232959.zdbf3n3ey7qtnv7j@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.7.0-1-amd64)
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--gfutzrsxpsmqvzcd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 25, 2017 at 06:30:00PM -0500, Jeff King wrote:
> On Wed, Jan 25, 2017 at 11:19:26PM +0000, brian m. carlson wrote:
>=20
> > On Wed, Jan 25, 2017 at 04:35:44PM -0500, Jeff King wrote:
> > > On Wed, Jan 25, 2017 at 02:28:55PM +0100, Johannes Schindelin wrote:
> > >=20
> > > > > The need for the extensions could be replaced with a small amount=
 of
> > > > > Ruby code, if that's considered desirable.  Previous opinions on =
doing
> > > > > so were negative, however.
> > > >=20
> > > > Quite frankly, it is annoying to be forced to install the extension=
s. I
> > > > would much rather have the small amount of Ruby code in Git's repos=
itory.
> > >=20
> > > Me too. Dependencies can be a big annoyance. I'd reserve judgement un=
til
> > > I saw the actual Ruby code, though. :)
> >=20
> > I've sent the patch before, but I can send it again.  It's relatively
> > small and self-contained.  I'm also happy to be responsible for
> > maintaining it.
>=20
> Ah, it's:
>=20
>   http://public-inbox.org/git/1413070656-241955-5-git-send-email-sandals@=
crustytoothpaste.net/
>=20
> (and note there is some surrounding discussion there).
>=20
> The code is not _too_ bad. The main thing is that it would have to be
> kept up to date with changes to asciidoc.conf's version of the linkgit
> macro. But it's not like that changes frequently.

Yes.  I think I can actually simplify it some more, since we always seem
to use the argument to linkgit, so I'll send out a simplified patch in a
few minutes.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--gfutzrsxpsmqvzcd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAliJN40ACgkQv1NdgR9S
9otFLA/7BYB8AoHMOquWjgZtaQJE1zFO94IJnTMOH6aeuyQqtCxzPbPf/fBNYf52
qKnq/CBbHig2WPhh5Aty7df9awyG5zPp4KqQltQrlLSt5h9eQ/MJvJYmJ3ubJcm9
zAhZ83Xi9Pv2kB0uiCTuU1FEgiAygawCQrcX41HdfIqPBybz73Qk6edW5j7LXWED
IqorlEl+V4MALJz8Xo7I97jSiZ6zi6amZ3gJxQkUz7o15SBViN2vbakPz4N238mS
2it8P1+08PTtbiTCsk78V9AgKPSGtogvjc52UHR6e0tgwiU6+FDnacNJxMebs50D
eFRWntJV4MWgU+Jo081gBobzTGICINmQ5VOxBHeZ+bPRG7BlDWgGSFCZZHqPT/63
aZeRGPoCVIiqAQpW6GTzt2a/EZo5pkr4Rw1n4TgxUWXoBEoPnamBzBaAmfTrFxuQ
wdlz74WLkx5esM13l+omPgjlBGI36/XZlSFnqQHboMoH4rQB6np96r2b03D8ZVpV
QIkAiuEvDumj96W0vhk6TAAArswZ+FqpuyKIpp2OqKWXV9fSZXZo9Xq7f5vnsLj4
ls6MmrTjK1EHjqOY4RlEuYU6iZx/FcMrYPJdonNrqiwVHCIqTaMERy66iVnwe9Qz
0GWkElEDyqBXxYyc32ROWIlw/34CxvR7jD9wKwQynDNGP/eQfds=
=XNxl
-----END PGP SIGNATURE-----

--gfutzrsxpsmqvzcd--
