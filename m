Return-Path: <SRS0=9mHE=37=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59345C352A4
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 00:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 251F42082F
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 00:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="1GDPqueu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbgBKAF0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 19:05:26 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58396 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727496AbgBKAFZ (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 10 Feb 2020 19:05:25 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 265FC60478;
        Tue, 11 Feb 2020 00:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1581379524;
        bh=7DeCnBx+IPAP7POYTkGfCiN60pyBQyrouSuPYJNgmdU=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=1GDPqueuBrGk0cKPJXzd7MLntEEz1K18Dgf28jkRXL2k/k8DMi6Aj7jcUw7+T9dFG
         W6U3LU1HEEH4aDSXODvWlPkLTOEL1PadUs4HcKLYthVX1U4+nb+waiStZf5JiM8j31
         v+LOzgAkWKHLuQW5NLzXuqHdyM2uCHSXYWGy7szjijcVGIju/dYVnWW8UqngP7u0Ks
         QuaGue5bgPfaYD6i1XYTvypd58pnRdQF6cGmSOhRWVv5oVCLjcRmp0h545v6i0NyUr
         36WVWKqTJ0eZKb3TdifcYXb3zJRJr/QzUkjtBJE9WpsmDPBoaA4FCr7ftmLRf5q555
         9TNuyUsHQeT5MqLTqGtB1aLkPzblRvgzDe6wKILGwi8XZWHeJbZntFC76CSPRVGLKH
         dCU477j3Zpc0LaHbz7eooRTdr7iUBkqYhLo9UxoU/fhX9p8yf43FITdMZ4DSnv9rAs
         llXUFaI4nL8Y9GHas9WCyvu3b0VHdXo9ksjsuUCPoX+6rYWlJr6
Date:   Tue, 11 Feb 2020 00:05:20 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v4 4/5] Add reftable library
Message-ID: <20200211000520.GA6454@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
References: <pull.539.v3.git.1580848060.gitgitgadget@gmail.com>
 <pull.539.v4.git.1581029756.gitgitgadget@gmail.com>
 <02d2ca8b878a67a3334b222725645dd035b4289c.1581029756.git.gitgitgadget@gmail.com>
 <20200207001612.GF6573@camp.crustytoothpaste.net>
 <CAFQ2z_P+sdd5+46Ov_CO8ae4j_3aA4ahdVR5D_K1qKSQ-q+OcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
In-Reply-To: <CAFQ2z_P+sdd5+46Ov_CO8ae4j_3aA4ahdVR5D_K1qKSQ-q+OcQ@mail.gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.4.0-3-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-02-10 at 13:16:26, Han-Wen Nienhuys wrote:
> On Fri, Feb 7, 2020 at 1:16 AM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > > +     {
> > > +             struct merged_table m =3D {
> > > +                     .stack =3D stack,
> > > +                     .stack_len =3D n,
> > > +                     .min =3D first_min,
> > > +                     .max =3D last_max,
> > > +                     .hash_size =3D SHA1_SIZE,
> >
> > This is going to cause problems with SHA-256.  We'd want to write this
> > as the_hash_algo->rawsz, since it can change at runtime.
>=20
> As this is within the library, the hash size should be injected
> somewhere. I don't see huge problems here (the hash size could be part
> of the 'struct write_options'), but until we have properly defined how
> reftable will mark the on-disk files as SHA-256, it will only supports
> SHA1. I intend to work set the file format in motion, once this SHA1
> version is accepted into git-core.

It's not required to mark the on-disk files.  A repository's storage is
either entirely SHA-1 or entirely SHA-256, except for the translation
tables.  The entire marking of the repository is in the config file, and
everything in the .git directory is assumed to be in that format.

I expect full stage 4 SHA-256 support to land in the next couple of
months.  Currently, the entire codebase is ready and is hash agnostic
except for a small number of remaining tests, and having reftable
support land without support for SHA-256 will be a significant
regression to that state and delay future series.  So when you have a
series with tests, I'll send a patch that can be added to the series to
add SHA-256 support so we don't have that happen.

> There was one question you might be able to answer, though. Can
> repositories exist in dual hash configuration, i.e. where the ref
> database must store both SHA1 and SHA256 hashes?

No.  Refs are always stored in the native format with the rest of the
repository.  When we gain support for using both SHA-1 and SHA-256 to
refer to objects in the same repository, there will be either pack index
v3 or a loose object lookup table which has both and is used to
translate.  We won't store both values in the ref database at once.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl5B778ACgkQv1NdgR9S
9ov5WA//dg6M6gumOdV3VtnniLgBtIlfmARxoIM0KM12sdHdXuo+Eghn2TaH7SD7
v9MJ4EI1X5lsO40SYgjHTDEUVPggJGiesJAW9bQAEwygXBQ4kVpG8Ex0lvgKEfcO
Sp5q3cTTXpsqVAxw5NXb6rUI6wjq0HyokOiA4uRtyYoyY3qAtClzO14Miv6gAkGp
CVoA3sG+vLaWYRaGL4AmEHyUF01k8Hw3vTVg8fFiDN6T3WT2daI2L9m1pwHnt/f3
EnUoB4bRxLq4EYVradbFVKOGlvX/vpuXIYQM7wKzUKCAryciDLwb4ZYUyhVQkFsl
wstlu0JLJHFr3SnoYbyVM4om2JcGb+cU1Ek5Izn3+IVhS4jFACtjQARllTp0jmsG
TuStBRI4QHiuzwIRAx+DSoGaH4MTG14mbdo8qse8W272VDiKcpbhPObE/G6MiIet
GV+UHnKHtJ5PVn9y6bcqB4h9T6ptGcpU1KqGDWkJWtEoraHtihmqAvNlfbepPvmf
9il9KnfNU/CQzA+l18Am3pwMR7AJs43lHnlVPQwN4WIekWAWcvAk3x++/45cOxFv
eab39OsSY14OKAQffB2O4YCnpv4TOSGHoWmBX7TthKmyfMRS3yXieiQnzzmw+AFH
KFvB+/3RAORQx2e7VeeZEl1JKKbBox2ctFOZrgokzmkxmYPl8rc=
=FmLe
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
