Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E8061F517
	for <e@80x24.org>; Thu,  7 Jun 2018 00:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752241AbeFGA5M (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 20:57:12 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34526 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752175AbeFGA5L (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 6 Jun 2018 20:57:11 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:54a4:7f2e:59a2:6beb])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id AC86560129;
        Thu,  7 Jun 2018 00:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1528333030;
        bh=Pkjora8tnRYdIG6TvECX6yIhAuGSaATR35zeyYlP8w4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=IVlzt4shwRZ1Mku92FZa54SeqQIAqy7XSsMQPcHFVPuE3tcbZsORL/evYzFo6q5bR
         Tmy34fd7rtOzvk+fPKJkKMuNriznWVGtqcrChH38QkofEjc4l1U3j+mH+/1IKl/zGp
         dl28ZsB6Ec3ZJmyL0RNAmA1A7ZoGJ1fE4IPQilTrzoVcZE1FqAVIIovUwr/SOcv2CN
         jMlItg5URNkvKNER253sNk9+jYAVu9tp1vmd//rtTpkIxDZg8hIsrmf38Jzo5XVS/K
         i60SJBMT0pOU9W+AXaOACBG4CKHflQ+7I8QBTFfXD9dB3B2ZxlACOKzuCJRu+4KSCw
         BvNJyR2jpQPw4xt2OA/JvEMbLKmoVWzaKB90IaVh4JhI2luG7e8S5Da9v4OjomEZkc
         UnrCE1PCHStiv2oDwtO6uvnLq63NSiSx7lyUs/eCbNAezlpnrPISlTLuG8BnJNa0uy
         1Ytpq4Dexfjwi4aIeZgvhgoLoPYD4oUEGI5j3NQreku4dRvBSdV
Date:   Thu, 7 Jun 2018 00:57:04 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 01/10] t: add tool to translate hash-related values
Message-ID: <20180607005704.GA862596@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
References: <20180604235229.279814-1-sandals@crustytoothpaste.net>
 <20180604235229.279814-2-sandals@crustytoothpaste.net>
 <20180606061927.GA7098@tor.lan>
 <20180606205845.GB1381@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
In-Reply-To: <20180606205845.GB1381@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.16.0-2-amd64)
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 06, 2018 at 04:58:46PM -0400, Jeff King wrote:
> On Wed, Jun 06, 2018 at 08:19:27AM +0200, Torsten B=C3=B6gershausen wrote:
>=20
> > > +test_translate_f_ () {
> > > +	local file=3D"$TEST_DIRECTORY/translate/$2" &&
> >=20
> > Unless I'm wrong, we don't use the "local" keyword ?
>=20
> We've got a test balloon out; see 01d3a526ad (t0000: check whether the
> shell supports the "local" keyword, 2017-10-26). I think it's reasonable
> to consider starting its use.

I used it because it's already in use earlier in the file in some of the
mingw_* functions.  Perhaps we happen to know that our mingw systems
will always have a suitable /bin/sh, but I suppose some less capable
shells would still have choked on it by now.

I can remove it if necessary, but it didn't seem necessary.

> > > +	perl -e '
> >=20
> > The bare "perl" is better spelled as "$PERL_PATH"
>=20
> This use is OK. Since a0e0ec9f7d (t: provide a perl() function which
> uses $PERL_PATH, 2013-10-28), most common uses handle this automatically
> (there are some exceptions, covered in t/README).

This was exactly my reasoning.

> > > +	if [ "$1" =3D "-f" ]
> >=20
> > Style nit, please avoid [] and use test:
> > 	if test "$1" =3D "-f"
>=20
> This I agree with. :)

Yeah, I forgot that that's our style.  I'll fix that.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.7 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlsYguAACgkQv1NdgR9S
9ouJyQ/9H8dsFQdP8g3ai8bVdKKkC0Fg5SIPtfqsmuKrjq5MvDzeG7ss7NSYHT2y
ZTQ2d66Ex/1SE18pWybvgxGAeIqXfHS3B0/4Y57V4gOOFOCLTSYaEuPmWOolIj72
5TJ19spOGhfGER9cmx2o655t6m4Bb/Jb0CGHSBmVo6OJQ/NuiUQmaFjhbB26jeMV
NniInZ9pBx5/hJpXOdoAoX2UYEHLSqQDTvuaOH1SiOCgR53nWA7A4seJ+2b0Y1kM
/l+MXl+57imyr/MA74cb79rSpCoRBm6nCOmpy/KlM0QmygntvgY9lWbpa3u9Gjhu
nqjGq2vOWLggjH3xDLOuUNhUDdjomLHWoU2hvWxzdJI/1zb57bXRLcErwP5Sss7P
Pgv980+YVOD/sizdAWIYOCA5f8ADc/cd+JjGqLuppGPFAMJIaWWeudgJ3vHj0+yo
Dsp/HRfYWG1dIQyxmQIGyVRPpOd8tKRI4QKUWsl1Mc8wus1GxJt+PhCu3czaQCk+
xPRzWkTJk84CvnvE7C1j5wyx44VJ1AkBeN6Urh1gtQuFPgsex70HyVazRIPrQmVm
y6xSPLP1GoLc69I5AoTnC22r5ZfERpeHG4JbRF/Qmq7itFFmAiGTpAG9CXsbrmrA
+p9oIMb8I/RtnGRMFY17wdpU5zm7cjhOIhBwkNzglT4/T6q5Zn0=
=MGEZ
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
