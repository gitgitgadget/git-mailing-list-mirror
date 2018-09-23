Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C43D61F453
	for <e@80x24.org>; Sun, 23 Sep 2018 14:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbeIWUvl (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Sep 2018 16:51:41 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39024 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726280AbeIWUvl (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 23 Sep 2018 16:51:41 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:596e:6738:f59:e0e0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 58BBA6046C;
        Sun, 23 Sep 2018 14:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1537714435;
        bh=He/Wa/ofJyHZ0E+0Tt+5ngTzijbaD7GBLxAZGNEow+Y=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=XhdqueULXl6H/6CRkYI5DRspvhUkIqwjQnR24yWzzRyDyb0Y60DSUtCfWwNjSJZ6D
         Uj1ghNLMwKFRMOmwfsTgeODQkcZ+jlPUogZcACXhflq1ngneYJ9S6VKbyEmOg2QoyU
         lWbY2CMndn6JntCeUdvUGLNxKcy773h8zWudwo9nJO9reGnWOHxf2OBRkfcbxOntsy
         2N2ZyeWroAA6tPjn/XhUL8F1z1VUrny2AhHKy+zhDKPilMCBiGyJF97vH7thWKps0L
         j2x2IL1r04gn5UTJoP8e8avgZ7nfAuivK/esiUT1/uHUC5R4wDs4gY1k5ODdtdbd7K
         XG+Y8a/DEz+0w83/jczvwYm9oLZyty7bUSKSeLJ81kyBKYD12i4LEl8iKHPdWGuc9g
         kNPOucM/ngLA9CG8/p71/IleyGuX4+IK6fJ4oGVQoLEUPIwgb/kWKRNHvhoDXdGf0w
         x1wCMK+vLsDQHv+ZWsDfItDLEvzaarrHs3Zh3W5Sqo+NzOWI0qG
Date:   Sun, 23 Sep 2018 14:53:51 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        gitster@pobox.com, sunshine@sunshineco.com, sbeller@google.com
Subject: Re: [PATCH v2 2/3] transport.c: introduce core.alternateRefsCommand
Message-ID: <20180923145350.GE432229@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        sbeller@google.com
References: <cover.1537466087.git.me@ttaylorr.com>
 <cover.1537555544.git.me@ttaylorr.com>
 <9797f525517142b3494cfbd17a10dfeb3bf586e2.1537555544.git.me@ttaylorr.com>
 <20180922180231.GD432229@genre.crustytoothpaste.net>
 <20180922195258.GA20983@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QHrz2k/ePFTn56xd"
Content-Disposition: inline
In-Reply-To: <20180922195258.GA20983@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--QHrz2k/ePFTn56xd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 22, 2018 at 03:52:58PM -0400, Jeff King wrote:
> On Sat, Sep 22, 2018 at 06:02:31PM +0000, brian m. carlson wrote:
>=20
> > On Fri, Sep 21, 2018 at 02:47:43PM -0400, Taylor Blau wrote:
> > > +expect_haves () {
> > > +	printf "%s .have\n" $(git rev-parse $@) >expect
> > > +}
> > > +
> > > +extract_haves () {
> > > +	depacketize - | grep '\.have' | sed -e 's/\\0.*$//g'
> >=20
> > It looks like you're trying to match a NUL here in the sed expression,
> > but from my reading of it, POSIX doesn't permit BREs to match NUL.
>=20
> No, it's trying to literally match backslash followed by 0. The
> depacketize() script will have undone the NUL already. In perl, no less,
> making it more or less equivalent to your suggestion. ;)

Ah, okay.  That makes more sense.

> So I think this is fine (modulo that the grep and sed can be combined).
> Yet another option would be to simply strip away everything except the
> object id (which is all we care about), like:
>=20
>   depacketize | perl -lne '/^(\S+) \.have/ and print $1'
>=20
> Or the equivalent in sed. I am happy with any solution that does the
> correct thing.

Yeah, I agree that with that context, no change is needed.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--QHrz2k/ePFTn56xd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.10 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlunqP4ACgkQv1NdgR9S
9osaBQ/+PN9/fjSC6uAx9L5QiqBDwtbIms7yttLaFIxKjCTUwS006uBfWacfXrSx
QjPNO5MP0MZyFpcDScr3P/hlbt/ePNZNRsEgVlPIxK762ZbCHEeka7NqUe1ZrJtf
/bhHzFKNv4PmZWpvKuFLj5y+kqY+ARuDdLmzL2HJSQJGsfIaFGq/cCwzheykZyFC
sTYyUK0AcjxIuQ1UcBnZNBXcHBGWgyoZOSywEB0vMJTFvQ4keuD0n9CiIa3WqAvR
1873Mk2AZA4SdOZv1b2jXBEV39mZ9hGis04tWoAW17EdW+t8PR8T/qL/CI4c0SH1
musRqcTLeBwVtmuwZF69cAnEjsGGHqn1pgYirn800c0jEdNL/zwzTqNiX75gvFP9
VYlNHxDktMs5gOFLcVCRbuwol+NCqaxQ/c/V7Z6c6zlhZJEuLZWgewKlfB3OtUp0
dktgwDE153Mra5jcqXWL5n7iwClZfBrsEFmPTK0aeSKy1w1O3bgLbdKrt6JisFeO
Xdxany/QdX1x8KsJSuTtfevVXMpUzkPPCWMaJv/QkAs7RgXfnvp+R1ednDNj6FfM
fhg1hrHrFG7in3tEcimoVr4Gkbw8olgBIoLm1614T4+MxbaSyaSKddyPjtJsTdsq
CULXzAbfNxbPubFS2RWKGXk52fLzH7Qz5fLv4iNXivzpd559n/Q=
=oQB3
-----END PGP SIGNATURE-----

--QHrz2k/ePFTn56xd--
