Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFCC285CA2
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 17:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758563029; cv=none; b=Jm5meK8CADdxsKaINEYEp0xJ1yB1mouYL4ZaxA/SKu+tB/UurUnnpANhPaMuUOdVCObvF2pS3enxOdn/EwDwQRcIMlPLG0obTQYLgfeBcUlgJbqyThgwBndbtMWoHqRfCG4iC/y5AlBOR7E4cRuv8P3yidIZoqHQpyiVeSK+JB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758563029; c=relaxed/simple;
	bh=0GXQvOi2n85Hwn7HfvwDkPpBAmFu7Nttid2f/uWnMl4=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=LWKHEPbst8+SbJv4P/PqJ4NE8RYnFk1UH+id8Tr1zrlbZmgdODyGCefPuxH3QA16pV8urmRKhBR0x5qYpM3nthUfmEZYhtJwpuMeK/mGNKzuhC3aYHJTHDQiTqu4DzsNYDwofL+MwsyOL/D/bRHZfpuIwK8nKaEhUQ0O/DMNwN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=velocifyer.com; spf=pass smtp.mailfrom=velocifyer.com; dkim=pass (2048-bit key) header.d=velocifyer.com header.i=@velocifyer.com header.b=iCTC4gkh; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=velocifyer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=velocifyer.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=velocifyer.com header.i=@velocifyer.com header.b="iCTC4gkh"
Message-ID: <4ea9cb1e-4367-4926-a9ba-0680dd63e616@velocifyer.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=velocifyer.com;
	s=key1; t=1758563024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	to:to:cc:mime-version:mime-version:content-type:content-type:autocrypt:autocrypt;
	bh=0GXQvOi2n85Hwn7HfvwDkPpBAmFu7Nttid2f/uWnMl4=;
	b=iCTC4gkhumWXzoOVq+KYfJMvUfb77S24Om3CBskha0A1bZqSqjKRAQTemViM0qE8XlYPNz
	JL6Nza8ieDp+b9O2XBtPWkvMfxITjADWlEetzK8Qs9QXE2szXDwCjnkRm5gKGp/QUMnGVE
	IjdZYrxHmB+HRy+LpxFh794mi6jA5xmqFbgjg+8fZ22ONjbuT7oQMwRPIYQd/RxGx+jfxD
	LQWoxXAg5jDpFKCQQ4srGaqbHl1/WCxO3qNTr1YG9AIfI4FmexYnfekTh+89BBVcx6jDwB
	04OjbuDKOHlq+V7v+UQGcrrGLgeLwGhmJYKooyb7a7h9sa/qKXGkk+Tc9QvFBA==
Date: Mon, 22 Sep 2025 13:43:31 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: =?UTF-8?B?8J2VjfCdlZbwnZWd8J2VoPCdlZTwnZWa8J2Vl/CdlarwnZWW8J2Vow==?=
 <velocifyer@velocifyer.com>
Subject: How do i get news of git releases
Autocrypt: addr=velocifyer@velocifyer.com; keydata=
 xjMEaCpEhBYJKwYBBAHaRw8BAQdAZBZWSN4ekixMHE7duMBmw/2uteCfmp68D/mxaYk/dyrN
 JlZlbG9jaWZ5ZXIgPHZlbG9jaWZ5ZXJAdmVsb2NpZnllci5jb20+wo8EExYIADcWIQQboPxL
 gODyGwJpjO5jTr+HQMdIvgUCaCpEhAUJBaOagAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEGNO
 v4dAx0i+HU8BAJGd99DA1VdBzcYgch16XK7mC78ZqEwGegVCRerWry8RAQC3MJUOiyQ062Ol
 /3iNXY6zk2QXaAsV8eUbFKUo1HiwAs44BGgqRIUSCisGAQQBl1UBBQEBB0CEoaVGilG8Qt/y
 Xp135G4fhWjJH7VQkPIFo8/MsZspfwMBCAfCfgQYFggAJhYhBBug/EuA4PIbAmmM7mNOv4dA
 x0i+BQJoKkSFBQkFo5qAAhsMAAoJEGNOv4dAx0i+yNYBAKcE1fbRCPqWwsIpRvOjSq9Spvhl
 veEFpUMPaQ1tp7qOAPkBfZroJ8veENH/8sz+Gf/QK6O1kcqC4d/vAASzMpOiAQ==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------HZZAPee5qVDPFiG0vp8ohr99"
X-Migadu-Flow: FLOW_OUT

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------HZZAPee5qVDPFiG0vp8ohr99
Content-Type: multipart/mixed; boundary="------------CDyTGqMAS2bIQUeRtno8wydF";
 protected-headers="v1"
From: =?UTF-8?B?8J2VjfCdlZbwnZWd8J2VoPCdlZTwnZWa8J2Vl/CdlarwnZWW8J2Vow==?=
 <velocifyer@velocifyer.com>
To: git@vger.kernel.org
Message-ID: <4ea9cb1e-4367-4926-a9ba-0680dd63e616@velocifyer.com>
Subject: How do i get news of git releases

--------------CDyTGqMAS2bIQUeRtno8wydF
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SG93IGRvIGkgZ2V0IGNoYW5nZWxvZ3MgZm9yIGdpdCBpbiBhIGNvbnZpbmVudCBmb3JtYXQg
KGxpa2UgZW1haWwgb3IgUlNTIA0Kb3IgQXRvbSk/wqAgSSBzZWUgdGhhdCBpIGNhbiBnZXQg
Y2hhbmdlbG9ncyBpbiAvRG9jdW1lbnRhdGlvbi9SZWxOb3Rlcy8gDQpidXQgdGhlbiBpIGhh
dmUgdG8gY2hlY2sgdGhlIGZvbGRlciBtYW51YWxseSBpbnN0ZWFkIG9mIGl0IGJlaW5nIGlu
IG15IA0KZW1haWwgYW5kIFJTUyBhbmQgQXRvbSBjbGllbnQgKFRodW5kZXJiaXJkKS4NCg0K
LS0gDQpHZW9yZ2UgdHJ1bHksIPCdlY3wnZWW8J2VnfCdlaDwnZWU8J2VmvCdlZfwnZWq8J2V
lvCdlaMNClRoaXMgZW1haWwgZG9lcyBub3QgY29uc3RpdHV0ZSBhIGxlZ2FsbHkgYmluZGlu
ZyBjb250cmFjdCDigK4NCg==

--------------CDyTGqMAS2bIQUeRtno8wydF--

--------------HZZAPee5qVDPFiG0vp8ohr99
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQboPxLgODyGwJpjO5jTr+HQMdIvgUCaNGKwwUDAAAAAAAKCRBjTr+HQMdIvo8/
AQCJj99mAGSG45b27RNXc4th6TE1mrEQXpsGJQcWbbnSnAEA1/nboHjn2ZWsXKMiaNr13loqcL/R
jo4hHmBv7OGAlAA=
=Pc4e
-----END PGP SIGNATURE-----

--------------HZZAPee5qVDPFiG0vp8ohr99--
