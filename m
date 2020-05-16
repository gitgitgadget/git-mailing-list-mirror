Return-Path: <SRS0=AWh0=66=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1519AC433E0
	for <git@archiver.kernel.org>; Sat, 16 May 2020 19:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB901206F4
	for <git@archiver.kernel.org>; Sat, 16 May 2020 19:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="k5hf8tyC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgEPTab (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 May 2020 15:30:31 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38410 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726360AbgEPTab (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 16 May 2020 15:30:31 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id EB1046045A;
        Sat, 16 May 2020 19:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1589657400;
        bh=5vrfP5IOyNcm8GetmtKAKqxgmitXYwYvf7lgn7pDr/s=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=k5hf8tyCfyrVKYaF9FRlDt3NjqWXYnFV1FHEoW73kHHZmdZYvvxWQC/kQk/WQobY0
         brjFCaQrdHlImIX7Zo37vjpcGfrz5QaRallxOJSYLKO6rQ3F7ib/xxRqJ3g54e7bCJ
         sgh9E2oFDy22VgAUJhsW1fwvdtVY13yTqUVHVQEI2HkTzGdhwg22qAzCQs490Ata8R
         XttqDD1cDZgHE13d5heiLCNBfiB7pSI5ZZb/BtHHevh9vJQ3YvyfEKkx205RRcTzNY
         vWODXvLhINHXmPgY20qSAKZp/QGfGjbN0Jb65REmpj7MZWMFRXcUoQjjur6VXXqlE8
         GTQ5+ytYKqD+yqwPyFM9FsWzWGftXWgKSKS5OqqS7X3hpFhft8LF5CBSY/2BSwXc+6
         b5GiUhzYz6zejfvr6I+U6KiBHrmO2aOSIWHL/ShZtglCw2JRPnzHygqH1eHIE11dOm
         WzVMB4tvleBQDMMJyRzMR1uWR0pMYx0mn8rdknXZOyTo8iXoOqO
Date:   Sat, 16 May 2020 19:29:55 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 23/44] setup: set the_repository's hash algo when
 checking format
Message-ID: <20200516192955.GE6362@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
 <20200513005424.81369-24-sandals@crustytoothpaste.net>
 <CAN0heSrMrXE2g4LaZ4A71CxGteVfE2RfsT6WyGzmfFSHFKjATQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cPi+lWm09sJ+d57q"
Content-Disposition: inline
In-Reply-To: <CAN0heSrMrXE2g4LaZ4A71CxGteVfE2RfsT6WyGzmfFSHFKjATQ@mail.gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-1-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--cPi+lWm09sJ+d57q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-05-16 at 11:03:56, Martin =C3=85gren wrote:
> On Wed, 13 May 2020 at 02:56, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> >
> > When we're checking the repository's format, set the hash algorithm at
> > the same time.  This ensures that we perform a suitable initialization
> > early enough to avoid confusing any parts of the code.  If we defer
> > until later, we can end up with portions of the code which are confused
> > about the hash algorithm, resulting in segfaults.
>=20
> This doesn't make a difference as long as you just use SHA-1, right?
> That is, this isn't a bug in the first half of this series nor in
> v2.27-rc0 as long as you stick to SHA-1?

Correct, because the default is SHA-1 if no algorithm is specified.
I'll update the commit message to reflect that this affects only
SHA-256.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--cPi+lWm09sJ+d57q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXsA/MwAKCRB8DEliiIei
gSNLAQCeY2RbrQkVGLBsIM0ksyeovQzKB+wCnblrW2g4yOkDVQEAl1A/T7HON+ci
+BcrO0rqgCg5Yhz/Ey2cdecIAaNuLQU=
=y7YZ
-----END PGP SIGNATURE-----

--cPi+lWm09sJ+d57q--
