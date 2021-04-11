Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066AAC433B4
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 21:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A51176102A
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 21:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235320AbhDKVH5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Apr 2021 17:07:57 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:59402 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235005AbhDKVH4 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 11 Apr 2021 17:07:56 -0400
Received: from camp.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 10C056041F;
        Sun, 11 Apr 2021 21:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1618175258;
        bh=pHarPjE31Ibe5D0qKkTaDxyxPVO4g0vcSAHt62AysJA=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=HW6xhrwnrgfrPKZGzLfzt2G1OINw5G1bN/Z1us5hYZoNAdvGgWJbkx2C4UKRdXG8C
         BzSDFUhEvCqgbxtSnSlzuhfKxRjldY1lk8uUgVOAv+CrriVOnG72jcTb/5zWKgRLgQ
         iylk+V6Gv2nXbxD/Ryo8/CAxEFw4gElpX+KHrXIBGF9tr0y8JxN76n0eyY7Zf7LCC1
         eJFbq+5RyXT2FmjbQmpFnwlWDLbG+f2RHlUWsJ8FVsw4tkpDqFZn3lEDiX/j/xek9a
         IeHjvG75kxa14TR6YUL46jpWY3cGbIzTeQyXUUtqmaTc2OzgEUsD09zx/pP86m+3+w
         PlyiNDPosZdGzy/8a5oWAC9KTrMQ8Mj9bYZAKDZdPjfe9juMWdkV7dI6PWOaO3oYaJ
         DSX6N1oUzBHl1/fucoFOS/OmWOUy/TQjfBeoN6VG1uIMYBYV5sm8Mb5iMAIUFzOjc3
         XJRvUwNyrWC1/BUG2dHy5B7q8KW+uBwS1qRjGHSPEIL+lIoGJVm
Date:   Sun, 11 Apr 2021 21:07:34 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 02/15] builtin/hash-object: allow literally hashing with
 a given algorithm
Message-ID: <YHNlFmpQa3Qlgh9g@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
References: <20210410152140.3525040-1-sandals@crustytoothpaste.net>
 <20210410152140.3525040-3-sandals@crustytoothpaste.net>
 <87sg3xfbkd.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jzRZZLm4oRPWgApj"
Content-Disposition: inline
In-Reply-To: <87sg3xfbkd.fsf@evledraar.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--jzRZZLm4oRPWgApj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-04-11 at 08:52:02, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>=20
> On Sat, Apr 10 2021, brian m. carlson wrote:
>=20
> > +	algo =3D the_hash_algo;
> > +	if (object_format) {
> > +		if (flags & HASH_WRITE_OBJECT)
> > +			errstr =3D "Can't use -w with --object-format";
> > +		else {
> > +			int id =3D hash_algo_by_name(object_format);
> > +			if (id =3D=3D GIT_HASH_UNKNOWN)
> > +				errstr =3D "Unknown object format";
>=20
> An established pattern, but shouldn't these be N_()'d while we're at it?
> At least for new strings.

Sure, I can do that.

> > +			else
> > +				algo =3D &hash_algos[id];
> > +		}
> > +	}
>=20
> Style nit: if .. {} else {} not if .. else {}.

Will fix.

> > +test_expect_success '--literally with --object-format' '
> > +	test $(test_oid --hash=3Dsha1 hello) =3D $(git hash-object -t blob --=
literally --object-format=3Dsha1 hello) &&
> > +	test $(test_oid --hash=3Dsha256 hello) =3D $(git hash-object -t blob =
--literally --object-format=3Dsha256 hello)
> > +'
>=20
> This would be more readable and easier to debug with 4x tempfiles and 2x
> test_cmp.

Okay, I can go for that.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--jzRZZLm4oRPWgApj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYHNlFgAKCRB8DEliiIei
gfOnAQDxCYce8WGLJC/yOtPy+NuNMcClFJaxK/U7wHz9o0DEpAEA0fW4VqLlFX1S
HOqFQAe0ZtaHvAEHVf61SoGn2o0wlAI=
=3rS4
-----END PGP SIGNATURE-----

--jzRZZLm4oRPWgApj--
