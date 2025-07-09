Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F15B4317D
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 00:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752021732; cv=none; b=PLV48+gMdcyhT0La0iV+8FktidzvZooVePfCG1xWAOQq9DCfkMbK6RD5YzP/U+qtVsnZNx35D3WnFPDTPXml9gCZ2VrgivZhXiuTlbQMqtGguLjhnZH4u0/05xS8SuYBKOQbS2EDdH4euFrqabJn1ZpLHDZll4RXkbnSRei5xrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752021732; c=relaxed/simple;
	bh=pWdAb5uEqj2QaY0xgqhpIHbJJFb2P1Wa2cShbJ1I1Bg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bgYuDETShgmeqd2Omoum8MuMXMNxJu1A//jWKBtLut5ajZgmRUNf2EF6/V1NGX0xwEB72ZtRfxc/2SH7lt8jDTFmVYV4fTGqeg8Gsiu21UfcWrz5xbJDL8tny28b2fkbShDEzgV9GHTumGSawjbYaalECotrWkRHpai5Im0iPhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [IPV6:2603:6011:3f0:6f00::12ac] (unknown [IPv6:2603:6011:3f0:6f00::12ac])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: eschwartz)
	by smtp.gentoo.org (Postfix) with ESMTPSA id E6214342536;
	Wed, 09 Jul 2025 00:41:16 +0000 (UTC)
Message-ID: <c629f3a6-4749-4ac0-8fbb-fd1fb9db1d0a@gentoo.org>
Date: Tue, 8 Jul 2025 20:41:13 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: locally storing issues/comments/projects
To: Sahil Gautam <printfdebugging@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <3e964e0d-bb90-4074-a9ae-a10fb02b3f50@gmail.com>
 <xmqq4ivmtlnf.fsf@gitster.g> <3a8590f3-ab8d-4155-b8c1-7cd34dc9db00@gmail.com>
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
In-Reply-To: <3a8590f3-ab8d-4155-b8c1-7cd34dc9db00@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------6cpG7U024buTQVfLun1iI2Ok"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------6cpG7U024buTQVfLun1iI2Ok
Content-Type: multipart/mixed; boundary="------------fsqFTU568uy5mE5TZh0I2weN";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@gentoo.org>
To: Sahil Gautam <printfdebugging@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Message-ID: <c629f3a6-4749-4ac0-8fbb-fd1fb9db1d0a@gentoo.org>
Subject: Re: locally storing issues/comments/projects
References: <3e964e0d-bb90-4074-a9ae-a10fb02b3f50@gmail.com>
 <xmqq4ivmtlnf.fsf@gitster.g> <3a8590f3-ab8d-4155-b8c1-7cd34dc9db00@gmail.com>
In-Reply-To: <3a8590f3-ab8d-4155-b8c1-7cd34dc9db00@gmail.com>

--------------fsqFTU568uy5mE5TZh0I2weN
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 7/8/25 8:21 PM, Sahil Gautam wrote:
>=20
> On 7/9/25 3:01 AM, Junio C Hamano wrote:
>> It would be very nice if these hosting providers can agree to make
>> project metainformations interchangeable in an open way.
>=20
> it's not just about migrations, it's about a repository being self
> reliant in itself. think of some git
> hosting provider blocking my account because of some ai algorithm, thin=
k
> of some disaster striking
> some data center or some malware deleting all the data on the servers,
> all these are quite possible.
>=20
> having git store that data means that you clone the whole thing and
> doesn't matter what happens
> to the hosting provider, if you have the repository, you have the whole=

> thing.


You may be interested in https://github.com/git-bug/git-bug


--=20
Eli Schwartz

--------------fsqFTU568uy5mE5TZh0I2weN--

--------------6cpG7U024buTQVfLun1iI2Ok
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQTnFNnmK0TPZHnXm3qEp9ErcA0vVwUCaG26qQUDAAAAAAAKCRCEp9ErcA0vV4tQ
AQCAwQyjrVEUzapZCI2MOgp4//q2JXg3Z6FicCWT4FsFPwD/akznPuvGAIUslbi3Lqepb8+7lmEe
gX2S1IUiX5B9owk=
=KK5o
-----END PGP SIGNATURE-----

--------------6cpG7U024buTQVfLun1iI2Ok--
