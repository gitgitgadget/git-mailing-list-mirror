Received: from mail-43166.protonmail.ch (mail-43166.protonmail.ch [185.70.43.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692DCB644
	for <git@vger.kernel.org>; Sat, 28 Dec 2024 01:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735350475; cv=none; b=n6BYQQbBjGBm9OQuWFxpnkIgcF0l3MzZwOaKOGpqZycpcfHJKV9MljD9TdOuAha1XqC3TSTRinGT96H4Oa4BPjoofY4TJRlPBHHHsuvQy23tTbV04FCbiGbl3AHRADuK18SNnFliRpxKNM175WTsDcFRl3ayqunKK/LmI/ehReU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735350475; c=relaxed/simple;
	bh=f0MG2Y5isJPA6KHGIyiNrqxbWtU0ayjyxaM9fw/CmMY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hofab3ey+ucedS9MmnYq3qq+bwwo8JW8V4FPnpzqDweLcbxYgCpGu52efaPpko/i3zb3krKWEPdbADVKECELvEc+Xl0H5kHIo0PwN74U2hiLR3DvlQoLjMrjg6LxGv131HjhA9jRPqqZ3j+jkwQkgb0LlcHD+HIpj+gHODsx0aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=UGi0RuY4; arc=none smtp.client-ip=185.70.43.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="UGi0RuY4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=qufcb3fbt5gz7a3wp63fsclsq4.protonmail; t=1735350465; x=1735609665;
	bh=+VLknPxjyYYjs+utfsiRUnN9Jyx8mHZCThzxuUDAN/k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=UGi0RuY4aoDO+Nara0dxdGxTExviGmHBfaXULTtv8XD/4c13qg5ggCbfSHfHEtIpZ
	 xMdf2h4axw6t/ry/x8lvzhCitEaF1toYKu+9YTIsQ0jmvA+0iKIfJERhQglQo7bW14
	 qubXnm+ftxX9bmUHRA+qFORiU0yNdsCKClzA3LFaVg+la3aqRlEOf4ee7H3LYcXu/O
	 T93KmrP05CzWDQ/XD9P+meh5vDarciV7VlPOc6+r3W0tjEwOHiP4KcB4++ovumriOg
	 PwAgRblHnwJ0cgvS4AILCT/ghY4xp6wuDC6vU5zYHBX0uDgvEwkAHiSz+10esxJtXp
	 IANmYN5hqEuQA==
Date: Sat, 28 Dec 2024 01:47:41 +0000
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
From: A bughunter <A_bughunter@proton.me>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [help] can nobody get me an email
Message-ID: <LXWuYLP6FfmXIxPdj7pH1ueaTpIgQG3iDpz2VAWqlYj1UQLT5tRNzZwSq0p64JAdtfhDeBJIpinA0rhAzJQccSKFPO6T7r7J8gYq4QeIwHk=@proton.me>
In-Reply-To: <20241227-positive-cyber-guan-b3891e@lemur>
References: <4wL3MobzQEJEcq565GgPg4K-l5xzGERtmFhRm9FgCnlyU5rOMCgLMaWB3qzFR5httauT4gi7peWUjIfR0j_nBtiatlTpqp5xfTXnz-kX0Jw=@proton.me> <hzyhvw4pe42yqbuqdbgl5bgnxz2kd5mxxh6jnklnqwvembueqv@b6oaetnegprl> <s44De1e7kjF5OIY_YVaSJ0DdAavD-4WeZ3XrrA7XJLJO67ShZWLM9Sb1ywSUq58wmCWOTkRfhBBOvw1qCpiiUyygy53wFTetUECruyO1SEw=@proton.me> <TpuMiCTLZ7JDXxJPgVNqcYXWFavK4asar9Gk9uJiiYp1nbqmKlP22mX6xiDOKHKr5yaN7ZH7jXoISqIY67wmbFfz8i8MsYokeomQu_6Ytis=@proton.me> <ErRnPDWInS44QmxYjAyDuZ9aaZgBwRoP0xRdx0qln2dHF_I6JK6zYErrx41iQaN6GOb0iOWeEMMEXtWzlVr4ayLUUX9L6yDkpj23O8ubNPg=@proton.me> <20241227-positive-cyber-guan-b3891e@lemur>
Feedback-ID: 120910843:user:proton
X-Pm-Message-ID: b239f5d95063dc80515ca974b5d70eba9b225abb
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------6d3b19a026653dcb67ede765e674351d62343b422ea28e56c53e74c28fd82834"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------6d3b19a026653dcb67ede765e674351d62343b422ea28e56c53e74c28fd82834
Content-Type: multipart/mixed; boundary=-------------------bae7223522f07d3f790a879fbb84f0b5

---------------------bae7223522f07d3f790a879fbb84f0b5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=utf-8

>  https://brennan.io/2021/05/05/kernel-mailing-lists-thunderbird-nntp/=0A=
=0ADoes this not work on Thunderbird Mobile for android? Look's not.
---------------------bae7223522f07d3f790a879fbb84f0b5
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
---------------------bae7223522f07d3f790a879fbb84f0b5--
--------6d3b19a026653dcb67ede765e674351d62343b422ea28e56c53e74c28fd82834
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wqoEARYIAF0FgmdvWLwJkKkWZTlQrvKZNRQAAAAAABwAEHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmfzB2CH5c/81b5oYotrMubPFiEEZlQIBcAycZ2l
O9z2qRZlOVCu8pkAAB/mAP9zZuk3f8raMHAXH1GLpByathwmeQLS0GV/5pUp
BnMhMAD43x/3JJntXen9FgoyD3DVBd+DBGX0vvXh28Am/SbmCA==
=GxA1
-----END PGP SIGNATURE-----


--------6d3b19a026653dcb67ede765e674351d62343b422ea28e56c53e74c28fd82834--

