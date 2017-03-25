Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C98720966
	for <e@80x24.org>; Sat, 25 Mar 2017 21:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751147AbdCYVxh (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Mar 2017 17:53:37 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:57814 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751042AbdCYVxh (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 25 Mar 2017 17:53:37 -0400
Received: from genre.crustytoothpaste.net (unknown [172.16.2.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id D1BB0280AD;
        Sat, 25 Mar 2017 21:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1490478271;
        bh=98Vc4TxjR2IKMEs+WIrV73gnangN8T+KKENaYWI3/L4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T9zldW66cpbAbm2ml1488RRDRJ7ChdlK3KnhHeQPZJz4hhaJ4Xi6yYjklMhrrXlAk
         j2T8cZ0BnDhdV5RoHm0EdPZ1IXnM5d7HSeFYtA5fiFSQiWvaB25wkSyLvK0gIq9w3X
         y1eMwEBH8SeFL2F2T+ci9VlHOjVlfaD+3WHR6BnDjjRebR8D5W9xwi56mtgfrENB1w
         G1g66ZjirYXPaG0nfrLN8o9qxkd+oeG8t1U088S/myOBaKeUlir1pqGbCm1Kur26ye
         ynt+XHSzY3smqWhvC3rFesCuOkfTsjd3D2heTQt1VyGPGdlv64RwkOzcn84I/k9bzu
         +F8UdQ8lqu1zqg1/m0bRxB5VW2FyfIGZ2T1JpFNlDiU+9JSDeFy5USPTKGBeE1L57y
         +IsaouOH8ffKgXgywpluN7GzSt/hMNmcr+4ZNbTqkMVUf1bEN3QsfDNbyv5UUloX3D
         ytGIT8DtIGjhp8xLbpxET08YGWmP094OdcXJblvQi3g3fmDvo3m
Date:   Sat, 25 Mar 2017 21:44:27 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Will OpenSSL's license change impact us?
Message-ID: <20170325214427.f3kdxgrldpnar4ag@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <CACBZZX6F47uC9jLxppgkUnwVpGV2jpzzP4kwTuqKgayCevomeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mss5ml6w37atudxb"
Content-Disposition: inline
In-Reply-To: <CACBZZX6F47uC9jLxppgkUnwVpGV2jpzzP4kwTuqKgayCevomeA@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-2-amd64)
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--mss5ml6w37atudxb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 25, 2017 at 12:51:52AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bjar=
mason wrote:
> They're changing their license[1] to Apache 2 which unlike the current
> fuzzy compatibility with the current license[2] is explicitly
> incompatible with GPLv2[3].
>=20
> We use OpenSSL for SHA1 by default unless NO_OPENSSL=3DYesPlease.
>=20
> This still hasn't happened, but given the lifetime of git versions
> packaged up by distros knowing sooner than later if this is going to
> be a practical problem would be good.
>=20
> If so perhaps we could copy the relevant subset of the code int our
> tree, or libressl's, or improve block-sha1.

I think that most distros don't link against OpenSSL because they can't
take advantage of the system library exception.  I don't think that's
going to change.

If we want to consider performance-related concerns, I think the easier
solution is using Nettle, which is LGPL 2.1.  Considering that the
current opinions for a new hash function are moving in the direction of
SHA-3, which Nettle has, but OpenSSL does not, I think that might be a
better decision overall.  It was certainly the implementation I would
use if I were to implement it.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--mss5ml6w37atudxb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.18 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAljW5LsACgkQv1NdgR9S
9otTCRAAih+OPF8qcUv4Vwo2JFQt+Yp6HXzwYuEYIN4E/c6q4Sf1l8MCcHTwruUZ
OfWEJxDfIQPKb8pRToO9iimqAdcmT2jlXIBQ4XTiRTKfz/OE5IOIM1pxAeb5Oy8p
1fywvBaBF6arfpd/QMHCn8i0U7K7YN5AWUaaA17bVCMa14BiZum9tEI2KUyUf1Pn
Bam3OHpBNq0LvIcaivDgKHgiZ3Wlkp6Qpb9a/IPeHUC0v3Ved4b/5QjVeoxCPKvK
fU5UoErmFjiW0GfR5QrT+J1TgOTSEYB23VHZP1+Qc1fuWYFBBciZCW4MRV8ZagIq
CG6FKgnvgNKJVkDXL0soGfP5a1swtHCvUF0XZRaAOeVUezBQ3z7bAlTvHguK/Yow
Hdn3uQEzxFMa5t6OkNVdo2QXBDlwmxW09LSn/aNCLk68Asy5ODPPhEHf+e+PhRjM
2qHhEKE/MIZvU6UEG2AvI6rlSUI4YLW4jvJDx55bvVO6RgAtmG28B5we8WiG3yqb
ZfXmrOzyxUy/a2ypFHM3PN4Kutiqn/crZu9yrDrjt6PZIj+HGGKPIvUQSoLxpAGe
VO9AOy87oqVCLur9fZOga5Gop/8VvIkOKnaAczuQDvYhKVVYlsEdrsI9sSfJIXfG
sYt79OP/QWDWXa/xjIgLTPu2KPOcnR4Pw4IDOZXZdg3XU9vuPAk=
=a+0G
-----END PGP SIGNATURE-----

--mss5ml6w37atudxb--
