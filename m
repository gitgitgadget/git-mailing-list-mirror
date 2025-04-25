Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3BA21C178
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 05:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745558846; cv=none; b=WHsu2qhmFemHQ40IXUESxaDPH2U5+18MRXfkmSwxJ/8eJwLiIYlawcyajttchiDW8Axr+9xLnJwNtbd2bV1oeUobyZlnfLWHs+5/08Ac1hZADXaVbHz6un4di9pawrFQ9wXR9JuUl6EhSVrFfHByhPmSIOPxXdoFlG1kl/+bp/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745558846; c=relaxed/simple;
	bh=A6aTzi+rHpfktfFXrBCILGHrOYqzSeEulHA2Wff/lus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=shIppbB7DbTRfB4p7ONy5FEKRrvZA6t3fBWtTtoMyEnzF36JqmmWYGEb/Ilr/PJeWxoNX6/e7o3jvwoXoekBMadT9fZ3bNtdCOVMLh65ruPJRzmZAJCcM7KZywXD0MjZoZeDSwRWy4aJbY013XjiPFNFkWwad0G6BX0OLf68rLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [IPV6:2603:6011:3f0:6f00::12ac] (unknown [IPv6:2603:6011:3f0:6f00::12ac])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: eschwartz)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 20F12342FE0;
	Fri, 25 Apr 2025 05:27:24 +0000 (UTC)
Message-ID: <7d7c22c9-953f-43b4-8976-9303effd63ea@gentoo.org>
Date: Fri, 25 Apr 2025 01:27:21 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] meson: miscellaneous system detection fixes
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Sam James <sam@gentoo.org>,
 Junio C Hamano <gitster@pobox.com>
References: <20250421175247.240971-1-eschwartz@gentoo.org>
 <20250425002017.246985-1-eschwartz@gentoo.org> <aAsSDA5y_Dur9PGj@pks.im>
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
In-Reply-To: <aAsSDA5y_Dur9PGj@pks.im>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------JGL3OrS6Ms2PSMy03M0dOnno"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------JGL3OrS6Ms2PSMy03M0dOnno
Content-Type: multipart/mixed; boundary="------------t0ujEVS9XygoV8Cpb4a9Dopq";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@gentoo.org>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Sam James <sam@gentoo.org>,
 Junio C Hamano <gitster@pobox.com>
Message-ID: <7d7c22c9-953f-43b4-8976-9303effd63ea@gentoo.org>
Subject: Re: [PATCH v2 0/6] meson: miscellaneous system detection fixes
References: <20250421175247.240971-1-eschwartz@gentoo.org>
 <20250425002017.246985-1-eschwartz@gentoo.org> <aAsSDA5y_Dur9PGj@pks.im>
In-Reply-To: <aAsSDA5y_Dur9PGj@pks.im>

--------------t0ujEVS9XygoV8Cpb4a9Dopq
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 4/25/25 12:39 AM, Patrick Steinhardt wrote:
> On Thu, Apr 24, 2025 at 08:13:29PM -0400, Eli Schwartz wrote:
>> Principally motivated to handle an issue where these were failing to
>> detect the system properly, on Solaris.
>=20
> I was expecting to also see my comments addressed around the one style
> issue as well as the comment regarding `fs.exists()` being a bit too
> magical (both mentioned in [1]). This is the only remaining item that
> I'd like to see addressed, and other than that this series looks good t=
o
> me.


I overlooked the style comment, will fix.

Regarding the fs.exists I was worried that it would be repetitive and
unwieldy but I think I found a good solution, as a bonus I can now
handle strtoumax.


--=20
Eli Schwartz

--------------t0ujEVS9XygoV8Cpb4a9Dopq--

--------------JGL3OrS6Ms2PSMy03M0dOnno
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQTnFNnmK0TPZHnXm3qEp9ErcA0vVwUCaAsdOQUDAAAAAAAKCRCEp9ErcA0vV6YQ
AQCpIAd4gFXnbXBdEXgtI1bVtar/H52iGluSjUIsxsjpUgEAyavGj2uLyNxV/4wEHnnn8pGJdPLM
AG1R6BDat0nAZQg=
=fhKY
-----END PGP SIGNATURE-----

--------------JGL3OrS6Ms2PSMy03M0dOnno--
