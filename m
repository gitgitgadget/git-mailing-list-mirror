Received: from mail-43166.protonmail.ch (mail-43166.protonmail.ch [185.70.43.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB281A8F70
	for <git@vger.kernel.org>; Wed,  4 Dec 2024 19:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733341149; cv=none; b=TEgix6iN7OjbsOhbWaawN2Ah4BrsCdWL+B030pHaQE4OoXlE7nDaZkesWNZxcCRLV98XyIbYXaE6vwzi/frEdrRadBYcHm6RCTznsKpDXf5qy+tJLO7k52f+Md95tcrCHNmSZpNSFg4FCtuNBMkQBijlIFP9E8JdWx5wQg+Xkjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733341149; c=relaxed/simple;
	bh=jBlX9nKDDfPlpCKRE2x4tiPHEZGHoHPWIFEZ1aTgCK4=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=WCKxyTCL+wr/sQ2t95HzCLyt3V2HXjQp3yAiVraTR2Mgd2YJH969ty+zFZrx95KywYV50xf9AatUuTORk7o7WJ7K3WgWnHRIFbZaNBYjAAVZ7AVaGTfyLxrwdymCZslBMcvF/t/3+ptJEuFUHk4mvGrWrDRd1YfjDHjeT1m6PUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=AiMu7J2z; arc=none smtp.client-ip=185.70.43.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="AiMu7J2z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1733341139; x=1733600339;
	bh=jBlX9nKDDfPlpCKRE2x4tiPHEZGHoHPWIFEZ1aTgCK4=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=AiMu7J2zJ45phV/ZBTZdcI1S8AU4tS103sWdVjE9qP6Cw7T6phkSm7SNP5RQZSWNm
	 pNHszG2gnx/5AM0fAAOFK6ZDO1KaI/NguTZQ6glKkLTowBgVc/h4i1JTx+pd5JGIj5
	 7n7TVzGSxLpOYsXirEYojAIZ7fdElqOPRpzNhWt1jih94gpJPKT8EPXoR0l+zo+6Wm
	 XzXV5SEymOwSmIiEXY6PYVbv/dh49fIStlwoO8nHDKo8P46sX9FuskS+fgZmQdnSLz
	 Gqr2442qb/TMfq3NYBtWczKOFgYTW+MYtX8JPdDSZfogqLmuuUkir94jaF0HYs7oIA
	 wEEIUkU85iMyw==
Date: Wed, 04 Dec 2024 19:38:54 +0000
To: "git@vger.kernel.org" <git@vger.kernel.org>
From: A bughunter <A_bughunter@proton.me>
Subject: [help] configure git email
Message-ID: <0lBq-LfeilZJ3SBXZeBJdqr5UhOaxiOhOUHVGl6GNmbvcVGQ8LVWJYkSr5X27uE9kIFDS2YHS3hGTf3CYUkkwYtQOw4E3zteBqDXPeMvcic=@proton.me>
Feedback-ID: 120910843:user:proton
X-Pm-Message-ID: 74bba078d8f26430f88134b134e5977289f7422e
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1=_ZxrbT4WZgN5ixhjSJBCqEahKPrw9ehhD3RNsnq88Q"

--b1=_ZxrbT4WZgN5ixhjSJBCqEahKPrw9ehhD3RNsnq88Q
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512




[help] configure git email

To setup email from git using my public GitHub relay email apparently I wil=
l need a compatible email account as it seems the only compatible free emai=
l is Gmail and I have an open troubleshooting project[A] out on Google. See=
 Google Chrome for android Criminal espionage bug[A]. Will any friendly fol=
k here help a beginner out with an email account I can configure with git, =
and for local GPG -This would be good? Suggestions for alternatives are OK.=
=20
[A]: https://github.com/users/freedom-foundation/projects/2

from A_bughunter@proton.me

Sent with Proton Mail secure email.
-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYKACcFgmdQr8wJkKkWZTlQrvKZFiEEZlQIBcAycZ2lO9z2qRZlOVCu
8pkAANWQAQDcsOvBwbCD/AH2IdRMNqUncOKksI0SaNnu9uVbmzf7swD9F5Nw
fGWABTeTvZCpNBN+pmhSLdLN033C2N/nxqzh9AA=3D
=3DwxW+
-----END PGP SIGNATURE-----

--b1=_ZxrbT4WZgN5ixhjSJBCqEahKPrw9ehhD3RNsnq88Q
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

--b1=_ZxrbT4WZgN5ixhjSJBCqEahKPrw9ehhD3RNsnq88Q
Content-Type: application/pgp-signature; name="publickey - A_bughunter@proton.me - 0x66540805.asc.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - A_bughunter@proton.me - 0x66540805.asc.sig"

wnUEABYKACcFgmdQr8wJkKkWZTlQrvKZFiEEZlQIBcAycZ2lO9z2qRZlOVCu8pkAAMkwAP95RWwO
KLzUpLfS2MElIKv8aGmJSRoZIIWA4d85XmTfhwD/fGH/s/CZi8/OyaoKyYnFmfdscI/qqPaXBc9+
iZrJ2A4=

--b1=_ZxrbT4WZgN5ixhjSJBCqEahKPrw9ehhD3RNsnq88Q--

