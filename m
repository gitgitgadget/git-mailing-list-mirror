Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F7A26F2BE
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 19:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758656532; cv=none; b=i0TwJkxg+dq2/8FPkxLgXy4U0iOXGHmxWqB2rmDFrntucOCNk1ZzpHxoyuIpDiq2l0h3N+FwuNXdjUQ2oAywlzz89CWZ9QSL08InD3XSV/mah0xg3uBu+H0aEdX0CMSSI70WlmjVwppmW/I4oW+yyNN+VblFyBzWnP38+KlO+J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758656532; c=relaxed/simple;
	bh=cvqqzbjUWiiAJEJ6HAdQ+Ju9WQ+Vs48WJIeQlQ0oZbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FfeHIfW+nTlOaZiaSZdZ1RtVA+gKm4FjLMfZGDwtaCQw/YyCxIy7Igm65HDBHSBeq7IaGu434x4m5SIXleIk8FOLsYJ4Irr9alurx+VNt26C+iaAGMyiTocRKd1tE6zQ0D3fRhMWo8Ik+tlNdnCuGyDNFUgzGz/l2gWeZXHjhmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=velocifyer.com; spf=pass smtp.mailfrom=velocifyer.com; dkim=pass (2048-bit key) header.d=velocifyer.com header.i=@velocifyer.com header.b=P+IwBa2H; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=velocifyer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=velocifyer.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=velocifyer.com header.i=@velocifyer.com header.b="P+IwBa2H"
Message-ID: <b5867a92-c516-4a66-a108-8cabbc166336@velocifyer.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=velocifyer.com;
	s=key1; t=1758656525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cvqqzbjUWiiAJEJ6HAdQ+Ju9WQ+Vs48WJIeQlQ0oZbQ=;
	b=P+IwBa2HhMTJ2/GCvYZjhVWTrPMaw0TwonOoqnBa8iZq/kYsR1P6EuWwj0TbWSVY7KXylE
	cXggSrp2GUNNGZwoxVfk663R6ebGhBeI1BbAUVPi7h/gjBJH9wm7Sh0Z2uutabvYrwokSl
	4+XXctHxRn7MmiHoS/QNZ/ybGcNWBX8bUFx7mo+iBSatnecsaChWn22O4C42HonFmb5XgF
	0uIQPS89qWePVvKTW29aJk8S429K4YeqzXfX/gqqe1r7brKnzHkEAZvXpw376S0v4vfmeL
	OrNIvgCvT54qdtoLuq3fQ/kbUpXtE1dFPKKqcY1+1pW+ynru5CSBKmaiTnripg==
Date: Tue, 23 Sep 2025 15:41:55 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: How do i get news of git releases
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org
References: <4ea9cb1e-4367-4926-a9ba-0680dd63e616@velocifyer.com>
 <CAP8UFD2asXf_4_02khYRVWVQruBdvoMkZVE-6cVHttT9gHdWqw@mail.gmail.com>
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
In-Reply-To: <CAP8UFD2asXf_4_02khYRVWVQruBdvoMkZVE-6cVHttT9gHdWqw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------fuPwsBoYDEuX0awQ0n30anNV"
X-Migadu-Flow: FLOW_OUT

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------fuPwsBoYDEuX0awQ0n30anNV
Content-Type: multipart/mixed; boundary="------------sC0B018O03CUKcbAr0bFhauf";
 protected-headers="v1"
From: =?UTF-8?B?8J2VjfCdlZbwnZWd8J2VoPCdlZTwnZWa8J2Vl/CdlarwnZWW8J2Vow==?=
 <velocifyer@velocifyer.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org
Message-ID: <b5867a92-c516-4a66-a108-8cabbc166336@velocifyer.com>
Subject: Re: How do i get news of git releases
References: <4ea9cb1e-4367-4926-a9ba-0680dd63e616@velocifyer.com>
 <CAP8UFD2asXf_4_02khYRVWVQruBdvoMkZVE-6cVHttT9gHdWqw@mail.gmail.com>
In-Reply-To: <CAP8UFD2asXf_4_02khYRVWVQruBdvoMkZVE-6cVHttT9gHdWqw@mail.gmail.com>

--------------sC0B018O03CUKcbAr0bFhauf
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

PiBUaGUgVVJMIGZvciBlYWNoIHJlbGVhc2UgcG9pbnRzIHRvIHRoZSBhbm5vdW5jZW1lbnQg
ZW1haWwgb24gdGhlDQo+IG1haWxpbmcgbGlzdCBhcmNoaXZlLiBUaGF0IGVtYWlsIGNvbnRh
aW5zIHRoZSByZWxlYXNlIG5vdGVzLg0KSWYgdGhleSBhbHJlYWR5IGhhdmUgdGhlIHJlYWxl
YXNlIG5vdGVzIG9uIHRoZSBtYWlsaW5nIGxpc3QsIHdoeSBkbyB0aGV5IA0Kbm90IGhhdmUg
YSBzZXByYXRlICJnaXQtYW5ub3VuY2UiIG1haWxpbmcgbGlzdCB3aXRoIGp1c3QgdGhlIHJl
bGVhc2UgDQpub3RlcyBhbmQgb3RoZXIgaW1wb3J0YW50IGFubm91bmNlbWVudHMNCi0tIA0K
R2VvcmdlIHRydWx5LCDwnZWN8J2VlvCdlZ3wnZWg8J2VlPCdlZrwnZWX8J2VqvCdlZbwnZWj
DQpJbXByb3ZlIHlvdXIgd2lmaSByZWNlcHRpb24gZm9yIGZyZWUgDQo8aHR0cHM6Ly93d3cu
eW91dHViZS5jb20vd2F0Y2g/dj1MWThXaTdYUlhDQT4NClRoaXMgZW1haWwgZG9lcyBub3Qg
Y29uc3RpdHV0ZSBhIGxlZ2FsbHkgYmluZGluZyBjb250cmFjdCDigK4NClJlbWVtYmVyIHRv
IHJlcGx5IGFsbCBvbiBtYWlsaW5nIGxpc3RzICh0aGlzIGlzIGhlcmUgc28gaSBkb24ndCBm
b3JnZXQgDQp0byB1c2UgcmVwbHkgYWxsKShJZiB5b3UgYXJlIHJlYWRpbmcgdGhpcyBpIGZv
cmdvdCB0byByZW1vdmUgaXQpDQo=

--------------sC0B018O03CUKcbAr0bFhauf--

--------------fuPwsBoYDEuX0awQ0n30anNV
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQboPxLgODyGwJpjO5jTr+HQMdIvgUCaNL4AwUDAAAAAAAKCRBjTr+HQMdIvlaC
AP9Lo/S20RHuErPnLl8V+buKTaRLfe9nZMctFqnrnRDNcgEAoII7YIp/xlKbg/s1MkLMFM9MrGkz
QHME1gfwV2ehXA0=
=X+QB
-----END PGP SIGNATURE-----

--------------fuPwsBoYDEuX0awQ0n30anNV--
