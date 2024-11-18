Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D9B1E765C
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 19:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731959527; cv=none; b=tPO9qH8wnHkgN+L1Kh9eoZFvVyG55+8oWVqd6gJ58BRHK4RNVTB1b0fTRofvysYzt4za3rCTFQZmBtErqqyjSVjfn+ERPcampGuBzitP3Kzs1PxVk1HejADlT8wBZMtDpBeD+CnjO5839iaBwDyqSepgxuSt83KiMu7s0leb8ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731959527; c=relaxed/simple;
	bh=tDvlc0LwFbwHrCWFiVRQ5ZyvEuImT0xC2UMqNzIf82A=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CdX6BFsahbpnhHxoFGiIROTIkh6XT2Mut10ZDkVlNSzFRep1PXyWPW48N6G6LdlgeIiHGT8n6dkx+UVIa+hm/MsTxDI6RufcrGHRqyY/t4OyzPov6VdskE/tWzRmFBXgjYIHibV5l9R4FOJj2n2rmxSFS9HcZ4PtLln6714s7CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=ZArweRuv; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ZArweRuv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1731959514; x=1732218714;
	bh=tDvlc0LwFbwHrCWFiVRQ5ZyvEuImT0xC2UMqNzIf82A=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=ZArweRuvK/EXRS2hKpGyzVGsY4+idEiOd03cPW67XILcTlJ4ebQfUlnvC5wYcl2YQ
	 X8xdEiKtq03MP3333x0cRby3p+W5OzbAMgiq8+mia3z7XvkL/w8uFYdDfaDmOaTSRj
	 NDBtlhwcqW8OvSTZEfmYRxJ822u7vfGMCoS7jeINHCKT5DLaEAlcC39/CXpPYh8Vuj
	 LNF4U54KVcCMOu0JSQOBg41E+FlzP+/86tSFwOsShjkrkjwsXlHUz7XuNA/g0678CW
	 7z7r4V+Yue9L8XsndGcFzeWrYbE3+HFtzxTlLvgoHw6RnHz1HAjnPBAoyxqUz4y6T+
	 SpvnyAcIUHWmw==
Date: Mon, 18 Nov 2024 19:51:49 +0000
To: "git@vger.kernel.org" <git@vger.kernel.org>
From: A bughunter <A_bughunter@proton.me>
Subject: Re: How do you hyperlink a thread
Message-ID: <lLSbsbSEi1ltdY3N1MKhGPVHTPeII5XsqVcYwmh_WHIjVAlNyktnNEaLgBUkh6stvHLE371tlmlhOTdoFloVic-Wq0wE0pQYLBeeVuvA_oA=@proton.me>
In-Reply-To: <Sj2qFJa5yPRxluqhZvXlMwgfLuX9n6Um4OOS9IHNXCJU3jjE0YblQDUt0rOpEzY-fUHs5CiognunZO-ddQN-1IVVBEyxLz_2hl936VBW-JU=@proton.me>
References: <Sj2qFJa5yPRxluqhZvXlMwgfLuX9n6Um4OOS9IHNXCJU3jjE0YblQDUt0rOpEzY-fUHs5CiognunZO-ddQN-1IVVBEyxLz_2hl936VBW-JU=@proton.me>
Feedback-ID: 120910843:user:proton
X-Pm-Message-ID: e2f0ac79aa4d4dc71a7bf46cde59191fbec70b7d
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1=_ofEdFX6W1rYtLKgZIe2BKnL9RNwpUi5ei0AXpWFNYog"

--b1=_ofEdFX6W1rYtLKgZIe2BKnL9RNwpUi5ei0AXpWFNYog
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Monday, November 18th, 2024 at 05:04, A bughunter <A_bughunter@proton.me=
> wrote:

> How do you hyperlink a thread in this Mailing List when writing to the ML=
 in order to reference related threads? I now have three threads going and =
all of them are related BUGREPORT > TECHNICAL QUESTION > USE-CASE. How do y=
ou hyperlink to a ML thread in a ML message?

Hello, why isn't anybody answering me? I see an active list. As you may'v s=
een I'm new to the ML. I read up on top posting, bottom posting, and interl=
eaved. Please wait while I configure my email for bottom posting by default=
 and no appended signatures. There is a logic to top posting for magnus and=
 bottom posting more passive things. I call it interspersed and not interle=
aved because each line is a sparce sperse of the whole reply.=20
-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYKACcFgmc7mtIJkKkWZTlQrvKZFiEEZlQIBcAycZ2lO9z2qRZlOVCu
8pkAALZ3AQDVOFNJ0RKeMqJibdLD/ziyq/3LOXu0c1SUOMBAKEHjHwEA/oGl
OUCVMnCswiGXojmq5WH0rv6ad+DGzrzGBMwJJAs=3D
=3DVTzt
-----END PGP SIGNATURE-----

--b1=_ofEdFX6W1rYtLKgZIe2BKnL9RNwpUi5ei0AXpWFNYog
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

--b1=_ofEdFX6W1rYtLKgZIe2BKnL9RNwpUi5ei0AXpWFNYog
Content-Type: application/pgp-signature; name="publickey - A_bughunter@proton.me - 0x66540805.asc.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - A_bughunter@proton.me - 0x66540805.asc.sig"

wnUEABYKACcFgmc7mtIJkKkWZTlQrvKZFiEEZlQIBcAycZ2lO9z2qRZlOVCu8pkAAFRfAP9+GZ/H
T4muc2abr1hX76/M/VPPCMKYYpBx/dZoMrsLBgD/RFnqsw6ZXworZXGz+lnExneFHd/B7HlvX6Z5
lWUw4gM=

--b1=_ofEdFX6W1rYtLKgZIe2BKnL9RNwpUi5ei0AXpWFNYog--

