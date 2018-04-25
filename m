Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA0301F424
	for <e@80x24.org>; Wed, 25 Apr 2018 01:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750862AbeDYB35 (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 21:29:57 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33268 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750779AbeDYB34 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 24 Apr 2018 21:29:56 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5976060129;
        Wed, 25 Apr 2018 01:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1524619795;
        bh=B9QDRMp/WHuBzRgyXdg4CoqUc/dALsmPHsLIH3JX/MQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=RZCO61FDRybDoMElYfbk+zRKuqrQXI4bEy0pwBNi1BrJQKPwPZj3XSz7Ar01Mxa29
         t7n1NYS5TnEcuXnWs3g8jpLtxu0wvnJjC1cdy3RxEJzjfL4OD3FOp+wLUglCKp1fG/
         b9NDPihoGMd9S24L4FSFvA1NPTIMpqzFBxQmZXzc5h7dd3ri3behaDUCyGK5xJ/7fr
         09CbYNjVlOfRmxhq9Iq5bCeSZf4qR6Sz/JfOyiGh/lfYBy8dRJs1j4NJTR6/DrFAul
         eyvWRknfig7KQwvNnG7dhgAGFBwdixmrXZmiwE17746qowq2yzzLPnaQLwdBRjfo2Y
         km1I8LDgh73Z54oBZB+D97n3YD6Ge/wMuA1x5Y39hqKaBNKdkyzcrQo83LIKz7sqZs
         ALJfo5qfzEjnMx5a75E73emAoQNKN8WOLQgeeXTQMgQZ+jQqCy1lEPJvkZ0BbAKN5Y
         O1e9scjqESFFtBrbf1o4CGKcBvPEkgMTCGbiqa7JUwL3928cCQt
Date:   Wed, 25 Apr 2018 01:29:50 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 21/41] http: eliminate hard-coded constants
Message-ID: <20180425012949.GE245996@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <20180423233951.276447-1-sandals@crustytoothpaste.net>
 <20180423233951.276447-22-sandals@crustytoothpaste.net>
 <CAN0heSoCsFYqDmwTRCzh2FGDnOghBqVBTCOa7yEw0jtQ3LxDbA@mail.gmail.com>
 <xmqqpo2o5fvw.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Dzs2zDY0zgkG72+7"
Content-Disposition: inline
In-Reply-To: <xmqqpo2o5fvw.fsf@gitster-ct.c.googlers.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.16.0-trunk-amd64)
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Dzs2zDY0zgkG72+7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 25, 2018 at 08:44:19AM +0900, Junio C Hamano wrote:
> Martin =C3=85gren <martin.agren@gmail.com> writes:
>=20
> >>                 switch (data[i]) {
> >>                 case 'P':
> >>                         i++;
> >> -                       if (i + 52 <=3D buf.len &&
> >> +                       if (i + hexsz + 12 <=3D buf.len &&
> >>                             starts_with(data + i, " pack-") &&
> >> -                           starts_with(data + i + 46, ".pack\n")) {
> >> -                               get_sha1_hex(data + i + 6, sha1);
> >> -                               fetch_and_setup_pack_index(packs_head,=
 sha1,
> >> +                           starts_with(data + i + hexsz + 6, ".pack\n=
")) {
> >> +                               get_sha1_hex(data + i + 6, hash);
> >> +                               fetch_and_setup_pack_index(packs_head,=
 hash,
> >>                                                       base_url);
> >>                                 i +=3D 51;
> >
> > s/51/hexsz + 11/ ?
>=20
> Quite right.

Good point.  Will fix.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--Dzs2zDY0zgkG72+7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.5 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlrf2g0ACgkQv1NdgR9S
9ose5Q/7BqUwfhlxvo7zmtD1Ot/mq1yFmvIzkW5ZTQkTN5AiSl4IdZCx3f0mUmXH
DO5PofNPAa51wKDJJ3YeIoewVYHieqWsCtZ7luzJJFpMRhxZ+WtKkrkXHjeh3qbo
YMhNGmp3QKOLJ5oPNMSwcoOp6o2qUPX3TRzMwASm1cwyljE+R65CRjfq3OR6c3A4
1Nd5FO7llmUOa1zfLdrCGMYCTz9LnB5gdNjz7byXKofWnwrBJ+W55DldayCbxHRX
0NYSHMOk8bNMDoUGkSajHoY4QK19Ejjwv00wngEEnmZZ3WbdK8sD+mFFQ8q1HFIi
ReDuXLaRKOUS/NTrPe8bUOav1WlKNIGwpvX9It2lJjIHNxBpbCKHeI1A7wCQiuRE
ZKg11vdei+QRSRZnBDxHyo3vsQ5pHys1o7DmijBfj0pvHZwW2s+uhV+QXB1n6stD
Cfiz5AfC9ilj1nwYAV1JhkzISaxffauOqgW/tDQzLBiG7AOovOWazV6E/VHhHZRv
VKT9dmVBZYHPTd2K/r/JZS49qVH0iQNtLUsLsCW0fAtU+v9mLBPBoYt1xX6Hycsd
RA58YJQlkXmVhZVmmMOcotAH+NELjbD3Xn1UvPyzxJMHlmC1aTK+XI/DDv7MjXDl
IdHjpSTfN6iLbGAKHEQvwLKCKtRaPQ0orA0hpGAKnq7iCOkIds0=
=qEf9
-----END PGP SIGNATURE-----

--Dzs2zDY0zgkG72+7--
