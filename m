Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B65F9E8
	for <git@vger.kernel.org>; Sun,  1 Dec 2024 02:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733021524; cv=none; b=bm+s1S0SFinTMlfSU1OPJduD2vqargS+Bjmvmq7PS576D8esIR4/z5ZVl4PEg+AlKt/Pq9iO5SKWBh29z4QTRJEftM+X53kjuQSP3l3JijBZgtUpGjNhXJXuh8H2a5B9phSKeb4yv4kYN9BlNF98tuoAIyTlG38Fhv+2bIvPgxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733021524; c=relaxed/simple;
	bh=cAH9o8B4oh0R/WSx+kQpKkVhRgyAQdLLzR8k842R+7E=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RIlEvJCpHyRvHMlvv1Xai7HnsPMoDQfj7mLxw7jWw8ZmDY9nDw9SfWV6jJ71Fr+2/T5SHcmFdyRGE9zfSOOjsk55Q3gZIObg1m+RdBMcL8iHB4idASrTirmXjv1iXxLHYO7u26hO/SL4p55Hu9UK+p7xnvT26ZAQgP9MwXVm8wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=bSEuYWlH; arc=none smtp.client-ip=185.70.43.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="bSEuYWlH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=wi6k6ajtwnhw7iu6vnrgb3plfu.protonmail; t=1733021512; x=1733280712;
	bh=cAH9o8B4oh0R/WSx+kQpKkVhRgyAQdLLzR8k842R+7E=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=bSEuYWlHMcatgsipJ4OKlzOi/rzCQP/IypaYCLambQu5RahLbeoM9ndsiw5aR0HDH
	 bUQgmQdMg3kh6rFvPeji2imN9EeKVgUD7piQsD+cgnU3smSzH7M5YP0jTFb006Ulto
	 EZC0QOYq2Dq2uKBQgl6S/rg9kXO4g5n9EYmtYu0WU90PbaBTKsjR1mR+O8L3XujOUT
	 47z08Sr/o+W61gZJnkepFwl6PJ7yerEqlh2dSXfYDYhjWXJJHgcL5Lr2mLjM1BvKV4
	 4SK1K2cr10mV4TRX0zhmctaJey04Ii1gUrRsEDFnMf0zZy6A+8bz84ibPn39qVUKfi
	 h1XZZpxCUxT6Q==
Date: Sun, 01 Dec 2024 02:51:49 +0000
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
From: A bughunter <A_bughunter@proton.me>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Extending whitespace checks
Message-ID: <cEDEN8jk6KzFgDQ32ejB3TGL8nHkAwS84330i3oroO-rwjWmor_NGAwnAjOt_25zEbYgsNBoE9QMLXAsLW_R_IQVUM14kDzleSStPpilyK8=@proton.me>
In-Reply-To: <89b1b39c-a6d2-4f63-9cc5-722772bddd8a@app.fastmail.com>
References: <xmqqbjy5bc6m.fsf@gitster.g> <D5UQHS9IV5N1.3IO1848Q1730B@ferdinandy.com> <89b1b39c-a6d2-4f63-9cc5-722772bddd8a@app.fastmail.com>
Feedback-ID: 120910843:user:proton
X-Pm-Message-ID: d6e4d55d13df24a46ac77529409de4bd8d9ce65e
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1=_qZCEAeLXVu0CPW4AkzgO6tB4ou6NawriKC5nf46FBw"

--b1=_qZCEAeLXVu0CPW4AkzgO6tB4ou6NawriKC5nf46FBw
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

 " This might be a tangent, but since enhancing whitespace checking was men=
tioned, "shoehorning": If it ain't broke don't fix it. Prudence indeed. Esp=
ecially if you are messing with something having what you called " landmine=
s".=20
-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYKACcFgmdLz0MJkKkWZTlQrvKZFiEEZlQIBcAycZ2lO9z2qRZlOVCu
8pkAAIROAP46l2AgKrh/FKvSwUHxC6XdqMYODOi7zTMYy7Annv72nQEAn6sQ
rtlEGS/xcb1BMKaMUWS5zYxrdi3hrwFsbasCQwU=3D
=3DFwc6
-----END PGP SIGNATURE-----

--b1=_qZCEAeLXVu0CPW4AkzgO6tB4ou6NawriKC5nf46FBw
Content-Type: application/pgp-keys; name="publickey - A_bughunter@proton.me - 0x66540805.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - A_bughunter@proton.me - 0x66540805.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgp4ak1FWnUwWDF4WUpLd1lCQkFI
YVJ3OEJBUWRBSDBJNDdqRHNQWjZndmIrWVVHQm5BeDdKeWYxNEFWT0gKeGE4eTArZG1ONWJOTFVG
ZlluVm5hSFZ1ZEdWeVFIQnliM1J2Ymk1dFpTQThRVjlpZFdkb2RXNTBaWEpBCmNISnZkRzl1TG0x
bFBzS01CQkFXQ2dBK0JZSm03UmZYQkFzSkJ3Z0prS2tXWlRsUXJ2S1pBeFVJQ2dRVwpBQUlCQWhr
QkFwc0RBaDRCRmlFRVpsUUlCY0F5Y1oybE85ejJxUlpsT1ZDdThwa0FBRDlGQVA5L2RkVDYKNTZH
a2E5TnRNdm1kb1k1a3ROZ3FiWTVYYmQ5Zng2a1BFNS80dFFEL1hpaWFsS1FIam13QXRiY1NlMVEr
CjNjeFlMeE5oalU3bXluUXNwdjlkeEFET09BUm03UmZYRWdvckJnRUVBWmRWQVFVQkFRZEFuZnAv
ejJGdwpSa3B2VWdmN21xWUk5UktuVFZhZHdHZmdhUUxobXdnM0x4TURBUWdId25nRUdCWUtBQ29G
Z21idEY5Y0oKa0trV1pUbFFydktaQXBzTUZpRUVabFFJQmNBeWNaMmxPOXoycVJabE9WQ3U4cGtB
QUppOEFRQytmbk9tCjRWajlRbUg0SDBHVnQ3UnVPUUsrd09RMVBSdnB5bVNqZXlCSk93RDlHWXV2
eE9BVks4aUF1cEorcHB3TQpyMzZWdWtJZTFwWHVIbzlSaGp2ZUF3MD0KPUZRRncKLS0tLS1FTkQg
UEdQIFBVQkxJQyBLRVkgQkxPQ0stLS0tLQo=

--b1=_qZCEAeLXVu0CPW4AkzgO6tB4ou6NawriKC5nf46FBw
Content-Type: application/pgp-signature; name="publickey - A_bughunter@proton.me - 0x66540805.asc.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - A_bughunter@proton.me - 0x66540805.asc.sig"

wnUEABYKACcFgmdLz0MJkKkWZTlQrvKZFiEEZlQIBcAycZ2lO9z2qRZlOVCu8pkAABlrAP0Wy0Sv
A5jC82qoEVVAaxil37b8bY1mJQLNYSK4gZxEUwEAwU7rJUzy3kX7mqLlAeftEzK/O2W6JuIC5tkU
W0CEYwE=

--b1=_qZCEAeLXVu0CPW4AkzgO6tB4ou6NawriKC5nf46FBw--

