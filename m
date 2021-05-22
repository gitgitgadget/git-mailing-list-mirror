Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C220C2B9F2
	for <git@archiver.kernel.org>; Sat, 22 May 2021 18:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ABEB61175
	for <git@archiver.kernel.org>; Sat, 22 May 2021 18:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbhEVTAO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 May 2021 15:00:14 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47406 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231249AbhEVTAN (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 22 May 2021 15:00:13 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 438FD60479;
        Sat, 22 May 2021 18:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1621709928;
        bh=dzaTfSXwAjnNi3Ck2xelOgHwwVStld0n+yNbgLxR2FQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=mAWm5XJXhjEm+7bEyKIxgzLC+9iJVe0tt93gMNztY4HGqhNJoZfe3ehz1b6n7YbeD
         DXXXucWkyk9qqCnodC6LruO5MONdsOVswOtmWjTjNl5jijSUsAMD/pJC1ruWTCjHBV
         wXBqXkgq2t3P87RECQCqKfuqLUMVx1XIw6jCqqyMezvNMMAAjqoxkqROG6F2yD3ouP
         ojfPbvWZjArXHdFKhsp4ihK9Ey4IBqfoEBpUCspqY7pJe6nTmTB2n9PiSZfnVhpuO9
         GORAZX4FfOx9tHzjjqL/zsbezXNMWEEfFGQ+lej0cpmPdruvQKQJLmhgg0k3Muxmvv
         IIMN0oP7fLsGzLXATfdHwHt24fJMXMaeKE4MOLrdfLQdiI7EyVATHTxKp/VuLWEctu
         FRPjCb6boBGmAnezO9doHVDw+c+Aq1lODocckYVWy1C739ETwfaZSiWUJ5fVVOChJA
         L7uBCoE+0MHWA4lUSyounKiGkhA0gJteyWeJELGLBwWUUfcR7cO
Date:   Sat, 22 May 2021 18:58:40 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] t: use configured TAR instead of tar
Message-ID: <YKlUYKNm0V6ReJ2f@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh <congdanhqx@gmail.com>,
        git@vger.kernel.org
References: <20210522062815.17083-1-congdanhqx@gmail.com>
 <xmqqk0nrqn8q.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="peBt9AzVgYRDXoxr"
Content-Disposition: inline
In-Reply-To: <xmqqk0nrqn8q.fsf@gitster.g>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--peBt9AzVgYRDXoxr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-05-22 at 06:46:45, Junio C Hamano wrote:
> =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes:
>=20
> > Despite that tar is available everywhere, it's not required by POSIX.
> > And, we're allow users to specify which tar they want to use in Makefile
>=20
> s/we're/we/;
>=20
> > knobs, and we prefer GNU tar in autotools script.
>=20
> The last part I didn't know about---it is sad if autotools require
> use of gtar (but since use of autoconf and autotools is not required
> to build Git, I do not deeply care ;-)).

I don't believe we do require it.  macOS ships bsdtar (that is, the one
=66rom libarchive) and to the best of my knowledge, everything works fine
there.

I suspect the reason that gtar is preferred is because on some systems,
the tar(1) command is relatively incapable and doesn't support things
like POSIX tar archives or pax extensions.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--peBt9AzVgYRDXoxr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYKlUXwAKCRB8DEliiIei
gSlAAP4kXqECkcY/Gdo49PNG51rXQFFYONxf/A7OUJQnDFZYlgEAlqpJHz4lnsb4
aUdSeVEK4hyIi9uqQhi9cT8Yzqz9NgQ=
=zfrs
-----END PGP SIGNATURE-----

--peBt9AzVgYRDXoxr--
