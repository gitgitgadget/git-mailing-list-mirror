Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344631BC2A
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 02:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728871635; cv=none; b=een+wcrXK+50TqGDLB7YFxryMo+XFlS2CvYzM0TE9pGcihK5d34lokz5jBIlqqixea+oHuhtcuPChANRMB6dtofFoBhXyJoMcBV+UTSAREJm4h+D6kCFbZQzhQlyulyDupQT/R64wcv9F3Umw9MaF9GpNdCzhWE6jGDU5rQd2wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728871635; c=relaxed/simple;
	bh=bYOCfS4upCm1RAvjVmxjzJN16+sSE3Mpv3vVG9Uz800=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O+Pu4b+MqmIGc1sFjsD5OMHUS67Oo9ol8Hp8jtt1+4kDCqbLPJDhOh9VVvkfIidsdw0HZbfYPqVftFRusa3JqitrKAWXq5eh+F6msVYYcnh+YqAJpJhAzzCYIoHc+i+YWVzGJCtz9oTNjm/bQ2eUNCaMARZIQGJiCC9oyUOe4ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Message-ID: <e4c99594-08a1-4b5d-b862-bf51efae410e@gentoo.org>
Date: Sun, 13 Oct 2024 22:07:10 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 24/24] Introduce support for the Meson build system
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
 Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <cover.1727881164.git.ps@pks.im> <cover.1728485139.git.ps@pks.im>
 <724232b0fad2cbd5602ac1e900fd5dafff666012.1728485139.git.ps@pks.im>
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
In-Reply-To: <724232b0fad2cbd5602ac1e900fd5dafff666012.1728485139.git.ps@pks.im>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------N7Z0XJeazpUvIaXKEV00bnxW"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------N7Z0XJeazpUvIaXKEV00bnxW
Content-Type: multipart/mixed; boundary="------------wZeJStBx2GZv63ZICwSBsvLH";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@gentoo.org>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
 Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano <gitster@pobox.com>
Message-ID: <e4c99594-08a1-4b5d-b862-bf51efae410e@gentoo.org>
Subject: Re: [RFC PATCH v2 24/24] Introduce support for the Meson build system
References: <cover.1727881164.git.ps@pks.im> <cover.1728485139.git.ps@pks.im>
 <724232b0fad2cbd5602ac1e900fd5dafff666012.1728485139.git.ps@pks.im>
In-Reply-To: <724232b0fad2cbd5602ac1e900fd5dafff666012.1728485139.git.ps@pks.im>

--------------wZeJStBx2GZv63ZICwSBsvLH
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10/9/24 10:57 AM, Patrick Steinhardt wrote:
> +script_environment =3D environment()
> +foreach tool : ['cat', 'cut', 'grep', 'sed', 'sort', 'tr', 'uname']
> +  program =3D find_program(tool)
> +  script_environment.prepend('PATH', fs.parent(program.full_path()))
> +endforeach
> +
> +libgit_sources +=3D custom_target(
> +  'command-list.h',
> +  input: 'command-list.txt',
> +  output: 'command-list.h',
> +  command: [shell, meson.current_source_dir() + '/generate-cmdlist.sh'=
, meson.current_source_dir(), '@OUTPUT@'],
> +  env: script_environment,
> +)


Maybe I am missing something about the necessity of this setting up of
PATH? Should these programs not already be on PATH -- how does meson
find them?

> +zlib =3D dependency('zlib', default_options: ['default_library=3Dstati=
c', 'tests=3Ddisabled'])
> +if zlib.type_name() !=3D 'internal' and not compiler.has_function('def=
lateBound',
> +  prefix: '#include <zlib.h>',
> +  dependencies: zlib,
> +)
> +  libgit_c_args +=3D '-DNO_DEFLATE_BOUND'
> +endif


Probably should have mentioned this earlier on, but.

What about

if zlib.version().version_compare('>=3D1.2.0')
    libgit_c_args +=3D '-DNO_DEFLATE_BOUND'
endif


since that is when that function was added.


--=20
Eli Schwartz

--------------wZeJStBx2GZv63ZICwSBsvLH--

--------------N7Z0XJeazpUvIaXKEV00bnxW
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQTnFNnmK0TPZHnXm3qEp9ErcA0vVwUCZwx8zgUDAAAAAAAKCRCEp9ErcA0vV5PE
AQCrw5k6gsohUuwroMIi91HBEKdJGhyUSU1wkwsS5PkjqgEA0qbDX6n2LrsdGl8dY+UbiXXem2cX
IoA1xofiFjM8Wgc=
=zbxw
-----END PGP SIGNATURE-----

--------------N7Z0XJeazpUvIaXKEV00bnxW--
