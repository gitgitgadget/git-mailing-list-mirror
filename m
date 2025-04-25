Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922596FBF
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 00:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745541949; cv=none; b=FBg59jySdwtBZE2BTJrFTLgWZTS9dsBD2plz47FLNqtqIE10fEky65kP3t7mToYm0U5lCranorex8/yelCkVa/G7fosaU84FJ2w0/8Y1aCtAKasf1jVvcEka9RsVzwtGbrrRktr+q4RzFQgSe5QuqWTv8NkqN5kT1E/60osQn8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745541949; c=relaxed/simple;
	bh=wfyYmRBUWrZvlXk/3UvnRZEsNRAHIVrQjjHLhI1l3yE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HkvycSTFSc3wjOksnogpH3On3r798WFihvT+CqgYVraDZqOacs3GSZlGKRbPQ/001+zpRb1qlqxW32buhgR/59Dc7sG4rPP1m6kKVREAtLqdvRsW8i4es+EtiOtuDYblDmBQZGq9rFOM8AVgMXeMiKABcpxK91rtO0OfBm/YJHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [IPV6:2603:6011:3f0:6f00::12ac] (unknown [IPv6:2603:6011:3f0:6f00::12ac])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: eschwartz)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 9E7DE340BE0;
	Fri, 25 Apr 2025 00:45:47 +0000 (UTC)
Message-ID: <43e86c8f-904b-4572-b84d-009c203fda11@gentoo.org>
Date: Thu, 24 Apr 2025 20:45:44 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] meson: report detected runtime executable paths
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Peter Seiderer <ps.report@gmx.net>
References: <20250424-pks-meson-posix-shell-v1-0-45e06ee4b6ad@pks.im>
 <20250424-pks-meson-posix-shell-v1-1-45e06ee4b6ad@pks.im>
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
In-Reply-To: <20250424-pks-meson-posix-shell-v1-1-45e06ee4b6ad@pks.im>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------CtbbDwuHvf00Z4RtDc4vIxZj"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------CtbbDwuHvf00Z4RtDc4vIxZj
Content-Type: multipart/mixed; boundary="------------Q8iBLg2XHe4LFoq98zh4WDiJ";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@gentoo.org>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Peter Seiderer <ps.report@gmx.net>
Message-ID: <43e86c8f-904b-4572-b84d-009c203fda11@gentoo.org>
Subject: Re: [PATCH 1/2] meson: report detected runtime executable paths
References: <20250424-pks-meson-posix-shell-v1-0-45e06ee4b6ad@pks.im>
 <20250424-pks-meson-posix-shell-v1-1-45e06ee4b6ad@pks.im>
In-Reply-To: <20250424-pks-meson-posix-shell-v1-1-45e06ee4b6ad@pks.im>

--------------Q8iBLg2XHe4LFoq98zh4WDiJ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 4/24/25 9:38 AM, Patrick Steinhardt wrote:
> Git needs to know about a couple of executable paths to pick at runtime=
=2E
> This includes the system shell, but may also optionally include the Per=
l
> and Python interpreters. Meson detects the location of these paths
> automatically via `find_program()`, which does a lookup via the `PATH`
> environment variable. As such, it may not be immediately obvious to the=

> developer which paths have been autodetected.
>=20
> Improve this by exposing runtime executable paths at setup time.
>=20
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  meson.build | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/meson.build b/meson.build
> index c47cb79af08..8f04534c7ff 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2080,3 +2080,9 @@ summary({
>    'sha256': sha256_backend,
>    'zlib': zlib_backend,
>  }, section: 'Backends')
> +
> +summary({
> +  'perl': target_perl.found() ? target_perl.full_path() : 'none',
> +  'python': target_python.found() ? target_python.full_path() : 'none'=
,
> +  'shell': target_shell.full_path(),
> +}, section: 'Runtime executable paths')

summary({
  'perl': target_perl,
  'python': target_python,
  'shell': target_shell,
}, section: 'Runtime executable paths')


No need to check if they are found. Meson will print the full_path()
already, if it is found, and if it is not found, it will print "NO" in
its standard color code (red) for things-that-are-missing.




--=20
Eli Schwartz

--------------Q8iBLg2XHe4LFoq98zh4WDiJ--

--------------CtbbDwuHvf00Z4RtDc4vIxZj
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQTnFNnmK0TPZHnXm3qEp9ErcA0vVwUCaArbOAUDAAAAAAAKCRCEp9ErcA0vV5U5
AQCY3HBd0aKhXkuBobBS1grSSa650wRp9FmXxZFB9uqBkAD/du5Zit9ZlXNkmog5HMFjV11XgJOL
6NncEY/4jI7bDQI=
=M+HS
-----END PGP SIGNATURE-----

--------------CtbbDwuHvf00Z4RtDc4vIxZj--
