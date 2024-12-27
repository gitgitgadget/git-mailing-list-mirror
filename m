Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917FD3D69
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 17:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735318993; cv=none; b=ueX+088RBu7hiue5epJq47x6KtL7k/uNusnk9oxQbfJVbnn29dpqyOJ6bZZTzmAq5TsLvUcFqWpWSbXuudKYQOv8XF3euDfTjl1UzBzB9j3CuA5s8cx8YsY9dtbc7dgz1o9mtbsqip+RTyWnZTiO59fMIhwvBSgRJbC+CMOTXKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735318993; c=relaxed/simple;
	bh=DVibmClF1d6ZJUljW/H06lokhR2xkupb7iF6Fs6Fpm4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iswWNPYZSag8wc7Y532SU82oF4jNy0aAOZVTDtFZJov2BnQBpabf/5kHxJIBIR6ellPP2Bvkt+xDbOtJ4cefSNsoUNW+aaTKYiiCsPqu06HElVGN+ULRJl8a3Okq3OFyb9wmBNmgP/Tqh9cC8kP1OceYmftI33onSs22E2lkfG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=bxcxzlBk; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="bxcxzlBk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1735318976; x=1735578176;
	bh=DVibmClF1d6ZJUljW/H06lokhR2xkupb7iF6Fs6Fpm4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=bxcxzlBk+rpKeYo8VLX6hKZGHwTiIcFAux2pWtdS/5ShfXmG82u6Ds/fNdsT8grdK
	 xMr6mKpBe1eEESldBs4B+00yGix7EVdsiHGSCDdLTJNvBrz8ByMiQvuQC5FkzeuFzp
	 /0ZrHaZcpWGu3cuLTGkvtKJphM41GU+Q7t7dVvj4NdApMpl7OQzSet67S/3loHEsPL
	 7nPFytLwq3gKBqKpxJ56DGUZPg5e56JSLZz1AOkRF/Fndqlv2OrmuIe7XZJ2Rm6tal
	 KeXSI5/X4hZ6uKExleKy9XvbfIvgdB0AoNcQhpfjBI6ZKhdJnN2QlCAAgy8AvjjmsD
	 jLMgRdJ53nA6w==
Date: Fri, 27 Dec 2024 17:02:49 +0000
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
From: A bughunter <A_bughunter@proton.me>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [help] can nobody get me an email
Message-ID: <ErRnPDWInS44QmxYjAyDuZ9aaZgBwRoP0xRdx0qln2dHF_I6JK6zYErrx41iQaN6GOb0iOWeEMMEXtWzlVr4ayLUUX9L6yDkpj23O8ubNPg=@proton.me>
In-Reply-To: <TpuMiCTLZ7JDXxJPgVNqcYXWFavK4asar9Gk9uJiiYp1nbqmKlP22mX6xiDOKHKr5yaN7ZH7jXoISqIY67wmbFfz8i8MsYokeomQu_6Ytis=@proton.me>
References: <4wL3MobzQEJEcq565GgPg4K-l5xzGERtmFhRm9FgCnlyU5rOMCgLMaWB3qzFR5httauT4gi7peWUjIfR0j_nBtiatlTpqp5xfTXnz-kX0Jw=@proton.me> <hzyhvw4pe42yqbuqdbgl5bgnxz2kd5mxxh6jnklnqwvembueqv@b6oaetnegprl> <s44De1e7kjF5OIY_YVaSJ0DdAavD-4WeZ3XrrA7XJLJO67ShZWLM9Sb1ywSUq58wmCWOTkRfhBBOvw1qCpiiUyygy53wFTetUECruyO1SEw=@proton.me> <TpuMiCTLZ7JDXxJPgVNqcYXWFavK4asar9Gk9uJiiYp1nbqmKlP22mX6xiDOKHKr5yaN7ZH7jXoISqIY67wmbFfz8i8MsYokeomQu_6Ytis=@proton.me>
Feedback-ID: 120910843:user:proton
X-Pm-Message-ID: 5399d59550730d226ec1f85d980ea349b9cc7a0f
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------6274d9b750bddd996a4e6b74ecc372a4e6a7199c863a536a68f097a3d8dd687e"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------6274d9b750bddd996a4e6b74ecc372a4e6a7199c863a536a68f097a3d8dd687e
Content-Type: multipart/mixed; boundary=-------------------a07c1039fb551e2cba463e77cf7eb39f

---------------------a07c1039fb551e2cba463e77cf7eb39f
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=utf-8

How do you move this mailing list to gmail this is too much for my proton =
inbox here.
---------------------a07c1039fb551e2cba463e77cf7eb39f
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
---------------------a07c1039fb551e2cba463e77cf7eb39f--
--------6274d9b750bddd996a4e6b74ecc372a4e6a7199c863a536a68f097a3d8dd687e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wqsEARYIAF0Fgmdu3bgJkKkWZTlQrvKZNRQAAAAAABwAEHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmdhfiiBWtBsRuNqXy/Y91O0FiEEZlQIBcAycZ2l
O9z2qRZlOVCu8pkAAMYDAQDy9TRRD317pOAJ/IWIY5TiZIuq3dC+eN2U2WO6
VHajhgD9Gz5exImjZfGdGqpB8VbYyEENqaTjwMSwcOfYu4/WEwE=
=HE02
-----END PGP SIGNATURE-----


--------6274d9b750bddd996a4e6b74ecc372a4e6a7199c863a536a68f097a3d8dd687e--

