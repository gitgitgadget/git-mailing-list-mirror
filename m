Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 913F9C35242
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 21:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5360B206CC
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 21:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="dVRgFbP1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730163AbgBNVFu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 16:05:50 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:32882 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726191AbgBNVFu (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 14 Feb 2020 16:05:50 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7B53360791;
        Fri, 14 Feb 2020 21:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1581714348;
        bh=nHZvRpQqJZOyDUIeK1qa8+IfYe/TxDMSdAfJ2DlS3tc=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=dVRgFbP1kAM5VeLschbxG3CBbrurBc4RslaJuDoabwUc4M032tYtjc+pyCX+h8sw0
         zoLQkS33onry00OitLTC2rhCuomNfR43tdnFzXnQQbHHvp8jqVMtCNzK2+AWI+i+jt
         9G4CTWY7/45ZvhLnTD9/8vO50NwyWS4LK2gqp1hsd7ak+2gBtnfMGSe9LASFmNEadx
         HQPhAOq/3gLdlhYmWnouxBLZJKUjgT+mDeIkF5CBtTKH88u4ATNbM7Dh34wwlDMcZm
         1frPINfJBDPNrJC4O036Mle2hGxuJP+jGu90p13ZDiJNfsTNrbJ42SqPXrCf7RrCDB
         66SL2ycF4vtlwX6w5odHQb8JJPqoTvbQt27Mla0ARgZ1ozLj32agc6qCa7pUiq0PTv
         2XxVgfu9GzAdVjZ2okZZ+KKacARNG/Dgtuh0oxegy6LU9cAh8YW/eYAW8KSemipR6z
         AiFOl1T075SbGoCiVkhZoevXXBqYDy+rrjeG1H5JO14AL0++Bbt
Date:   Fri, 14 Feb 2020 21:05:44 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: Git representative on AsciiDoc Working Group
Message-ID: <20200214210544.GA6664@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20200212002129.GB6464@camp.crustytoothpaste.net>
 <20200214062335.GB605125@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2002141306350.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2002141306350.46@tvgsbejvaqbjf.bet>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.5.0-rc5-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-02-14 at 12:07:00, Johannes Schindelin wrote:
> Hi,
>=20
> On Fri, 14 Feb 2020, Jeff King wrote:
>=20
> > On Wed, Feb 12, 2020 at 12:21:29AM +0000, brian m. carlson wrote:
> >
> > > I've had folks from OpenDevise reach out to me and let me know that t=
hey're
> > > launching a standardization initiative for AsciiDoc under the Eclipe
> > > Foundation's open standardization process.  The goal is to standardiz=
e the
> > > language, ensure compatibility across implementations, and provide a =
reference
> > > implementation, with input from implementers, users, and others.
> > >
> > > They'd like to extend an invitation for the Git project to send a
> > > representative, since we're a significant user of AsciiDoc.  I'm send=
ing out
> > > this email to see what the project thinks and if anyone would be inte=
rested in
> > > fulfulling that role.
> >
> > [...]
> > As far as choosing a representative from the project, I'd probably
> > nominate you. ;)
>=20
> I'd probably second this. ;-)

I'm happy to fill this role if the project would like.  The main
interest for me when representing the Git project would be a focus on
compatibility between implementations, which has historically been a
minor pain point for us.  That, of course, is the whole point of
standardization.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl5HC6gACgkQv1NdgR9S
9ou7Bg//fKJg5wlCAta6fhYghswihuAoWRy7gaeZ3QQEERdRPsJCTbDk2TscgzCi
xhrvcGpuqEls8UI7VwgLcCaUoPb8K7Y6wiPmM5eTYJjmXuUM0pO20EcncuyQirQX
PIvEg3hvt4iJWlfq+FNsdpogup3lCTwvXmE3ppf3vP/cYhDk/ot3FP0gUngh+LCo
wOpaQb6MmHS6aYUzTodgmgh0TrUoJtbFnyt6k5Kr4VJWqEEQ90I9lrf39vF6v+Ax
+UU7Xh1YB9hdXjd398Iw8rdANuBU5/m3PlykFrDTuwL4B/zj/16A3NWsbbJ2c1P1
cFG/f0YJpTfpC/RqyRV5XHi0kGN9kziqxIWTwDiAeihcaJpRxeUWUD7EjqZxhraq
lZ325MtIL+VpVfdrhLSeL3gi+k0VVavRnPhJhS/d0fME2RvsPF70UOizlC7GiMJ9
suvPah3vpoJ1GbMRve/MYfgnacu4LC8JB3xh7xPBivLbS/Ie+1tNrxDTuorKu3CJ
piyIixLrNl1ft6cbbPEcU1aIKLdhtLOCJF2sYSnv/EuwN667sLERkyBooXkw7ern
sZq+YvnVGZNuBcgStXGVEFQJ7D0fRrLpCtWGvLu5X1xNuLwPJ/rgy9VY7AqQkFyO
Fw992QVJh92JZcFoJoZnRWjl6md/EG6J43rz5t0jA6YEHWdBLjw=
=oSRz
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
