Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38047200B9
	for <e@80x24.org>; Mon,  7 May 2018 02:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751925AbeEGCkt (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 22:40:49 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41424 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751831AbeEGCks (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 6 May 2018 22:40:48 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9CFF660444;
        Mon,  7 May 2018 02:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525660847;
        bh=DYy8VGAWAX/X7nLbZu5qK6uly9LXIn4ZkEVhLSmtS/I=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=glEnMLb8v5GK8ko+ZZ3VwBU/ioQO8NrXmgGApddGhZGkN0CJIxC5iloe2FowvtX6S
         5URew7kgPZs19pliYUTy2mBxa43rlDqcb34I17fnJTgFJLxqcsxjA/Ef/qvaUmycqd
         rTbiVYYN2yDVf9vU+r2QbBD1Bd6TvMYoxkhRFbYHr7yHAmuRI3Cin8M83K4df9mbEv
         HPYw6wIc55HHjj3jbVzVi9FP7QmimQJaP5zaFVp3qHftsCe/RerY53CEQMeYfd062m
         V7IgngKBN6IJNXgEab+pDrAuQ6ZJgyay0SCny6yJKF9PsjH1dNo/lG37Ed5GicKUSU
         OYyYv5gdb51ccQCmqS3Qm+lpTvShDgemmHDPBAzu/2H2z5GSHXPvFiC27gxA5O0iz7
         pHZqpsARVbJ33xjjIG3RB8GWzI+g896NLJ1YSI+gXj1ZQJmYc10RFQ1gAYhoGwSdGy
         CbhsQ0iE62lr7rv2a24IMDylNI8BX0wJtSbOaDKd32xj3/5ZhfM
Date:   Mon, 7 May 2018 02:40:42 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH 00/28] Hash-independent tests (part 2)
Message-ID: <20180507024041.GF953644@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
References: <20180506231752.975110-1-sandals@crustytoothpaste.net>
 <CAPig+cQnsdcYQnDB_bvn1p9wc9wTVAPAGZKn6_JHqnRtfAXaUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OzxllxdKGCiKxUZM"
Content-Disposition: inline
In-Reply-To: <CAPig+cQnsdcYQnDB_bvn1p9wc9wTVAPAGZKn6_JHqnRtfAXaUA@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-3-amd64)
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--OzxllxdKGCiKxUZM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 06, 2018 at 09:49:45PM -0400, Eric Sunshine wrote:
> On Sun, May 6, 2018 at 7:17 PM, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > This series introduces an SHA1 prerequisite which checks if the hash in
> > use is SHA-1, and can be used to skip the test if it is not.
> > Additionally, because NewHash will be 256-bit, I introduced aliases for
> > the test constants $_x40 and $_z40 which will be less confusing when the
> > hash isn't 40 hex characters long.  I opted to leave the old names in
> > place for the moment to prevent any potential conflicts with other
> > series and will clean up any stragglers later.
> >
> > Several tests are skipped because of SHA-1-specific dependencies: some
> > of these are core tests which test basic expected hash values, some
> > depend on colliding short names, and some depend on specially named
> > object (the pack tests).
>=20
> Was I wrong to expect this series to annotate[1] tests
>=20
>     t3404 "short SHA-1 setup"
>     t3404 "short SHA-1 collide"
>=20
> with the SHA1 prerequisite?

t3404 is in the next series.  I realize it's slightly out of order, but
I tended to fix them in roughly the order they showed up in parallel
test output, which is why it's in the next series.  There are some more
involved ones which ended up in the next series as well.

I figured reviewers would appreciate a shorter series over a longer one.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--OzxllxdKGCiKxUZM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.5 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlrvvKkACgkQv1NdgR9S
9ou22A//RRdP+6/TjS6EdbRmjjFWYNWCZ5l+FXFDQPx68gy+C1MKegc2g8/IPY24
iHcpWFN61DKZY4oEVsUV5iCIaVAQM7zxY5g1foP7Xvz8tf2diq3QJsIY0Kv+Jowe
Ok7Ejl50hwvO1b75SH/2rpbEA2CA2pQoxTZ5PBFE9AN8UrZP3FNaBsfBhUM2uZ9Y
xIoYTQ6rcHVKW6eKl7Mc6js9SENXhyMWXyXBRdIU0uYNKw3aE3QENiHNCOsxL1q2
tkkBPSufrKlymcMWDb/RI2MuvQzEncwJLK7GIJuAeNpJyWVSSd0ZOS5C17mgXJ76
62vByX7gih0q237hDaGA7lhU9fG5oaMl4WCrUnG5p7HA7ABNM7YOb5rju1lVmhwm
Unk0sU1sqoXoOZZKeFJs553LzfyufcQGDhgfXRTOHbZ8Qb/YK/TJzhhHCRINxIbR
vA9gMXGZgqIqjhRY2ZbMxQDLEz4JEvMiQi/mrI0osGCSgx2SjSJ3EOJU12yG+O8u
tgHM2A+43EhQ3wWuhkjUKcBXmbHOIbgiYjKbi6/KuxL6lx+ULplZCgcKFcOqBMi6
q/lwlVgoWdZAfuL2DJqeSw2BSaPQD9CmvlaWX5coqXMNed7/OjyPj+Hm4QnC43n8
tF8T9HGGQAuGZj441Fisi4mnVS1eaT0d9LydWxAdH0zhOxvt8iI=
=ykyJ
-----END PGP SIGNATURE-----

--OzxllxdKGCiKxUZM--
