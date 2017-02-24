Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB5D1201A9
	for <e@80x24.org>; Fri, 24 Feb 2017 19:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751392AbdBXTYz (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 14:24:55 -0500
Received: from ipsumj.de ([109.75.177.107]:55528 "EHLO ipsumj.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751275AbdBXTYz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 14:24:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ipsumj.de; s=js1;
        h=Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject; bh=IEb8e8aObkOfl5LKC80w0VAU9jJtloIyXkTsvI53W/M=;
        b=F70fdmeESou8ZrugIwUXQVO1Us26lXp4vIXrBSpY+P/mLRlC/GJsWTSATGtao2tRoB0Owhqq1xBH7sNzHX7TOg0Yj3VHGhS5Qvhpd/2eMOazchd5uhGSCgUyu78a3F/RtAprHzQKPKj0O5sXyKk932ur7yOkeNdU7IbxGIlHxp/vasDy4VLFBJBaFkrRlNyN8FFAM9qwCf13w6HtEBncCeA9vTyyi7lQtgeOTM6gfYom9ZSVyIv5DT1noXjXmBBRtdYcxx242jSYAyIrW+zdu3bMFVH6fmpE60OfE4NQo+c69cNvMNwJ/8d109ZPlVzw7y8pKVrT5tbRmR9LBVMYNFJ6Kx49jgrh29YrsgzRCB9gb3LMzvX6/5j5d5Pxmwlb5aV95KLQLivD38dup0GqyTOq2GBGHuGRhWz7sJHnouSBLcoFqdBapb6mKry9VtXxmUH/l62OBCdggYnX20/nFhlUAqkJglMJ4fpW5vyXccuatG4TmRyYCC17phXN1N3oQyLHX7LGrog5dozM6eCl1sgxrXhoZXuLvvO0/VhpygkSPXjMWq+w/fl8x3eXKMkKPYk1IjgX0CXL12IVFv3wif42APKuYyfW7UTk8DtcfsV9V1PbjbZIm/1c80wUIn43lEOju/otCxKKw2Sxupk2n7Sjt4psoHBO/25iyNntYa8=;
Received: by localhost with esmtpsa (TLSv1.2:DHE-RSA-AES128-SHA:128)
        (Exim 4.84_2)
        (envelope-from <hw42@ipsumj.de>)
        id 1chKjM-0001Zg-Rm; Fri, 24 Feb 2017 19:36:36 +0100
Subject: Re: [PATCH 3/3] Makefile: add USE_SHA1DC knob
To:     Jeff King <peff@peff.net>
References: <20170223230507.kuxjqtg3ghcfskc6@sigill.intra.peff.net>
 <20170223230621.43anex65ndoqbgnf@sigill.intra.peff.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Joey Hess <id@joeyh.name>,
        Git Mailing List <git@vger.kernel.org>
From:   HW42 <hw42@ipsumj.de>
Message-ID: <16c6d843-a516-9265-d3e7-61b110acbdcf@ipsumj.de>
Date:   Fri, 24 Feb 2017 18:36:00 +0000
MIME-Version: 1.0
In-Reply-To: <20170223230621.43anex65ndoqbgnf@sigill.intra.peff.net>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="GSvI4iN26nUCg2F7t1m0c1TOfKnXvTfdA"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GSvI4iN26nUCg2F7t1m0c1TOfKnXvTfdA
Content-Type: multipart/mixed; boundary="ucUlbcFIQs8GBoIsLHJ3oav4TCQ9xOXuu";
 protected-headers="v1"
From: HW42 <hw42@ipsumj.de>
To: Jeff King <peff@peff.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Joey Hess
 <id@joeyh.name>, Git Mailing List <git@vger.kernel.org>
Message-ID: <16c6d843-a516-9265-d3e7-61b110acbdcf@ipsumj.de>
Subject: Re: [PATCH 3/3] Makefile: add USE_SHA1DC knob
References: <20170223230507.kuxjqtg3ghcfskc6@sigill.intra.peff.net>
 <20170223230621.43anex65ndoqbgnf@sigill.intra.peff.net>
In-Reply-To: <20170223230621.43anex65ndoqbgnf@sigill.intra.peff.net>

--ucUlbcFIQs8GBoIsLHJ3oav4TCQ9xOXuu
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jeff King:
> diff --git a/Makefile b/Makefile
> index 8e4081e06..7c4906250 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1386,6 +1390,11 @@ ifdef APPLE_COMMON_CRYPTO
>  	SHA1_MAX_BLOCK_SIZE =3D 1024L*1024L*1024L
>  endif
> =20
> +ifdef USE_SHA1DC
> +	SHA1_HEADER =3D "sha1dc/sha1.h"
> +	LIB_OBJS +=3D sha1dc/sha1.o
> +	LIB_OBJS +=3D sha1dc/ubc_check.o
> +else
>  ifdef BLK_SHA1
>  	SHA1_HEADER =3D "block-sha1/sha1.h"
>  	LIB_OBJS +=3D block-sha1/sha1.o
> @@ -1403,6 +1412,7 @@ else
>  endif
>  endif
>  endif
> +endif

This sets SHA1_MAX_BLOCK_SIZE and the compiler flags for Apple
CommonCrypto even if the user selects USE_SHA1DC. The same happens for
BLK_SHA1. Is this intended?

> +void git_SHA1DCUpdate(SHA1_CTX *ctx, const void *vdata, unsigned long =
len)
> +{
> +	const char *data =3D vdata;
> +	/* We expect an unsigned long, but sha1dc only takes an int */
> +	while (len > INT_MAX) {
> +		SHA1DCUpdate(ctx, data, INT_MAX);
> +		data +=3D INT_MAX;
> +		len -=3D INT_MAX;
> +	}
> +	SHA1DCUpdate(ctx, data, len);
> +}

I think you can simply change the len parameter from unsigned into
size_t (or unsigned long) in SHA1DCUpdate().
https://github.com/cr-marcstevens/sha1collisiondetection/pull/6


--ucUlbcFIQs8GBoIsLHJ3oav4TCQ9xOXuu--

--GSvI4iN26nUCg2F7t1m0c1TOfKnXvTfdA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEqieyzvOmi9FGaQcT5KzJJ4pkaBYFAliwfR0PHGh3NDJAaXBz
dW1qLmRlAAoJEOSsySeKZGgWE14P/0dklGTnH4DpiNywPL0HPMU1U3WGAr/b7J2g
6wu4PvCD/wzxGRx6A1/jO574xFJLd+aqBu3uaXWK902oSNadytU0v6zi80HNoznL
63u7AVwS6HL04Z9v6cn/W7yqO7MIOGntCId26aGtidxw5+tSUAXQIq8oP2KXHJlE
945gdHeZC3/Bu04ZndCzH7ciY87M0pFFwjVBqHFGzCCjI1XMmlMYjSjnFwRAa+dE
cJj+I8lbq6Z2Ni4J186uz9baI8Hhbs5uP29wrmFHOcDkw4V52bSHzflzdS0GOc7h
d205bXG3hATcRnKguOTQOzj5djHdhUWDIcmiM19d6vtrLGCMdKWwiBsxwGLxbk8Q
fae7V4bOos0NOGk1cyzzbkOcySxaLh5gOgT/EBk3mU31RCZOpf4+h/3uNJwGEQHk
kcBkbqpowVHHEM0odlOGMHgt5thwVUR/djy1F1IDb0RlwalNkxDPpJeWv5HqnPFt
UHXGGWr57B7U3M4lYE1WmqmHoOXvwrsTywwCWvB7ZK6O5CnRYpmFAvNBkAUZs5pu
GBiyRlbWiwWg+dvAar2wGBANCWbpqItj4hWhFvcYU6/ISAnZR32ieI2SpTw+13f0
9C+bjBTvxogS+ioA+a1/M11udrqC3kHTXz9bWqIiZZF5YMH+9TQmDfPgIRWHHc72
zKsktLhh
=2TGn
-----END PGP SIGNATURE-----

--GSvI4iN26nUCg2F7t1m0c1TOfKnXvTfdA--
