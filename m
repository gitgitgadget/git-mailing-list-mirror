Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E339CC433E0
	for <git@archiver.kernel.org>; Mon, 25 May 2020 17:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4801206DD
	for <git@archiver.kernel.org>; Mon, 25 May 2020 17:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="lKTRPNgz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389139AbgEYR6e (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 13:58:34 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38670 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388621AbgEYR6e (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 25 May 2020 13:58:34 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4D61360482;
        Mon, 25 May 2020 17:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1590429482;
        bh=311y1oWr9lN6gCQgWE1Dj0lSpD+XDBjqQLfDKlmycJY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=lKTRPNgz6k4lAUdM8KxVSDU5PVeV+o1VM+ybaSzNX0P4fgT5AroIAI4iy8N74RY3W
         hcROhITrgRN7NcimSN/Kkhw08o115S0Hm2mfQuKabX98jUh4cCUzQYE0rkXsAtB72+
         VbK/KmgDZwSbaPbbtSrDNm5gl+tWmGObWS0MMI+f/djXyk30wlpyi+70ECsfB1ACZy
         aF2tQZ+F31X6jbYcKFxXTRBsM3EanqPZ1Ice8uGFI8WAmkMgfXDvqojbdB3hJoKPzN
         iiHEaBjYWsP+bipXt9pdwcUHtTScTmsPUA5C1QrWUra5HPay/9wOMyLwNr+zUMobwF
         s8fMbaL8XmR9FRxFAzVFHp3p+RsWBff1Ts76Xv3NRJDJSBvL1AZRMQK0HrDNHiCKXb
         DjfGM2Uv2jR3mF+E5cC8p2XHL+R1DmAeF1mtQZZ/UlCjC4A9r5VAPdrPl+a9shTLt9
         OeqdnAdHs0fO2pOT+66xX4Yb6k0OX6/MKwXRr0qB+hmkQzNC97U
Date:   Mon, 25 May 2020 17:57:58 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Toon Claes <toon@iotcl.com>, Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/1] Documentation: correct hash environment variable
Message-ID: <20200525175758.GE1915090@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Toon Claes <toon@iotcl.com>, Git Mailing List <git@vger.kernel.org>
References: <20200525144138.1624272-1-toon@iotcl.com>
 <20200525144138.1624272-2-toon@iotcl.com>
 <CAN0heSoyxvTTaJaRmnQADTaMrWa4QBbGnXi8MUZp7ksibejc8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AsxXAMtlQ5JHofzM"
Content-Disposition: inline
In-Reply-To: <CAN0heSoyxvTTaJaRmnQADTaMrWa4QBbGnXi8MUZp7ksibejc8g@mail.gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-1-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--AsxXAMtlQ5JHofzM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-05-25 at 16:42:57, Martin =C3=85gren wrote:
> > -`GIT_DEFAULT_HASH_ALGORITHM`::
> > +`GIT_DEFAULT_HASH`::
> >         If this variable is set, the default hash algorithm for new
> >         repositories will be set to this value. This value is currently
> >         ignored when cloning; the setting of the remote repository
>=20
> Indeed. This discrepancy is visible in the commit which added both the
> documentation and the implementation, 3c9331a129 ("builtin/init-db: add
> environment variable for new repo hash", 2020-02-22). As
> developers-only as this variable is, that commit was not in v2.26.0, so
> this might be worth fixing before cutting v2.27.0.

Yeah, thanks for catching this.  I think this is worth fixing.  It
doesn't do anything right now except produce an error, but we might as
well not mislead people.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--AsxXAMtlQ5JHofzM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXswHJgAKCRB8DEliiIei
gb/7AP4q4vH+Cgw7hUhbDieRdNHBr+RZ5T5foVflGYZmQDtEUQD/R99fecOoVUN2
2x8wxn68pywIMawKuLetbXtEkK8QdwM=
=mOsG
-----END PGP SIGNATURE-----

--AsxXAMtlQ5JHofzM--
