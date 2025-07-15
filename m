Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894AF28B415
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 14:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752589333; cv=none; b=h0B2S9Uu8lpMh4pzOWjeFNWr1JerDWQ3fARVZuvdqmwwCtNl2mvHSazNOzq3BbJMH2OeLzalksCJDIB5u7YJip/zAbQrjMSJLluTTglLA3x1UaV3axBYNu9kq0dfQbrjc49Mci3r+/c5R7TcuOBf9OD/1IFFt1+IS+bbyFgncL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752589333; c=relaxed/simple;
	bh=GM4pp6HR54WpJL/pZ3x2hH4njpf+KJEUArHPfdyGNyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EwhnD+2MYDfOJdNn8o4rQP39Z6Z7GFQURJ26hJGAUi5eUVKmQKFhMIo+9fU1XVr2GmfRA5wVHr+wRsUEuB25x20zinwwbJmhg8vfjJcQc2Sx8NkpqLyyS/yrlxvmFPkX0UQ5GCLaLx6Q667BSSRwjEnJdKNjThCb6FEU5BvSh0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [IPV6:2603:6011:3f0:6f00::12ac] (unknown [IPv6:2603:6011:3f0:6f00::12ac])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: eschwartz)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 7AE1133BE12;
	Tue, 15 Jul 2025 14:22:10 +0000 (UTC)
Message-ID: <a0faa9b9-3c65-44c9-97e0-bcf2af053f5e@gentoo.org>
Date: Tue, 15 Jul 2025 10:22:07 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] meson: disable PCRE2 dependency by default in macOS
To: Carlo Arenas <carenas@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, sandals@crustytoothpaste.net
References: <20250713122341.17976-1-carenas@gmail.com>
 <20250713174807.32444-1-carenas@gmail.com>
 <2414b962-e843-4ac0-814f-bb4bc7aacda7@gentoo.org>
 <CAPUEspjCbi0U6HYxEvpqMW9FPLn98VMePDTNfadQbt_9GHsZsw@mail.gmail.com>
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
In-Reply-To: <CAPUEspjCbi0U6HYxEvpqMW9FPLn98VMePDTNfadQbt_9GHsZsw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------gHECec0aELV0pKtF26Km0HZL"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------gHECec0aELV0pKtF26Km0HZL
Content-Type: multipart/mixed; boundary="------------7DxCz00R1GTyAdhI0bn30spt";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@gentoo.org>
To: Carlo Arenas <carenas@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, sandals@crustytoothpaste.net
Message-ID: <a0faa9b9-3c65-44c9-97e0-bcf2af053f5e@gentoo.org>
Subject: Re: [PATCH v3] meson: disable PCRE2 dependency by default in macOS
References: <20250713122341.17976-1-carenas@gmail.com>
 <20250713174807.32444-1-carenas@gmail.com>
 <2414b962-e843-4ac0-814f-bb4bc7aacda7@gentoo.org>
 <CAPUEspjCbi0U6HYxEvpqMW9FPLn98VMePDTNfadQbt_9GHsZsw@mail.gmail.com>
In-Reply-To: <CAPUEspjCbi0U6HYxEvpqMW9FPLn98VMePDTNfadQbt_9GHsZsw@mail.gmail.com>

--------------7DxCz00R1GTyAdhI0bn30spt
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 7/15/25 8:01 AM, Carlo Arenas wrote:
> On Mon, Jul 14, 2025 at 6:55=E2=80=AFPM Eli Schwartz <eschwartz@gentoo.=
org> wrote:
>>
>> Please double-check my work, that this compiler.has_header() is
>> sufficient on your reproducer system to detect and disable the
>> non-working feature.
>=20
> it is indeed all that was needed, abd makes me wonder
> if a future version of dependency() shouldn't have a "has_header"
> parameter like the one used in find_libray() to allow for this
> validation to happen internally and fallback as needed.


It's... possible, I suppose, but usually not needed unless a distributor
doesn't respond to reports that their OS is broken. Which well, fair
enough, happens. :)

Another possibility is to add a quirk to meson's underlying python code.
If pcre2 is searched, and the platform is darwin, also check the header.
You'll need a small override in mesonbuild/dependencies/*.py, like:


class PCRE2PkgConfigDependency(PkgConfigDependency):
    def __init__(...):
        super().__init__(...)
        if is_darwin:
            self.is_found =3D check_that_header()


> Posted a v4 with your code and modifications to still allow a
> fallback to the wrap.


Thanks. :)

--=20
Eli Schwartz

--------------7DxCz00R1GTyAdhI0bn30spt--

--------------gHECec0aELV0pKtF26Km0HZL
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQTnFNnmK0TPZHnXm3qEp9ErcA0vVwUCaHZkDwUDAAAAAAAKCRCEp9ErcA0vV4tT
AQD2g6+lhT35dla7XMRv4R8nG6BEJ6oFhIkhpzyoUMi9TwD8CJQnnqmEoyv0DF3vXVbj/f84Irof
IkpbBNpqu5F22AM=
=NMw0
-----END PGP SIGNATURE-----

--------------gHECec0aELV0pKtF26Km0HZL--
