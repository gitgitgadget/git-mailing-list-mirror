Return-Path: <SRS0=v+yc=5F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450BEC4332D
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 01:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 165E420752
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 01:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="LuCISQnq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbgCTBSP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Mar 2020 21:18:15 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57684 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726950AbgCTBSP (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 19 Mar 2020 21:18:15 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C1FDC6077C;
        Fri, 20 Mar 2020 01:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1584667094;
        bh=ydyRewUL0m4q+rYybp6skJiCwljAtLeh+qf2tKW/2Mg=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=LuCISQnqqTb32wdQ3hbKVHooHe1v/dsu7/oG+QRAOjAyDe7pWa+d3pu+SAtuFVzlX
         7koO0U6jtA7axjAaN0NQ0lOF6H9gEYKV2iyGlsxsGy8JrSkjqtwAdCP6BOsEo3v0EF
         RliHgV8HImhngKovYFDktaK65Md2/Ywb7UtGShjJBfFVzYC9HKy3ba3ZnWKK7FXoCr
         qi2f1PF2+hwJVUqBo4o3+efovff//SFtclm7/T5Aj61cJaaGfgB4b4W0rKYFoxbfvn
         BBLb+xjlV/EizlhaKywUGIdXFBXPtLeWv5ft9n+rtfoI4b+zCeAPvQDNUD3r/qW7fV
         5u0VNmfEIhz45AwA+m5QaQk52LPEkwdO63Xqy5N1KRj7k2N4Qpak6xx68pGaIEfwLw
         hMnnQj4RM3ZJtYHfKYMa2mksyB4Zi2oZkY7H2pRrlZ4B4rCyoT0sABcTXJAFDmzepl
         B2/ej2GW2/Zs3zqFzMHPygDpU3dQHLCqBfaRxKyBo1QHSfM3FVD
Date:   Fri, 20 Mar 2020 01:18:09 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Benjamin Shropshire <benjamin.shropshire@economicmodeling.com>
Cc:     git@vger.kernel.org
Subject: Re: Relative url values in .gitmodules confusingly sensitive to
 clone via ssh vs https.
Message-ID: <20200320011809.GG366567@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Benjamin Shropshire <benjamin.shropshire@economicmodeling.com>,
        git@vger.kernel.org
References: <CAAjm7Ga5JOJ2w=01o1-x-80HMGVaYQQy8SBBb-zJ6MOQAe4SxQ@mail.gmail.com>
 <20200318002630.GA366567@camp.crustytoothpaste.net>
 <CAAjm7Gb8DdGUCfoPO+p2=YsmvFj5eoCn3jjEbwg3-hwRnt0Q9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="L1c6L/cjZjI9d0Eq"
Content-Disposition: inline
In-Reply-To: <CAAjm7Gb8DdGUCfoPO+p2=YsmvFj5eoCn3jjEbwg3-hwRnt0Q9A@mail.gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.4.0-4-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--L1c6L/cjZjI9d0Eq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-03-18 at 16:02:18, Benjamin Shropshire wrote:
> On Tue, Mar 17, 2020 at 5:26 PM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > Looking at the code, it appears that we don't let you go above the top
> > of the URL, which makes sense.  So we interpret it as a file system
> > path.
> >
> > (And since this SSH format is not technically a URL, we don't have a
> > root slash, which is probably why this is a problem.)
> >
> > Does it work if you write the following?
> >
> >   git clone git@github.com:/user/repo.git ./ssh
>=20
> That seems to work... thought if the final resolution is telling
> people to just use a particular format for the repo address, I'd vote
> for telling them to use a full and proper ssh:// URL. (Technically I
> think `git@host:/...` may be a protocol relative URL? or maybe that
> would need to be `//git@host:/....`?)

I do intend to send a patch to make your particular use case work such
that we consider a colon equivalent to a leading slash, but I have a
little less time than usual (mostly due to current events).  I hope to
find some time this weekend, although of course anyone is welcome to
send a patch sooner if they get to it first.

I agree that the URL form is probably better overall, but I suspect I'm
in the minority there.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--L1c6L/cjZjI9d0Eq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXnQZ0AAKCRB8DEliiIei
gQ62AQDYWr9UPoTUczGjZi+D0XgFoQeZ2vKjOqZA/DCN2yJoUQD+Iiloio7N+II+
KZdbfcFjvoLQlp1BDwBkhgZgok3nFQ8=
=UTF/
-----END PGP SIGNATURE-----

--L1c6L/cjZjI9d0Eq--
