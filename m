Return-Path: <SRS0=BhVQ=67=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8674C433E0
	for <git@archiver.kernel.org>; Sun, 17 May 2020 22:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 853FF207C4
	for <git@archiver.kernel.org>; Sun, 17 May 2020 22:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="dvj2NbfN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgEQWh4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 May 2020 18:37:56 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38474 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726458AbgEQWh4 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 17 May 2020 18:37:56 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B3AA16045A;
        Sun, 17 May 2020 22:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1589755045;
        bh=uoZbsWN13xUKIw24f5p7KwKJQJLctiGEjuVYlxVfsLQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=dvj2NbfNngjFLlwCu2+fMNWSTjS9EGJ+HDtA0o6iCfw5vwV9U5HRfDecw7k+dv3UA
         YGBH6EYwrYOPxV3J0HqrxR+l6K8l0b+WqusyFRujTKDYstjMw6F2uYvAJcDn+JZez6
         0W85YmKnws+cmekG4Y9/KLgeMIEZ5BCXQqSkq9FTVFqxw91d6o7vFJdFnXpZuJ/Sgp
         ZvCdSknD4zfvuSNLYORGTX2XMpZwTzB6IsIDxiejGAcpZUAj5CH6lrPGppyqJANgYv
         ZABpuLzqeywtzibwwBHPJxQpRqdDtH8CsaoK/TrbDpnNrvjFZLTkBfEpaadvG2NXv8
         4h2lE7vrThmeddjy34dsjr4jr4eJndmBRJdkYBNOrHj7dwzF2gIv48OQVFqpQiru4Z
         NqPPZmkhcFo9sISXRKivy18lSyas9n7B/Wv/yJfuLSRL1H4Rg0xt4fO9Qt+vRCSyrx
         046o6KU7EVbDFoUMwEtQjW2c4AOygh6QeployGiKTYttkBGBbkZ
Date:   Sun, 17 May 2020 22:37:17 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 31/44] connect: parse v2 refs with correct hash algorithm
Message-ID: <20200517223717.GL6362@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
 <20200513005424.81369-32-sandals@crustytoothpaste.net>
 <CAN0heSpq-t1E6CBsLiVDUE8NYB2ES916MR=d99eug9U=vdOLHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DXIF1lRUlMsbZ3S1"
Content-Disposition: inline
In-Reply-To: <CAN0heSpq-t1E6CBsLiVDUE8NYB2ES916MR=d99eug9U=vdOLHQ@mail.gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-1-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--DXIF1lRUlMsbZ3S1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-05-16 at 11:14:16, Martin =C3=85gren wrote:
> On Wed, 13 May 2020 at 02:58, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> >
> > When using protocol v2, we need to know what hash algorithm is used by
> > the remote end.  See if the server has sent us an object-format
> > capability, and if so, use it to determine the hash algorithm in use and
> > set that value in the packet reader.  Parse the refs using this
> > algorithm.
> >
> > Note that we use memcpy instead of oidcpy for copying values, since
> > oidcpy is intentionally limited to the current hash algorithm length,
> > and the copy will be too short if the server side uses SHA-256 but the
> > client side has not had a repository set up (and therefore defaults to
> > SHA-1).
>=20
> > -       oidcpy(&ref->old_oid, &old_oid);
> > +       memcpy(ref->old_oid.hash, old_oid.hash, reader->hash_algo->raws=
z);
>=20
> Might an `oidcpy_algop()` prove useful over time?
>=20
>   oidcpy_algop(&ref->old_oid, &old_oid, reader->hash_algo);

I think I can just omit this chunk, because oidcpy now copies the entire
struct for speed.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--DXIF1lRUlMsbZ3S1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXsG8nQAKCRB8DEliiIei
gWKCAP9AMZKbKxOCdCsnCAxF9JqmAVgrLVpKVy+x3oxZ9gZIvgD8DJ0/RFiEhegV
b+MGoSb3nvcTUUsdBfo8yx9qaaWgPgI=
=nJ4F
-----END PGP SIGNATURE-----

--DXIF1lRUlMsbZ3S1--
