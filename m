Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2253C215F4
	for <e@80x24.org>; Tue,  1 May 2018 01:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751559AbeEAB1I (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 21:27:08 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36968 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751298AbeEAB1H (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 30 Apr 2018 21:27:07 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A869360129;
        Tue,  1 May 2018 01:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525138026;
        bh=WZuhXXbTuqkALalzXw4RVhqZxcSiQQHsGBhKjjHyZDs=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=nPMXa2IpajhlgZO1PJd0AwvnCJxlSKQ9SSO5rBiu9H2wy2RBCA8IZoeL3XQgG6tc1
         F3bUIUsCqQDnq1cP7ww1VSzBwctNU3TrBh8NrSMI9YnOmJSAcgyt3LkCusve5ydHrw
         YCAAVzft001EGXu0HiqFHSZhoqZrcF6EXyk0BowTX/Ot9sI142mCWB2wa3d7sAkWod
         4rycwKQR+RgJtPEV6Zt9O0Nxvuy6gREqgq/lWKVpyxbbl2kJ/OhT96I8kf1rXlkE7B
         CJytxF/xG+WGbwLuh5ISety/iy/HrEPz6Uw9Nxyt6UYW2dgca+byTwELdsFaWg+Ler
         TblCw5vBjEW+JNhzudsPjvrPUDnqaf7aEtnROA+Ew0SvyYFC8Skgl2ZD+RY9eCeb31
         31FBChz5tkS1/vrldf2FkLHkiIY+BCFMcQsmW9Zasp+M4MzxdcNFkV/F4ZaTCUIA5e
         YD+rHHRO08pjip+Rti0cjsM2rApxypzz+bj6uR3/7HJH+aXSTRh
Date:   Tue, 1 May 2018 01:27:01 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/9] get_short_oid UI improvements
Message-ID: <20180501012701.GE13217@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
References: <20180430220734.30133-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wchHw8dVAp53YPj8"
Content-Disposition: inline
In-Reply-To: <20180430220734.30133-1-avarab@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-3-amd64)
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--wchHw8dVAp53YPj8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 30, 2018 at 10:07:25PM +0000, =C3=86var Arnfj=C3=B6r=C3=B0 Bjar=
mason wrote:
> I started out just wanting to do 04/09 so I'd get prettier output, but
> then noticed that ^{tag}, ^{commit}< ^{blob} and ^{tree} didn't behave
> as expected with the disambiguation output, and that core.disambiguate
> had never been documented.
>=20
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (9):
>   sha1-name.c: remove stray newline
>   sha1-array.h: align function arguments
>   sha1-name.c: move around the collect_ambiguous() function
>   get_short_oid: sort ambiguous objects by type, then SHA-1
>   get_short_oid: learn to disambiguate by ^{tag}
>   get_short_oid: learn to disambiguate by ^{blob}
>   get_short_oid / peel_onion: ^{tree} should mean tree, not treeish
>   get_short_oid / peel_onion: ^{tree} should mean commit, not commitish
>   config doc: document core.disambiguate

As mentioned, I'm a bit unsure that patches 7 and 8 are entirely
correct.  I've mostly convinced myself that they are after looking at
peel_onion, but I'm still harboring lingering doubts for some reason.

The rest of the series looked fine to me.  Thanks for cleaning up my
stray newline.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--wchHw8dVAp53YPj8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.5 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlrnwmQACgkQv1NdgR9S
9ouwNQ//QJGWzEj5njPPCNEh/El4p6EWVq15BfYr4L/FjPe8ffVE25QLt3RqBDj4
TzHeClr2uev7Q7VbaCk1Rw7NEUbI6ESB81cqOa9z0A96J2ZtyttzRP+ftS6K1ZvA
c3ZahZxvngdjWsLwl4U5tXJFkCdVjSyMsHaZ1tCpb7mOAoiSZvdAIyGRLYdO0wUY
L6aaF2LJ3ICn5Y79bf6FweD8wDjD8OL9/FnhWeD+MOUZZ7FHTUVL56fTeI9pHTGM
jNSfeGXygQHFQZYF1sIHBCy9oAV8h7LEDlC90DTt+hDFfe/vI2rIGQldODszO4BY
A7+5Lt1NHi/s4Rnd0QWnyviLkRs1lOwKzfqq3xCgcj7kwcDF9gNT92tvOJEYNF1q
TBrnexo3Q0Oyol+ORIeIhvHCacLsMdYg5MCVp1rC9ytyvKSVZsxIs4kcMzkP974C
k0g91Z4fifriVQmcl9S0riVib+edP2D7PWIDoYxw/dmPLPchvsH8L+ij1qkNw1mR
6JlUuQyKfi2OpfCsHBSjQZiYTGTfwysW9s6YsduF6O8Oq+FhD/wRDlspUaCZFz7B
wUVWhnfXQVfEgRuuNz6Iihskz5I84+PfQ8+7l6rVUEMIc5l8juxlRXqTXNDu61iK
IrO4GIhHTdz70vTDnm3SU40HYpt/RjX9UO6tHuuEVg0T2uRPxLQ=
=xOoM
-----END PGP SIGNATURE-----

--wchHw8dVAp53YPj8--
