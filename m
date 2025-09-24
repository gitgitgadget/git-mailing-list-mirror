Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D038314A7B
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 17:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758733310; cv=none; b=PDtBKRFk4QrYQiK1asJesf+Tdi75zYX4rZjNAeRbOl7eHMwfSDVUV9fY+L6iFHX1SBvZPHVHb/gQ8YYHOzBzKro9KTHnw0xh7hbV/639viOPv3Hfi+HZ53FNEdxGJPQJSa6h8ISjlPrau60wKeBPA0+pKmr0NIJmp+6RKmVcMh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758733310; c=relaxed/simple;
	bh=+m5HQbyRcjh5lLzCeQGd9zZtumRMKdXp4/Xw0q8x44Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vEgEEIE5VOZ83dsLnjKdIJU0WmyanujST6PkHXYlQQ6idKiKgLVkkpxoDjLE20ixPoYcEDMLKY2cO39+BINs/CASPEC2DvN8KA2UOw6JmBM4XHVmjnXy8422RO0c/JidVhAFOXwzvN2JbAWEPG27ash5xUzICmMsKJ7aHz6OVZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=velocifyer.com; spf=pass smtp.mailfrom=velocifyer.com; dkim=pass (2048-bit key) header.d=velocifyer.com header.i=@velocifyer.com header.b=IDa8VCkX; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=velocifyer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=velocifyer.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=velocifyer.com header.i=@velocifyer.com header.b="IDa8VCkX"
Message-ID: <75860b99-b7b5-4398-b32f-47a4873508aa@velocifyer.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=velocifyer.com;
	s=key1; t=1758733299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+m5HQbyRcjh5lLzCeQGd9zZtumRMKdXp4/Xw0q8x44Y=;
	b=IDa8VCkXtBMyb56Kh7LLuFAQu+s19lqxjbThOkBsIqFs0CM9glvPe/A8LjrzdMr9mIl08g
	ZBYgcoQfQOthrvgOmQ0swLmXatdUEfNPDaoXy3nHCA/VsBywH+E0VUpxp9j4vNE1olXqTT
	BgZIWiySJUGDkMVA7gzybn7AOMCs5IftLaLRgCZBQj4cwoLwUSvtg3p2KPQUCY4qmU2Y55
	x+4lQAtRHt8ikvdVY4HzJgEpz5FvxjlQbw3o3Wps5FIAYXDD38yZXBfeJFcVRFPjfxfGYl
	fKgdFAtycTjPJDOBXwLbUNf1G61hntjZHhz+H8Pjr02+zraQU4edfUWRVsfkVg==
Date: Wed, 24 Sep 2025 13:01:30 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: 0-Based indexes for git log
To: Nico Williams <nico@cryptonector.com>
Cc: git@vger.kernel.org
References: <fd7758e5-7719-4bed-b1b3-2137c49cc950@velocifyer.com>
 <aNQRoMgSRVvNtStG@ubby>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: =?UTF-8?B?8J2VjfCdlZbwnZWd8J2VoPCdlZTwnZWa8J2Vl/CdlarwnZWW8J2Vow==?=
 <velocifyer@velocifyer.com>
Autocrypt: addr=velocifyer@velocifyer.com; keydata=
 xjMEaCpEhBYJKwYBBAHaRw8BAQdAZBZWSN4ekixMHE7duMBmw/2uteCfmp68D/mxaYk/dyrN
 JlZlbG9jaWZ5ZXIgPHZlbG9jaWZ5ZXJAdmVsb2NpZnllci5jb20+wo8EExYIADcWIQQboPxL
 gODyGwJpjO5jTr+HQMdIvgUCaCpEhAUJBaOagAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEGNO
 v4dAx0i+HU8BAJGd99DA1VdBzcYgch16XK7mC78ZqEwGegVCRerWry8RAQC3MJUOiyQ062Ol
 /3iNXY6zk2QXaAsV8eUbFKUo1HiwAs44BGgqRIUSCisGAQQBl1UBBQEBB0CEoaVGilG8Qt/y
 Xp135G4fhWjJH7VQkPIFo8/MsZspfwMBCAfCfgQYFggAJhYhBBug/EuA4PIbAmmM7mNOv4dA
 x0i+BQJoKkSFBQkFo5qAAhsMAAoJEGNOv4dAx0i+yNYBAKcE1fbRCPqWwsIpRvOjSq9Spvhl
 veEFpUMPaQ1tp7qOAPkBfZroJ8veENH/8sz+Gf/QK6O1kcqC4d/vAASzMpOiAQ==
In-Reply-To: <aNQRoMgSRVvNtStG@ubby>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------JXNvOKtIf7YGTWbCQ8s9YbnR"
X-Migadu-Flow: FLOW_OUT

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------JXNvOKtIf7YGTWbCQ8s9YbnR
Content-Type: multipart/mixed; boundary="------------Hf6mkwZWJoPZ14UwYl005p1q";
 protected-headers="v1"
From: =?UTF-8?B?8J2VjfCdlZbwnZWd8J2VoPCdlZTwnZWa8J2Vl/CdlarwnZWW8J2Vow==?=
 <velocifyer@velocifyer.com>
To: Nico Williams <nico@cryptonector.com>
Cc: git@vger.kernel.org
Message-ID: <75860b99-b7b5-4398-b32f-47a4873508aa@velocifyer.com>
Subject: Re: 0-Based indexes for git log
References: <fd7758e5-7719-4bed-b1b3-2137c49cc950@velocifyer.com>
 <aNQRoMgSRVvNtStG@ubby>
In-Reply-To: <aNQRoMgSRVvNtStG@ubby>

--------------Hf6mkwZWJoPZ14UwYl005p1q
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

PiBEYXkgb2YgbW9udGggbnVtYmVycyBhcmUgMS1iYXNlZC4NCg0KSSBjb25zaWRlciBkYXkg
b2YgbW9udGggdG8gdXNlIGEgMC1iYXNlZCBpbmRleA0KDQotLSANCkdlb3JnZSB0cnVseSwg
8J2VjfCdlZbwnZWd8J2VoPCdlZTwnZWa8J2Vl/CdlarwnZWW8J2Vow0KVGhpcyBlbWFpbCBk
b2VzIG5vdCBjb25zdGl0dXRlIGEgbGVnYWxseSBiaW5kaW5nIGNvbnRyYWN0DQo=

--------------Hf6mkwZWJoPZ14UwYl005p1q--

--------------JXNvOKtIf7YGTWbCQ8s9YbnR
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQboPxLgODyGwJpjO5jTr+HQMdIvgUCaNQj6gUDAAAAAAAKCRBjTr+HQMdIvgQ1
AP9115qD7onGWaoFtAqKIleiXvIJl1JJ4MvJzn7qMv7TlgD9HnxVPcrt9y+2odzOmnKeMYMpzCzO
01zOTflYtUu2iAU=
=FP3a
-----END PGP SIGNATURE-----

--------------JXNvOKtIf7YGTWbCQ8s9YbnR--
