Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7EC946A
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 04:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752554305; cv=none; b=Ijp89kz66zu/oSKE17h1JmzND2ybdF1aX9B2pgnCICHjl8xdj681kebo92W8KSmo55e59yKm01miYqvtD54rU98xyOnzjCqiL7Macel3PKhH5jkmFsT+R+euglCNxqyPmQLcvpcxnEXfzpRatgOClOuVgJR5btsyCCJtFTI+2Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752554305; c=relaxed/simple;
	bh=YwLJ9vDFEMRcFJkiMfBuQT5pkstWsglTHWGR96FlE30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HC0I6K1sAYnGaSHlf0SJOv7hUEwlaUSYerh6sDBlzf729obi+BXyrr1fYc8+YsnwuB7vkNyg1hbusduodFZ/DLUFMyXVAY9jT538DoQv+WZbOufBqqUjU2P3Z119XujrTPK3A1hfX/UTp8mAzm2W6oMGAWEReY10qTb7Jug7Qak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [IPV6:2603:6011:3f0:6f00::12ac] (unknown [IPv6:2603:6011:3f0:6f00::12ac])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: eschwartz)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 266F1340E5D;
	Tue, 15 Jul 2025 04:38:23 +0000 (UTC)
Message-ID: <77879bc4-9b8b-4f8f-a9d5-ea0114937e9b@gentoo.org>
Date: Tue, 15 Jul 2025 00:38:19 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] http: don't send C or POSIX in Accept-Language
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
 Carlo Arenas <carenas@gmail.com>, Justin Tobler <jltobler@gmail.com>,
 semtlenori@gmail.com, Collin Funk <collin.funk1@gmail.com>
References: <20250710221641.857081-1-sandals@crustytoothpaste.net>
 <20250710221641.857081-2-sandals@crustytoothpaste.net>
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
In-Reply-To: <20250710221641.857081-2-sandals@crustytoothpaste.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------W1Fdr820ISRHbBAAMC05eNV1"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------W1Fdr820ISRHbBAAMC05eNV1
Content-Type: multipart/mixed; boundary="------------SjonMCWWvGCYaiApVheojeVP";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@gentoo.org>
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
 Carlo Arenas <carenas@gmail.com>, Justin Tobler <jltobler@gmail.com>,
 semtlenori@gmail.com, Collin Funk <collin.funk1@gmail.com>
Message-ID: <77879bc4-9b8b-4f8f-a9d5-ea0114937e9b@gentoo.org>
Subject: Re: [PATCH 1/1] http: don't send C or POSIX in Accept-Language
References: <20250710221641.857081-1-sandals@crustytoothpaste.net>
 <20250710221641.857081-2-sandals@crustytoothpaste.net>
In-Reply-To: <20250710221641.857081-2-sandals@crustytoothpaste.net>

--------------SjonMCWWvGCYaiApVheojeVP
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 7/10/25 6:16 PM, brian m. carlson wrote:
> The LANGUAGE environment variable is not specified by POSIX, but a
> variety of programs using GNU gettext accept it.  The Linux manpages
> state that it can contain a colon-separated list of locales.
>=20
> However, not all locales are valid as languages.  The C and POSIX
> locales, for instance, are not languages and are not registered with
> IANA, nor are they a part of ISO 639.  In fact, "C" is too short to
> match the ABNF production for a language, which must be at least two
> characters in length.
>=20
> Nonetheless, many users provide these values in the LANGUAGE environmen=
t
> variable for unknown reasons and if they do, we do not want to send a
> malformed Accept-Language header to the server.  If there are no other
> valid language tags, then send no header; otherwise, send only the vali=
d
> tags, ignoring "C" and "POSIX" wherever they may appear, as well as any=

> variants (such as the "C.UTF-8" locale found on some Linux systems).


Better docs -- the gettext manpages suck:
https://www.gnu.org/software/gettext/manual/html_node/Locale-Names.html
https://www.gnu.org/software/gettext/manual/html_node/The-LANGUAGE-variab=
le.html


At minimum this commit message needs revising. Gettext was adopted into
POSIX 2024 (Issue 8).


Respected by tools of course:
https://pubs.opengroup.org/onlinepubs/9799919799/utilities/gettext.html#t=
ag_20_54_08
https://pubs.opengroup.org/onlinepubs/9799919799/functions/gettext.html

$LANGUAGE docs can be found at

https://pubs.opengroup.org/onlinepubs/9799919799/basedefs/V1_chap08.html#=
tag_08_02


"""
The value of LANGUAGE shall be a list of locale names separated by a
<colon> (':') character. If LANGUAGE is set to a non-empty string, each
locale name shall be tried in the specified order and if a messages
object is found, it shall be used for translation. If a locale name has
the format language[_territory][.codeset][@modifier], additional
searches of locale names without .codeset (if present), without
_territory (if present), and without @modifier (if present) may be perfor=
med
"""


And, for locale name values,

"""
If the locale value is "C" or "POSIX", the POSIX locale shall be used
and the standard utilities behave in accordance with the rules in 7.2
POSIX Locale for the associated category.

If the locale value begins with a <slash>, it shall be interpreted as
the pathname of a file that was created in the output format used by the
localedef utility; see OUTPUT FILES under localedef. Referencing such a
pathname shall result in that locale being used for the indicated categor=
y.

[XSI] [Option Start] If the locale value has the form:

language[_territory][.codeset]

it refers to an implementation-provided locale, where settings of
language, territory, and codeset are implementation-defined.

LC_COLLATE , LC_CTYPE , LC_MESSAGES , LC_MONETARY , LC_NUMERIC , and
LC_TIME are defined to accept an additional field @modifier, which
allows the user to select a specific instance of localization data
within a single category (for example, for selecting the dictionary as
opposed to the character ordering of data). The syntax for these
environment variables is thus defined as:

[language[_territory][.codeset][@modifier]]
"""


Your tests and code are probably broken -- they appear to normalize
nearly none of the standard grammar into valid Accept-Language entries.
Of course, "surely nobody actually does that" (except when they do!) --
but it's a relatively simple grammar structure, simply getting the
"shape" correct seems like a good idea.


--=20
Eli Schwartz

--------------SjonMCWWvGCYaiApVheojeVP--

--------------W1Fdr820ISRHbBAAMC05eNV1
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQTnFNnmK0TPZHnXm3qEp9ErcA0vVwUCaHXbOwUDAAAAAAAKCRCEp9ErcA0vVzUd
AP9qEiVhLveAbA08AiBAAcpNOeTaYfIQoIDvD84FZG+hOQD+MXhc2EgVSjcMjxVBUvlYcqGkt0Ti
0n97Y57iiWz1qQk=
=AiMz
-----END PGP SIGNATURE-----

--------------W1Fdr820ISRHbBAAMC05eNV1--
