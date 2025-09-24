Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42D0314A9D
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 17:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758734110; cv=none; b=jEmyXmLpEqdKuf3LQeW10gonSSIjWeIxgsay2D8bJTqTlWe4LhAS6ge4SWunt31e/qXLpinJAl8Mc8iEYBNsOz4kupQgRy7I9xR8C7lG/ZjTNIWfO4OBJlST+Oma2vIdlK1u4sCK7EDlVKPtnSuWWSPIQM/iR+XERaOemCxRGDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758734110; c=relaxed/simple;
	bh=iFmYDcVhU5UjcOgWAUXvztjp3s3c3+b8+pj0+nliyXs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=WkwtipbyAgcqAbGwIYXBqHa6zqgk3Xaj9FAurQTfzwT/VBfDExPbaPDau7AP3LbSnLYuLEgHFLMHaRJfEqrgLRK3JfNgbnfY6YM3LxXLZKCaY2prkmkUlmlbR88iHcJPgXZ38Tctb/Jc8Tm8/ID7+NJNMCD8xx/FbhD+IgUEoYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=velocifyer.com; spf=pass smtp.mailfrom=velocifyer.com; dkim=pass (2048-bit key) header.d=velocifyer.com header.i=@velocifyer.com header.b=CTV5+2Mv; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=velocifyer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=velocifyer.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=velocifyer.com header.i=@velocifyer.com header.b="CTV5+2Mv"
Message-ID: <f1599790-b48c-4c37-8cf7-4756f5064d2e@velocifyer.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=velocifyer.com;
	s=key1; t=1758734105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iFmYDcVhU5UjcOgWAUXvztjp3s3c3+b8+pj0+nliyXs=;
	b=CTV5+2Mvt4vbcCtiIT+1Rtf6JHtW9SAt43cNr73ihlleJayc3JEtpMN20w3P0Tmm24GS7j
	QhJc7/gVQTDFmgpJNJX131gxJs08UC91an6rt5NpsnoS61u/jsd4fLzNanEUOObBIEIb/w
	PIRx9hE5uO+SuIrIWeTsjdauDegxh4uzWes0AHO8bK0RP0oievr1rlLGeucwOFf0oTMSeO
	MyrrnEYj+FmobETj3XJyxV/ZKXg+kcArI5JfFANfDyoM17pJ/8RfKlyaiuqSrIumztnlgq
	xxsQw8y9rpI/BBl3nM+S5AtS2ILXht7dzFseYNDlba7Hmn0TbNudO2YMkWJSWw==
Date: Wed, 24 Sep 2025 13:15:02 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: 0-Based indexes for git log
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: =?UTF-8?B?8J2VjfCdlZbwnZWd8J2VoPCdlZTwnZWa8J2Vl/CdlarwnZWW8J2Vow==?=
 <velocifyer@velocifyer.com>
To: git@vger.kernel.org
References: <fd7758e5-7719-4bed-b1b3-2137c49cc950@velocifyer.com>
Content-Language: en-US
Autocrypt: addr=velocifyer@velocifyer.com; keydata=
 xjMEaCpEhBYJKwYBBAHaRw8BAQdAZBZWSN4ekixMHE7duMBmw/2uteCfmp68D/mxaYk/dyrN
 JlZlbG9jaWZ5ZXIgPHZlbG9jaWZ5ZXJAdmVsb2NpZnllci5jb20+wo8EExYIADcWIQQboPxL
 gODyGwJpjO5jTr+HQMdIvgUCaCpEhAUJBaOagAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEGNO
 v4dAx0i+HU8BAJGd99DA1VdBzcYgch16XK7mC78ZqEwGegVCRerWry8RAQC3MJUOiyQ062Ol
 /3iNXY6zk2QXaAsV8eUbFKUo1HiwAs44BGgqRIUSCisGAQQBl1UBBQEBB0CEoaVGilG8Qt/y
 Xp135G4fhWjJH7VQkPIFo8/MsZspfwMBCAfCfgQYFggAJhYhBBug/EuA4PIbAmmM7mNOv4dA
 x0i+BQJoKkSFBQkFo5qAAhsMAAoJEGNOv4dAx0i+yNYBAKcE1fbRCPqWwsIpRvOjSq9Spvhl
 veEFpUMPaQ1tp7qOAPkBfZroJ8veENH/8sz+Gf/QK6O1kcqC4d/vAASzMpOiAQ==
In-Reply-To: <fd7758e5-7719-4bed-b1b3-2137c49cc950@velocifyer.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------C03tlAjy8C4gj6mpnL1F7xmI"
X-Migadu-Flow: FLOW_OUT

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------C03tlAjy8C4gj6mpnL1F7xmI
Content-Type: multipart/mixed; boundary="------------gdc70RpygFYKbPCl1FaoMWWS";
 protected-headers="v1"
From: =?UTF-8?B?8J2VjfCdlZbwnZWd8J2VoPCdlZTwnZWa8J2Vl/CdlarwnZWW8J2Vow==?=
 <velocifyer@velocifyer.com>
To: git@vger.kernel.org
Message-ID: <f1599790-b48c-4c37-8cf7-4756f5064d2e@velocifyer.com>
Subject: Re: 0-Based indexes for git log
References: <fd7758e5-7719-4bed-b1b3-2137c49cc950@velocifyer.com>
In-Reply-To: <fd7758e5-7719-4bed-b1b3-2137c49cc950@velocifyer.com>

--------------gdc70RpygFYKbPCl1FaoMWWS
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

PiBJbiBnaXQgbG9nIGl0IHVzZXMgYSAxLWJhc2VkIGluZGV4IGZvciB0aGUgZGF0ZSBpbnN0
ZWFkIG9mIGEgMCBiYXNlZCANCj4gaW5kZXguIFNvIGl0IHNheXMgIkZyaSBTZXAgMTkgMTQ6
MjM6MjQgMjAyNSAtMDQwMCIgd2hlbiBpdCBzaG91bGQgc2F5IA0KPiAiRnJpIFNlcCAxOCAx
NDoyMzoyNCAyMDI1IC0wNDAwIiAob3IgIkZyaWRheSAyMDI1LTgtMTjCoDE0OjIzOjI0IA0K
PiAoLTQ6MDAuMDApIsKgIHRvIGdldCBhIGJldHRlciBmb3JtYXQpDQo+DQpJIHN1Z2dlc3Qg
Z2l0IGFkZHMgYSBjb25maWcgb3B0aW9uIGZvciAwLWJhc2VkIGRhdGUgYW5kIGF1dG9tYXRp
Y2x5IHVzZXMgDQowLWJhc2VkIGRhdGUgaWYgdGhlcmUgaXMgYSBmaWxlIGF0ICRIT01FL3Vz
ZS0wLWJhc2VkLWluZGV4LWZvci1kYXRlIG9yIA0KJFVTRS0wLUJBU0VELUlOREVYLUZPUi1E
QVRFID09IHRydWUNCg0KLS0gDQpHZW9yZ2UgdHJ1bHksIPCdlY3wnZWW8J2VnfCdlaDwnZWU
8J2VmvCdlZfwnZWq8J2VlvCdlaMNClRoaXMgZW1haWwgZG9lcyBub3QgY29uc3RpdHV0ZSBh
IGxlZ2FsbHkgYmluZGluZyBjb250cmFjdA0K

--------------gdc70RpygFYKbPCl1FaoMWWS--

--------------C03tlAjy8C4gj6mpnL1F7xmI
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQboPxLgODyGwJpjO5jTr+HQMdIvgUCaNQnFgUDAAAAAAAKCRBjTr+HQMdIvm8T
AP9S5qVjeEvNHRmmrqyfc0577WuP5p2QaKzVvqO7tIDohgD+NOlVoKh3wqde/FN+KK00PA6c85MA
X5q/P7xTdefZVQE=
=A6Wg
-----END PGP SIGNATURE-----

--------------C03tlAjy8C4gj6mpnL1F7xmI--
