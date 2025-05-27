Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91C4242938
	for <git@vger.kernel.org>; Tue, 27 May 2025 18:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748369748; cv=none; b=OdrpNKwxqexxBWtCElWlwCjb9Rjp0pxYzU3YKyjesVgjOD2ltcHLrG6H/x/rQQmSYq38zP+hbAiwBL9aHaPXZyqAYO/9opLURM4OYnorB+et+UtWFMDaw5J1vEi+Hskh/8WeJqLbxPppdd26LonY2ss8HqvYvCzNfnMUevEInmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748369748; c=relaxed/simple;
	bh=7JnxAK6AkZzOxNxxXJtUbfxV6o7L10WYZcTaPjzPdZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CwdvHzkxHtKMn3YMwI1a3gVsT2iL2lyt1pKBQNAPcDMzODlLcktRtM6hQKlfdcrqTvzOdp9clCFkqFJoSCkYP7QTQ9CH9gr1rS9ziVOwRO+zt5heep59fVRYrJpPr1wAJ6d2aiMKslQcbWTBLLd1SgdH2qZxmEIaE2K6VXs25pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=hamlin.carlisle@gmx.com header.b=YsMF/gZC; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=hamlin.carlisle@gmx.com header.b="YsMF/gZC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1748369743; x=1748974543; i=hamlin.carlisle@gmx.com;
	bh=7JnxAK6AkZzOxNxxXJtUbfxV6o7L10WYZcTaPjzPdZk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=YsMF/gZCF+YsqOpEiwXszdzfp5EdIxdYeafPZuRvTlk5BXoH1xpN3fwS0WPfbCXP
	 VdoNQvi+ho9Gkr3FUfGP3Cl5/aLwIfwz0SB3zhIexdM5V+CRcAaYMsb/+qrlFWjv9
	 lsYt2Dul6NLTM9YGZHexjw+Xw1ImmbHlw2PuaS0I1UdKW4QQ8Ogdo096ckqEd4ylC
	 mO/Br43xi3I8JagYOmAAKW0IyQDncVaGi93iioNm/KAWXcnZLifH/rQcZ9yV6UGww
	 q/+4Dzf8bb+uZLATmtzbNF/wYGSR+4RxYfxZWQ2FI78KpjfBU9XjM2pjbcbfFRLyQ
	 vcu/x89DMCm/Gd8oAA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.65] ([69.62.178.28]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MvbBu-1v9L8T1mCc-00zZY7; Tue, 27
 May 2025 20:15:43 +0200
Message-ID: <468cbd94-058b-41d3-81ab-e3c1fd2807c6@gmx.com>
Date: Tue, 27 May 2025 11:15:41 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: the
To: Tengo kalandia <kalandiat@icloud.com>, git@vger.kernel.org
References: <7374F252-3540-40AF-9DF7-9B308A7626A1@icloud.com>
Content-Language: en-US
From: "Carlisle T. Hamlin" <hamlin.carlisle@gmx.com>
Autocrypt: addr=hamlin.carlisle@gmx.com; keydata=
 xsAiBEfLBpcRAgD8qfOOlcAEezHtcm6xrrZbwjKLXlIfKXUf/YiTeuaLk7TkfnvTVU5fwUam
 iewb7AN+t3mzKxcgwxViDnFQ8spDAKDtjKSLxKSCTYDVT8WR5w0NwOI3dwH9GetPPjCjJvnk
 JOr7yJOcyF0+T0bwR/cEUJ6nuQfbh2eVSNyWSiixsr14dQWphJf7CwGsTfIfv7vsZ+fIwP39
 rgIA+g8d2waPxl76gDjIygL6TrF6hhTt7KUb2yNgSng9IldkMfcdBYlg3dWOpZNNcZrTGOyd
 6xvhvmMuojRRx8r54c0oQ2FybCBULiBIYW1saW4gPGhhbWxpbi5jYXJsaXNsZUBnbXguY29t
 PsJjBBMRAgAjBQJYh9SnAhsDBwsJCAcDAgEGFQgCCQoLBBYCAwECHgECF4AACgkQyLm4ydrA
 Bve9TgCdGob4qLVTBIOjrTrY+/PmPPGby4AAn21LQfE5TXjJP298WdZNVCmAzXarzsFNBEfL
 B4oBEADbRPe1kVPw4r1YTMTRjRGKz1zF1juy+w7rgYmbwGE7g59jyb2jQYkiuUykupPom63I
 UAiHsTm7rt+GrHqJ2WjgBfDC7rUM0tWst5pKkt9Ma27l/O9J0T4YDr0kRDGhEUJPHI27V2D2
 NX52bDFgKiPl5WyRxtgAtTZC9KOdCPJ4t9c8waUIWlFn/YeWYerC2b15Sf3AB6bKVhP+2v91
 j/vOsTEFIlfg57fbQpEknGsLRIbO1V5Gx5FhFgycNh50zk86LiTz7pzZ19E6UnYuUEgaozru
 UjTQubdqPYOdgCnReTgcwo4ylon12sXjWHBScODgIYooPEUjAyn8H/m5i7jaSV5l2eZOUPvF
 8NPuuGUUWgMmQ+pCah3DnO3ccdaOOjW2z02Skx1XGep7Zyyn4hzV3cZpIhnOP5udwE1D3Pxr
 ljwVKs4uroPo28Eeh1KiYf95kP5KfzYafOpVx3QyykkiqQ4MEd1k61Y1ZoQ4pz+XskOym1DD
 9w6JdoAimsb7YGAqMQbSrtNSVpDMcYIDpXboDDussRmRD+Xoko/mhhQ2ZpUUyeqnlPHHmzSJ
 va0+hvBhw3QEv0QV7or3V1tN9r72o0KGp1un1n9IZv7JA4CKvs2oWPlR593d+pmHzZswK01Y
 ozFV+96kRXULHziVesdtlJCa+/341vc/p9teqKEJSQARAQABwkkEGBECAAkFAkfLB4oCGwwA
 CgkQyLm4ydrABvf1ogCfcujflHLQUSahVKgWtF/qDpK10+gAmwQ6EVxuZ3Z1GO6EbFxyRtm3 kOwI
In-Reply-To: <7374F252-3540-40AF-9DF7-9B308A7626A1@icloud.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------cDDpzeWRy6coM0uQkiP1iUoa"
X-Provags-ID: V03:K1:cPeN9KyfH1/4mNUwkJpTqrz+uMPTiygpBe1wqNtwPcXSh0DQD6P
 iCxT2GtRfGHKko6TqwxSx6GkQg9qvDnB0MAgGpxdVA/ATyfu83ql9hzj0BUnLtsvBGyJK1l
 4EW2wvaFlOvepOQe57/cbO8aJywzHQSE1D66K78aHRfx0/H0ZSxToZSsuBwQcXz7J6dXu3a
 155VmTPDFKam82d0DxLRQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AUZJ3Jz+bTU=;PFeM1bPEBWFT3pHufqcDKRU/8Wz
 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
 bV/c=

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------cDDpzeWRy6coM0uQkiP1iUoa
Content-Type: multipart/mixed; boundary="------------Foj7ffTlXNQs7lkKWWsOSu13";
 protected-headers="v1"
From: "Carlisle T. Hamlin" <hamlin.carlisle@gmx.com>
To: Tengo kalandia <kalandiat@icloud.com>, git@vger.kernel.org
Message-ID: <468cbd94-058b-41d3-81ab-e3c1fd2807c6@gmx.com>
Subject: Re: the
References: <7374F252-3540-40AF-9DF7-9B308A7626A1@icloud.com>
In-Reply-To: <7374F252-3540-40AF-9DF7-9B308A7626A1@icloud.com>

--------------Foj7ffTlXNQs7lkKWWsOSu13
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gNS8yNi8yNSAwNzo0MywgVGVuZ28ga2FsYW5kaWEgd3JvdGU6DQo+IA0KPiANCj4gU2Vu
dCBmcm9tIG15IGlQaG9uZQ0KPiANCg0KV2UnbGwgZ2V0IHJpZ2h0IG9uIHRoaXMuIFNob3Vs
ZCBiZSByZWFkeSBieSBuZXh0IFR1ZXNkYXkuDQo=

--------------Foj7ffTlXNQs7lkKWWsOSu13--

--------------cDDpzeWRy6coM0uQkiP1iUoa
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wmMEABEIACMWIQS03Plbjnx/WLb9533IubjJ2sAG9wUCaDYBTQUDAAAAAAAKCRDIubjJ2sAG96Uf
AJ9IIOWJDX/5pTdzNis8KgepIN1oXQCeKCfs9wRzI8B7R+yw2r90AbhKLvE=
=JDov
-----END PGP SIGNATURE-----

--------------cDDpzeWRy6coM0uQkiP1iUoa--
