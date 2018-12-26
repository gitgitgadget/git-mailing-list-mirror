Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C547B211B9
	for <e@80x24.org>; Wed, 26 Dec 2018 19:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbeLZTZg (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Dec 2018 14:25:36 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57986 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727258AbeLZTZg (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 26 Dec 2018 14:25:36 -0500
Received: from genre.crustytoothpaste.net (unknown [208.118.126.250])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7733C6042F;
        Wed, 26 Dec 2018 19:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1545852332;
        bh=/GLmjaeJvCQXZ+jv9oiIx5KKRXiV1ZJsrH5Ar3/NiJE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=exBZNVmvE7K4AWOcWBNrGRLhJc/hlFx5IXrrugfjZ5Kq1ZZHMm3N5n5S0iaF+xxtI
         RMn8FSJyt1oKE8Nxo3Ksoz+1+qi9TndGO762kNW+hfkSoiXXjyHnVYKHQWyknhZQIg
         QUdPhMMfPbhNMdVsZhvM7OhuxcHw+ftYbf5q+8mL2Mtwz65M+oAOLQUqxIhAxRCsdO
         vOHuTTjEpcF2jsRq9U8yIuAi5wlIdOQQK86ehwkf9Om6SsbqS4yGIAvy6a90VW5pnV
         vuMl4ie8ugR8BiQ4wVO4wCYyOHTsGOHXhphi1ngd342bL/BvKsHJycH/OIxduKBmpf
         I6i95ZRAogw4F/UkwvOpDDZ030Xd1iseqfv08M1stWPxSbsehq+YJUL328lW4pgMQ3
         VTaCy9KVI1/eg6JATt7cRL0ROqYgNg0vQR4Z6iJQMJs7ubYo9V9WgBPAiPew85kCvl
         bYaEHJyWk7uMAI/c+OihRDRm7nF2CD5yq1MDt5x6CawjK5hBZaI
Date:   Wed, 26 Dec 2018 19:25:25 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Alexandre Grigoriev <alegrigoriev@gmail.com>
Cc:     'Torsten =?utf-8?Q?B=C3=B6gershausen'?= <tboegi@web.de>,
        =?utf-8?Q?'Adri=C3=A1n?= Gimeno Balaguer' <adrigibal@gmail.com>,
        git@vger.kernel.org
Subject: Re: git-rebase is ignoring working-tree-encoding
Message-ID: <20181226192525.GB423984@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Alexandre Grigoriev <alegrigoriev@gmail.com>,
        'Torsten =?utf-8?Q?B=C3=B6gershausen'?= <tboegi@web.de>,
        =?utf-8?Q?'Adri=C3=A1n?= Gimeno Balaguer' <adrigibal@gmail.com>,
        git@vger.kernel.org
References: <CADN+U_PUfnYWb-wW6drRANv-ZaYBEk3gWHc7oJtxohA5Vc3NEg@mail.gmail.com>
 <20181104170729.GA21372@tor.lan>
 <CADN+U_MgrGHLQ5QNa-HgzxLN4zJLJPu4PaT2MTRoc18=gET+5Q@mail.gmail.com>
 <20181105181014.GA30777@tor.lan>
 <20181106201618.GA30158@tor.lan>
 <CADN+U_N345aMaiN4CT-_qsecw2gv=8-r+Hqq+CNz-xOx2KGYzg@mail.gmail.com>
 <20181108170230.GA6652@tor.lan>
 <002201d49cb5$cc554160$64ffc420$@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tjCHc7DPkfUGtrlw"
Content-Disposition: inline
In-Reply-To: <002201d49cb5$cc554160$64ffc420$@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--tjCHc7DPkfUGtrlw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 25, 2018 at 04:56:11PM -0800, Alexandre Grigoriev wrote:
> Many tools in Windows still do not understand UTF-8, although it's getting
> better. I think Windows is about the only OS where tools still require
> UTF-16 for full internationalization.
> Many tools written in C use MSVC RTL, where fopen(), unfortunately, doesn=
't
> understand UTF-16BE (though such a rudimentary program as Notepad does).
>=20
> For this reason, it's very reasonable to ask that the programming tools
> produce UTF-16 files with particular endianness, natural for the platform
> they're running on.
>=20
> The iconv programmers' boneheaded decision to always produce UTF-16BE with
> BOM for UTF-16 output doesn't make sense.
> Again, git and iconv/libiconv in Centos on x86 do the right thing and
> produce UTF-16LE with BOM in this case.

A program which claims to support "UTF-16" must support both
endiannesses, according to RFC 2781. A program writing UTF-16-LE must
not write a BOM at the beginning. I realize this is inconvenient, but
the bad behavior of some Windows programs doesn't mean that Git should
ignore interoperability with non-Windows systems using UTF-16 correctly
in favor of Windows.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--tjCHc7DPkfUGtrlw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlwj1aQACgkQv1NdgR9S
9ovMYQ/+P12zUv4cuc6BOy9hr+s2r8/agTYiu2c7L43IhYvjuiALxs/Z/TQsK5Qn
IzQnC7ORxK8KYT18JCFiG056PJe8KE7RAYAxaOXuJ8PrKg3JJJIrHxEgZ+VzXt9A
EAZbX1cXATlswE024eeVa+ipT1ZMIfY/XuJjGjFOHrTV5zlobc5DFJ8dFfoXIBN+
nv+ri1lv7L/tA7+qxltZJ68iiy4D81nZPx2KyR8Ywb9rgR7xsXY5NJGt+k8LS3ft
cHSR7gqmdb3E2DHOHAH25Jm1mEzyGwFMpDxNar+rgBI75IFQ3g2PBB8HXhOgt4ny
E7Y9VE8xo0wxD0ObEDTA3yt1RxrT16V6naGQx9UfWiHWbXpbI7KUIewV8a2PjtYA
ICWl2t0OjN46t5Ksh31mHCGo0NVSqGKiA2MHp7sJDeUSTmVXfTiJA/d8sOF+CyyB
VxP02/PW8qhw/AljdYl9cIuVK/I3NXWmHJzhDyacNF3cZMZw+1Cp84mjI1/MYVm1
Cvg8FPLUfEVveyz6swOXH1+gDlQrDy9Lq6OGOk2MWdi/pKfWo2Yr/i5CqPIB56oV
ppPieRd+pWGgdLn6i9Oosi/FNI6iJVhVzDqMxCELB8kzC2LwNMPVpPucfRCIVOiC
xgZzReWIXYRQ9atATTlZQ9OAKQYPkD2xfWo+pFSoBZsTdpzXYAM=
=OFMZ
-----END PGP SIGNATURE-----

--tjCHc7DPkfUGtrlw--
