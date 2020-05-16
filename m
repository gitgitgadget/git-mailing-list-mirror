Return-Path: <SRS0=AWh0=66=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6506BC433E0
	for <git@archiver.kernel.org>; Sat, 16 May 2020 19:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 394F220657
	for <git@archiver.kernel.org>; Sat, 16 May 2020 19:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="KpelwtNP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgEPTO7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 May 2020 15:14:59 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38400 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726360AbgEPTO7 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 16 May 2020 15:14:59 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id CD9836045A;
        Sat, 16 May 2020 19:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1589656498;
        bh=paY9cnfL1ZuCF474Zl66aVjLSZ2zhVocRcrl9bPUwv8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=KpelwtNP5+pegnyFSZFpWNXsNKJ/I9MwNEBR4dSMhaM8M5DkWw9bmkl+AtIdx25U8
         CanWG5SzBFAioSwbNnfdviCbp6hU25ne6Z1ziPCK2NvbRPwwv6K+MDtCyVqZ8jN9oJ
         oBuMWb3BNn3LBlnkBrI5rJTYMexnmVBDKlbKe8LA5OLIIcVgFccAEqn7Nt1sdk3oh0
         fR7mRaFzCBtFuJv11QiYWJDUMrSBTE1dv3tO0rhGR2C5gocDcNCwKaewJeeHfkhNGQ
         VKibJA4DG2h/aduEyWp0MqjqWdSPVx6G4w8L85RZotmlvSov6n0w7v1xzoBwM4Zha6
         1AMuEHLxDfeksn2Vbejim4VfCzGTZYG5n3HEW6/WW7wQosCULWEt2q06p0nY6yR3rD
         4vQaBOZKEM6T02AOv267VoR6W2qAwDUvU4M6nFwGATc39bO4ErvH5+jRuUMgjmXnYJ
         K8Cw9YclRiMBNHiRTtb5gyMW9EPWixkznB0/bdR0nToBO/1wZ/g
Date:   Sat, 16 May 2020 19:14:52 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 21/44] t5704: send object-format capability with SHA-256
Message-ID: <20200516191452.GD6362@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
 <20200513005424.81369-22-sandals@crustytoothpaste.net>
 <CAN0heSqf8E9cXvJcDJmx_YU5Eiwnqre-g3MwU3UMe40SioCNPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NklN7DEeGtkPCoo3"
Content-Disposition: inline
In-Reply-To: <CAN0heSqf8E9cXvJcDJmx_YU5Eiwnqre-g3MwU3UMe40SioCNPA@mail.gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-1-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--NklN7DEeGtkPCoo3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-05-16 at 11:02:48, Martin =C3=85gren wrote:
> So we need to pass this capability for the SHA-256 tests to run ok. But
> if we start passing "object-format=3Dsha1" unconditionally at this point
> in the series, the tests will fail:
>=20
>   error: 'grep expected flush after ls-refs arguments err' didn't find
> a match in:
>   fatal: unknown capability 'object-format=3Dsha1'
>=20
> That is, we don't yet actually implement "object-format" handling. So
> this will still fail with SHA-256 ("unknown capability"), just that once
> the implementation is in place, the SHA-256 tests will pass (as will the
> normal SHA-1 runs). Do I understand that correctly?

Yes, that's correct.

> Or put differently, by the end of the series, we can do this:
>=20
> diff --git a/t/t5704-protocol-violations.sh b/t/t5704-protocol-violations=
=2Esh
> index 47e78932b9..22993812e2 100755
> --- a/t/t5704-protocol-violations.sh
> +++ b/t/t5704-protocol-violations.sh
> @@ -6,14 +6,11 @@ communications if the other side says something
> unexpected. We are mostly
>  making sure that we do not segfault or otherwise behave badly.'
>  . ./test-lib.sh
>=20
> -# If we don't print the object format, we'll fail for a spurious reason:=
 the
> -# mismatched object format.
> +# If we don't print the object format, we might fail for a spurious reas=
on:
> +# the mismatched object format.
>  print_object_format () {
>         local algo=3D$(test_oid algo) &&
> -       if test "$algo" !=3D "sha1"
> -       then
> -               packetize "object-format=3D$algo"
> -       fi
> +       packetize "object-format=3D$algo"
>  }
>=20
>  test_expect_success 'extra delim packet in v2 ls-refs args' '
>=20
> Should we? (And if we do, we might as well drop this function and inline
> the whole thing, IMHO.)

We certainly can.  I'll move this later on in the series so that we
can simplify the code.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--NklN7DEeGtkPCoo3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXsA7qwAKCRB8DEliiIei
gVqXAP9lB8oFxPWqJamx3EFmY+CmFRpNztlIHGkMMdDZ/xpyuQEAkvPBNnNMUt2Y
aZnBCm/Bgw2wYRrzqnJHHB8LeVIPqgM=
=I4uF
-----END PGP SIGNATURE-----

--NklN7DEeGtkPCoo3--
