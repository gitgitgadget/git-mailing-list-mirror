Received: from mail-43167.protonmail.ch (mail-43167.protonmail.ch [185.70.43.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596903FD1
	for <git@vger.kernel.org>; Sat, 28 Dec 2024 03:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735355123; cv=none; b=X7JW+Q5Z84rRwCAcsVE+wu9IAQpyAY29aJdTcLTBlDcRDLS/wRHkzaZg5HQ2C9vjY3VNZ/RIqnYTfkGDpqiGX+f4DZD5ehpqOICB3r+qF3sLZTyYfXd3RbfonX4U1ARSKubrMxvkGY1IN5JTbKYUu6jOVhaS2+j6fZHk86zrneU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735355123; c=relaxed/simple;
	bh=7RVnwNveaEiMmLnlX6LK4LKpsoSm6gB01d5CbJwgOXk=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=GcIFBjBMvm/SAI94QmCUIz3l8l5fPMD2QWdpg+CZTATGmTJSizQZKamZLfBUdz4lT3DUxR9DI/JjK5QFPVPJV4wTloYSAJZAvJRhFnur7eFSLGgY34Pm1CDYYZwKUbaWH3ROEc34CeivWRy1xXZdG4CUDZuVQRZasXhwKFO+CjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=QW7hxebV; arc=none smtp.client-ip=185.70.43.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="QW7hxebV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1735355115; x=1735614315;
	bh=7RVnwNveaEiMmLnlX6LK4LKpsoSm6gB01d5CbJwgOXk=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=QW7hxebVSctdxEgHzW4q7LfbzchqkpK+0ezK6WUHbyjzZ2MmoYZ57oQzhN8hGRbDl
	 +WzrxXriYVZamzzTNUy/W33g926aSix94ZtW4zgLwC/PTJH3xMo3lumVP6fMQZdvH3
	 /YuktykbceoVgPnHL5EX2ehKA64vYQuU/S6hA9UswFNGO4FrxB+bNEKcWjvYM8LUmV
	 FXs+ky02id5bIkiY1ukulRb1UaReyzTRG01xhZHiNgJbE+MvNISFjRtHUfwrqIryw2
	 HV7YxNjXeumpBoGWCazQ8U7s7SlWEXUxXhZhyjipOMWtckJgfQX9iX6JX3YfbtT4WQ
	 cCpsHFpor2EYQ==
Date: Sat, 28 Dec 2024 03:05:11 +0000
To: "git@vger.kernel.org" <git@vger.kernel.org>
From: A bughunter <A_bughunter@proton.me>
Subject: [fingerprint] of github.com
Message-ID: <ROrCxOsQ6KcZqO7YsIr2BGbPsmyUYAHXgF-l3Pwg0-7Z12oBWFrwy4yzgax9Zq6whGT4Fh4gKQxMNlHEoEOBljSvucyX9sQyc3rtT3NT0us=@proton.me>
Feedback-ID: 120910843:user:proton
X-Pm-Message-ID: fb0cc16fccc6dae981d43fbd4dcf2ae73d22af93
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------273bc02414f8966f40d474e60aecf845329bee864e98e7f3662b237d985960f2"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------273bc02414f8966f40d474e60aecf845329bee864e98e7f3662b237d985960f2
Content-Type: multipart/mixed; boundary=-------------------6bc0b444a4ee3968a6577370c1e17025

---------------------6bc0b444a4ee3968a6577370c1e17025
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=utf-8

How would you confirm the correct SSH server fingerprint of github.com upo=
n initial connection? Does GitHub post valid FP anywhere?=0A=0Afrom A_bugh=
unter@proton.me=0A=0ASent from Proton Mail Android
---------------------6bc0b444a4ee3968a6577370c1e17025
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
---------------------6bc0b444a4ee3968a6577370c1e17025--
--------273bc02414f8966f40d474e60aecf845329bee864e98e7f3662b237d985960f2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wqsEARYIAF0FgmdvauYJkKkWZTlQrvKZNRQAAAAAABwAEHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmc3JM8NccScRx5iP736mlBuFiEEZlQIBcAycZ2l
O9z2qRZlOVCu8pkAAJnqAPsFQ9o2sU0r9geS2AXPoHUja4dvsSW9OvquTJYl
63ETvgEAvbCSTBSy89FhnNPjL0byALwRWbpY5S+9syoK/UdEUwE=
=avqK
-----END PGP SIGNATURE-----


--------273bc02414f8966f40d474e60aecf845329bee864e98e7f3662b237d985960f2--

