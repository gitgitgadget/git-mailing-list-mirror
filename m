Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFDC1E4BE
	for <git@vger.kernel.org>; Sat, 28 Dec 2024 01:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735349410; cv=none; b=ddWG627tlf5ButSIPpkSHI6+fQzeq05yx03XdSAtO3mwzRSygyKqmwVE4RGjy/bbQ1amdU63HddivMocdzay+rRopaisvuDAtbYKMcVWf51O9n4p9x+629ibbLumGkJPfShKiT6xamCWXVKcRNGVkznudHCOFvd9KT2FBvP6zeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735349410; c=relaxed/simple;
	bh=8l84V32h2l2TQWzA6fE4wq9p9yR40qVCwu+ESNdUaAI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xvc/W9uPMLfpX0l8CEuKWmDXOTMMH2+ipIlLr1VN6DwimtsjuGXOp0r8dqVUsqZUcCQp4YJfjQFqjVf9tVAB6RaSLWjbalcG4/9fTv+KaHSZ+pZMOj8vE46cJlxZPKduBV8wk+P6a4XuvtLrjbYa6adQzj+mWmvNQa6M8Rphf9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=cgT2jGph; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="cgT2jGph"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1735349392; x=1735608592;
	bh=8l84V32h2l2TQWzA6fE4wq9p9yR40qVCwu+ESNdUaAI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=cgT2jGphXsnSMHDkRdtaUvAZw54BsU4e9nbSYu6UmlcWSQzkP6/CQWqW8Eu45ujIE
	 E5xveTgekZaysS7BpnvGYl/wriak3aHv3MM8cz8ncPlDtLRfncHJJKLKQGczRmbuQ1
	 TtiNaG6Maii3rEuV9lHkMReiQCPMYPbWZUlmhfUsbmT6oycTsartmP2Obx06PB2AOo
	 EIdv9guyz8lVBtSPBp5jWxqrbFpZQsFoML9Vd/CQumw7CSdpBVf6NheUJmtiLUbXZi
	 eCimX/irmZTv9mB82i9Qu74ZdXUgOeOhTJqTfydYNUvOsaNJYP0fWSrMYPH9B7ElMF
	 HolNY+x1CerfA==
Date: Sat, 28 Dec 2024 01:29:50 +0000
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
From: A bughunter <A_bughunter@proton.me>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [help] can nobody get me an email
Message-ID: <ZdbN-WEAvzrUFGmH6BlSKp8gAbRpXe8afMWdR3cD5eR8mlYzxp4ICi0kuSlptzYjj0qMMpz1zgbtgM1GHSLGWq8ciWR0jxnvONPmx3F647o=@proton.me>
In-Reply-To: <20241227-positive-cyber-guan-b3891e@lemur>
References: <4wL3MobzQEJEcq565GgPg4K-l5xzGERtmFhRm9FgCnlyU5rOMCgLMaWB3qzFR5httauT4gi7peWUjIfR0j_nBtiatlTpqp5xfTXnz-kX0Jw=@proton.me> <hzyhvw4pe42yqbuqdbgl5bgnxz2kd5mxxh6jnklnqwvembueqv@b6oaetnegprl> <s44De1e7kjF5OIY_YVaSJ0DdAavD-4WeZ3XrrA7XJLJO67ShZWLM9Sb1ywSUq58wmCWOTkRfhBBOvw1qCpiiUyygy53wFTetUECruyO1SEw=@proton.me> <TpuMiCTLZ7JDXxJPgVNqcYXWFavK4asar9Gk9uJiiYp1nbqmKlP22mX6xiDOKHKr5yaN7ZH7jXoISqIY67wmbFfz8i8MsYokeomQu_6Ytis=@proton.me> <ErRnPDWInS44QmxYjAyDuZ9aaZgBwRoP0xRdx0qln2dHF_I6JK6zYErrx41iQaN6GOb0iOWeEMMEXtWzlVr4ayLUUX9L6yDkpj23O8ubNPg=@proton.me> <20241227-positive-cyber-guan-b3891e@lemur>
Feedback-ID: 120910843:user:proton
X-Pm-Message-ID: c15eed77fb5d4ee3e4b4049c25f22fc91c4fcef4
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------9e438453d646f2a9c1cb8e919538f0cc743f2341792793f898bcd5f81140186d"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------9e438453d646f2a9c1cb8e919538f0cc743f2341792793f898bcd5f81140186d
Content-Type: multipart/mixed; boundary=-------------------3f2939754b0f41cfc2567934f0bfb1ef

---------------------3f2939754b0f41cfc2567934f0bfb1ef
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=utf-8

I take it I just need to unsubscribe here and subscribe using another emai=
l: that there is no moving the ML account. So how to unsubscribe?=0A=0Afro=
m A_bughunter@proton.me=0A=0ASent from Proton Mail Android
---------------------3f2939754b0f41cfc2567934f0bfb1ef
Content-Transfer-Encoding: base64
Content-Type: application/pgp-keys; filename="=?UTF-8?B?cHVibGlja2V5IC0gQV9
 idWdodW50ZXJAcHJvdG9uLm1lIC0gMHg2NjU0MDgwNS5hc2M=?="; name="=?UTF-8?B?cHVi
 bGlja2V5IC0gQV9idWdodW50ZXJAcHJvdG9uLm1lIC0gMHg2NjU0MDgwNS5hc2M=?="
Content-Disposition: attachment; filename="=?UTF-8?B?cHVibGlja2V5IC0gQV9idW
 dodW50ZXJAcHJvdG9uLm1lIC0gMHg2NjU0MDgwNS5hc2M=?="; name="=?UTF-8?B?cHVibGl
 ja2V5IC0gQV9idWdodW50ZXJAcHJvdG9uLm1lIC0gMHg2NjU0MDgwNS5hc2M=?="

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tClZlcnNpb246IEdvcGVuUEdQIDI
 uOC4wCkNvbW1lbnQ6IGh0dHBzOi8vZ29wZW5wZ3Aub3JnCgp4ak1FWnUwWDF4WUpLd1lCQkFIY
 VJ3OEJBUWRBSDBJNDdqRHNQWjZndmIrWVVHQm5BeDdKeWYxNEFWT0h4YTh5CjArZG1ONWJOTFV
 GZlluVm5hSFZ1ZEdWeVFIQnliM1J2Ymk1dFpTQThRVjlpZFdkb2RXNTBaWEpBY0hKdmRHOXUKT
 G0xbFBzS01CQkFXQ2dBK0JZSm03UmZYQkFzSkJ3Z0prS2tXWlRsUXJ2S1pBeFVJQ2dRV0FBSUJ
 BaGtCQXBzRApBaDRCRmlFRVpsUUlCY0F5Y1oybE85ejJxUlpsT1ZDdThwa0FBRDlGQVA5L2RkV
 DY1NkdrYTlOdE12bWRvWTVrCnROZ3FiWTVYYmQ5Zng2a1BFNS80dFFEL1hpaWFsS1FIam13QXR
 iY1NlMVErM2N4WUx4TmhqVTdteW5Rc3B2OWQKeEFET09BUm03UmZYRWdvckJnRUVBWmRWQVFVQ
 kFRZEFuZnAvejJGd1JrcHZVZ2Y3bXFZSTlSS25UVmFkd0dmZwphUUxobXdnM0x4TURBUWdId25
 nRUdCWUtBQ29GZ21idEY5Y0prS2tXWlRsUXJ2S1pBcHNNRmlFRVpsUUlCY0F5CmNaMmxPOXoyc
 VJabE9WQ3U4cGtBQUppOEFRQytmbk9tNFZqOVFtSDRIMEdWdDdSdU9RSyt3T1ExUFJ2cHltU2o
 KZXlCSk93RDlHWXV2eE9BVks4aUF1cEorcHB3TXIzNlZ1a0llMXBYdUhvOVJoanZlQXcwPQo9R
 lFGdwotLS0tLUVORCBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0t
---------------------3f2939754b0f41cfc2567934f0bfb1ef--
--------9e438453d646f2a9c1cb8e919538f0cc743f2341792793f898bcd5f81140186d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wqsEARYIAF0FgmdvVI4JkKkWZTlQrvKZNRQAAAAAABwAEHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmcTcXHWOVodZoEpFquun8GWFiEEZlQIBcAycZ2l
O9z2qRZlOVCu8pkAAEOXAQD54FGcd0ydhXgWnBX3KrfDP2HUm06XCtvKg3Rn
1aS5xgEAqkCGYMA3bnN/y3nWCeYVcAA1AjpJLxc1fhnlxEu57Qk=
=L5TU
-----END PGP SIGNATURE-----


--------9e438453d646f2a9c1cb8e919538f0cc743f2341792793f898bcd5f81140186d--

