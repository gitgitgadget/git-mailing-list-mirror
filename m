Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25393211C
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 15:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729699124; cv=none; b=hbep81lRIoWNbj0ZkZ5zxbyDmdb7S5Agt7uWFL0GEPn85NpkF19L+i1Xd0R3lL9tIsr6miXYKNTvfRPv1OPv2fLnHwxQ+O/FX3OdDyvjwZd89Yiepkh9GL9zdIFXFKv4TUm4j7Tek5MqYnRoz5splK+JwOhJwHPWeAmhveJe5zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729699124; c=relaxed/simple;
	bh=wP5k6rN/2hhbSWm2rfQDJVJUBrIkXC5wgufh/MpAJeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NgU2RQ01n5RnZBxJnnOTSd8B0FjELmUGYi/T2dAeh11L8frN7L9iCmgzhECrMasJXb44bSc7PFYxJvArl6jMv7CUXeC9p1xbhb7ayZgnadiEQR3LgSM6T9y34vx9FxPbQ2dYcYBpYDSZ6F90D6gJy8dKSHQU2ShmfmdL8XQOCEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Message-ID: <6883a8d4-7e2e-4988-b57f-89b7c0aacadc@gentoo.org>
Date: Wed, 23 Oct 2024 11:58:38 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 00/15] Modernize the build system
To: Ramsay Jones <ramsay@ramsayjones.plus.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
 Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <cover.1727881164.git.ps@pks.im> <cover.1729254070.git.ps@pks.im>
 <86de131b-bdea-4c37-b512-68b8378f4343@ramsayjones.plus.com>
 <361e69ee-4491-4e2b-8edc-fdf4bcbb8532@gentoo.org>
 <b35b6f10-ebb5-4266-ab95-aafb67cfad22@ramsayjones.plus.com>
 <ZxjmTbATU7usHcqQ@pks.im>
 <c32a7dc3-cf9f-4d42-98da-80009f9df847@ramsayjones.plus.com>
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
In-Reply-To: <c32a7dc3-cf9f-4d42-98da-80009f9df847@ramsayjones.plus.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------kpi5mzgND0tZHeSk3HINOeIb"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------kpi5mzgND0tZHeSk3HINOeIb
Content-Type: multipart/mixed; boundary="------------2m4ONhba4yhUPh5d0cXk5SFV";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@gentoo.org>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
 Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano <gitster@pobox.com>
Message-ID: <6883a8d4-7e2e-4988-b57f-89b7c0aacadc@gentoo.org>
Subject: Re: [RFC PATCH v3 00/15] Modernize the build system
References: <cover.1727881164.git.ps@pks.im> <cover.1729254070.git.ps@pks.im>
 <86de131b-bdea-4c37-b512-68b8378f4343@ramsayjones.plus.com>
 <361e69ee-4491-4e2b-8edc-fdf4bcbb8532@gentoo.org>
 <b35b6f10-ebb5-4266-ab95-aafb67cfad22@ramsayjones.plus.com>
 <ZxjmTbATU7usHcqQ@pks.im>
 <c32a7dc3-cf9f-4d42-98da-80009f9df847@ramsayjones.plus.com>
In-Reply-To: <c32a7dc3-cf9f-4d42-98da-80009f9df847@ramsayjones.plus.com>

--------------2m4ONhba4yhUPh5d0cXk5SFV
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10/23/24 10:38 AM, Ramsay Jones wrote:
> Hmm, I could have sworn that this caused a complete rebuild for me
> (even when having just built), hence the '--no-rebuild --print-errorlog=
s'
> parameters to meson test. (Oh, maybe that was just 'meson test' - so
> how do you run *all* tests with meson - rather than 'ninja test').


"meson test" without --no-rebuild will first run "ninja" to verify that
everything has been built, and build it if it hasn't been. When passing
specific test names, it will filter for dependencies of that specific
testcase, and only ensure *those* are up to date. Assuming those
dependencies are accurate, of course. :D

What do you mean by "complete rebuild"? Do you mean all binaries that
were already built and up to date get marked stale and recreated?

> BTW, I have been doing:
>=20
>   $ meson setup .. -Dprefix=3D$HOME
>=20
> so that it matches the default prefix from the Makefile (not that I
> have attempted to actually install yet!;) ). Can the default be set
> in the meson.build file (with command-line override, of course)?


project('git', 'c',
  meson_version: '>=3D1.3.0',
  # MSVC does not support GNU99, and C99 does not define __STDC_VERSION__=

  # on MSVC. So we instead fall back to C11 there.
  default_options: ['c_std=3Dgnu99,c11'],


You can pass any command-line options in as default_options, including
prefix. Defaulting to $HOME is somewhat unconventional regardless of
whether it's done in a Makefile or a configure.ac or a meson.build or a
CMakeLists.txt, but given the Makefile does indeed do that I suppose
it's not incredibly bizarre to do it in meson.build as well. :)


--=20
Eli Schwartz

--------------2m4ONhba4yhUPh5d0cXk5SFV--

--------------kpi5mzgND0tZHeSk3HINOeIb
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQTnFNnmK0TPZHnXm3qEp9ErcA0vVwUCZxkdLgUDAAAAAAAKCRCEp9ErcA0vVxTG
AP9IPSvItcdaQh6h3TlVXpzmZWUAhyR5kLiOT/jNjA63eQEAk9+YPAbLalikE3zprzFqNXLFeLe/
+2N8zihwwc70HAk=
=Ps0K
-----END PGP SIGNATURE-----

--------------kpi5mzgND0tZHeSk3HINOeIb--
