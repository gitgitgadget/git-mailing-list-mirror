Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFEFD1F4B5
	for <e@80x24.org>; Sat, 16 Nov 2019 05:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbfKPF7h (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Nov 2019 00:59:37 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41646 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725830AbfKPF7g (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 16 Nov 2019 00:59:36 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A839A60FFC;
        Sat, 16 Nov 2019 05:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1573883975;
        bh=TEvsSz1KB6gG9WwVXUCMCgRsQqsxXGhI9BQ7Ra6Ra2o=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=PCq89xH5vApT9CP9LqUUL7908zE9bokNGbrVdcNtNDxbGWd+yOBxBNOkpp1ed6ns4
         xt56E46fz+4GGXyEnVs18haBRR91xNI9Eow8WTxwlbiepeBZLHkW1UHFpj7nQQTHFf
         NgkiEcPXRD5yf4OagfPGGq67F6j6kexNBKKJ9GdGMgU/edrTV/a4V7U6GEp5cEXHzV
         v+b11ZaSp14iN3rowrZmrfMAZInZY8K11GJCOjispMIp9C3dzNIafhVTFMVAUky9mg
         2+6cYDsP3Vbfup0YGz/P04tMIxMauzRXsk6O9scz0GPqttDMdPyEGOzEag4Rlhmv6v
         MGyOfcuZoerCLqv/46X1+c4j0bIcYOAlbxyWIjpwLJYRGzj9QT2susg3VUihyoEXj4
         81+EbdGfuH43s++Xsjh04iamtcWQ42IYLU2pDcUGfRypHU1osYFIQ/nPM4FtKMQ+pz
         WnT5UDUsVelZy3zprzdWrY6CLixmF873urf3naDrO0DskRpy3fT
Date:   Sat, 16 Nov 2019 05:59:29 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     git@vger.kernel.org,
        =?utf-8?B?R8OhYm9y?= Szeder <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH] coccinelle: merge twelve rules from object_id.cocci
Message-ID: <20191116055929.GB6538@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Markus Elfring <Markus.Elfring@web.de>, git@vger.kernel.org,
        =?utf-8?B?R8OhYm9y?= Szeder <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
References: <6c9962c0-67c1-e700-c145-793ce6498099@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gj572EiMnwbLXET9"
Content-Disposition: inline
In-Reply-To: <6c9962c0-67c1-e700-c145-793ce6498099@web.de>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-2-amd64)
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--gj572EiMnwbLXET9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-11-14 at 12:10:26, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 14 Nov 2019 12:48:27 +0100
>=20
> This script contained transformation rules for the semantic patch language
> which used similar code.
> Combine these rules by using five SmPL disjunctions so that the run time
> characteristics can be nicer because of common usage of a few metavariabl=
es.

This seems like a nice improvement.  It's probably quite obvious, but my
skills with Coccinelle are rather limited, so I appreciate you cleaning
this up.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--gj572EiMnwbLXET9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl3PkEAACgkQv1NdgR9S
9otVSA/+K2/inDNy8tjQ0QrpU+HB2Mu+Z+ZZgpU96u396pNoF3DsC3KqJ40Zh/5+
779iuNMizWoVtd4jZ4KcgSD/AQhla5GeQkpvJvFwBoA9XEBVr59JbzP1/UPecOjl
OFZy1mPEXVmYrbayx3Hcwo6gHJEsuMRf19GYQC3Ibm1Tb09w0UJZOSyjcLlpsB5m
NRXryc/+OBS3FAxyhr3YVZ2r3QTFIhfeWqrUW+PY3P5EMe+jsXiXOWPkxfOb25tz
dsWIt5+skGbAcZqmvXZNOIWT1EJM0MbrhB292O4tzxNkUarhzG4gB6HiftBTq241
88DNeRMTTpUDMJBsjbjPqWDvEVJPzbNNcwKiogpuqjT2E1cPBkXqrxHB6/hb2Jlg
2YBAFE6clL/p7O5pImDaeisEV/7vwGbjVk4Zi0tBt1NXuQQAnPO1E1CQIjFAi8QC
hlrdSrJ1zjSl/74+mGVCHAn6XLmu3NV8k5W0F5Uevw1lMlcZl7YlrluwnRH48gMc
rlfD9e4nwL8czNVDoVmGUaLeDWct4yACNiI4fjtu93yYHH05CRCgbj1qnJ8PG25l
Cb44kXAxg7Zo0T0/1JZwptqQ6RZLyxmaAVkTqKHxzcSSpIHuUQ1bmLhNoj1pTHRI
SJcln4GzYqZQ0aQ9o8OX5MXn2Nx1vm2UbrK+Ufuy/LQEOF29zYI=
=MM2a
-----END PGP SIGNATURE-----

--gj572EiMnwbLXET9--
