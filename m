Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8D529A9
	for <git@vger.kernel.org>; Sun, 24 Nov 2024 02:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732415067; cv=none; b=FeMUzpZw30xdrB6iRn+zz8dP1KwPI6jbb30N7FDJ/bDI5gjx2tCBme/z2QEFEp15DmhjjEYTVCDn1nd7U4mfUQXMO26HWhSX7zBPUjVpI42o54dDdOrvhRxMddVFRJFusdLNl4Cug+6U0/2wJDLWipwEqhJwo7WP4FzGKZk5IdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732415067; c=relaxed/simple;
	bh=EM0wqxOwu0HVHmv94f5WzitO5/20X1xI//g5E4Tmat4=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=rEdu2tlhmgSIjtCi9D1abrq3FiK2bnEwwtJu2NlYYyi6BIK/RdC8zWDJLyaqrMlHeh4q2HaCGpGFvQXIjmKSbfVCp0qAU+YIQHZnkCSXNxRhQMJT9/ohXTc6HHSs4vMMvQsckcktDRMlLOa9u7+wqpCGiMDOjf7FMntxe2Nftto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=JcTtJxor; arc=none smtp.client-ip=185.70.43.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="JcTtJxor"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1732415062; x=1732674262;
	bh=rxfc55l5VFfpljtnIINCvEIqznGfy4ORfGHJ8wT99Jc=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=JcTtJxorY7LJZCts0NSy3IKWssrl3MduZkDL4C8bLUuS6vZt6lHedpLLzV+ojUvgb
	 TohaEdqL/Zu3rr28552XKXgQeXGNOJrayb8EoITWA/BQ6nZ5Mgrv9LlDihHHToDRPj
	 w0nEnI4ZPuX4GE9Z9oGKfWwMaj+WHvAewjUnIYEe+5XtTerzOSw7Lm6Q3LuuJC55WN
	 weoIvxZTfQp64WYGi8GdjQwNfSJ3/Im3An9wovTJQAU1xktIRRWpGow6cLm/B6piEj
	 THGYpHsudRjdE/TvSQp6wYkayeRQLHQkRQuaDxzGOfJ9P6xD4So9gqgWMq2PWju4TH
	 8ztGV/SUBOW2g==
Date: Sun, 24 Nov 2024 02:24:19 +0000
To: "git@vger.kernel.org" <git@vger.kernel.org>
From: A bughunter <A_bughunter@proton.me>
Subject: [question] When an identical file is added
Message-ID: <lSW86a4L1xWHfSTWIq732o26YCBCIN_B0rd6B1bCP8VIAY8d1V9pD1WEcCyW7Wyw2T14VVYka5XMTwJGFZEKcovBYIgOBUO5lbPWQ44cIfM=@proton.me>
Feedback-ID: 120910843:user:proton
X-Pm-Message-ID: 27fc54f0b50bfa39672e4bd10a4541aa68404ca1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1=_1MinLqvfJ0vlLPaX7ACdFAbrErNXCIYfHLDwX2GGQ"

--b1=_1MinLqvfJ0vlLPaX7ACdFAbrErNXCIYfHLDwX2GGQ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

[question] When an identical file is added

While objects are immutable, if I do mixed mode reset switching to an old-c=
ommit under HEAD then 'add' the same files again
Q. Will it keep two copies as objects?=20
A. No because when an identical file is added the object file is identical.=
  These become tree entries pointing to the same object.=20
Q. May this overwrite the same object file because it is the same file? or =
because it is immutable will it reuse the old object file?
A. When an identical file is added the old object shall be _ANSWER_HERE_



from A_bughunter@proton.me

Sent with Proton Mail secure email.
-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYKACcFgmdCjlAJkKkWZTlQrvKZFiEEZlQIBcAycZ2lO9z2qRZlOVCu
8pkAADfCAP0fuC5Rc0gHALam7YkQHjZg54dGrnEUa6tZJZpSzNuiBgEA5c0a
G+ZwfchdHP0gMPwHx4+TBL6LhW7ogj7u2IubQA4=3D
=3DxVzR
-----END PGP SIGNATURE-----

--b1=_1MinLqvfJ0vlLPaX7ACdFAbrErNXCIYfHLDwX2GGQ
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

--b1=_1MinLqvfJ0vlLPaX7ACdFAbrErNXCIYfHLDwX2GGQ
Content-Type: application/pgp-signature; name="publickey - A_bughunter@proton.me - 0x66540805.asc.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - A_bughunter@proton.me - 0x66540805.asc.sig"

wnUEABYKACcFgmdCjlAJkKkWZTlQrvKZFiEEZlQIBcAycZ2lO9z2qRZlOVCu8pkAALFQAPwKt4bn
spoS9Spwz7W7fVGIwS7FwXVbay75QegP6BNuEwEAsOPAQsoUsS/KMeOXCnWDoom+XBe4eC41A4gx
IndNCAg=

--b1=_1MinLqvfJ0vlLPaX7ACdFAbrErNXCIYfHLDwX2GGQ--

