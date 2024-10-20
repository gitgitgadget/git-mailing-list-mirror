Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D48039FD6
	for <git@vger.kernel.org>; Sun, 20 Oct 2024 08:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729414317; cv=none; b=H58NSf/GDxMhs75FDEsiCKHZ8tx8D55gaDQsAa2IHMjlbL1FMkKTRpdVvpqQkdo6YCyAqvSs/vzNU3TGyj9asTUgxEAbs8imd+W/mVwp1u0ws3nNua7M68U6S6ZpGorN9GQsz2+L1m03gHIIvGX+6oKSu9H1flypYCwavn/BJH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729414317; c=relaxed/simple;
	bh=iYw6pR7n0Osp88tMxELzUCnyvLX/GxOaWu9LjJToKqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gW+7X6drbiDheY/m95bsalwemDsyPQG/tCA4UQctzhQVPMmXZkPWVCEPMNdWw9NL7/k9kSeMgPg8midXSPuo1etVttCA7J6daEFXs+EZZ78N5Ja1ZYKpoadoCHFGiecooURVZhFqgFGnUjtePohs5pHWyVfi9rN+l427ibg3Et8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Message-ID: <361e69ee-4491-4e2b-8edc-fdf4bcbb8532@gentoo.org>
Date: Sun, 20 Oct 2024 04:51:49 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 00/15] Modernize the build system
To: Ramsay Jones <ramsay@ramsayjones.plus.com>, Patrick Steinhardt
 <ps@pks.im>, git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
 Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <cover.1727881164.git.ps@pks.im> <cover.1729254070.git.ps@pks.im>
 <86de131b-bdea-4c37-b512-68b8378f4343@ramsayjones.plus.com>
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
In-Reply-To: <86de131b-bdea-4c37-b512-68b8378f4343@ramsayjones.plus.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------JDSiSNkrxRPMpEpNSfxl0yCB"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------JDSiSNkrxRPMpEpNSfxl0yCB
Content-Type: multipart/mixed; boundary="------------YBpwCsj0n7S0GD3x0mhkA65O";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@gentoo.org>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>, Patrick Steinhardt
 <ps@pks.im>, git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
 Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano <gitster@pobox.com>
Message-ID: <361e69ee-4491-4e2b-8edc-fdf4bcbb8532@gentoo.org>
Subject: Re: [RFC PATCH v3 00/15] Modernize the build system
References: <cover.1727881164.git.ps@pks.im> <cover.1729254070.git.ps@pks.im>
 <86de131b-bdea-4c37-b512-68b8378f4343@ramsayjones.plus.com>
In-Reply-To: <86de131b-bdea-4c37-b512-68b8378f4343@ramsayjones.plus.com>

--------------YBpwCsj0n7S0GD3x0mhkA65O
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10/18/24 12:08 PM, Ramsay Jones wrote:
> I had a very quick attempt on cygwin the other night, and it behaved
> differently at the 'ninja test' stage. It printed something like
> '[0/1] all tests' and then seemed to do nothing, except 'python3.9'
> was hovering up all cycles (well over 75% anyway) with no indication
> of any progress. This was nothing like the behaviour on Linux (which
> also looked a bit strange, but at least showed progress on each test
> as it ran).
>=20
> I ^C-ed it, since I didn't want to wait 6 hours before it (hopefully)
> finished running.


Running "ninja test" can be thought of as a convenience target to make
all commands available via the Makefile equivalent. What it actually
does, though, is first depend on "all" + any explicit test dependencies,
and then dispatch to the separate "meson test" tool with some tastefully
chosen arguments such as "--no-rebuild" (to prevent rerunning ninja) as
well as --print-errorlogs.

Running "meson test" directly is still possible, and maybe required if
you want to do things such as --interactive, or running a specific
testcase rather than all of them, or --maxfail, or well, all kinds of
fiddly and specific fine-tuning. :)

But in particular, I am wondering if maybe your cygwin issue is somehow
due to ninja deciding that it really really wanted to buffer all output
and wait until it completes before showing anything. It's not supposed
to do that, since we wire it up to the "console" pool:
https://ninja-build.org/manual.html#_the_literal_console_literal_pool

The other possibility is that the python installation has decided to
buffer itself:
https://docs.python.org/3/using/cmdline.html#cmdoption-u

possibly because due to ninja's juggling of pseudo ttys, the python
runtime for "meson test" thinks it is *not* running in a tty. I know
that ninja messes around with this in counterintuitive ways in general,
but I am not sure exactly how that interacts with the console pool. But
regardless of the reason -- if it is happening at the python level, then
exporting PYTHONUNBUFFERED=3D1 may help. It's something I've had to do
before for programs other than meson, at least.


--=20
Eli Schwartz

--------------YBpwCsj0n7S0GD3x0mhkA65O--

--------------JDSiSNkrxRPMpEpNSfxl0yCB
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQTnFNnmK0TPZHnXm3qEp9ErcA0vVwUCZxTEpQUDAAAAAAAKCRCEp9ErcA0vVwYN
AQCVmTWvqnJfUE6XeBZiT+9GmA3WBzCJiLcCGSS2PYaDEwD9Hrm6vhoAQ9zvhUhvcaokyDfW5cAj
D/ChCy40Rp3olwc=
=YsHs
-----END PGP SIGNATURE-----

--------------JDSiSNkrxRPMpEpNSfxl0yCB--
