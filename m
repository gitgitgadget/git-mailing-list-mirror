Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F4B1DF721
	for <git@vger.kernel.org>; Tue, 17 Dec 2024 10:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734430386; cv=none; b=mOj7WEh/kmYxYKOJjzV/7Zz3f1Vls2kQ+NjRbQNN8bZRF7Jj0OolldHZCKZgHQI/6mZIHdChMOclM+FCYyeZVdzqldkf65s3cAXj9KDcij62Mq2PCWTSUDFLGo9aVdR79cP3Bpc2nduX0HWGRfKzSzIx+fbVcvnws2luTPOq7iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734430386; c=relaxed/simple;
	bh=E6OGZXozQC4j1PEqx7fjooQ/L5AgJpof+Evbxm7hUUk=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=nkAyvhjA2SRI39oTaxdXCpGMgZpW6D49kKKEM9/KdANxS5cxtFya4h4e6s0cm03qIpRA3y6fvWEP9U1oAAkcVVvGF9twER3hou3PlDw2rWAdHsi2vbKlMaQj+QwGB6QCGw9zrUQiROvUyaOdIvouSYMk7DtDRxxl1tIumQ7J+aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=M7Wo8LpR; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="M7Wo8LpR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=tk4ywivxmjhj3bla5zoqjzfpim.protonmail; t=1734430373; x=1734689573;
	bh=E6OGZXozQC4j1PEqx7fjooQ/L5AgJpof+Evbxm7hUUk=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=M7Wo8LpRsnj9xeLfV5+GHNJMYjOS2QEi2qAyWi/Fw5A9O+gpmceGIY78SzKs3E9yG
	 nhFaSr0sheofcm7on6IzWoOi+JdBDvPO8bF5IAbCduxH4C7pPcXpzVtG0GyI02Ll2p
	 NHcu8VfGxg6bKRTZPUIOdbxGq+6CkyLr96FkdLAGV9IIkh1mvAXUnaUDIPl57Zlwfo
	 pTOk+QdUPDkuPDnA0L8v5Fn0SKgYjxu5/MfYOzF8FJTR+cuQIk0v+40BsHxNGTz0l3
	 Y5U1eisJOUSd+6DbP5bmclewJHwUjmfufq++ybuoHdXmba0STeduTOnF8viD9jTx+S
	 PNM4Zq9/eURAA==
Date: Tue, 17 Dec 2024 10:12:46 +0000
To: "git@vger.kernel.org" <git@vger.kernel.org>
From: A bughunter <A_bughunter@proton.me>
Subject: [help] can nobody get me an email
Message-ID: <4wL3MobzQEJEcq565GgPg4K-l5xzGERtmFhRm9FgCnlyU5rOMCgLMaWB3qzFR5httauT4gi7peWUjIfR0j_nBtiatlTpqp5xfTXnz-kX0Jw=@proton.me>
Feedback-ID: 120910843:user:proton
X-Pm-Message-ID: 2de9e0abb6747ce978046ff3e4d7da0177c6dc8d
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1=_RESglPh2pL6nxUtfzcz03LVBMJVyCbxUJt37y2wi8Y"

--b1=_RESglPh2pL6nxUtfzcz03LVBMJVyCbxUJt37y2wi8Y
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

I can't really start much of anything without an email. In the conscerns of=
 OpSec all online security concatenates to email. Google is not an option b=
ecause of Google Chrome for android Criminal espionage bug https://github.c=
om/users/freedom-foundation/projects/2 and Proton is in cahoots with Google=
 (or fakeGoogle) and outlook keeps locking me out. I will use aerc and send=
-email/format-patch for email interactions. And for development, I use Neov=
im. Can nobody get me an email?



from A_bughunter@proton.me

Sent with Proton Mail secure email.
-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYKACcFgmdhTpoJkKkWZTlQrvKZFiEEZlQIBcAycZ2lO9z2qRZlOVCu
8pkAAGKNAP46ibXUzKuIKhGstr5ZFfBsFr9WVBz8HlE/+Y4H6brI0AD+OY4B
wO82Ytw0Tmxnxu+Kt+fTSFXoAOMfx06kx4B0AAU=3D
=3DaXLB
-----END PGP SIGNATURE-----

--b1=_RESglPh2pL6nxUtfzcz03LVBMJVyCbxUJt37y2wi8Y
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

--b1=_RESglPh2pL6nxUtfzcz03LVBMJVyCbxUJt37y2wi8Y
Content-Type: application/pgp-signature; name="publickey - A_bughunter@proton.me - 0x66540805.asc.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - A_bughunter@proton.me - 0x66540805.asc.sig"

wnUEABYKACcFgmdhTpoJkKkWZTlQrvKZFiEEZlQIBcAycZ2lO9z2qRZlOVCu8pkAAMVwAQDgS1vB
RjIzvzN4hMQ/aHKgYEh3+ELGt8VS/53qxwyj9wEAz3hHD0GowOzgcVE+B59Yj7OWw/356bwEX4TZ
NhY0uwQ=

--b1=_RESglPh2pL6nxUtfzcz03LVBMJVyCbxUJt37y2wi8Y--

