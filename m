Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058ED28F1
	for <git@vger.kernel.org>; Fri,  2 May 2025 22:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746225470; cv=none; b=p1cELeBfWqY8gqGbzYWwPOMYmFBFLtIFvGu8UkUoM9u4dV+qs2nEvQep+oI6+d0hHnE/mdtOOj9DB4jBwHxPN9SkpfUt+e1gzDwikUWuGq+cVlcLQTtLsYoVwLzltsNq2/3lV+Qa61m2DlAryEZe50B+vjwHOD4bzUlkAlqdvA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746225470; c=relaxed/simple;
	bh=Fq7UIUQXnEAg5+k7L5DEKGHvqvFxQJpVo5S4mngt+Kc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B60kx3/D8sCJFqaKfmMhjevHl5PX+s5U6Rch4Fezwt9cMnWUI1ANt6MRlITwMyACdTUs5asharFKC4AhPKJmDlJQdgzIBUlxBKgcoyq9y+VxIt0UYi6R51y0OtjY9+gjPQEBAVB0bl2w7x44UjOeOoe1zSikVhMkSvZwTR+lFYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [IPV6:2603:6011:3f0:6f00::12ac] (unknown [IPv6:2603:6011:3f0:6f00::12ac])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: eschwartz)
	by smtp.gentoo.org (Postfix) with ESMTPSA id D4511343067;
	Fri, 02 May 2025 22:37:47 +0000 (UTC)
Message-ID: <c5486e20-dbae-4ec2-bc19-d5dc537a8399@gentoo.org>
Date: Fri, 2 May 2025 18:37:45 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] meson: prefer '/bin/sh' over PATH lookup
To: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Peter Seiderer <ps.report@gmx.net>,
 Justin Tobler <jltobler@gmail.com>
References: <20250424-pks-meson-posix-shell-v1-0-45e06ee4b6ad@pks.im>
 <20250425-pks-meson-posix-shell-v3-0-01607a2e9334@pks.im>
 <xmqqjz6yu30o.fsf@gitster.g>
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
In-Reply-To: <xmqqjz6yu30o.fsf@gitster.g>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------fTSe0tsyuwBk56BBQbVvCtQ2"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------fTSe0tsyuwBk56BBQbVvCtQ2
Content-Type: multipart/mixed; boundary="------------iaHTpXOOOb83aBjABfPPBzcE";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@gentoo.org>
To: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Peter Seiderer <ps.report@gmx.net>,
 Justin Tobler <jltobler@gmail.com>
Message-ID: <c5486e20-dbae-4ec2-bc19-d5dc537a8399@gentoo.org>
Subject: Re: [PATCH v3 0/2] meson: prefer '/bin/sh' over PATH lookup
References: <20250424-pks-meson-posix-shell-v1-0-45e06ee4b6ad@pks.im>
 <20250425-pks-meson-posix-shell-v3-0-01607a2e9334@pks.im>
 <xmqqjz6yu30o.fsf@gitster.g>
In-Reply-To: <xmqqjz6yu30o.fsf@gitster.g>

--------------iaHTpXOOOb83aBjABfPPBzcE
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 5/2/25 5:16 PM, Junio C Hamano wrote:
> So the discussion seems to have died out.  Have we decided that
> unlike Makefile-based approach, it is too cumbersome to teach the
> Meson based approach to allow user-specified commands that have
> different basename to stand in for the command we expect in the
> build based on Meson [*], and what the v3 iteration of this series
> does is a good place to stop?


I don't have any objections to teaching git's own meson.build to do
this, and I don't think it would be particularly cumbersome. But as I'm
not the person who would use it, really, I was hoping others would state
their preferences.

=2E..

One possibility would be if meson itself was adapted to support setting
simple "machine description" settings via the command line. I seem to
recall someone had proposed at one point on the meson ticket tracker, to
support e.g.

```
meson setup -Dbinaries.cc=3Dgcc -Dbinaries.sh=3D/bin/dash
```
but I cannot recall what came of the discussion. I'll try to find the
relevant ticket after the weekend (going offline right around now).



> [Footnote]
>=20
>  * It is trivial to say "make SHELL_PATH=3D/bin/dash", but we do not
>    add support for anything like 'meson -dSHELL_PATH=3D/bin/dash', and
>    we only allow the search path for fixed-name commands to be
>    configured and tell our developers that they have to write an
>    extra file paths.ini just to be able to do so.


--=20
Eli Schwartz

--------------iaHTpXOOOb83aBjABfPPBzcE--

--------------fTSe0tsyuwBk56BBQbVvCtQ2
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQTnFNnmK0TPZHnXm3qEp9ErcA0vVwUCaBVJOQUDAAAAAAAKCRCEp9ErcA0vV0hA
AQCdiiOaQfEc/Uf1a++1riNfRmm+xDGz1DI0eAz2y0RGuQEAssY8vifwcRErC20DER/uUF5J/A7q
lLH8EpjWekcM4wQ=
=ybKO
-----END PGP SIGNATURE-----

--------------fTSe0tsyuwBk56BBQbVvCtQ2--
