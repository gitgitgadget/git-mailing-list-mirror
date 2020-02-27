Return-Path: <SRS0=G+lC=4P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408C6C4BA24
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 00:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AB7C24670
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 00:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="bGQ1OzTy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgB0ABh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 19:01:37 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:42156 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727974AbgB0ABh (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 26 Feb 2020 19:01:37 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2C3A660478;
        Thu, 27 Feb 2020 00:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1582761695;
        bh=ugh6DEfAYcEnzcJe6IDu7FFGpMmiTDA9/gzv9TcYxN8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=bGQ1OzTyJIJmzsHVmc5vNyyJ7nIWlb+/2jbafWaD/8oSedHyuWRBdBn3cNeeWrsnb
         uo25Qo1aNAWYSSrr/Tm5wnDeUOiRY/Q/6P1SXLC+PKIkHoHvsh6f/87ujGJ3WUGQLb
         /vxhjKHmqNpVj4UBu6z7ViLZzpesb3i4Bcd1L4sR2eWSdCKci7SXy/mWKmy6P4N6nu
         HxlcmX6Vq4hKeV8kYnm8aRh9dLy1w25jNaAwJ4y0TYgbUQrpGT05wAlgraoau02JyW
         z6AHJPaQn5wYp09bJpUPB70QgzLrVyTi1qwKtDbLo0wO4m+ci/sN3hYFdEzoaX9LYc
         Q6yf6QrOAjbE9zvhCDlcSHgALPL99MtdPnDQP7sSW7vi7PWgtLphh/U1N4ALu5/Pqa
         +C+S1bLG+DcC5P+xfv6u5wE3P1RK5oFJyIFnDBsjRDyp5SpQm5/6F1ZmyITW/ypSBX
         YfIumZScQoMKdymmrTEApdMcnpaA0p9l9ADYWAjUELi5QIpYGI6
Date:   Thu, 27 Feb 2020 00:01:30 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [PATCH v6 0/5] Reftable support git-core
Message-ID: <20200227000130.GE7911@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.539.v5.git.1581344060.gitgitgadget@gmail.com>
 <pull.539.v6.git.1582015420.gitgitgadget@gmail.com>
 <20200221064026.GA11129@google.com>
 <CAFQ2z_P8Ph_f0CbYHYZm0XVyk+ax+Dv_-FrSSyLBkB-xn-uupA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3XA6nns4nE4KvaS/"
Content-Disposition: inline
In-Reply-To: <CAFQ2z_P8Ph_f0CbYHYZm0XVyk+ax+Dv_-FrSSyLBkB-xn-uupA@mail.gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.4.0-4-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--3XA6nns4nE4KvaS/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-02-26 at 17:16:01, Han-Wen Nienhuys wrote:
> On Fri, Feb 21, 2020 at 7:40 AM Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
> > > This adds the reftable library, and hooks it up as a ref backend.
> >
> > As promised, here's a patch to include the reftable spec in git.git.
> > Please include this in the next iteration of this patch series (or if
> > you prefer for it to land separately, that's also fine with me).
>=20
> I did.
>=20
> > [...]
> > >  * support SHA256 as version 2 of the format.
> >
> > I'd prefer if we error out for now when someone tries to use reftable
> > when the_hash_algo !=3D sha1.  That would buy a bit more time to pin
> > down the details of version 2 (e.g., should it only add an object
> > format field, or object format and oid size?).

If we do this, the testsuite will start to fail with SHA-256 unless you
label those tests with the SHA1 prerequisite.

> You have convinced me that we should go with the 4-byte identifier.
>=20
> How about setting version=3D2 and extending the header by 4 bytes (which
> hold the 4-byte identifier). The footer would also be increased in
> size equivalently. There are no further changes.

Just so you're aware, the values we're going to be using in pack index
version 3 are in sha1-file.c as the format_version values of struct
hash_algo.  They're 0x73686131 for SHA-1  ("sha1", big-endian) and
0x73323536 for SHA-256 ("s256", big-endian).

I know Jonathan is already familiar with those, but I thought I'd point
them out since others may not be.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--3XA6nns4nE4KvaS/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXlcG2gAKCRB8DEliiIei
gaL+AP4jR2bU/F6gVUzP5PQDiscCVn02WWmCR6DXkPBxAVfAFQEA8BxGaP3fK0bG
k8lG7l/UXCh3zmyfI5uxsH6Qczv9Rwo=
=RkeI
-----END PGP SIGNATURE-----

--3XA6nns4nE4KvaS/--
