Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4502F221DB0
	for <git@vger.kernel.org>; Sun,  7 Dec 2025 05:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.187.169.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765085284; cv=none; b=IN6VsF98DEwO0ZAWXWVb/EdVM0KKykE6e/QxGYfIlhm/k3dcg4bLm2Vqa4x1tfcEXaCdZ+ca63n1+ky0dWfSceVV7BXjS+Jal4B5qCaMCqm0JtWAHJOc4BrenbXpKnyjurxGQl+pR7J++9CR5IQolTAj4nPMML6tNgySc5vsChs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765085284; c=relaxed/simple;
	bh=AoqxyYMN3wLf7Aa4tuWa0ELkcB2TLVUogpPZt094F5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bsshGW6ocpbJs6DY4ndOKr76JEHZqeF3eXY4JGbro7EJkST4F5+krwwus84DKS4vWzCy42S2zOa+jejNvs/9RCP6IwffKFFrg5x/AGAua3rX9l8I9zCRyrLuRwi4UhtvY4ZCjxPSaom31AqWwgp/R7XurEH87CnvNsSF+GBG7xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de; spf=pass smtp.mailfrom=hogyros.de; arc=none smtp.client-ip=185.187.169.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hogyros.de
Received: from [IPV6:2400:2410:b120:f200:9e5c:8eff:fec0:ee40] (unknown [IPv6:2400:2410:b120:f200:9e5c:8eff:fec0:ee40])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by psionic.psi5.com (Postfix) with ESMTPSA id B66923F1BA;
	Sun,  7 Dec 2025 06:27:51 +0100 (CET)
Message-ID: <2ae0a2d5-e909-4c51-9459-83f5c6950d51@hogyros.de>
Date: Sun, 7 Dec 2025 14:26:46 +0900
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Git for structured data
To: Cedric Sodhi <manday@openmail.cc>, git@vger.kernel.org
References: <aTMNdQ_NHTVPtwG8@air>
Content-Language: en-US
From: Simon Richter <Simon.Richter@hogyros.de>
In-Reply-To: <aTMNdQ_NHTVPtwG8@air>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------T4su8cfGZNjiWpDC9o7dDW6C"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------T4su8cfGZNjiWpDC9o7dDW6C
Content-Type: multipart/mixed; boundary="------------MVQhTlIxzNT20VjBOFMAGcn2";
 protected-headers="v1"
From: Simon Richter <Simon.Richter@hogyros.de>
To: Cedric Sodhi <manday@openmail.cc>, git@vger.kernel.org
Message-ID: <2ae0a2d5-e909-4c51-9459-83f5c6950d51@hogyros.de>
Subject: Re: Git for structured data
References: <aTMNdQ_NHTVPtwG8@air>
In-Reply-To: <aTMNdQ_NHTVPtwG8@air>

--------------MVQhTlIxzNT20VjBOFMAGcn2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGksDQoNCk9uIDEyLzYvMjUgMDE6NTEsIENlZHJpYyBTb2RoaSB3cm90ZToNCg0KPiBXaHkg
Y2FuJ3Qgd2UgaGF2ZSBzdHJ1Y3R1cmVkLCB2ZXJzaW9uIGNvbnRyb2xsZWQgZGF0YT8NCg0K
WW91IGNhbiB2ZXJzaW9uIGNvbnRyb2wgaW5zaWRlIGEgcmVsYXRpb25hbCBkYXRhYmFzZSwg
YnkgYWRkaW5nIHZhbGlkIA0KdGltZSBjb2x1bW5zIHdpdGggYSByYW5nZS1iZXR3ZWVuLXRp
bWVzdGFtcHMgdHlwZSBhbmQgYSBjb25zdHJhaW50IHRvIA0KZGlzYWxsb3cgb3ZlcmxhcHMu
IFRoZXJlIGFyZSBnb29kIGluZGV4aW5nIHRlY2huaXF1ZXMsIHRoZSBmaXJzdCB0aGluZyAN
CnRoYXQgc3ByaW5ncyB0byBtaW5kIGlzIFsxXSwgYnV0IEknbSBmYWlybHkgc3VyZSB0aGVy
ZSBhcmUgb3RoZXJzLCBhbmQgYSANCm1vZGVybiBSREJNUyBzaG91bGQgcHJvdmlkZSBjb25z
dHJhaW50cyBvbiByYW5nZSB0eXBlcy4NCg0KQSB2YWxpZCB0aW1lIGNvbHVtbiBjYW4gZW5j
b2RlIGVpdGhlciAidGltZSBhdCB3aGljaCB0aGUgZGF0YSBpcyB2YWxpZCIsIA0Kb3IgInRp
bWUgYXQgd2hpY2ggdGhlIGRhdGEgd2FzIGN1cnJlbnQgaW4gdGhlIGRhdGFiYXNlIiwgd2l0
aCB0d28gDQpjb2x1bW5zLCB5b3UgY2FuIGVuY29kZSBib3RoIGF0IHRoZSBzYW1lIHRpbWUu
DQoNCklmIHlvdSBoaWRlIHRoZSAiZGF0YSBpcyBjdXJyZW50IHdpdGhpbiIgY29sdW1uIGJl
aGluZCBhIHZpZXcgYW5kIA0KYXV0b21hdGljYWxseSB1cGRhdGUgaXQsIHRoaXMgY3JlYXRl
cyB0aGUgaGlzdG9yaWNhbCBsb2cgb2Ygd2hlbiBhbiANCmVudHJ5IHdhcyB1cGRhdGVkLg0K
DQpUcmFja2luZyBhcmJpdHJhcnkgZGF0YSBpbiBnaXQgaXMsIG9mIGNvdXJzZSwgYWxzbyBw
b3NzaWJsZSwgYnV0IA0KcmVxdWlyZXMgZGlmZi9tZXJnZSB0b29scyBhZGVxdWF0ZSBmb3Ig
dGhlIGRhdGEuIFRoZSBidWlsdC1pbiB0b29scyBhcmUgDQphZGVxdWF0ZSBmb3IgdGhlIG1h
aW4gdXNlIGNhc2UsIHRleHQgZmlsZXMgdGhhdCB1c3VhbGx5IGNoYW5nZSBvbiBhIA0KbGlu
ZS1ieS1saW5lIGJhc2lzIGFuZCBhcmUgc2VsZG9tIHJlb3JnYW5pemVkIGFzIGEgd2hvbGUs
IHNvIHdlIGNhbiANCnByZXRlbmQgdGhleSBhcmUgb25lLWRpbWVuc2lvbmFsLg0KDQpJbiBL
aUNhZCwgdGhlIGZpbGVzIHdlIGdlbmVyYXRlIGRlc2NyaWJlIGEgdGhyZWUtZGltZW5zaW9u
YWwgc3RydWN0dXJlLiANCk5vIG1hdHRlciBob3cgd2Ugbm9ybWFsaXplIHRoZSBmaWxlIGNv
bnRlbnRzLCBlbGVtZW50cyBjYW4gb25seSBiZSBtb3ZlZCANCm9uIG9uZSBheGlzIHdpdGhv
dXQgcmVxdWlyaW5nIHVzIHRvIG1vdmUgdGhlbSB0byBhIGRpZmZlcmVudCBwb3NpdGlvbiBp
biANCnRoZSBmaWxlLg0KDQpTbyBpZiBJIHNvcnQgYnkgeix5LHgsIHRoZW4gbW92aW5nIGFu
IG9iamVjdCB0byBhIGRpZmZlcmVudCB6IGNvb3JkaW5hdGUgDQpsaWtlbHkgcmVzdWx0cyBp
biAiZGVsZXRpb24iIG9mIHRoZSBvbGQgb2JqZWN0IGF0IHRoZSBleGlzdGluZyBwbGFjZSwg
DQphbmQgImNyZWF0aW9uIiBvZiBhIG5ldyBvYmplY3QgYXQgYSBkaWZmZXJlbnQgcGxhY2Ug
aW4gdGhlIGZpbGUsIHRoZSANCm9uZS1kaW1lbnNpb25hbCBkaWZmIGFsZ29yaXRobSBpcyB1
bmFibGUgdG8gY3JlYXRlIGEgbWluaW1hbCBkaWZmIGhlcmUgDQp0aGF0IHNob3dzIHRoYXQg
b25seSB0aGUgeiBjb29yZGluYXRlIGNoYW5nZWQuDQoNCk5vdCBzb3J0aW5nIChpLmUuIGxl
YXZpbmcgZWxlbWVudHMgaW4gY3JlYXRpb24gb3JkZXIpIG1lYW5zIHRoYXQgDQpkZWxldGlu
ZyBhbmQgcmVjcmVhdGluZyBhbiBvYmplY3Qgd2l0aCB0aGUgc2FtZSBwYXJhbWV0ZXJzIGNh
dXNlcyBpdCB0byANCm1vdmUgd2l0aGluIHRoZSBmaWxlLg0KDQpUaGUgc29sdXRpb24gaXMg
dG8gdHJlYXQgdGhlIHNlcmlhbGl6ZWQgcmVwcmVzZW50YXRpb24gYXMganVzdCB0aGF0LCBh
IA0Kc2VyaWFsaXphdGlvbiwgYW5kIG5vdCB0cnkgdG8gaW50ZXJwcmV0IG9yZGVyIGluIGFu
eSBtZWFuaW5nZnVsIHdheSwgYnV0IA0KdGhpcyByZXF1aXJlcyBkZWRpY2F0ZWQgZGlmZi9w
YXRjaCB0b29scyBhbmQgaGV1cmlzdGljcyB0aGF0IGd1ZXNzIA0Kd2hldGhlciBkZWxldGlu
ZyBhbmQgY3JlYXRpbmcgc2ltaWxhciBvYmplY3RzIGNvbnN0aXR1dGVzIGEgbW92ZSBvciBp
ZiANCnRoZSBvYmplY3RzIGFyZSB1bnJlbGF0ZWQsIHNhbWUgYXMgZ2l0IGRvZXMgaW4gaXRz
IG1vdmUgZGV0ZWN0aW9uLg0KDQpJIHRoaW5rIHRoYXQgZGlmZi9tZXJnZSBvbiByZWxhdGlv
bmFsIGRhdGEgaXMgbW9yZSBkaWZmaWN1bHQgdGhhbiANCmV4cHJlc3NpbmcgaGlzdG9yeSBp
bnNpZGUgdGhlIHJlbGF0aW9uYWwgdGFibGVzLiBGb3Igb3RoZXIgZGF0YSANCnN0cnVjdHVy
ZXMsIHRoaXMgbWF5IGJlIGRpZmZlcmVudCwgYW5kIGdpdCBtaWdodCBiZSBhIHZpYWJsZSBz
dG9yYWdlIA0KbWV0aG9kIGZvciBoaXN0b3J5IC0tIGJ1dCBpbiBhbnkgY2FzZSBpdCByZXF1
aXJlcyB0aGUgZWZmb3J0IHRvIGJ1aWxkIGFuIA0KYXBwcm9wcmlhdGUgcGx1Zy1pbi4NCg0K
ICAgIFNpbW9uDQoNClsxXSBodHRwczovL2xpbmsuc3ByaW5nZXIuY29tL2NoYXB0ZXIvMTAu
MTAwNy9CRmIwMDU0NTEyDQoNCg==

--------------MVQhTlIxzNT20VjBOFMAGcn2--

--------------T4su8cfGZNjiWpDC9o7dDW6C
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEtjuqOJSXmNjSiX3Tfr04e7CZCBEFAmk1EBYACgkQfr04e7CZ
CBHPEQf/fmBiwWaEeH08RJraptcAFCGPYHJxIwx96U7xgWrBxXvKS/3FlMryG+iI
YHuEuUOnZ0JY7ytrFp0Umn34xpV9gFOAwNclBnibiQu88kiRURLdPcGaOxbS2QL4
TetBwOL1oaqx9eh+SFb4BCbiuvJy77vmG4t4W7iRr9P5KbIFRUv5XM26sGfo8EBl
ja/7XlN9wFyL8gmMr1j0x8qr+lBxfRVc5y/hTuf2xyGbFrkwUyUT0uEW8K7PsOB1
FWWBuiu4gkUHCK+wrPKpOUD2Ui6rA1NPpOkxwZWo6DdvduyRKjeEGbHc8DJgeutg
R6XtB5TyOHeIa5RmQhb7Ox2OJ6OrgQ==
=J/hj
-----END PGP SIGNATURE-----

--------------T4su8cfGZNjiWpDC9o7dDW6C--
