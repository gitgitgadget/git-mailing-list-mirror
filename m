Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C51C433E1
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 23:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CEF820792
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 23:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="OkVR6RCs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbgGWXiy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jul 2020 19:38:54 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40584 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726735AbgGWXix (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 23 Jul 2020 19:38:53 -0400
Received: from crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 68F07607A2;
        Thu, 23 Jul 2020 23:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595547502;
        bh=96LqDmKectOLw8Sqam6QFOxTQAuTRCcJMFK7DmojZU4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=OkVR6RCsbsnMO9xnONwvGLFFWT7jJZr3I655SsalXb5T5nkBN4FIv+kUUFBQLZSLU
         f3ZAMQ8GAmunglJEF34bbWdU/MlP7FSQUjGmn7oOphQAHxcB5gLOSuP8mtklUGIbmw
         EPwswalr2rfVK63/GiO5/8i1SB4jG3hz2Jzl9O2+Aq5ehA1m04v6bgqsFkaQh6k2ql
         2Stv18JW2DRweSwta/K0G3NdVQ35CTPSVpw606UznaDkkI2B47RWdbYwEWC7ZW7Pij
         hwxfkItblV5LKcT08pSHm2Xk2TwA9X2DUssinuSonG6L8cXVsjEZHd7HeAEEWIINw6
         AhsehSwW7wHJ1xdtKRjBnZz4MHN48bXmmRPwRDommddOSx12Te+01EfCHzF1cAQqtS
         hg0azQwcXp3z0HgEd7xHbZoDrK6HPWfZh+PbZauCCKDEV/JQCJWzQyBpJOaKeUPZIh
         l5phNovIHnmEchboBhubfKu9WBUyw5amEUof0JsCd8ijX0/8MPt
Date:   Thu, 23 Jul 2020 23:38:16 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH v3 34/39] t: add test_oid option to select hash algorithm
Message-ID: <20200723233815.GB1758454@crustytoothpaste.net>
References: <20200723010943.2329634-1-sandals@crustytoothpaste.net>
 <20200723010943.2329634-35-sandals@crustytoothpaste.net>
 <CAPig+cT36rhfMzOTH8L59cyoBKQQoF92nJ-Unccm+yf9RCgXMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
In-Reply-To: <CAPig+cT36rhfMzOTH8L59cyoBKQQoF92nJ-Unccm+yf9RCgXMQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-07-23 at 04:51:32, Eric Sunshine wrote:
> On Wed, Jul 22, 2020 at 9:11 PM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > In some tests, we have data files which are written with a particular
> > hash algorithm. Instead of keeping two copies of the test files, we can
> > keep one, and translate the value on the fly.
> >
> > In order to do so, we'll need to read both the source algorithm and the
> > current algorithm, so add an optional flag to the test_oid helper that
> > lets us read look up a value for a specified hash algorithm. This should
>=20
> Readers trip over confusing grammar: "lets us read look up a value"
>=20
> > not cause any conflicts with existing tests, since key arguments to
> > test_oid are allowed to contains only shell identifier characters.
> >
> > Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> > ---
> > diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
> > @@ -928,6 +928,17 @@ test_expect_success 'test_oid can look up data for=
 SHA-256' '
> > +test_expect_success 'test_oid can look up data a specified algorithm' '
>=20
> Readers trip over confusing grammar: "can look up data a specified".

Yeah, these are both typos.  Will fix.

> > diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> > @@ -1468,7 +1468,17 @@ test_oid_cache () {
> >  # Look up a per-hash value based on a key ($1).  The value must have b=
een loaded
> >  # by test_oid_init or test_oid_cache.
> >  test_oid () {
>=20
> Should the function documentation be updated to talk about the new
> --hash option?

Sure.

> > +       case "$1" in
> > +               --hash=3D*)
> > +                       algo=3D"${1#--hash=3D}" &&
>=20
> Bikeshedding: I wonder if this should be named "--algo"?

We already have a use of this in t5515; I appear to have accidentally
sent it in an earlier series.  I can, of course, change it, but I don't
feel strongly that one or the other is better.  If you do feel strongly,
or you think it's confusing, I'm happy to change it.
--=20
brian m. carlson: Houston, Texas, US

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXxofZgAKCRB8DEliiIei
gbY+AP4hPKn32kpFO+3DXwLLWgi09qEaCL108+vfzOhllFXfVwEA7ra+U94NsZFn
fsTAwSGL31BTNpVA+nbJogO7VzvOuw4=
=a7ai
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
