Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 884DE1F731
	for <e@80x24.org>; Tue,  6 Aug 2019 19:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbfHFTTS (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Aug 2019 15:19:18 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:53726 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbfHFTTS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Aug 2019 15:19:18 -0400
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by smtp.gentoo.org (Postfix) with ESMTPS id 7E6EE349957
        for <git@vger.kernel.org>; Tue,  6 Aug 2019 19:19:17 +0000 (UTC)
Received: (qmail 27516 invoked by uid 10000); 6 Aug 2019 19:19:11 -0000
Date:   Tue, 6 Aug 2019 19:19:11 +0000
From:   "Robin H. Johnson" <robbat2@gentoo.org>
To:     Git Mailing List <git@vger.kernel.org>
Subject: Feature-request: git-bundle --quiet
Message-ID: <robbat2-20190806T191156-796782357Z@orbis-terrarum.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="o9w4P0ZCTVHZJ0iX"
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--o9w4P0ZCTVHZJ0iX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I started trying to make a stab at implementing this, but the code
wasn't standing out for it. Hopefully somebody else has poked at it
before:

I'd like to have a --quiet option for git-bundle, such that only errors
are sent to stderr, and not the packing progress.

This is towards a better incremental backup of large Git repos, later
steps would be easier selection of ranges (writing out markers e.g. to
use in the next day's incremental backup), and more fine-grained control
of the bundle repack behavior (e.g. don't try hard to repack, backup
speed is important)

--=20
Robin Hugh Johnson
Gentoo Linux: Dev, Infra Lead, Foundation Treasurer
E-Mail   : robbat2@gentoo.org
GnuPG FP : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
GnuPG FP : 7D0B3CEB E9B85B1F 825BCECF EE05E6F6 A48F6136

--o9w4P0ZCTVHZJ0iX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iQKTBAABCgB9FiEEveu2pS8Vb98xaNkRGTlfI8WIJsQFAl1J0q1fFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldEJE
RUJCNkE1MkYxNTZGREYzMTY4RDkxMTE5Mzk1RjIzQzU4ODI2QzQACgkQGTlfI8WI
JsQfXg/+Ljf3WI9Zy96otoQnFHxkG04TPxCLtqRbwt67vswhJ0x2RTmDkgwQRpsE
zU0CwILlfa9DIwXT3BgUdwu3ZkdE79TO4BKg87zG7ckNYk6MURb2pz5eIyG1Rt5Z
U4dlUmLPd8pQXuHV9wkpQgsT6y0eRJQNkbUSsx++qLy1nuTgMct7opWxuguWmzH2
LH8lXw170M0xbSunWiyboCJw49fQPFjP0bUAoWABR6L5XyWUjURapFUSbr4nbrPD
D8Z/CV8ol7opdVsIMBS5fPWw/DlaPLadUJVXmieu1/TdQgnQ0p80FqS2AaMZ+3dF
iYLuJ+uxF3X1MuuPsWBRLrbpgoug1Q8ykBnSkfFhm0NS2z2qkj782j5zdfOlH6CC
BYkRcRROFVmoKQh0J5PSdxv5esOhwGXBHVMIY5dRzRZRA0sDpgqViNDMzkfnIhJC
vyGiIeMWK5JyPUB0nRMrdeE8m5a1Bu7841HtzqwnZUTSITUP89hOImD1hdFNTZYI
+UAlkrPlfx8IVN2E3P87w7nRnbu40slPo6tFGcPA4he0LzAHN0mpfywyPaP+EH5i
PhxDCcnZdvjPYNJb1XGGxR4bR10IM0JHfIEeodfl+LaUGfr8uycdFkIJvG+ejHJ8
ChcpuURkoG/NfsuDIj25P9gMy9FwvojWY6SYiJ2X7ha/5x2Ti3I=
=360N
-----END PGP SIGNATURE-----

--o9w4P0ZCTVHZJ0iX--
