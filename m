Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF63C1F424
	for <e@80x24.org>; Tue, 24 Apr 2018 01:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932769AbeDXBDu (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 21:03:50 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60866 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932662AbeDXBDr (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 23 Apr 2018 21:03:47 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 694F860400;
        Tue, 24 Apr 2018 01:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1524531824;
        bh=gMyLjpcE/mYHv/7KjIN6/HVpADtf24bk/GafhSzn0UQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=h6AdtBHTUEUD3g537y9LB9gfCFg5+ZdutYEVgnYV6AtIzhAG6MYft69B9A1ktBviH
         +KRH+ux4R6Qmk63jbbcEEEvFWBZi1WsDHtm1zBUfDiGIIiuUcmNzEevQOP28G0AN2d
         3mvgok66QOfv/iPikJ741kd8clYIag4pBQojvN18upKv91mjUwDPm40zFYN+YPDovl
         /vYhrFYuLpk46HREIUZluUGC1aUm8Ohc9WEXdYUEKMGTk0gXdAEc5LZ6s9mTONbsYz
         CsMqAIDe2dHtSTGBLCQYQgwNHiH/e6oejJkOEMan3jqYYxw9fejsVg2ewy5agi3WUV
         HnPsV18MAj31DfpaxOaYPF1+VNVXl+I10t8sJhoGOVuwnV9Ft6V9GVlFyXkOk8l5+S
         vcrAVX3qS/KZk/ipuMjJw5XKmftM0mDqQe0LEXMDnaQxG8s2mwVD1pvlVNyPP7JN2Z
         EtS/WH9TO1X5RfC8zi0biTq4PH0UiobKhe65AyjaxG3L6tlhyvy
Date:   Tue, 24 Apr 2018 01:03:39 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 41/41] merge-one-file: compute empty blob object ID
Message-ID: <20180424010339.GC245996@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <20180423233951.276447-1-sandals@crustytoothpaste.net>
 <20180423233951.276447-42-sandals@crustytoothpaste.net>
 <20180424010055.13183-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0lnxQi9hkpPO77W3"
Content-Disposition: inline
In-Reply-To: <20180424010055.13183-1-szeder.dev@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.16.0-trunk-amd64)
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--0lnxQi9hkpPO77W3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 24, 2018 at 03:00:55AM +0200, SZEDER G=C3=A1bor wrote:
> > This script hard-codes the object ID of the empty tree.  To avoid any
>=20
> s/tree/blob/
>=20
> > problems when changing hashes, compute this value by calling git
> > hash-object.
>=20
> Missing signoff.

Thanks, will fix.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--0lnxQi9hkpPO77W3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.5 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlregmoACgkQv1NdgR9S
9ovx6g/+KIC7eRXfRagYfmlGEU+NFRx9XiOCYAGi2hxthki7lxHUA/KtF2rZcqih
yiltbx3/lU7J4ki6hilID5FLlVMLmRpod6zDmUEGsxENvgeLIhGko0SkMS6vQ9wF
cnmE5MdjVVsXJ/Hy8xEnTvBUxpqSCeEHrd5BZfG0yu231GC7vFmI+LW6dub/tOgd
5NmA4Gm1TGMxnhb0yACi01Em34VrR9gnwqoovENg6gee1nWr5Ing3GU4/0mrxfDM
BiTJ5eG8NU67oED9VR6saFc4wbSQ1sln4DTd4cDd2o5kXWAR4k5+Fm1t9Y+nemmI
bC1euEe1kYGa67QfH23rQxC3wDw45KPLTj+ie9KpP03Xq0o0XQevMJ36iR+I2WmU
ffXMt0GaoIs1fVe89SN2gKQUqc6lredICbgPMufP6beE2Bnol6Ban19Yj0utcnYi
Bvwh5Lns/4WBZXtuPKObPR4+xO1bmv3CF1J1P81aBwMsDQoywPG2OZvDb5x5CbCG
ZE13SQ5gCbvHcvwpzruSuvIMdjz/EXdPe5Hd2irH0d2W9rbI3k9QujxE49gALpPy
e7QveL6VpJX7hGmsMTnRNwSKQfrBqSg3ytg1nCmvq/vnpxoIkEqu+2ofHNcShOdE
5W+l/AcrHgXMJIdrgFdkNvnkWWw23NJ5jGI1H3KB9q88tBXCxic=
=qn8j
-----END PGP SIGNATURE-----

--0lnxQi9hkpPO77W3--
