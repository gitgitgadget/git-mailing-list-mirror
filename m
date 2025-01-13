Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3E21BD9C7
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 17:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736790726; cv=none; b=dIbaA930GgiaDN1AfLy7cC3IqCMs7fd2Rr/XI9tSL731sAfhdKj9SJlHjrz9ZXYdtTK9L3rKhfz++9oc9U5U+IY0Q6EdF8FCzi4XaO/6gFtRjnZWh26vPLLH6TEPH9KYrqgn8Ifh7byoKu0Z8yFov4RCrkOpB5lZW9kBHCwDCwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736790726; c=relaxed/simple;
	bh=PlXXYN4z0FmPCCuxpgt4gIFCU1LW7trjOwwDIMOsqD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GxwGnhuKnop+KqTGuH7ngYC0qHCCSBp5RBdW/YDhmBIFc93vfPs3Si0f7RHNPkwqOuX+8NK2uT35CRhAG8LUVrj0Gk/Em4Mx7DSZCy2h20Icl+O3dD4ZUxlZcj3e1PyN5c7vR20h9OGPPtycSTdNX157INSQFpO29fOkNdQxOGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Message-ID: <c36dc170-2792-41e2-b128-04c7c5e7ab55@gentoo.org>
Date: Mon, 13 Jan 2025 12:51:59 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] GIT-VERSION-GEN: move default version into a separate
 file
To: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Evan Martin <evan.martin@gmail.com>
References: <20250113-b4-pks-meson-additions-v1-0-97f6a93f691d@pks.im>
 <20250113-b4-pks-meson-additions-v1-2-97f6a93f691d@pks.im>
 <xmqqa5bua9vy.fsf@gitster.g>
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
In-Reply-To: <xmqqa5bua9vy.fsf@gitster.g>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------vWklZvQlJ3ONG5mGtdGihxu2"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------vWklZvQlJ3ONG5mGtdGihxu2
Content-Type: multipart/mixed; boundary="------------3BRell0IwtSy9kh3Q1mapsOk";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@gentoo.org>
To: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Evan Martin <evan.martin@gmail.com>
Message-ID: <c36dc170-2792-41e2-b128-04c7c5e7ab55@gentoo.org>
Subject: Re: [PATCH 2/9] GIT-VERSION-GEN: move default version into a separate
 file
References: <20250113-b4-pks-meson-additions-v1-0-97f6a93f691d@pks.im>
 <20250113-b4-pks-meson-additions-v1-2-97f6a93f691d@pks.im>
 <xmqqa5bua9vy.fsf@gitster.g>
In-Reply-To: <xmqqa5bua9vy.fsf@gitster.g>

--------------3BRell0IwtSy9kh3Q1mapsOk
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 1/13/25 12:42 PM, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
>>   - We can pull the default version out of GIT-VERSION-GEN and move it=

>>     into its own file. This likely requires some adjustments for scrip=
ts
>>     that bump the version, but allows Meson to read the version from
>>     that file trivially.
>>
>> The last option is a proper solution and quite trivial to implement, a=
nd
>> adapting scripts should be a one-time event. Refactor GIT-VERSION-GEN
>> accordingly.
>=20
> It is not clear what "proper" is.  It smells like we are bending an
> established work flow element to placate a tool that is not willing
> to cooperate, which is very much unwelcome.


If I understand correctly, the constraint is that it should work on
Windows, which means there is a bootstrap issue regarding detection of
an "sh" command for running ./GIT-VERSION-GEN

Proper simply means it works reliably on all supported targets.


> Compared to that, grepping for "^DEF_VER=3D" in the file may be less
> yucky.


Or for the sake of Windows portability, grep_version.py?


--=20
Eli Schwartz

--------------3BRell0IwtSy9kh3Q1mapsOk--

--------------vWklZvQlJ3ONG5mGtdGihxu2
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQTnFNnmK0TPZHnXm3qEp9ErcA0vVwUCZ4VSvwUDAAAAAAAKCRCEp9ErcA0vV4T8
AP9i+fJ+BT0Y+vmmF02kT6Co24FeQccAmjd5rc9uo5r1OgD/UIvVurUzc0DPlI9lXGnpc3K+KFWW
yFG4m4BUru1rxAU=
=cxOf
-----END PGP SIGNATURE-----

--------------vWklZvQlJ3ONG5mGtdGihxu2--
