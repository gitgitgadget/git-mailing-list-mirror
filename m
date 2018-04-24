Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49D971F424
	for <e@80x24.org>; Tue, 24 Apr 2018 23:52:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750791AbeDXXv6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 19:51:58 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33204 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750766AbeDXXv5 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 24 Apr 2018 19:51:57 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id DA14360129;
        Tue, 24 Apr 2018 23:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1524613916;
        bh=hv+N7gqh1HgFuP0cAQrkl/GBA2cIKCvZ6jrh16uysj8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=FQeISJeBusbi141gOfztUvrjS1DkgKSUYORh7J1PAIcQRrAJQPYanWW8/8IDwbZPj
         uHONqH0s4qMkFU+59xjpLdSto12nydck9N69py3TRFXRi3Ct21Y9osiYxVWnaSpGBB
         F3TBLOAuun6o2xG+88F0EemK7A/HzkcbB9QgQxGiuNQPydfv7+ihNVfr0r6/MHOanp
         +ocnlfpsaJFoNk5YDgxp1JytIienXYbsYfY0JchJ9YqYKKVKI3kFoi5QiWgRubxQuM
         Au2bSxqFKu22c/tqHNmD00bCMlnHpr2PPg5Ds4XsIWlD8rr4ColrJ293ngKLhJ7gT7
         qIjcVuIu1leCvDSkvcsAG5yNpJftasyy+YO53uIk0J1HQPpWpZwtCIaWWZqVa5ESbp
         Rr6zkCRlu6ZQsae+U4RYmGRM1NSBFXdou6AVPAu3EpSHZ771ige9FYksdMYvht4lrK
         7OiwVumO/p7jbLgGc0my2BELnZKSfLuf+5sSyUwL0AuM0FDMbNv
Date:   Tue, 24 Apr 2018 23:51:50 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 18/41] index-pack: abstract away hash function constant
Message-ID: <20180424235150.GD245996@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <20180423233951.276447-1-sandals@crustytoothpaste.net>
 <20180423233951.276447-19-sandals@crustytoothpaste.net>
 <CAN0heSouHbAj8TbiROe=XRsBJ788Vi6P4a_Wvv=7OrdsXqQXHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UoPmpPX/dBe4BELn"
Content-Disposition: inline
In-Reply-To: <CAN0heSouHbAj8TbiROe=XRsBJ788Vi6P4a_Wvv=7OrdsXqQXHw@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.16.0-trunk-amd64)
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--UoPmpPX/dBe4BELn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 24, 2018 at 11:50:16AM +0200, Martin =C3=85gren wrote:
> On 24 April 2018 at 01:39, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > The code for reading certain pack v2 offsets had a hard-coded 5
> > representing the number of uint32_t words that we needed to skip over.
> > Specify this value in terms of a value from the_hash_algo.
> >
> > Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> > ---
> >  builtin/index-pack.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> > index d81473e722..c1f94a7da6 100644
> > --- a/builtin/index-pack.c
> > +++ b/builtin/index-pack.c
> > @@ -1543,12 +1543,13 @@ static void read_v2_anomalous_offsets(struct pa=
cked_git *p,
> >  {
> >         const uint32_t *idx1, *idx2;
> >         uint32_t i;
> > +       const uint32_t hashwords =3D the_hash_algo->rawsz / sizeof(uint=
32_t);
>=20
> Should we round up? Or just what should we do if a length is not
> divisible by 4? (I am not aware of any such hash functions, but one
> could exist for all I know.) Another question is whether such an
> index-pack v2 will ever contain non-SHA-1 oids to begin with. I can't
> find anything suggesting that it could, but this is unfamiliar code to
> me.

I opted not to simply because I know that our current hash is 20 bytes
and the new one will be 32, and I know those are both divisible by 4.  I
feel confident that any future hash we choose will also be divisible by
4, and the code is going to be complicated if it isn't.

I agree that pack v2 is not going to have anything but SHA-1.  However,
writing all the code such that it's algorithm agnostic means that we can
do testing of new algorithms by wholesale replacing the algorithm with a
new one, which simplifies things considerably.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--UoPmpPX/dBe4BELn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.5 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlrfwxYACgkQv1NdgR9S
9oudKBAAmZYbiM1Vv1fIx1JWW8sZ1+AbNEfItxSNk45mDlCtXP/uViqQJM0qy13r
+01HCbnj/k5mkVPTKvUTQX3fSb+wUEAHtYCEj4+2OZpgBvHxed95oVQvTczI+NDR
XhxDWNknE5f8n4+6Cv/TXd5NyaK+Iv39WtN9DYq1pyy/HFTdsKtgLl8Gdes06ooR
qKa5WhJyDkoHOzShNnxJORt4ULeZBIxJBC6ehUqjNfp9Bz1zYWbaUL6MsSwwgMm+
kXU0f3qV4xhLA8BlXmuk6gnMvY48ZvyXZOiNnriBm3Ybh0qygzj0ydfg+Uat7heG
gpvvvtoKlNCjiVHlusNXPmvO7CgWyJMwjBFgJpqGR0CbSWbMIQr2oJjV1PKufp5W
hLqhJ2KtNHjZvNJdHcTAJ2mt5m9pHESmWDWK4m05tTkURd7Ep9ZMYOGVYMkfsfyU
n+j4KaZSmTV8Ks1u+9hsletxuA13eZgjN3lOTGejWO/kJgn2cd5l4sou1nZrewNr
ckVOS72fDAXDgm55yodDSNGTnKqw6t5V4ve+wrThErNbsIo0NEdTlZiKE69GxQH0
UYty3sOn5JuaGvDt2fA1NkiLtnzlaQgmMBDdkwvT8mn6OgJB6hoMffUCx1J+e9AL
zY2iME6qeamhmlQU7fSF7YwkXr0phzip0rbA9JdNef0uGBER32I=
=Bd6b
-----END PGP SIGNATURE-----

--UoPmpPX/dBe4BELn--
