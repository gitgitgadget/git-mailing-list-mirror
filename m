Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008844CF477
	for <git@vger.kernel.org>; Sat, 17 Oct 2026 00:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.187.169.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792196342; cv=none; b=gIksrOk0aDg6eXHSQNIDrCKSGHyibG1T302mCBNKef0KjzHd5vFf0AmsngEY14whl4pvfRv0cvl/LmbN35pcOqQz969xymNKUi6NTwo1U4O6q8eBxqw8QdxC0nkB0Czc8Ajx2ETaGkori2QBI/NEVgDExUmxXHkR2+H9f6Ezt/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792196342; c=relaxed/simple;
	bh=Db1uLvafZSz9nXHrr+COPT/yxZeUbVN9knnEYpHBoJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I0pTiD1vwAsGHeZ4ZPkk6ZDn1Fg8p1Ci8yRrQir8F4Hv6Y0phV9esQ0Ft42NrOLszFspVLNMFU57cnG33zwhLfCA9SgWj7w7DMnK+m7V1SolQgf2QUA6YjboAUC1n8sIRkCsqQn1pC0RmHYiA8CwhaF4hYPUDMxpEgQ3mGcGUrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de; spf=pass smtp.mailfrom=hogyros.de; arc=none smtp.client-ip=185.187.169.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hogyros.de
Received: from [IPV6:2400:2410:b120:f200:9e5c:8eff:fec0:ee40] (unknown [IPv6:2400:2410:b120:f200:9e5c:8eff:fec0:ee40])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by psionic.psi5.com (Postfix) with ESMTPSA id CFA193F11B;
	Sat, 17 Oct 2026 02:18:47 +0200 (CEST)
Message-ID: <395b47c0-6dc7-4a1b-b547-e5e68e7356f5@hogyros.de>
Date: Sat, 17 Oct 2026 09:18:41 +0900
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] http: use `size_t` for byte position in
 fwrite_sha1_file
To: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.2253.git.1791958171.gitgitgadget@gmail.com>
 <70a909de18e8cd8d282439fb51a9399baa8c7be8.1791958171.git.gitgitgadget@gmail.com>
 <atHiiye4oi_lF5FP@pks.im> <xmqq1p9pk99q.fsf@gitster.g>
Content-Language: en-US
From: Simon Richter <Simon.Richter@hogyros.de>
In-Reply-To: <xmqq1p9pk99q.fsf@gitster.g>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------d6HyPzE1wxC7HAskGebqiWes"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------d6HyPzE1wxC7HAskGebqiWes
Content-Type: multipart/mixed; boundary="------------9h0Xaa0Sb3exy2wOuYpDAxZ0";
 protected-headers="v1"
From: Simon Richter <Simon.Richter@hogyros.de>
To: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Message-ID: <395b47c0-6dc7-4a1b-b547-e5e68e7356f5@hogyros.de>
Subject: Re: [PATCH 2/5] http: use `size_t` for byte position in
 fwrite_sha1_file
References: <pull.2253.git.1791958171.gitgitgadget@gmail.com>
 <70a909de18e8cd8d282439fb51a9399baa8c7be8.1791958171.git.gitgitgadget@gmail.com>
 <atHiiye4oi_lF5FP@pks.im> <xmqq1p9pk99q.fsf@gitster.g>
In-Reply-To: <xmqq1p9pk99q.fsf@gitster.g>

--------------9h0Xaa0Sb3exy2wOuYpDAxZ0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGksDQoNCk9uIDEwLzE2LzI2IDIzOjMwLCBKdW5pbyBDIEhhbWFubyB3cm90ZToNCg0KPiBJ
IGFncmVlIHRoYXQgY2hhbmdpbmcgdGhlIHR5cGUgb2YgcG9zbiBmcm9tIGludCB0byBzaXpl
X3QgaXMgdGhlDQo+IHJpZ2h0IG1vdmUuDQoNCkl0IGlzIGEgcG9zaXRpb24gaW4gYSBmaWxl
IHRoYXQgaXMgYmVpbmcgcmVhZCBhcyBiaW5hcnkgZGF0YVsxXSwgc28gDQpvZmZfdCB3b3Vs
ZCBiZSB0aGUgYmVzdCBjaG9pY2UgSSB0aGluay4NCg0KVGhhdCBpcyBzdGlsbCBzaWduZWQs
IGJ1dCBpdCBjYW4ndCBvdmVyZmxvdywgYmVjYXVzZSBvcGVuaW5nIGxhcmdlIGZpbGVzIA0K
cmVxdWlyZXMgT19MQVJHRUZJTEUsIHdoaWNoIGlzIGF2YWlsYWJsZSBvbmx5IGlmIGxhcmdl
IGZpbGUgc3VwcG9ydCBpcyANCmVuYWJsZWQsIHdoaWNoIGNvbnZlbmllbnRseSBtYWtlcyBz
dXJlIHRoYXQgb2ZmX3QgaXMgNjQgYml0Lg0KDQogICAgU2ltb24NCg0KWzFdIHRvIG1ha2Ug
YSBkaXN0aW5jdGlvbiBmcm9tIHRoZSB1c2UgY2FzZSBmb3IgZnBvc190DQo=

--------------9h0Xaa0Sb3exy2wOuYpDAxZ0--

--------------d6HyPzE1wxC7HAskGebqiWes
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEtjuqOJSXmNjSiX3Tfr04e7CZCBEFAmrSvuEACgkQfr04e7CZ
CBHPQwf+PKgesEduADPihwJzjlemixek7bkGfDm5atReoXaLvCnp5/pnLYUT0w+v
irfwrAaiitqCSALnNndyfYeSiR6dtF6Q8TUJZhD51FMeZlZHFlX5G66WkQL5kzFl
4yn/ECjeR6pCuv46h6YQlNLzKyIUP8QjF7ddEcpH0WsP/Ewaw8uNlz+MB9cNgdQA
qvvNSdVdccl6SBn5fyplPB1dZ96b03WTS3HfGtfT8RpDolZiT9qgVujlNXyiKPZE
TZ4Ggc3xYBI/M+4/8t0Y00Y4hmkEsTc4FqPhHczjf+6BRyQyYUbkfClpuyS2ccfl
x3iXcy9dq3jDqwsLFR9qCUx6nNhPVQ==
=OzBB
-----END PGP SIGNATURE-----

--------------d6HyPzE1wxC7HAskGebqiWes--
