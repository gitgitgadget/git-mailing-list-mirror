Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1F331F453
	for <e@80x24.org>; Fri, 22 Feb 2019 00:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfBVALx (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 19:11:53 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34988 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726035AbfBVALx (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 21 Feb 2019 19:11:53 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id DE70260489;
        Fri, 22 Feb 2019 00:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1550794311;
        bh=CKXF/wkjSf1WsoqtUuBjVScLrI3F38HxufgtJwvO3t4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Y8s7NXCpSvRE5Z74pE4gTmGrYHHTYddgvu2xhqfDABTOD4KZRODBj0ai2LtmBhQNS
         1fJr8llkCGGM/NWJHigYJC6EUOlCJqG9QCD0ile06hD3j2i9hziHmflugwnRGCrzp2
         8bSyrJth1Fu7jco4qBYQf+F6wCpkjjm8dFrogpCZmVyaCokX81UZ2ugaHtlaCeQJIa
         3aQ0EiGVFTbh0Cb8/wleW2wjuFKxJ47ACKawyP8AhKUjooRK5RhpBNlVOMCvS30lwt
         wi+WhIU54FIV7ok5FwVAHGAdSVCco+BKhpnqgdF0rcKEYfzD5G2jY4QZyfXFNSchXw
         FNZO90i0KOlNftjra5Lrf/lqBKtnkgOO2yS9BS1VXl884uoWhzxPS4aNgi/kerPNZd
         I+fQTNdsAYhjd2+zzJ67T26XDwEUnGeR0787Lr12bhi89z1Je+8+v5dO3AIbAG5/lF
         yB1MmOIB7DJA8oZga8SwjsqYAkLDvo909RQRKuw8zFF9fJ/mTvu
Date:   Fri, 22 Feb 2019 00:11:46 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?zqPPhM6xz43Pgc6/z4Igzp3PhM6tzr3PhM6/z4I=?= 
        <stdedos@gmail.com>, git <git@vger.kernel.org>
Subject: Re: git format-patch can clobber existing patch
Message-ID: <20190222001145.GD488342@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?zqPPhM6xz43Pgc6/z4Igzp3PhM6tzr3PhM6/z4I=?= <stdedos@gmail.com>,
        git <git@vger.kernel.org>
References: <CAHMHMxVdpOnTkf9RHzCa+YjjvpqJApsSE03Jjyb_VbJp_4q-jw@mail.gmail.com>
 <CAHMHMxUfjnNXFikVD=rys_t5BUho=7uRw4LsXgAphFwSf3xOnw@mail.gmail.com>
 <xmqqpnrksobq.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NklN7DEeGtkPCoo3"
Content-Disposition: inline
In-Reply-To: <xmqqpnrksobq.fsf@gitster-ct.c.googlers.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--NklN7DEeGtkPCoo3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 21, 2019 at 03:40:09PM -0800, Junio C Hamano wrote:
> =CE=A3=CF=84=CE=B1=CF=8D=CF=81=CE=BF=CF=82 =CE=9D=CF=84=CE=AD=CE=BD=CF=84=
=CE=BF=CF=82  <stdedos@gmail.com> writes:
> > Would it make sense / be easy enough to have some clobbering check / fl=
ag?
>=20
> Given that use of '-o' to redirect to a fresh/new directory would
> reduce the risk of such clobbering, and use of '-v' to force
> different filenames would reduce the risk of such clobbering,
> it seems to me that aborting the operation when we fail to open
> the output, without any option to override and allow clobbering,
> would make sense.  If existing files record 4 patch series
> 0001-x.patch, 0002-y.patch, 0003-z.patch, and 0004-w.patch, and you
> generate with "format-patch --allow-clobbering" a three-patch series,
> it would overwrite 0001 thru 0003 but will not remove 0004, so the
> end result will still be confusing.

I think a flag for this would be useful. For people that store tarballs
(or pristine-tar files) and patches in their repository, overwriting the
existing files is definitely desired.

My personal preference is that the flag be --no-clobber, but I can see
arguments for the other side as well.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--NklN7DEeGtkPCoo3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlxvPkEACgkQv1NdgR9S
9ouzpRAAhitX3pSdNbZylpghkYAwG+1FQpGE/JIP3Teh4vP1fGuBflKigq7/fsIk
R0RSBhx8mLmZh42aD08kBtT2IWa9+MzgUmunjZ68OLv2ZDWHzteu8wiyHsy9pVF0
7TGaHCWvEpj28Dct8/zte3SbH4gsk7Ptn1zRcqlTWDzceaycid3W2gQUC2BDFSqR
+iHe9gKREv9InTy7reg46EXAi3+yvUmnTgmrDciDtUk+O+IV/G+effYOSKuZ/E0W
I3kLC9+tmmE5sOEP0FjKDB/fZ+w/Dlt+xzscNS1GP+zyEFlC2x0DSF37ItwjQ+U1
KyIAEyVY2oilrLO/w+LV4pJljilpXRpUGYdbXfM/VkIDn+eHtOLSEU4ZLHTUWSPH
dsszeZZYXkk/aJlGNlgKilw/wa+X/y1GoLyUqnUU/joWWtDqP0pzWW4zRT7lZInO
CWvyHyY0wD1RKCic+Kse6VGzh5Cxsd3QR2/QrW/Bg7gP2l4QkVow518xwjwu8We6
jNeL1U6665ei5R4wbqacKpwcG4uM7XxcQ7jlu+2wYNUmCaRHlzXu6ZtH/+pfVWVL
KYKfCNaW8uqVX8p5IuerC1SWMCnNZEEUVHfzRcO7iAgopb3lowjq+195dyxaxI2w
zwgKs783oRpcU8RKdHXZCWyRtucNDs/SkIcBmhxX0emAcGDRzVU=
=XgX4
-----END PGP SIGNATURE-----

--NklN7DEeGtkPCoo3--
