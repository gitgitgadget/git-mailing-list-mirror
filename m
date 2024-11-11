Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195B619CC0C
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 23:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731369343; cv=none; b=lcvG3woqxtzTkBLRzlbkf9GZTZGZYs5bt+cbPlTq2mfL48f0RJneC2iuOLEZCQFW/c7k46R/cK5CyTAVXBe2paOypsoetCVvB1T/nQ8PRfLnRF9WgW8XmGVRvxCwDLY88Z79Fnelmxr0KcQiRvsg7VCd9mKhnPTYh6Wh/3+ad5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731369343; c=relaxed/simple;
	bh=bt07LulYe9+qH+C95CZzaFlab5jz1c+asWduupKyTes=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AJ8oUUG0OVAJrj/mLPb5hjY2JKVw3XT1bCzFIFJV0njtq4F3VBfMQop3JczkCKUw5pOSBRNHEBvGobatq8+apVme9Cl+exN3SYvVtpy4VFp85pCyhoFdpK/TjZ5344e2XsHsAGWbwa03yOwzwxoOl7ytLkQvnJEMzPHCxrkQysI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Message-ID: <f3b00260-ec3d-4607-aaf7-9cfd9898434f@gentoo.org>
Date: Mon, 11 Nov 2024 18:55:38 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 00/19] Modernize the build system
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>,
 git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
 Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano
 <gitster@pobox.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>
References: <cover.1727881164.git.ps@pks.im> <cover.1729771605.git.ps@pks.im>
 <Zxv4osnjmuiGzy94@nand.local> <Zyi7PA2m2YX9MpBu@pks.im>
 <ZyjlvNJ4peffmGZ1@nand.local> <ZzHeLlYu8Gwk1FPj@pks.im>
 <20241111210629.GB5019@coredump.intra.peff.net>
 <bfc876ea-1a90-4e78-8756-efdcd53e7525@gentoo.org>
 <20241111221320.GF5019@coredump.intra.peff.net>
Content-Language: en-US
From: Eli Schwartz <eschwartz@gentoo.org>
Autocrypt: addr=eschwartz@gentoo.org; keydata=
 xjMEZmeRNBYJKwYBBAHaRw8BAQdAYNZ7pUDWhx1i2f3p6L2ZLu4FcY18UoeGC04Gq/khqwfN
 I0VsaSBTY2h3YXJ0eiA8ZXNjaHdhcnR6QGdlbnRvby5vcmc+wpYEExYKAD4WIQTvUdMIsc4j
 CIi+DYTqQj6ToWND8QUCZoRL+gIbAwUJBKKGAAULCQgHAwUVCgkICwUWAgMBAAIeBQIXgAAK
 CRDqQj6ToWND8aB5AP9r4kB691nNtNwKkdRiOdl7/k6WYzokvHvDamXxRJ0I+gEAjZqR5V8y
 mfR3fy2Z+r2Joeqdt3CIv5IwPs64spBvigLOOARmZ5E0EgorBgEEAZdVAQUBAQdATT46Z06b
 1X9xjXFCYFxmq/Tj3tSEKZInDWTpoHQp4l8DAQgHwn4EGBYKACYWIQTvUdMIsc4jCIi+DYTq
 Qj6ToWND8QUCZmeRNAIbDAUJBKKGAAAKCRDqQj6ToWND8a2RAP40KPfbfoiZAJW5boFmFJ3G
 TUBDJRh9CWHyaPqq2PN+0wD/R07oLzfnJUN209mzi9TuTuHjeZybysyqXSw4MAxkMAY=
In-Reply-To: <20241111221320.GF5019@coredump.intra.peff.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------zX60iaSOPXhufD15R4tFRf3U"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------zX60iaSOPXhufD15R4tFRf3U
Content-Type: multipart/mixed; boundary="------------k7RyDXMgmOXPVaialvfsOO0i";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@gentoo.org>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>,
 git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
 Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano
 <gitster@pobox.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <f3b00260-ec3d-4607-aaf7-9cfd9898434f@gentoo.org>
Subject: Re: [RFC PATCH v4 00/19] Modernize the build system
References: <cover.1727881164.git.ps@pks.im> <cover.1729771605.git.ps@pks.im>
 <Zxv4osnjmuiGzy94@nand.local> <Zyi7PA2m2YX9MpBu@pks.im>
 <ZyjlvNJ4peffmGZ1@nand.local> <ZzHeLlYu8Gwk1FPj@pks.im>
 <20241111210629.GB5019@coredump.intra.peff.net>
 <bfc876ea-1a90-4e78-8756-efdcd53e7525@gentoo.org>
 <20241111221320.GF5019@coredump.intra.peff.net>
In-Reply-To: <20241111221320.GF5019@coredump.intra.peff.net>

--------------k7RyDXMgmOXPVaialvfsOO0i
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/11/24 5:13 PM, Jeff King wrote:
> No, they don't. I don't have msgfmt on my system at all, and always
> build with NO_GETTEXT.


Well, even systems without msgfmt installed may have the gettext()
family of symbols available. On various systems, it may even be built
into their libc.

So, detecting and handling this case sensibly out of the box would be
good, which I guess means checking for find_program('msgfmt') inside of
po/meson.build

That being said, the meson way to handle NO_GETTEXT is to use the build
option

meson setup builddir -Dgettext=3Ddisabled


That option is a "feature option", which means by default its value is
auto, not disabled, and it will check for an available libintl / libc
gettext().

The po/ directory is only processed if libintl / libc gettext() is
found. Passing -Dgettext=3Ddisabled means that it will be forcibly
overridden to "not found". Meson will log this configuration message:


Dependency intl skipped: feature gettext disabled


--=20
Eli Schwartz

--------------k7RyDXMgmOXPVaialvfsOO0i--

--------------zX60iaSOPXhufD15R4tFRf3U
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQTnFNnmK0TPZHnXm3qEp9ErcA0vVwUCZzKZegUDAAAAAAAKCRCEp9ErcA0vV59N
AP9FD8EsRLdaQZFlJyPnCjjogNIL7fD/7MUY4RJjye4E1QEAt0R24LA4a9p3OUqjxaokEobPAREJ
dtTuQFEwEO/VwgI=
=UJGB
-----END PGP SIGNATURE-----

--------------zX60iaSOPXhufD15R4tFRf3U--
