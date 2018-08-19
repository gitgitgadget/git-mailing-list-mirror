Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC05E1F954
	for <e@80x24.org>; Sun, 19 Aug 2018 21:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbeHTBGV (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Aug 2018 21:06:21 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55330 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726171AbeHTBGV (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 19 Aug 2018 21:06:21 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:1024:89fd:c4a5:84be])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 761C06047A;
        Sun, 19 Aug 2018 21:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1534715602;
        bh=/7gop5oBS4WO3AzlVLWkRVuqucmdq/b+W9E40BW189c=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=yX1ucQGFY+YV4Fqq7cxhw3VIouqGelbSc6D+nKWGglAHL2WxFcM530xyPl4cp0QIG
         0aiBUxWB3iWYHMObUIbx6J5ZuMYmyLn1FfT3AHo+kh83rombDOvTBu2n0EsjezYdHA
         19QNJhl0eYeySzsqw6QgCOOPmgTBL1gizltfLvFoML4vB/JzSQ8dR2tsjT9NL8Vd0E
         edwN2JbcmFQ6lFHup3JGArrmVa8V16fDgyOyn/ciA1G1B6J+6LXUzKbGtYUPZ6ev/Y
         xgjc40TDeyojMIIgaYvmswsjbvt2jIiHMz4yaGzfMNU5R4TddtD1z9bt4w2q7waRoO
         LngOVw9RclLdepKfgCIY1d4NvjPAQG0fJOKIOS8yJQcV60KheNBDeHto8OVQfpaW67
         BGmASkAgEI9MSzKy8v7qVhbBgeZRyqYAz7JvGuWOteTJzYt5Q/g5u5345hdHzq+1vf
         Of2seTJLx79SSUjSzmbfx7QSFqUXCH1UngQRCuU75qjIlmsHyHj
Date:   Sun, 19 Aug 2018 21:53:18 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v2 03/11] t0000: update tests for SHA-256
Message-ID: <20180819215318.GI70480@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
References: <20180819175351.449973-1-sandals@crustytoothpaste.net>
 <20180819175351.449973-4-sandals@crustytoothpaste.net>
 <CAPig+cSRYZ6X-71oZ473g_pChcfNcFyFPO3e8YoJmYyg+KwoyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CxDuMX1Cv2n9FQfo"
Content-Disposition: inline
In-Reply-To: <CAPig+cSRYZ6X-71oZ473g_pChcfNcFyFPO3e8YoJmYyg+KwoyQ@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--CxDuMX1Cv2n9FQfo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 19, 2018 at 04:01:05PM -0400, Eric Sunshine wrote:
> On Sun, Aug 19, 2018 at 1:54 PM brian m. carlson
> > diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
> > @@ -868,8 +870,9 @@ test_expect_success 'writing tree out with git writ=
e-tree' '
> > +test_expect_success 'validate object ID of a known tree' '
> > +echo $tree &&
>=20
> Debugging gunk?

Yup.  Will fix both.

> > +       test "$tree" =3D $(test_oid simpletree)
>=20
> If test_oid() fails to find key "simpletree", this expression will be
> invalid. Therefore, it probably would be a good idea to quote the
> $(test_oid ...) invocation.

Good idea.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--CxDuMX1Cv2n9FQfo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.9 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlt55s4ACgkQv1NdgR9S
9osx6Q/9FQyc8grArZR6FO7h6hxhne1wh2jTozmsVNHpJzYBb07p9q0MfvueZR1r
33yEkwaEbo9xCWN0VRK4rBAg22S81FkHki3JE8P65rIIXBU2Hq/NUnkweeLgY0I/
GR2KgpjAb/yQqUnZGmakF8noeWpl6TUOJw51WytFWxmNs5uhxvHNnhYJQs3M5rWv
dZPJzVfOx8DN+zT/RXLUNLR/fxfE8mkYlwOAt8tYgrmnAiuNOzGAR0+iykPOiy5C
FcUIgGFGB3jWRvG09p+b7B8ydyr+f0fZnQaQL6UrCZV16khds+RviBzhcKMetD/P
adaiZVVjQgO6vgclRibqy+4NMGolDB6i6nBPR/j29Dde/pKyQcpfr73YyyOgz+9f
bcPYSMrcZJwPRs4QQWWFCes6Z8BxE6l4zgb+xkm9S7yYPvvTO0NBTlpiVjty9YRA
VcxnXtRUI8+XhpI/GvCb4aECpnNjb7ey6BYSVyrJaBbbdsOJyI8P4y2gCh3Bi4Qh
XcOHygdHCWM5mP9znnIXGaEGNfzhgm5h0u1bgzr9el0Cva11p6hQmkqiBEO6lnlC
sGvv+K1+Cgd5cUSXKJL93DT8lGORMUXd6A1rycd17o17wDb7fxeIXARFCQf5k0Yz
HRJBYthRMKo9MakNcZeGMbTy72ni8Zl3+sw+Wu2QhF+pHb+C/xw=
=ctwP
-----END PGP SIGNATURE-----

--CxDuMX1Cv2n9FQfo--
