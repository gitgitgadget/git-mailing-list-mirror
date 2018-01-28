Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A0F01F404
	for <e@80x24.org>; Sun, 28 Jan 2018 15:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751632AbeA1Pk3 (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Jan 2018 10:40:29 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58360 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751347AbeA1Pk2 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 28 Jan 2018 10:40:28 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id EBE1360FBD;
        Sun, 28 Jan 2018 15:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1517154027;
        bh=8SogA6J//Ad6v6lJvxu2EO/os1LBlTyxFsCSLwfxr0Y=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=PL6nGTTFvJW3Ba1R0YKZSIs0qdAn3ObfXZ+iyApLE6ssbEv1T5bpFKTzWiyiv4AI8
         dyn7DPMf/Tg20OSqwou9j+B40z1clHkhfokhjbuLJD52W1safBX/0dOGbsgP4pXTG+
         C23iZ3oNcFpNTDbphoZQqLIwbzaCzQfb89K52SM9EN+/pDh0a7/7zAg6bg2NIw8qyP
         bNLsgvieXe0kikdGOcbSRNtoNQqm1P5HqoyRodebnsd2re4qRII7uJua8L/NOlYvoS
         TrWMcFLQi6DanWBLFAaQ/RPK3CZy/WMFrdzJnYRdKAPINRgzVyzcNTrfOKwzt453Ar
         PYF8nLj3FP8Kfo4Aj4ZgFOxNklp6okxezIrhYn5CCcHEaSNmAshHklxi7cPS8ukEsI
         Eeagf0sbtOO5ns8Q3a5c/6g8Pi5yxxGZSzVvCoGgJo3Rq6Hng2ZVbYkd30qYvw0e/H
         l4IXuuE/nteo5W6jWdbIq9qcviLG5BSUCiYixRYnuhSrds1YFBH
Date:   Sun, 28 Jan 2018 15:40:22 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Patryk Obara <patryk.obara@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Johannes.Schindelin@gmx.de, sbeller@google.com
Subject: Re: [PATCH v2 1/1] setup: recognise extensions.objectFormat
Message-ID: <20180128154022.GG431130@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Patryk Obara <patryk.obara@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Johannes.Schindelin@gmx.de, sbeller@google.com
References: <cover.1517098675.git.patryk.obara@gmail.com>
 <e430ad029facdd6209927d352f0e7545cdd0e435.1517098675.git.patryk.obara@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ulDeV4rPMk/y39in"
Content-Disposition: inline
In-Reply-To: <e430ad029facdd6209927d352f0e7545cdd0e435.1517098675.git.patryk.obara@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-rc8-amd64)
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ulDeV4rPMk/y39in
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 28, 2018 at 01:36:17AM +0100, Patryk Obara wrote:
> This extension selects which hashing algorithm from vtable should be
> used for reading and writing objects in the object store.  At the moment
> supports only single value (sha-1).

I think you want an "it" here: "At the moment *it* supports".

> In case value of objectFormat is an unknown hashing algorithm, Git
> command will fail with following message:
>=20
>   fatal: unknown repository extensions found:
> 	  objectformat =3D <value>
>=20
> To indicate, that this specific objectFormat value is not recognised.
>=20
> The objectFormat extension is not allowed in repository marked as
> version 0 to prevent any possibility of accidentally writing a NewHash
> object in the sha-1 object store. This extension behaviour is different
> than preciousObjects extension (which is allowed in repo version 0).
>=20
> Add tests and documentation note about new extension.
>=20
> Signed-off-by: Patryk Obara <patryk.obara@gmail.com>

Other than that, the patch looks good to me.  I like that we reject
invalid values immediately.  Adding documentation is good, too.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--ulDeV4rPMk/y39in
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.4 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlpt7uUACgkQv1NdgR9S
9ovDog/+MaX9+Z31/qkJZcKWp4zKJ0cUOfQg+v2sAyFbzDa+LmPJytcVm3JhV6lF
j2fosTX5/moO3FyXzjzfaPrlMcXeqiuzzVi7swZkB6oDNQYmgucPJ5nzOINBmdaK
mm4+xPviQ5N57keso/9AdnAAeuDN5/4LhUrurod+pzPPff7UqqvS4jisxBfBddBs
+Gkmht3j1jrrvq3jPIpRsQiEitclEeQjzd7XUs8UyK9+8l3ddp+l/4fD9186bbjP
n6FBGFap1BwzWkfHYRr2onJQEPnIIUxGxZ1Kyshfb/3NR2hdCp7cLUzvOvfNhnt1
PJwjnXfpfaFnO2n8PTFPMnA8Djud3Jv0DxZ+aUpz4o2LFLDSBQynCY0YgweJqK01
vCxKvRfP/7qriRa/JRZL1hLK/3WAaR+jmQlt2a5NGCHpN4w0+mOtb/clEbknQcWe
t18tpnEqtixtbwqvgHj1wFbIVpxMnJFXXa7yHKEhCHEcHAFr32O5v9+CdP1SswdY
lQH6ZV1J+qUxTAW+69k9seorkg7gE8/wLzqQT+whkmByZYLwVZE+rLjSbvgLhGsE
D+pCXfifxy2jBDUZgI6vpatPekjm2bDvb74Y/AxPyhMvZG275E9WUy6CrrC8TFKi
6IyoK+wlzdiKYwaTWnjMqi+8etUWQVIyYn9bxvIc6czoGq3Z9UM=
=Unpm
-----END PGP SIGNATURE-----

--ulDeV4rPMk/y39in--
