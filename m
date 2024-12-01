Received: from mail-40138.protonmail.ch (mail-40138.protonmail.ch [185.70.40.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BE323A6
	for <git@vger.kernel.org>; Sun,  1 Dec 2024 03:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733022031; cv=none; b=Avel4bDGyq6ZDwUMYa4x/u4yoQT9rB2eq0B8yhCDJ7ccuVP3A+v90PY2TG1azwoSn+2OAm+gCTkfLeKIPZe3hHISdl/y6YuObZiUWSH6UFD8DGCrZxkK8/59XKMqILfIVaUd+bbGjwSnskQX6T5GVhgIjuy4Zki+HXEmXZBu9lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733022031; c=relaxed/simple;
	bh=vhEJrV9Kasye2s/b11OFtvSNc76q1La1Rs+LrG3EIok=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=bUO6XUL3daRcNywen8jZW9TjNBgCkWWWFGa5dP2yHpvqO63dIK+Qtu53P+vL8qoc0NNfTMullHbRk7LSz09l0WgAahwHZTU4sZL7qPBB7hzPBjzqwdN+OR2sQnNL62F5nIKVhf6rVipN1StSUKX9iQ0M5gkIB8hWWdWUpp+RlRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=SuwZNx5W; arc=none smtp.client-ip=185.70.40.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="SuwZNx5W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1733022022; x=1733281222;
	bh=vhEJrV9Kasye2s/b11OFtvSNc76q1La1Rs+LrG3EIok=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=SuwZNx5WHsiUhuFBDb9ag9eoTaTKG8hxjT3nMsDbEBbU6C1ka05vZRgjYu3i4AEkq
	 tUV7g6rPyj4qM41NknBdF45OQDjHfjPlVmYtYsvAgz+GeYu2NivCYYYwGnT+c7nIFV
	 chB2LlcmxtpocgDowJcM8gikQoQJZiR91uGLkHhB3qqCU/i3X2Ui8++TDR8n7kqA5v
	 OJCIslVKxInHoqglejwWy1VYHrBnDBvUmSEGJBb2mujImpSDWRxH/07cbb9kTZ11nf
	 EoUmsIXrKeKYIitD4B+eicbuQdL8vgLu2+ovdScJhVTCKjIBxeSTRUzq5B08dHJ8rQ
	 9t/Kv7bjHepBw==
Date: Sun, 01 Dec 2024 03:00:18 +0000
To: "git@vger.kernel.org" <git@vger.kernel.org>
From: A bughunter <A_bughunter@proton.me>
Subject: disarm the "landmines"
Message-ID: <7UwLla5WLJwqkusnmBWvXe8-heqVui93dYpo5BTXeSAdMk2nhkJphr0vkJd2NwGJxnGaCDHB6-x2rInUHWg5Q6yeH66k5ZZ3gaH08igVzOI=@proton.me>
Feedback-ID: 120910843:user:proton
X-Pm-Message-ID: cdd31464c114c486b4cb378c44f9ccf8a42820fd
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1=_ZMkqksfIYdChKLTxKKvg0oaIqRLRxh6WOUuWRocY"

--b1=_ZMkqksfIYdChKLTxKKvg0oaIqRLRxh6WOUuWRocY
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Y'all need to get your priorities straight. Maybe you should disarm the "la=
ndmines" before you go on about adding features thence introducing more def=
ects.=20


from A_bughunter@proton.me

Sent with Proton Mail secure email.
-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYKACcFgmdL0T8JkKkWZTlQrvKZFiEEZlQIBcAycZ2lO9z2qRZlOVCu
8pkAAEIfAP9q2Hgl1AdoxN2fr0/aoF6q3HCdu9KUKQwTX6bYn45zIAEAp2oA
wYMiaW0MnKoJjI3UgjUknN3ftMKi2wgrVM/riw4=3D
=3DHbOz
-----END PGP SIGNATURE-----

--b1=_ZMkqksfIYdChKLTxKKvg0oaIqRLRxh6WOUuWRocY
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

--b1=_ZMkqksfIYdChKLTxKKvg0oaIqRLRxh6WOUuWRocY
Content-Type: application/pgp-signature; name="publickey - A_bughunter@proton.me - 0x66540805.asc.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - A_bughunter@proton.me - 0x66540805.asc.sig"

wnUEABYKACcFgmdL0T8JkKkWZTlQrvKZFiEEZlQIBcAycZ2lO9z2qRZlOVCu8pkAAJZfAP0W7Ofh
rSDA7YENVmmhZNpCLBVOHs2oPpvkBrfnKYoZJwEAk8bbJmHy0ts9jLO+hDpP0dY7odjVBfXaBeYt
EriBOwM=

--b1=_ZMkqksfIYdChKLTxKKvg0oaIqRLRxh6WOUuWRocY--

