Received: from mail-05.mail-europe.com (mail-05.mail-europe.com [85.9.206.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D6416EB42
	for <git@vger.kernel.org>; Sun, 28 Dec 2025 20:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.206.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766954429; cv=none; b=RkWxTPGlt2fMS4nHX093WRWfUSecJONJEdAMjRkoHpMUnrBc1IkzY6kZkTXPuO9zx8rDRs6qV6/2l1MFlRWH4wtNHg2OBxNdDlbDqLs4oDdMXhyGxWdbQacpiyCTZj5jOFBFDMyRsE45fAsfWauXkLlo0fX/M65g+1btW4aHLrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766954429; c=relaxed/simple;
	bh=t3u+wFwx1LouesvrQEEV6ZTjOE/hzw2nuonpEph8vEc=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=rXUfqsWmtsbXllp8Af/ZCscXzQ6X2IS02E3WtuDm1wJZ59n0HvogiLgzQR8mRVum5gn8vb24vOBPKboayoDCqGUAjEQL+esU4rjrvEn52CgSJY4VvEG7ODjrkVvWrwonmHbFu105Ako+eEsy6nLxKk9NwEGI+Wtt94EUGO+4a2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfietech.xyz; spf=pass smtp.mailfrom=wolfietech.xyz; dkim=pass (2048-bit key) header.d=wolfietech.xyz header.i=@wolfietech.xyz header.b=D4zN/FPV; arc=none smtp.client-ip=85.9.206.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfietech.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfietech.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wolfietech.xyz header.i=@wolfietech.xyz header.b="D4zN/FPV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfietech.xyz;
	s=protonmail; t=1766954414; x=1767213614;
	bh=t3u+wFwx1LouesvrQEEV6ZTjOE/hzw2nuonpEph8vEc=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=D4zN/FPVDZ1HTb1ISTMyhEBDs+NZbOEJFwrSuXw3FRVPGP0ZkfAZ/TA6tDls3b0np
	 um7J7jHhrHoMKvKbRZeUfxvm2a/22mJL26RRJf19uhRybVPMebIeL/Csdd6WT2mRKi
	 KSA3kbzf2a33EzGAHE4IyLyuuo0G+REC4e6ZhoMhZJpKjFOlkZaTI6VY/UDgQ+5PXv
	 DLOtPpt8GtMPPsyvhsh4XczQkVmQHCuSdvvkWIuv2BRTAbYzNinZmcwFpCP1cKEhPd
	 CtcflE+C/N7sV6cnvqS5/+qdpuSIRErXYN4pvVWZvxvVCVz6xJjkKDyM2qtvq0INI4
	 pOhLiZttXv/+w==
Date: Sun, 28 Dec 2025 20:40:10 +0000
To: "git@vger.kernel.org" <git@vger.kernel.org>
From: Terrence | Wolf1098 <Wolf1098@wolfietech.xyz>
Subject: Git MSI Download Alternative
Message-ID: <KFiSIrIS7eM0dD67pvLae9ATOgPSyhL6ypLLaB2NTCX4k7AxDIbDGVTn1y35OO6O5wieHLL8NWkAxhgXF4uTd3HxqXN9JQzv2x996pXjsP8=@wolfietech.xyz>
Feedback-ID: 17620940:user:proton
X-Pm-Message-ID: 17325b3a46c2993f7a6216d9dabeb57c57a7275e
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------9369a38d6ce1c23d717debf3b409eea1ba2fb2839f6651f2c1e6da027835f8dc"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------9369a38d6ce1c23d717debf3b409eea1ba2fb2839f6651f2c1e6da027835f8dc
Content-Type: multipart/mixed;boundary=---------------------5de5405eaee5c5f83c5218b372fceafb

-----------------------5de5405eaee5c5f83c5218b372fceafb
Content-Type: multipart/alternative;boundary=---------------------1e5e257a798b996c08b3ef5b7c78590e

-----------------------1e5e257a798b996c08b3ef5b7c78590e
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

Is it possible to get an MSI(x) install of github so that it can be instal=
led via provisioning, or gpo rules in ad?
-----------------------1e5e257a798b996c08b3ef5b7c78590e
Content-Type: multipart/related;boundary=---------------------b7395596712cd7f03d2913d991167c9b

-----------------------b7395596712cd7f03d2913d991167c9b
Content-Type: text/html;charset=utf-8
Content-Transfer-Encoding: base64

PGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6IEFyaWFsLCBzYW5zLXNlcmlmOyBmb250LXNpemU6IDE0
cHg7Ij5JcyBpdCBwb3NzaWJsZSB0byBnZXQgYW4gTVNJKHgpIGluc3RhbGwgb2YgZ2l0aHViIHNv
IHRoYXQgaXQgY2FuIGJlIGluc3RhbGxlZCB2aWEgcHJvdmlzaW9uaW5nLCBvciBncG8gcnVsZXMg
aW4gYWQ/PC9kaXY+CjxkaXYgc3R5bGU9ImZvbnQtZmFtaWx5OiBBcmlhbCwgc2Fucy1zZXJpZjsg
Zm9udC1zaXplOiAxNHB4OyIgY2xhc3M9InByb3Rvbm1haWxfc2lnbmF0dXJlX2Jsb2NrIHByb3Rv
bm1haWxfc2lnbmF0dXJlX2Jsb2NrLWVtcHR5Ij4KICAgIDxkaXYgY2xhc3M9InByb3Rvbm1haWxf
c2lnbmF0dXJlX2Jsb2NrLXVzZXIgcHJvdG9ubWFpbF9zaWduYXR1cmVfYmxvY2stZW1wdHkiPjwv
ZGl2PgogICAgCiAgICAgICAgICAgIDxkaXYgY2xhc3M9InByb3Rvbm1haWxfc2lnbmF0dXJlX2Js
b2NrLXByb3RvbiBwcm90b25tYWlsX3NpZ25hdHVyZV9ibG9jay1lbXB0eSI+CiAgICAgICAgCiAg
ICAgICAgICAgIDwvZGl2Pgo8L2Rpdj48ZGl2Pgo8L2Rpdj4=
-----------------------b7395596712cd7f03d2913d991167c9b--
-----------------------1e5e257a798b996c08b3ef5b7c78590e--
-----------------------5de5405eaee5c5f83c5218b372fceafb--

--------9369a38d6ce1c23d717debf3b409eea1ba2fb2839f6651f2c1e6da027835f8dc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wrsEARYKAG0FgmlRlZwJEEOZArY0ro4BRRQAAAAAABwAIHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmdlELXs/UY5ysd61an8pyzqGXEtL+xTp70FWtz9
rRo8URYhBLr8hGxK4BV3xzBOXUOZArY0ro4BAABcvAEA5Qzl3Xoj2LbpkunQ
CnxBXzMA48m+fST9DntX4fvpycYBAK7qoiaeSFSP4TB5j6XgN0cPgRPVwaWe
vcjFpZ10qnEG
=c260
-----END PGP SIGNATURE-----


--------9369a38d6ce1c23d717debf3b409eea1ba2fb2839f6651f2c1e6da027835f8dc--

