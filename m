Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41C831F404
	for <e@80x24.org>; Wed, 21 Mar 2018 19:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753039AbeCUTjm (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 15:39:42 -0400
Received: from mout.gmx.net ([212.227.15.15]:48533 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752886AbeCUTjl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 15:39:41 -0400
Received: from [192.168.178.24] ([78.52.211.58]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M8m7Q-1etCjP1sce-00CE4e for
 <git@vger.kernel.org>; Wed, 21 Mar 2018 20:39:39 +0100
To:     git@vger.kernel.org
From:   =?UTF-8?Q?Toralf_F=c3=b6rster?= <toralf.foerster@gmx.de>
Subject: gitk takes a looong time for a subdir of the Gentoo repository
Message-ID: <d0ec090f-4fd4-09f8-ab3f-b95b91cee99f@gmx.de>
Date:   Wed, 21 Mar 2018 20:39:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="45oJCAkIdPqNnWPoed3ufogpxDOzgubcz"
X-Provags-ID: V03:K0:OzjlRRkpVnDYaRp9YhEo1E9YpbczEfcbNT/0mafycsl5CEyOvdy
 W3ulcX0WGDQcDIv3JQVbaXssBCXvZ+/NdUPfC27Fy+OAkj+atEjj3gi3BzJi2g4IPfGhJPa
 21QlT+tGxPHt4SaZblUn2pmwnjOiOIrLv/F+Tq7CV93Ra8IdIcFNXsjHbnHuD1qzWwmVqUQ
 b7mA1XdmoPQ7DhV6iR19A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OQzD6UbPl6c=:WsNOO5yue0glfuiED3CgkG
 UvW82FLKZSKQzpjRdP+8h8lcKu6NxRGCx0Ba2AnKM2LFYi5oBAC1ndtksLjOYTY/OdLn+JKLM
 1Zn/BpXwzLgYhEKagdb85/M4IsVvRP9llEXrU9jFQOWKFSMjDEbrXMkWdKTrqnsP0sCxbJrFW
 WNJiv7ZNvVmRDq2BouA8x+4x2blxOBlZ8SK8mK44aMLuRI77uNb3kzeuwZg4fLVJfCsTEBdR4
 F7f1s9TqF07Eyx0kaJl7k7cOeJxSXLkxCCFswRJKwYTgfS5lkt+HmxO9vpOyAFC+RicyfxCAD
 HElpDwuaHpwuvoIzPk6nXDTVRICvgtJDjNgrKKi05fY9jpZOuP5riWdUuh6zQncdkqCX3haDq
 oHEv/KE1dD+Dv11x39B/kAGw0p3pASl3KXDxyQzv+cfHGxYIu63J44mp2ifoooa0jxG5TkEjV
 YyOX9cXkYD37smIwIwVJkvnnLg5Ufp6G4GvmwlW4Gc9yc7xLNg4pLNkZEZawD6zGYTNRxOYdh
 QKcDoWOFfej6HV1PLljJydiA+tybUQML1oaM3mCO5miwCEfW3dxQJeafDpmL2LXMXnYJc+jC2
 oh0iBWryI4oTUEzNfnw8SVZ5Lt4MOYYIxKZehvBV12GP5EDZA7OmD2KV+sRIjQrCDsL9Q8a+C
 4mHoGQRqXfLLfxSqhIxX5mfM4Vo8MuTcZuAiyBOq6ha+TahE8H2yDnYG+MyAI7Ib01Tbg9Dqs
 qCI+SenXhGZCSWH9NrERpmh8MmeuE+KmR0CEfvEsX9U/YqvtoS81mKlXVAKUM+VolFwQf4NmC
 Qh9cH3Wedj3Sc6dXeRia+p4j67owQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--45oJCAkIdPqNnWPoed3ufogpxDOzgubcz
Content-Type: multipart/mixed; boundary="uxUoAeIpss4We0Qcu5ZErRLoI4X6DbasB";
 protected-headers="v1"
From: =?UTF-8?Q?Toralf_F=c3=b6rster?= <toralf.foerster@gmx.de>
To: git@vger.kernel.org
Message-ID: <d0ec090f-4fd4-09f8-ab3f-b95b91cee99f@gmx.de>
Subject: gitk takes a looong time for a subdir of the Gentoo repository

--uxUoAeIpss4We0Qcu5ZErRLoI4X6DbasB
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

steps to reproduce:

$> git clone  git://git.gentoo.org/repo/gentoo.git
$> cd gentoo
$> gitk  sys-apps/portage-mgorny

For few minutes I do just read here : "Reading commits..."

--=20
Toralf
PGP C4EACDDE 0076E94E


--uxUoAeIpss4We0Qcu5ZErRLoI4X6DbasB--

--45oJCAkIdPqNnWPoed3ufogpxDOzgubcz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEAREIAB0WIQQaN2+ZSp0CbxPiTc/E6s3eAHbpTgUCWrK0+gAKCRDE6s3eAHbp
TjsEAP9HvoOOoL8z5iPdMlH+/ekN4Py9hVWgqWnTbywemQ9dNwD9EVbPQ8sHXK2C
rfQGBhpHaFPacCLrwjFO9L71k/IP6xI=
=hhmz
-----END PGP SIGNATURE-----

--45oJCAkIdPqNnWPoed3ufogpxDOzgubcz--
