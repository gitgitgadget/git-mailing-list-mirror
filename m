Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39A211F404
	for <e@80x24.org>; Wed, 11 Apr 2018 23:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752286AbeDKXNO (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 19:13:14 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:53064 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751797AbeDKXNN (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 11 Apr 2018 19:13:13 -0400
Received: from genre.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2CFEB6042D;
        Wed, 11 Apr 2018 23:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1523488390;
        bh=HUSetkRD2CrVE+hGJSy+eNdm3pRFGoiUgQLYWyR4orQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=s1OJbSTSdr/qaK3rGngoAjgPMq+wyHsd81uUSenTzU5XJmCuFk0DhMcsnPy6ECXYy
         kPKYJrvI7HieSysK8wu41I0RbHNnnKhMB2aalTdV7RKKiMopdcd/fs4Y2N1+v90bUK
         pBMOftbrzfhAls1qq2JwKrexGyqSrGmTvdAbhwTc/39WilcL3rfOgZC7lmLuWV+f1G
         IhcW0OMtv6tB5ghMinjeXYUa/b/sP5ar2TevPxPHdoKOTT5xi7yxMSQbOUzY5nmGpf
         jPzERFZ+GN2V2Vh8koO56DRCW9thqkkKs0ni8HnbHtwJ24Zzg8KZ+VSvHEJ1pzE309
         3YWM24a/u7i3q04BFA1AONYEKXRl/g9mZL7A2rTjfn3H6WrIws3jCbI6f83Uqh0v+B
         pRZDEpxOQRCaTH1JJJH79iFNfxysMmA3qgyMpcI4z91FoV+xUSW7BaxFeoIcSLUABR
         Lru2pwh3ORpwN7Ng+K715Krd89ouUpIKnxES9XIXRB3yctfVSSU
Date:   Wed, 11 Apr 2018 23:13:03 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, jonathantanmy@google.com,
        jrnieder@gmail.com, l.s.r@web.de, pclouds@gmail.com,
        sunshine@sunshineco.com
Subject: Re: [PATCH 0/6] Rename files to use dashes instead of underscores
Message-ID: <20180411231303.GC233862@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <sbeller@google.com>, gitster@pobox.com,
        git@vger.kernel.org, jonathantanmy@google.com, jrnieder@gmail.com,
        l.s.r@web.de, pclouds@gmail.com, sunshine@sunshineco.com
References: <xmqqbmer4vfh.fsf@gitster-ct.c.googlers.com>
 <20180410212621.259409-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nmemrqcdn5VTmUEE"
Content-Disposition: inline
In-Reply-To: <20180410212621.259409-1-sbeller@google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.16.0-rc6-amd64)
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--nmemrqcdn5VTmUEE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 10, 2018 at 02:26:15PM -0700, Stefan Beller wrote:
> This is the followup for=20
> https://public-inbox.org/git/xmqqbmer4vfh.fsf@gitster-ct.c.googlers.com/
>=20
> We have no files left with underscores in their names.

This series looked good to me.  It's a nice change.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--nmemrqcdn5VTmUEE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.5 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlrOln8ACgkQv1NdgR9S
9ouNkg/+OFbQi4Vi1rBv30x6qiMiKP5eh9k2fWQWyoJ0ud9E3HFuayCfIQpaLcnq
OoKltD/cStw6xMfJH2RJ1kgvaHiOgqXJkVdDMqv7o0ZHYOPKtzAzBgKpzwRtE5EJ
BbtQTk3wmu6n8YWJ+UJkmHCqPFB2xrJBgMEa31JrqtkyM+b3xMvEURHJw3PfiRgQ
C7WV1ut3EE7lkbKSe7wm7JMmgC/t3u8in6u2343Eu5Ev1mCCtG9NJVlIKp3+xEaX
vzbNVW5BYsEbplgADenSbGYt/U3MS5rJrKUBCS4YAVZ4IdhbKvew7WGzfzSO2Rbn
HLY3eUCFkrytNyZm4StmzqG4YRA5JrKOy8nOBwJf+c1mT9nf8BLgWDZWov+DAiF7
U/cpKCVYfPaCAkZHvF84yCnyMB9gpj6sAlagF+hbNVJomisfrLkq5toS90rZRNtF
gkwDqsuq6tmWogLlsbBG+37bTmAL3QNbn7rNVqHmy6/SjVgpVHrKuCGGa+1YjzGS
XxC9VR3jxBaQsavo9ynzUlJv6jvFBSx28bys1FDYM50rPRo1/pWqIVI2k/nJQw4b
iuhu02pHvOKd0CyrlAXnfG+Ue3p78eecyZGnmk2xxViTnmhuMwyd1x776hjXCDde
j2ZwnNCMHREElwPuhEUirSkSTu7/8OMRjlbqpV6qbg+WFLVEl2Q=
=OGxs
-----END PGP SIGNATURE-----

--nmemrqcdn5VTmUEE--
