Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2566E1C695
	for <git@vger.kernel.org>; Wed, 13 Nov 2024 14:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731509880; cv=none; b=pmxuzYx2v7D2v7hykidgc0kgPApm7oYT5EjAjMTZjRXeePvOIuRAa2cTxIKIIY/ohAlQLP3Z5wsX3PNDi93k8WgVz07LNPMnICXWCv2rTWYVFL6DmU7RvFKiKRTXs2j+gKYSRGn0zM8gMfdrkBQarizTcNP/EujSt/rfTI8DnTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731509880; c=relaxed/simple;
	bh=KRKJwMDFB32F+ktld5Ex/RVnkFLk/385Gc0BqxhsPKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bpLrYJBH+bLhAc1yCPF4mJLi83jaL+AP4JNKwMeBX+zJZY7MXmCLt2RY5GU+zpIfltl9ID29LbOY0IHKJXeZgcNIhgc5g5uU7tlHSwis3FzL/JzJvP+6xPBqctVqjer3/4mfdsJj2phKBLH54XQmp+PpJnap0yb9IFlHjZs6i5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Message-ID: <c323599d-f60f-443c-8073-0942afbcdc04@gentoo.org>
Date: Wed, 13 Nov 2024 09:57:55 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 00/19] Modernize the build system
To: Patrick Steinhardt <ps@pks.im>, David Aguilar <davvid@gmail.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
 Eric Sunshine <sunshine@sunshineco.com>,
 Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano
 <gitster@pobox.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
 Jeff King <peff@peff.net>
References: <cover.1727881164.git.ps@pks.im> <cover.1729771605.git.ps@pks.im>
 <Zxv4osnjmuiGzy94@nand.local> <Zyi7PA2m2YX9MpBu@pks.im>
 <ZyjlvNJ4peffmGZ1@nand.local> <Zy9ckDezMSKVA5Qi@gmail.com>
 <ZzHeMjqUjzWpdX-Y@pks.im> <ZzRvsOeLsq3dJbGw@gmail.com>
 <ZzSprTl5Z3uIx0_d@pks.im>
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
In-Reply-To: <ZzSprTl5Z3uIx0_d@pks.im>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------vYDpAU4HVe33WXmNKtIeakGy"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------vYDpAU4HVe33WXmNKtIeakGy
Content-Type: multipart/mixed; boundary="------------caEsWlseGmn0u8vAPgDLaVee";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@gentoo.org>
To: Patrick Steinhardt <ps@pks.im>, David Aguilar <davvid@gmail.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
 Eric Sunshine <sunshine@sunshineco.com>,
 Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano
 <gitster@pobox.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
 Jeff King <peff@peff.net>
Message-ID: <c323599d-f60f-443c-8073-0942afbcdc04@gentoo.org>
Subject: Re: [RFC PATCH v4 00/19] Modernize the build system
References: <cover.1727881164.git.ps@pks.im> <cover.1729771605.git.ps@pks.im>
 <Zxv4osnjmuiGzy94@nand.local> <Zyi7PA2m2YX9MpBu@pks.im>
 <ZyjlvNJ4peffmGZ1@nand.local> <Zy9ckDezMSKVA5Qi@gmail.com>
 <ZzHeMjqUjzWpdX-Y@pks.im> <ZzRvsOeLsq3dJbGw@gmail.com>
 <ZzSprTl5Z3uIx0_d@pks.im>
In-Reply-To: <ZzSprTl5Z3uIx0_d@pks.im>

--------------caEsWlseGmn0u8vAPgDLaVee
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/13/24 8:29 AM, Patrick Steinhardt wrote:
> Fair. I don't really expect anybody to use the combination of muon/sumo=

> for everyday work, mostly because the usability is not quite up to par
> with Meson/Ninja. But there are two use cases that I deem important:


(samu :P)


>   - Esoteric platforms that may not have Python available. I don't know=

>     whether there actually are any relevant ones, but with muon/sumo it=

>     is possible to support these.
>=20
>   - Bootstrappability, which I think is rather critical for a project
>     like Git that is at the core of the whole software ecosystem.
>     Depending only on a C99 compiler and a shell is a huge win here.
>=20
> A bit of an anecdota, but CMake itself for example struggles with this
> quite heavily because it has dependencies that use CMake themselves. So=

> it is nice that there is a clear path for bootstrapping with Meson and
> thus Git.


Yeah, the cmake bootstrap route tends to be an issue for Linux distros
because we want to use system packages for those dependencies, and while
it's possible to build a bootstrap seed `cmake` binary using their
shellscript and use it to build a "real" cmake, that doesn't really help
you install cmake's dependencies. There are some tricks you can do like
for example on Gentoo, bootstrap the OS with http2 support in curl
toggled off, so you can build without nghttp2 / no cmake, then use that
to build cmake, then rebuild curl. It requires manual intervention but
then you can reuse the existing cmake binary.

There's generally no path for building cmake with bundled dependencies,
as that would conflict with the desired end state of distributing cmake
linked to system packages.



>> Thanks. I don't want to be the CMake champion, so here are a few
>> helpful/surprising details about the Meson build to help make it bette=
r.
>>
>>
>> (1) I first built w/out having "curl-config" installed. I was surprise=
d
>> to find that "ninja -C build install" ended up installing "bin/curl" a=
nd
>> "bin/curl-config" into the prefix.
>>
>> Is there a way to have the install step only install Git without
>> bringing along these other non-Git bits?
>=20
> It definitely shouldn't install curl and curl-config, I'll have a look
> at that. But other than that Meson is currently set up such that it wil=
l
> automatically fall back to the subprojects in case certain dependencies=

> cannot be found. This can be disabled via `meson setup --wrap-mode
> nofallback`.



https://github.com/mesonbuild/wrapdb/tree/master/subprojects/packagefiles=
/curl

could be updated to handle the case where meson.is_subproject() returns
"true", by not installing tooling.

Alternatively, meson install --skip-subprojects can avoid installing
*any* files from subprojects, on the theory that subprojects exist
solely to provide static libraries linked into the real project.

(In theory, one could have a subproject where arbitrary data files from
a subproject dependency are crucial at runtime. I think the gnome
ecosystem does this, hence using GLib / Gtk as a subproject "needs" to
install the subproject too -- but curl definitely doesn't have this
issue...)



--=20
Eli Schwartz

--------------caEsWlseGmn0u8vAPgDLaVee--

--------------vYDpAU4HVe33WXmNKtIeakGy
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQTnFNnmK0TPZHnXm3qEp9ErcA0vVwUCZzS+cwUDAAAAAAAKCRCEp9ErcA0vV2b2
AP4pkS2PlTaz+gFta2hj56XfAcBK0MdkfyJPMuv8jhWywwD/fYofsziXLDn7abhVeVgKtTcmQnGK
xoFUcWcX9IWUuw0=
=WPFL
-----END PGP SIGNATURE-----

--------------vYDpAU4HVe33WXmNKtIeakGy--
