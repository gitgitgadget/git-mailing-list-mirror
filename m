Received: from mail-40132.protonmail.ch (mail-40132.protonmail.ch [185.70.40.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896213C6BA
	for <git@vger.kernel.org>; Thu, 14 Nov 2024 17:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731606802; cv=none; b=i78ad3Z9hWMDnDsZoaPTwLJQ7zE2mGMTqa4SATiVzd/llIrDED7ojY85XxZtKcaLm2ZNE/6tsunM+4LxKG7Dq33njsnAysu3RioRH8TouGs8fwc0Whc2n5zABZ9sV9Op0X8obMYJDybXgMrTtg86LPjEgje6kPQb0KEnulC1rMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731606802; c=relaxed/simple;
	bh=tHpmGLuZSsXwvCfgBV6FEEkS1nwgflgVNhdotjw/OdI=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=Z2vw2jfSujZDTCLkJBK1cKFu81S3lh5b5CN2hx8i4Lu7n+6+nXSWtzId6vMyo6zROlQ5hEefYzW26rKXFQEVpD3Yg++P9rqRrYp8zUWOUwZE/GosdYTQDN8TGGLwK5+htq+XQdsU3YLKhyshWw/BBPzcjnLutvDwUsiDqHyhQJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Xij3fVh8; arc=none smtp.client-ip=185.70.40.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Xij3fVh8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=xsk4z63qjzao5ewjpuhuocuvsa.protonmail; t=1731606798; x=1731865998;
	bh=tHpmGLuZSsXwvCfgBV6FEEkS1nwgflgVNhdotjw/OdI=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=Xij3fVh8NxoLgveWePbSzkuHACCgZUBh7CQ2Rs11LSmI0MHX7nvDgKIqbPw7BFZA2
	 z6HC0jLfqYo9A/euV84t0XoAwpm3jT7yZfquIzaEp9ehsJoU3qNefhD2+B2V0SRAKe
	 OtXmefPbpS0Dump7fPIOTkYa8rlPpQGP4PEM+YcMBn1aDbrEWg/GvmJO9TCsHPDD/D
	 fyP36/ixYp3L2Wy6LnMbkv9BSl1Be/JiOkniEm/Ejoz/WnMDA+2D2jzNoMdoGytL2u
	 jMIHfiONMG8MSL+Qa8wu24yc/r8OJdMLfL+C5XCCyzuVur6HHlqe4UpmeWGvz0ktDI
	 oNNlpP7Jwlh7g==
Date: Thu, 14 Nov 2024 17:53:15 +0000
To: "git@vger.kernel.org" <git@vger.kernel.org>
From: A bughunter <A_bughunter@proton.me>
Subject: [bug] user may be cornered into delete files #9901
Message-ID: <P_ttzPnNTtUgpAy8cg_ntLvwskJhz7cmv-fFgDw0K4Y2vOCx8v_AXxHtHEuBtpREOQu9pxpvK6JgLusc5Uyn2wDZ4HZvC3ttM4k-Ry6jBs8=@proton.me>
Feedback-ID: 120910843:user:proton
X-Pm-Message-ID: 551a61c35cdc0733c954270d7c5de71297b99231
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1=_BYxMePBHap1WwOar1794ZUt3sxW3XcYXZ8h95wE"

--b1=_BYxMePBHap1WwOar1794ZUt3sxW3XcYXZ8h95wE
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

 [bug] user may be cornered into delete files #9901 pls see https://github.=
com/cli/cli/issues/9901 and look into all of the links.=20



from A_bughunter@proton.me

Sent with Proton Mail secure email.
-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYKACcFgmc2OQgJkKkWZTlQrvKZFiEEZlQIBcAycZ2lO9z2qRZlOVCu
8pkAAMpYAP92jH1GmK/fhQDScPH7WylcYaYatoIkZGTKhYGtvAcWdQEAqa9I
34yBlDPlbMPExwW6vNJEk0gzwHLKbZjgXO2WrAA=3D
=3D0D8V
-----END PGP SIGNATURE-----

--b1=_BYxMePBHap1WwOar1794ZUt3sxW3XcYXZ8h95wE
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

--b1=_BYxMePBHap1WwOar1794ZUt3sxW3XcYXZ8h95wE
Content-Type: application/pgp-signature; name="publickey - A_bughunter@proton.me - 0x66540805.asc.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - A_bughunter@proton.me - 0x66540805.asc.sig"

wnUEABYKACcFgmc2OQgJkKkWZTlQrvKZFiEEZlQIBcAycZ2lO9z2qRZlOVCu8pkAAAyjAQC+5Ox4
sHc7rpAVmUS2J8vxsbTwg70Gl/nqVQ1a90RgSAD/ZB+0fHQJrtG51/C+u0CbJmaryz1Wq6Xy6Ic8
t/G/dgk=

--b1=_BYxMePBHap1WwOar1794ZUt3sxW3XcYXZ8h95wE--

