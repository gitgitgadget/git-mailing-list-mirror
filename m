Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.187.169.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793466384;
	b=480zhvtdnCbEWe0mL/J6SgC7fE3VZZsLt+YJfWNHrzKZvyqM7lcNWTtQeR6qAb6zcfB4
	 HW+6zseeLBJAbq4BaPjWVrzNyhW2cXfNy8+k49gD7e8u/nxa/k6gPLFki7npxIQajK1iV
	 QOM4G7jSCVhqYIFtcsKo16vM3GIzNYYJVWuKVLvm4Xv1EgpjhXEc52htBx884lZDle7N0
	 YYB0sjDrIn3Fp2PymfK1q3lU53lYLypvXVdVx68iPZ83jJec23on0g793hZGxIg5ip6zT
	 yOwKGSmKcf8IzSjQSzlVuXSQlT4V6w3bn4VTqsS5TM62R5696tFA/U6VycTblBPH6Eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793466384;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:References:Content-Language:From:In-Reply-To:Content-Type;
	bh=MjSWCa3sAUUYmgwMKHkBosAuUElrh1j8SywwYA7r5T8=;
	b=0g9BL5aM6NuyAWAzHHQVFFw5K7TS7EoABV0o2qqSXrUSRI7HICAoRS8CdVdsyzEKkPHu
	 B667i40RMJT/VROrRJUHqRwg4LhxxLb/td6u9yP8QK+Y5zebookErGslCVRZK8evqDAH7
	 0yr5C0tAaGmj/K9UGoc7xkRuJr+6PhZga1oGMtAPxPlnuuErnO8KE56onSh0xc0lZBlYm
	 bbvaE/zGKZHQigcsNf2eNHC+cIsAaMHMwNvP89mi7V0NIMM3b6nh4gIOcwlkOopAokQ+K
	 J3diQ6yR24uTnB+BQdpJuPLHs+h+sIA8htw1z44swZcYjQZaqm5aeOqODB3IJfNxORg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=hogyros.de;
	spf=pass smtp.mailfrom=hogyros.de;
	arc=none smtp.remote-ip=185.187.169.70
Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E84A606A324
	for <git@vger.kernel.org>; Sat, 31 Oct 2026 17:06:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E84A606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hogyros.de
Received: from [IPV6:2400:2410:b120:f200:9e5c:8eff:fec0:ee40] (unknown [IPv6:2400:2410:b120:f200:9e5c:8eff:fec0:ee40])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by psionic.psi5.com (Postfix) with ESMTPSA id A1E7A3F11B
	for <git@vger.kernel.org>; Sat, 31 Oct 2026 18:06:12 +0100 (CET)
Message-ID: <b6c3c811-cabf-4421-aab2-f6b4b30951c2@hogyros.de>
Date: Sun, 1 Nov 2026 02:06:09 +0900
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] use size_t when parsing and checking objects
To: git@vger.kernel.org
References: <cover.1793444420.git.gitter.spiros@gmail.com>
Content-Language: en-US
From: Simon Richter <Simon.Richter@hogyros.de>
In-Reply-To: <cover.1793444420.git.gitter.spiros@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------4pbkUyMaYGgRgbCSM0421aW7"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------4pbkUyMaYGgRgbCSM0421aW7
Content-Type: multipart/mixed; boundary="------------vTNbbgNAoVD9im4YrScNAZ4i";
 protected-headers="v1"; hp="clear"
Message-ID: <b6c3c811-cabf-4421-aab2-f6b4b30951c2@hogyros.de>
Date: Sun, 1 Nov 2026 02:06:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] use size_t when parsing and checking objects
To: git@vger.kernel.org
References: <cover.1793444420.git.gitter.spiros@gmail.com>
Content-Language: en-US
From: Simon Richter <Simon.Richter@hogyros.de>
In-Reply-To: <cover.1793444420.git.gitter.spiros@gmail.com>

--------------vTNbbgNAoVD9im4YrScNAZ4i
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGksDQoNCk9uIDEwLzMxLzI2IDIwOjA5LCBFbGlhIFBpbnRvIHdyb3RlOg0KDQo+IFRoaXMg
c2VyaWVzIGNvbnRpbnVlcyB0aGUgc2VhcmNoIGZvciB0cnVuY2F0ZWQgc2l6ZXMgb24gcGxh
dGZvcm1zIHdoZXJlDQo+ICJsb25nIiBpcyAzMiBiaXRzIChXaW5kb3dzKS4gSXQgY292ZXJz
IHRoZSBmdW5jdGlvbnMgdGhhdCBwYXJzZSwgdmVyaWZ5LA0KPiBhbmQgY2hlY2sgd2hvbGUg
b2JqZWN0cyBpbiBtZW1vcnk6IHRoZXkgdGFrZSB0aGUgc2l6ZSBhcyBhbiAidW5zaWduZWQN
Cj4gbG9uZyIsIHdoaWxlIHRoZWlyIGNhbGxlcnMgaGF2ZSBhIHNpemVfdCwgc28gYWJvdmUg
NEdpQiB0aGUgc2l6ZSBnZXRzDQo+IHRydW5jYXRlZC4NCkFnYWluLCByZW1pbmRlciB0aGF0
IHNpemVfdCBpcyBhbHNvIDMyIGJpdCBvbiAzMi1iaXQgYXJjaGl0ZWN0dXJlcywgDQpiZWNh
dXNlIHNpemVfdCBpcyB1c2VkIGZvciB0aGUgc2l6ZSBvZiBpbi1tZW1vcnkgb2JqZWN0cy4N
Cg0KQW55dGhpbmcgdGhhdCBpcyBvbiBkaXNrIGNhbiBoYXZlIGEgc2l6ZSB0aGF0IG9ubHkg
Zml0cyBpbnRvIGFuIG9mZl90LCANCndoaWNoIGlzIDY0IGJpdCBpZiBsYXJnZSBmaWxlIHN1
cHBvcnQgaXMgZW5hYmxlZCwgYW5kIDMyIGJpdCBpZiBpdCBpcyANCm5vdC4gSWYgbGFyZ2Ug
ZmlsZSBzdXBwb3J0IGlzIGRpc2FibGVkLCBvcGVuaW5nIGEgZmlsZSBsYXJnZXIgdGhhbiAy
IEdCIA0KaXMgc3VwcG9zZWQgdG8gZmFpbCAoYmVjYXVzZSB5b3UgbmVlZCB0byBwYXNzIE9f
TEFSR0VGSUxFLCB3aGljaCBpcyANCmRlZmluZWQgb25seSBpZiBsYXJnZSBmaWxlIHN1cHBv
cnQgaXMgZW5hYmxlZCksIGJ1dCB0aGVyZSBpcyBhIGNoYW5jZSANCnRoYXQgYW4gb24tZGlz
ayBvYmplY3QgZ290IHRydW5jYXRlZCwgc28gdGhhdCBpcyBub3QgZ3VhcmFudGVlZC4NCg0K
U28sIHVzZSBzaXplX3Qgb25seSBmb3IgaW4tbWVtb3J5IGRhdGEsIGJ1dCBpZiB5b3UgYXJl
IHJlYWRpbmcgZGF0YSBmcm9tIA0KZGlzayBwaWVjZXdpc2UsIHRoZSB0b3RhbCBjb3VudCBv
ZiBkYXRhIHByb2Nlc3NlZCBuZWVkcyB0byBiZSBhbiBvZmZfdC4NCg0KICAgIFNpbW9uDQo=


--------------vTNbbgNAoVD9im4YrScNAZ4i--

--------------4pbkUyMaYGgRgbCSM0421aW7
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEtjuqOJSXmNjSiX3Tfr04e7CZCBEFAmrmIAEACgkQfr04e7CZ
CBH4wwf+OJcM5OaXkW+YowpgLiZm4vF3iBlfQxIcRilGtrVKP+FDPLsn1hdNA4jA
06emhL4REMXL10p4gnsVNmOaka1Kk1sf+ViCCLhwXGMQ6l++KwC2nAvsUnEFb2nx
34oPEt0+7zKYJ8vgJ1se4hj76Hahyevvx/x7JEHKFCkDCbAfWjVHFAR/3QhKtZC2
zbw0pqwsfAscRjZFYreSSSp8rAK6hcSloBycjXL2/EYFkT73VtVWLlPDDHtRbADL
SIpFVJ7JvVZd86e3Q7uerPVIU3+FflkkU/vf69ClcIdyBw8GRe5i/MN476bUTZ41
Bl7tdP2b8/DZta2X42cuPo6PFERKYg==
=susz
-----END PGP SIGNATURE-----

--------------4pbkUyMaYGgRgbCSM0421aW7--
