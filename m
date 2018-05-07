Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C579200B9
	for <e@80x24.org>; Mon,  7 May 2018 02:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751855AbeEGCcy (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 22:32:54 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41412 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751831AbeEGCcx (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 6 May 2018 22:32:53 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 911BC60444;
        Mon,  7 May 2018 02:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525660371;
        bh=MaDcrNDlf+cPkuQ+P6NbQwQ+JqomZXDE4Of2VhhoRws=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=g8VIoWh78uKTxzGikfH1kU2q15JRUro9GLDQZubRHvFpiHaikDTly/+gr4hw3EP6L
         G+cjJEZB/xnjZD48p+66lsK/fN/3iaRIn9ESRRLq9/GAMcCftshRBMdmx/6FW2PcHl
         tlJboNMvBzBeuHU1wsoyyA4cHv33bg/eOAmbgeh3UGtJWZ207vgHtGlRN3pIiDdc/V
         5DALc66KVJ2QRRvOIMNUHHGfVC35Z7JSaIC+J/+OiJOgL2Q1H16vckwPjw+uyCkCyY
         ZDyBH/TvRm7sJcysiheIxZPQrpwJjRmtZpiuaqS/G+f10HfdG2KtodqxM0bZLwYbB9
         Jud7/5oojPxfCu8T6/ikOnb5LoH7+0xJQ/k/3zrJ2yH4ScOBff1V/ULsWTN21W+5BM
         mk3OB2QTe73dRW3bfl+Hiq/3D0tkUbjFYLa/zPNndVZO1zqm8AKA+JzTKKoJ4cCHk5
         fEHgvl6ty+wkveUx7Hc+pNNqhgNiOWE3lrnL+V4+5hYlaWqlLVo
Date:   Mon, 7 May 2018 02:32:45 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH 16/28] t4008: abstract away SHA-1-specific constants
Message-ID: <20180507023244.GE953644@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
References: <20180506231752.975110-1-sandals@crustytoothpaste.net>
 <20180506231752.975110-17-sandals@crustytoothpaste.net>
 <CAPig+cQ0tm76B4_uewtdMwUo9weRkz92id5cuuQcRdBByZBCDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Lb0e7rgc7IsuDeGj"
Content-Disposition: inline
In-Reply-To: <CAPig+cQ0tm76B4_uewtdMwUo9weRkz92id5cuuQcRdBByZBCDA@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-3-amd64)
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Lb0e7rgc7IsuDeGj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 06, 2018 at 08:07:46PM -0400, Eric Sunshine wrote:
> On Sun, May 6, 2018 at 7:17 PM, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > Adjust the test so that it computes variables for blobs instead of using
> > hard-coded hashes.
> >
> > Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> > ---
> > diff --git a/t/t4008-diff-break-rewrite.sh b/t/t4008-diff-break-rewrite=
=2Esh
> > @@ -27,29 +27,32 @@ Further, with -B and -M together, these should turn=
 into two renames.
> > +       blob0_id=3D$(git hash-object file0) &&
> > +       blob1_id=3D$(git hash-object file1) &&
> > +       blob2_id=3D$(git hash-object file1) &&
> > +       link_oid=3D$(printf frotz | git hash-object --stdin) &&
>=20
> Inconsistency nit: For the blobs, you tacked on "_id" but for the link
> you added "_oid".

Yes, that was intentional.  I want them to line up nicely because it
makes reading the heredocs much easier.  Maybe it would be better if I
called it "linkf_id" or "slink_id" or something.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--Lb0e7rgc7IsuDeGj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.5 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlrvuswACgkQv1NdgR9S
9ovmMw/7BbCV2f/5mVS5658iHmDnRLv/k88AYtzvUqZqyRrGenGnOUjIODPp1ZJl
ZAlXLiDrVEWFm3F72dQaf+GDXJgg73ZXmKPtw7drMDxtonrDxQSQ70bz3KNs/2L3
9mEOwEw887AEEoc85/Zocv9ofv2m2YkDEw6NtxUoYWh3eNArnWgzPAir6Bd02X5H
GvVcekhmYLfNhs4+JepCBBfvbt5cCe6v0kX5g3D6ZsN6Rl6aU+tz7Lri02V46cXb
ZCRCC30B30V5s2eoCCf0DDjYWgukfmfklWHq2oS0IerAcxYJlVEbVjy6HSkL4Q5t
As0++ROYg7+V9gMAFhrGrprWBJVTlpbEY88Q2PdRFer3xWqO8ClCWEz5wI9NceXI
MPKiiOI6a0MefptG3WMSMKpl2rLXDLOzWBb0ATvg2mNdAc8NT3bsMMR1q7ZKFTYI
X//kT91PclXS6QzqYknFQrWUTnlV+WT3gHQI7N+nRhADVnJMGXT2BwNqIpc71gpI
Qa9afvs8oY+RQrb3WRFABQZNJ9ypq5W0/MKSFedkJTMSCzuPaUL75hjno763j3OR
ALjLXqefcTLXdL1LiyklPbcJ6cdvw76NcOr7tKdyBl+cMoBb8cAHT10exzuM27ay
EA2R7Em8JNYM0rBCY58Lij+R7m5qHuUoT3W+Rvpv9ypmEo71Fno=
=6qzr
-----END PGP SIGNATURE-----

--Lb0e7rgc7IsuDeGj--
