Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EC8375AC4
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 11:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791284992; cv=none; b=Ctv2E6n1+k4E9H+L780pLg1uIJ6mtXk7QjHnHsucTe5/U0JmKOCUbuJfk70nQ5SvqNTtNicku2CLloO8In2WBiRLvHt8kfmUWiX0ajhTSDurkSuINFiP9I4NrbACcsfuGzp2H0t+4HYWHd7OyDb19BMoqYgpZwvJ/06IhpSvQtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791284992; c=relaxed/simple;
	bh=tV8of6T5Ep1e/aE4feEpy9+DsL9V74HpVTIT1Emyfzs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=SgO9PmLFmrg3483EYbEN8Xv4Wrorl81/YAcEIV0IcyKSb7cusflKW9JoTlJqNvJoVM6Ns7JwHfWR3+zyK+5bejInd312476OWNB/ZUMvI5p984b5ZEPPQEnrXYOa8nHJbTkSkU2PhfpzjFg7Y8hL1gJcJxDbWi5CJv+OrYdjbWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=delpeuch.eu; spf=pass smtp.mailfrom=delpeuch.eu; dkim=pass (2048-bit key) header.d=delpeuch.eu header.i=antonin@delpeuch.eu header.b=GpWHmy+o; arc=none smtp.client-ip=212.227.126.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=delpeuch.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delpeuch.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delpeuch.eu header.i=antonin@delpeuch.eu header.b="GpWHmy+o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delpeuch.eu;
	s=s1-ionos; t=1791284982; x=1791889782; i=antonin@delpeuch.eu;
	bh=tV8of6T5Ep1e/aE4feEpy9+DsL9V74HpVTIT1Emyfzs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:In-Reply-To:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=GpWHmy+oYBlQFyBLzlbzixxGcwi1PeS5jYN73JSpVlPQuxFMEuAHoFfK8bYcEjzR
	 S5ybhmjPXilnosXNFIm6PYliscR5gCkDK6CgwOWwbyADRJDvjWSalS3/YwMizBNS6
	 5vQTkXNBBHLO8pZzowTiHarDBw2qTKxcmd6O+zLNhmSFkFmasZuAkF5jKgQtPSUgs
	 3XOwldgfYiw9lwntvOa62g+zxCsI9mZnS4suh2na0Bn3Tb6DbMDvlMybDtrUoYn/C
	 qSVrkEzd6q94llrVESqWPXX7dy7OVr6jfeTUjA5OepcRbinSeesDTTvoMS2bidaoZ
	 Em4zrifkMbr1rv/v4A==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue012
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MAtoX-1xPMmS3LvV-00AzqM for
 <git@vger.kernel.org>; Tue, 06 Oct 2026 13:09:41 +0200
Message-ID: <97c58bb0-5030-4e66-b183-44db2ab216db@delpeuch.eu>
Date: Tue, 6 Oct 2026 13:09:39 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Documenting the governance of the git project?
From: Antonin Delpeuch <antonin@delpeuch.eu>
To: "git@vger.kernel.org" <git@vger.kernel.org>
References: <1aee1829-d7ad-47e2-b7d1-1a946bd59991@delpeuch.eu>
 <xmqq7bkel0i3.fsf@gitster.g>
 <33b3ab6d-b2cc-49c3-9a06-3c4070ede57e@delpeuch.eu>
Content-Language: en-US
Autocrypt: addr=antonin@delpeuch.eu; keydata=
 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
In-Reply-To: <33b3ab6d-b2cc-49c3-9a06-3c4070ede57e@delpeuch.eu>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Jn72qF4pyDz80Gu8bds52S2D"
X-Provags-ID: V03:K1:w4hpLsbzmggzeSc1VnhBniRU0X3CDYjozIMT2XYP5JXdFaczpsA
 PvysqtPqcMM+K5xgMJViCHxHeF1l/I4BjISGeOrNnTgp3lJjpNOtxn4j+iuOvQf70FLgGNm
 +Zklicn6q1yXqmkTvz+pZbbQPTjOs5pheVozhtJiOMRLLAwAwh+qacxcXxzlf5fu01ku7sB
 tnugHcXR7+iZ1A/t79xBg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oxDttoXgr8o=;vmnRkmddZxPif/XifJYnb9G0Ply
 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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Jn72qF4pyDz80Gu8bds52S2D
Content-Type: multipart/mixed; boundary="------------YKZ4JZBjyaANZ7RFokgngWJr";
 protected-headers="v1"
From: Antonin Delpeuch <antonin@delpeuch.eu>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <97c58bb0-5030-4e66-b183-44db2ab216db@delpeuch.eu>
Subject: Re: Documenting the governance of the git project?
References: <1aee1829-d7ad-47e2-b7d1-1a946bd59991@delpeuch.eu>
 <xmqq7bkel0i3.fsf@gitster.g>
 <33b3ab6d-b2cc-49c3-9a06-3c4070ede57e@delpeuch.eu>
In-Reply-To: <33b3ab6d-b2cc-49c3-9a06-3c4070ede57e@delpeuch.eu>

--------------YKZ4JZBjyaANZ7RFokgngWJr
Content-Type: multipart/mixed; boundary="------------IEormHfCkq93LFg1Nbcn4Ym9"

--------------IEormHfCkq93LFg1Nbcn4Ym9
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgYWxsLA0KDQpJIGFtIHBsYW5uaW5nIHRvIGdvIGFoZWFkIHdpdGggdGhpcyBwcm9qZWN0
LCB1bmxlc3MgYW55b25lIHRoaW5rcyBpdCdzIGEgDQpiYWQgaWRlYS4NCg0KTXkgcGxhbiBp
cyB0byB3cml0ZSBhbiBpbml0aWFsIGRvY3VtZW50IGJhc2VkIG9uIHRoZSBpbmZvcm1hdGlv
biBJIGNhbiANCmZpbmQgb24gbXkgb3duLCBhbmQgdGhlbiBmaWxsIHRoZSBnYXBzIGJ5IGFz
a2luZyBxdWVzdGlvbnMgYWJvdXQgdGhlIA0KcG9pbnRzIEkgY291bGRuJ3QgZmlndXJlIG91
dCBteXNlbGYuDQoNCkl0IHdvdWxkIGJlIGdyZWF0IGlmIEkgZG9uJ3QgaGF2ZSB0byBib3Ro
ZXIgSnVuaW8gdG9vIG11Y2ggd2l0aCB0aG9zZSANCnF1ZXN0aW9ucywgc28gaWYgeW91IGhh
dmUgYSBnb29kIGdyYXNwIG9mIHRoZSBzb2NpYWwgc3RydWN0dXJlcyBpbiBwbGFjZSANCmlu
IHRoaXMgcHJvamVjdCwgSSdkIGFwcHJlY2lhdGUgaXQgYSBsb3QgaWYgeW91IGNvdWxkIGxl
dCBtZSBrbm93IHlvdSdyZSANCmF2YWlsYWJsZSB0byBoZWxwLg0KDQpNeSBnb2FsIHdpbGwg
YmUgdG8gd3JpdGUgc29tZXRoaW5nIHRoYXQgeW91IGFyZSBoYXBweSB0byBpbmNsdWRlIGlu
IHRoZSANCm9mZmljaWFsIGRvY3VtZW50YXRpb24gb3Igd2Vic2l0ZSwgYnV0IGlmIHRoYXQg
ZG9lc24ndCB3b3JrIG91dCwgSSdsbCANCnB1Ymxpc2ggaXQgZXh0ZXJuYWxseSAobWFraW5n
IGl0cyB1bm9mZmljaWFsIHN0YXR1cyBjbGVhciwgb2YgY291cnNlKS4NCg0KVGhhbmtzLA0K
DQpBbnRvbmluDQoNCg==
--------------IEormHfCkq93LFg1Nbcn4Ym9
Content-Type: application/pgp-keys; name="OpenPGP_0x922C1B66A3D3D022.asc"
Content-Disposition: attachment; filename="OpenPGP_0x922C1B66A3D3D022.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
L6U=3D
=3DFqrj
-----END PGP PUBLIC KEY BLOCK-----

--------------IEormHfCkq93LFg1Nbcn4Ym9--

--------------YKZ4JZBjyaANZ7RFokgngWJr--

--------------Jn72qF4pyDz80Gu8bds52S2D
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEJUVxpLyjfMNrm7SYkiwbZqPT0CIFAmrE1vMFAwAAAAAACgkQkiwbZqPT0CLe
ghAAkrlqbDXK/xR+Hpob3jbeyC9S1VA1dz547vr5AbqOXlYRCcCA5KcOk/8KtMuzhDuEFxd1hsua
vsC6l2lX3+NZ6h720fZ0PjA9PAQ6kH6C/BYPZhUwsxr+CiIRnaIAcTOY++7IvW0X4+zxEvrOpEKD
f6w/ly7M/76bMIcAzq0fOMdSWKbtONLgQE3sxcRorLEtm8+WqRrx2ZcQKciLEFPSl8mFXb+cTs6P
f09DZwgTrSlY0DRdyQwhrqdzUNMJuKxgwVogfnBsu8H9MwxPGUUw69+uEM6aaSnWM4aHNIalK0bs
aHgKyO+hW/aMj+Ca/MFGAfsohrmnGQvzF+GZZwUF8ySyNIw6oBrUd6oovZNjKu/DYrPVspnHUpn+
Sf679ssNdbbPFt+siNp/xD6A//2vt5inZEZiAno08B+iK3UWUFvPtxfOWs9Cvq4dpHPxAWxXm5gz
oZhX6NVKy+dTzFC6PMpn7JjVt61rxTu1G1qtrQOzZrwr8Lwu0nokESyp5smiH4OyawUtjOxZbjiH
CX3XDles0Mde8n/bxQSzANBjTUzpajx6qX3yPXdcwdQ28YtjE6o9Ep0ED0SQhvPVIyEXae57KxxO
BzOpHR143JfvwlOonYosFgZNbdn0KXizlry/DReWfiP8QeqOmUNU1CAYOWmfgOFFzP/FF7mRbpKD
C9Q=
=1W/d
-----END PGP SIGNATURE-----

--------------Jn72qF4pyDz80Gu8bds52S2D--
