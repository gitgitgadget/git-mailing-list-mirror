Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E78F1F404
	for <e@80x24.org>; Wed,  5 Sep 2018 22:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727713AbeIFDWb (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 23:22:31 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:46276 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727681AbeIFDWb (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 5 Sep 2018 23:22:31 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:1024:89fd:c4a5:84be])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E161D60745;
        Wed,  5 Sep 2018 22:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1536187809;
        bh=RK35ddE/Lxqa7R2ddRosrPiNZb9HJEfO6m4dnm45F9g=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=yiukGdL7m6xzNxZbrPonhQpJW1fXVLFtLp9W7EZwtBeh4+IPXnAumv+iBYRcE6hOL
         vQ1c6oNHjbwgsCjBmmRlH0aKotnDTP/AcQLGB1XpxaRm8sPvwJ8Kw8UA4WYtzWPckc
         RD9B68LV0K6UfBfRmHbYMM+xzeNFREMalZy14zo/nAnR5TB+tIyhL1D3G3tG9ivwAJ
         4ZWDBzxnH3uLXRMJmyfZgrhOl9k4JhFnPHDHU7VaSEQA41S5cPJjr2sq451lSnVidr
         3GNov0iuQSeHfIpuJPSf2v42/kS+XqjYLRGFtf57j9WJZorFsc7tsUiUM0gL9vKe/u
         mSdl5La7Doz/QNS/rmOpjRnrsTx8trBwhgoO0BX/6lav5sT65CBt1lr4FCjC+qJhh+
         d/cTuluc9OM1JqF0yk7Nrwbz7sKJTfF799BwAeDdmJT3aO0a7syK6P7ACVTpI4RLl1
         87rtvQ61FLO6paj352yJy/gm7JnV2VTAzcES6D0LouUeJARqcnr
Date:   Wed, 5 Sep 2018 22:50:04 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 01/12] t: add test functions to translate hash-related
 values
Message-ID: <20180905225004.GO432229@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20180903232515.336397-1-sandals@crustytoothpaste.net>
 <20180903232515.336397-2-sandals@crustytoothpaste.net>
 <CAPig+cQZMEvJZ2b3RjtXvy9ZtTjRKUvye_xT0nibOqcHtpApZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ck22u5fw4m2k6hx2"
Content-Disposition: inline
In-Reply-To: <CAPig+cQZMEvJZ2b3RjtXvy9ZtTjRKUvye_xT0nibOqcHtpApZQ@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Ck22u5fw4m2k6hx2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 03, 2018 at 08:01:35PM -0400, Eric Sunshine wrote:
> On Mon, Sep 3, 2018 at 7:25 PM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > Add several test functions to make working with various hash-related
> > values easier.
> > [...]
> > diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> > @@ -1155,3 +1155,70 @@ depacketize () {
> > +# Detect the hash algorithm in use.
> > +test_detect_hash () {
> > +       test_hash_algo=3D'sha1'
> > +}
>=20
> Not worth a re-roll itself, but if you do re-roll for some reason,
> perhaps include a comment inside the function saying that the actual
> "detect" part will be fleshed out later.

Sure.

> > +test_oid_cache () {
> > +       local tag reset k v
>=20
> s/reset/rest/
>=20
> It probably wouldn't hurt to &&-chain the above, as well, to
> future-proof it against someone coming along and inserting code before
> the 'local' line.

I'll fix that and reroll.

> > +       test -n "$test_hash_algo" || test_detect_hash &&
> > +       while read tag rest
> > +       do
> > +               case $tag in
> > +               [...]
> > +               esac &&
> > +
> > +               k=3D"${rest%:*}" &&
> > +               v=3D"${rest#*:}" &&
> > +
> > +               if ! expr "$k" : '[a-z0-9][a-z0-9]*$' >/dev/null
> > +               then
> > +                       error 'bug in the test script: bad hash algorit=
hm'
>=20
> Did you want to redirect this to stderr like you do with error() in test_=
oid()?

No, I don't believe it's necessary.  The commit message hints at this
slightly, but test_oid_cache is run with stdout unredirected, while
test_oid is run inside a command substitution (where stdout is
essentially redirected).

The issue with test_oid is not that it doesn't abort successfully (it
does) but that you don't see the error message and therefore have no
clue why your test suddenly exited 1, which is unfriendly to developers
when they make this mistake.  Since that's not an issue here, I opted
not to redirect it.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--Ck22u5fw4m2k6hx2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.10 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAluQXZsACgkQv1NdgR9S
9osp6A/+Npt+hdZgYF/twoBGAD9Nr73LIuvdbTeJovfMxhBYPD99MVktfyCQ2zZK
iINRLnA/MheaQxrmU7PGJV6359UvOmAW0Z/dIPQLdw7z8uV50ADJXv+BixdfpM/N
p3ecI6BJNHqvTTaLHXfbW0K842YFYiDonzuGudzVLR+74UpRp7RDAzQdhXJFhOZy
FkDEQxIKuL/D0Vj0u/kZGrPVpV4kEb+rNSF79uPctOdW4wpJUk23x6eV153UnGUl
uJXO+WCIf3/djySHU0xi1SRdBsngfLWrFKhQvpMkJb1f7b36MbLsn/i/o5EbSkql
68jepUFPx0xcI+mFLLBjpJhEcyXA57SezURVQByfkcX+EIh8Hm0H9DTv2fuIlRa1
yhlFCQFruTISCyg41Ey6DQvVFic65r2MnQtUOmq4fi+EVqIdM2MbWRKo2EmKufnW
LEbAYUK8B1k83/wiQC7hzduiAJ/NnFr102TxYYbCxfokZdPgDNer0srBi4ZGCtub
McKOL2EgkTNCx3X5PFx9RIAA/GREan0snj4TxnluDxFgFkV/mOFpLYoyYf6W1aer
rRp9edLCUBNIs/r9R1f+QyAhepOI3AkehgezPft0T934L0qAL2cKl1zPVIPb32cw
BI2JDFUdLmU+gClBVE0JWyeubtYxThei4TFA6KeQB9x0s4Rsr08=
=XoDh
-----END PGP SIGNATURE-----

--Ck22u5fw4m2k6hx2--
