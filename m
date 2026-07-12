Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91313CA6F
	for <git@vger.kernel.org>; Sun, 12 Jul 2026 06:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.187.169.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783836060; cv=none; b=JllL2LW0iBgSkRB4AkER1sfmdHQff7+/h8N6dsrREefpUHAroaBVbLtw9vuNhl6Iz7ms9mtivSgpL/vxMkQUqOHIwXtHYbyGvqE+4nLnnoXed2M9DIz0MbUyuiUkj/mXF6uWoNVcnh8Oe6MRoJ1ASK7UJ6BG8VVR01B1SkQjYQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783836060; c=relaxed/simple;
	bh=H4XpgR9MjaOmyxcqStmqpsUHy91Abcbt5TWlQqQ9JWU=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=Dii+7mrUFCLlJ/oNzqvLtDZiytlUwGBZTL01iqrwSWkml3UhY60HD1hWQ3sB9etGRJ17u+mT4RGKnhees3XF1YsAj2ruUKSOgnnUgmTe6JZ2INd1U9VOznKz+eW/qMXQwnK8mzizv64aQKll+ThDA7AsKydMbeFa6WXCdPxx0pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de; spf=pass smtp.mailfrom=hogyros.de; arc=none smtp.client-ip=185.187.169.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hogyros.de
Received: from [IPV6:2400:2410:b120:f200:9e5c:8eff:fec0:ee40] (unknown [IPv6:2400:2410:b120:f200:9e5c:8eff:fec0:ee40])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by psionic.psi5.com (Postfix) with ESMTPSA id 31DCA3F202
	for <git@vger.kernel.org>; Sun, 12 Jul 2026 07:54:51 +0200 (CEST)
Message-ID: <07c9811e-41db-473e-ba0a-cdcbf8187be7@hogyros.de>
Date: Sun, 12 Jul 2026 14:54:48 +0900
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git@vger.kernel.org
From: Simon Richter <Simon.Richter@hogyros.de>
Subject: "discard!" commit message for commits that should be removed while
 cleaning up the history
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------C8PQ48n5Agml0W98F0Sfhk26"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------C8PQ48n5Agml0W98F0Sfhk26
Content-Type: multipart/mixed; boundary="------------67gqx2VGi2pxvED2JYrTlMJz";
 protected-headers="v1"
From: Simon Richter <Simon.Richter@hogyros.de>
To: git@vger.kernel.org
Message-ID: <07c9811e-41db-473e-ba0a-cdcbf8187be7@hogyros.de>
Subject: "discard!" commit message for commits that should be removed while
 cleaning up the history

--------------67gqx2VGi2pxvED2JYrTlMJz
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGksDQoNCkkgb2Z0ZW4gYWRkIHByaW50ZiBzdGF0ZW1lbnRzIGR1cmluZyBkZWJ1Z2dpbmcs
IHdoaWNoIG9idmlvdXNseSBzaG91bGQgDQpub3QgZW5kIHVwIGluIHRoZSBmaW5hbCBzdWJt
aXNzaW9uLiBNeSB1c3VhbCBhcHByb2FjaCBpcyB0byBjb21taXQgdGhlc2UgDQppbW1lZGlh
dGVseSwgaW50byBjb21taXRzIHdpdGggYSBtZXNzYWdlIG9mICJESVNDQVJEIiwgc28gdGhh
dCB3aGVuIEkgZG8gDQphIGZpbmFsIHJlYmFzZSBwYXNzLCBJIGNhbiByZW1vdmUgdGhlIGRl
YnVnIGNvZGUgZWFzaWx5Lg0KDQpXb3VsZCBpdCBtYWtlIHNlbnNlIHRvIGFkZCBhIG1lY2hh
bmlzbSB0aGF0IGF1dG9zcXVhc2ggdW5kZXJzdGFuZHMgDQpkaXJlY3RseSwgYW5kIHRoYXQg
Y291bGQgYmUgY2hlY2tlZCBmb3IgYnkgYSBwdXNoIGhvb2sgb3IgQ0kgcnVsZT8NCg0KICAg
IFNpbW9uDQo=

--------------67gqx2VGi2pxvED2JYrTlMJz--

--------------C8PQ48n5Agml0W98F0Sfhk26
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEtjuqOJSXmNjSiX3Tfr04e7CZCBEFAmpTLCgACgkQfr04e7CZ
CBHIbgf/ex6fQxacDflHprM7WPPTHC4Eworr1pQ+LpmQZeuKvWDkVoRuqN2eEUKK
AqGhEHVI87KYyXjsFXAK81SefwwLEoFAuyBEWG+pxvVHXfg5+csLQPrgRkJjrjgB
fk5Fx7fxlyMvpjCbCKjIekxdFqNB0Bz2sDBZ3QtDlGQhRcKyWr6pYcw1XCQwtUJ2
G3teN0Tv6R/mlstCj+XsNQAuSobEpg/F+fI1pWVhbeCsQfK6+cSadnQVFzE7CDPy
JH4Lmf0VOyRhWNZAOKBxyUXgla+Hjab1cnKlJCNRxYpF5rX4TouHb/bg2mMRY9ST
g3VYUNWjyNUHjP/RJqQDW5xcObhz0A==
=IbQ0
-----END PGP SIGNATURE-----

--------------C8PQ48n5Agml0W98F0Sfhk26--
