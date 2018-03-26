Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 210121F404
	for <e@80x24.org>; Mon, 26 Mar 2018 23:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752277AbeCZXCs (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 19:02:48 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:43292 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752021AbeCZXCs (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 26 Mar 2018 19:02:48 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7E71960428;
        Mon, 26 Mar 2018 23:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1522105367;
        bh=idAB+iIssJWwekaL1X4kSJz0cMRtYe9wXoCsKGQUXkA=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Gpb571kZu1tEIwl36s2aVsnKOc7ihmqa2Oi9uqG10q3KQz0XRftvN1q4jcJ/JTGFd
         GIf/T6NoatmVp3uvqihTpy34n9H4+eC3+GUigNbfIanY4igP1nlSUd6s+mfNC6r4FK
         ETsZd4Cb+WnlsBTFoHdBASqObREU17cjvePdoD9u2D8yQ9UQFK3iIhPQ0vTAll34Ya
         EfM24/1J5DKav4w+ZrjvYnh9HQJYeedE/bhLTUHzRDA3GzM4GbZhqdGzlJnP7dSzAR
         bDwykijCEgD7nZSL5OgW49jSWnjc2NADWqbqZzgYXgs3Hvki1dO5kcFamthsBUWtcJ
         NAidggCRIRA+hGIrzRiTpVKBfGV6tgaxZOmwANc6NrfEmPgzvUH7CsqN3a4JKMMQzB
         xNli2Je8NNJ0oD+YLlrzBTr2TGSr/lQcNnX+a/JQEBkFflEXQtT8Pt83HYZNoP1aYu
         szlsdzGLaYbYvS9j+YpGbg9eFFbDFVUxl7TAVL/vEKRnECJ+JFK
Date:   Mon, 26 Mar 2018 23:02:41 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH 04/10] t1405: sort reflog entries in a hash-independent
 way
Message-ID: <20180326230241.GH74743@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
References: <20180325192055.841459-1-sandals@crustytoothpaste.net>
 <20180325192055.841459-5-sandals@crustytoothpaste.net>
 <xmqqefk6bhw3.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="J+eNKFoVC4T1DV3f"
Content-Disposition: inline
In-Reply-To: <xmqqefk6bhw3.fsf@gitster-ct.c.googlers.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.16.0-rc5-amd64)
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--J+eNKFoVC4T1DV3f
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 26, 2018 at 03:18:20PM -0700, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > The test enumerates reflog entries in an arbitrary order and then sorts
> > them.  For SHA-1, this produces results that happen to sort in
> > alphabetical order, but for other hash algorithms they sort differently.
> > Ensure we sort the reflog entries in a hash-independent way by sorting
> > on the ref name instead of the object ID.
>=20
> Makes sense.
>=20
> > Remove an assumption about the length of a hash by using cut with
> > the delimiter and field options instead of the character range
> > option.
>=20
> I thought you used your truncated blake hash to develop and verify
> these changes, but I'd imagine that the "42" thing were hard to
> spot.

Yeah, I had to do those by hand, but it looks like I did miss one.  I'll
reroll with that change.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--J+eNKFoVC4T1DV3f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.5 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlq5fBEACgkQv1NdgR9S
9os0OQ/+OrInCiCdYKlynjkGWSt44xjnYy1RVRdwj/Rhzntd97G/nKsrLNTfsXQu
yIKkaCPh/SuMK6BW/nnDl20uVjSbZuoYTiincFkBjueXUoKrh2B7VbI0I36gWpGJ
bym2zwFkVyDwbk0DAXI5OhZb0c5nlhr/EIISFjoyDYhRrBdQKtdNELcWA/qfB4ft
pPwnmi5JpCk9pVWPNO45t5s7fbhJ1ibUEQWYKt064QNUPH9imfr91mnz2rTReljx
PD9YF7qXziBSpgkXrwoXmfik/BhnVI6O8Io9SFTVtQrB9gXDNl2pKuN+wm665fxh
bYVtsJ7mnFO4JbTyulqJPW8e/enxYtNyoxxnbBURX75zJd0io4/SrNXsJL1qmKoV
w1uZOzpPvmlS/PRaPXCGM8Yjg20z17EHDYhJqlOjLh4GTbYcJQkfjVPJ5qAWVfuF
5trlMQNOlnl5sPWtEkS+6R3ZKOIzCrlkO7Y4JI/LPrwAsUl0KOUnZKHcF9ZB17/5
B3dxZC2APh3qit1HFGwrKSNlCi7c5g7sV1sQUXU6VVgfVh3umDZhpJgX/p66nn1/
mqj9CpyXgMtDiiz2OavnFOsXRGG3I2bKPTipfAJ8wRn6SeRmf9EcGFuUo73lFKO9
QuL5VIzDmdHyzAwm2ws4IW+E4cPF8q6cbiGqrAwy4fqC17ceDkU=
=qC8Y
-----END PGP SIGNATURE-----

--J+eNKFoVC4T1DV3f--
