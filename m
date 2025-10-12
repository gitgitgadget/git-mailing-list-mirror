Received: from mail-43166.protonmail.ch (mail-43166.protonmail.ch [185.70.43.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103FA1FDA
	for <git@vger.kernel.org>; Sun, 12 Oct 2025 16:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760287553; cv=none; b=AH126IH2dP05QKDyzUHtIuOqJjFA88+h1E3bItr0aBoymFOF5HAlTLse9+tKj1cdkFCvaQMDGmN/+vYq7u4/VUFEtIYDf7FleNUUsBasxpI9vytT3rqfa+J7P96ThVGT5j0mTGSPvW2c0k6KQ0IwFMPnhkfXEb/doQ6LlVV45X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760287553; c=relaxed/simple;
	bh=2Fy93ScysOFQWJeXFroG4s4Er5DofIeT8sZphMZ89NA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EjJoy6s1BK0yGFhq/oCmdhRsw6jOV22oBp+Gh0nyBW0G41tLSP9osfC6s6AB48+IgemfwbLVRqR8zP3r8rk5qRXor4LJ5KhGLt6/aRp6se0OamxXPy/LpDcBhDTYYNRHoCuz2WG3lNpAUGD3eRRr/FNmH2QKz7GeuDtnNjlygGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=cfZilggd; arc=none smtp.client-ip=185.70.43.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="cfZilggd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1760287538; x=1760546738;
	bh=jJbsxMjkRURMUzVvb5wXn5Bgl92mVoSLiTYRZUlV+nY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=cfZilggdfTORwHMeOmpnVVMHTeKEkEJ0Gl5NYCrNPlwz/OO0sgdDum7DPJHMhhARo
	 OWSZyHHpYZwRQwx2UCRpKi39j5vBd4qeygdh8ToO9QjxblpE/w1sUw8fa83Umus+Cj
	 TYUP64o2vg/lr1S4xggrTRSUzwFs95DljHYAtsST3cqhWaHfi9NzlcUtFPk+PnYaXs
	 VHbuBlbTz7vNuZHnOltNAEO3+QtoMSkv053HL73EJX89qbzhSNeINwbWKMi3SxioyS
	 iSozx94OBQ0m3Nvu9uhEMOQCMYHPoeArJdlTJBeZmqKbzcPer57o99RfsArDx4mIMI
	 5XPe5quFgybxg==
Date: Sun, 12 Oct 2025 16:45:34 +0000
To: Miroma via GitGitGadget <gitgitgadget@gmail.com>
From: Miroma <its.miroma@proton.me>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2] stash: show correct entries count
Message-ID: <-H8VS7fJi6Nie2ovTiryLWwggMWohoJybAfjf7QjUTBZPojsBZtOnl93jq5cOX8cDRiiNLkHLQQQOGehXLqcOG9fC_V7UUVHfHmY1doks84=@proton.me>
In-Reply-To: <pull.2067.v2.git.git.1760007783388.gitgitgadget@gmail.com>
References: <pull.2067.git.git.1759750539721.gitgitgadget@gmail.com> <pull.2067.v2.git.git.1760007783388.gitgitgadget@gmail.com>
Feedback-ID: 106560626:user:proton
X-Pm-Message-ID: b4e1de496166bf5c29006e17c081bd66873d8dc6
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------6c439f51153e8f6f711a1eb8efceec85169f7355772356eac7d1f74fc0c5eab9"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------6c439f51153e8f6f711a1eb8efceec85169f7355772356eac7d1f74fc0c5eab9
Content-Type: multipart/mixed;boundary=---------------------11ce497ff2de482a80672c4b5940b845

-----------------------11ce497ff2de482a80672c4b5940b845
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

I have a few questions I'd appreciate an input on:

- Should 'stash clear' also print "Your stash now has 0 entries"?
- Why does 'do_push_stack' pass quiet=3D0 to 'do_store_stash' (line 1695)?
- Why do the following subcommands not support '--quiet'?
    'branch', 'import', 'export', 'create', 'clear'
- Is exporting 'count_stash_entries' in "wt-status" a good idea?

-----------------------11ce497ff2de482a80672c4b5940b845
Content-Type: application/pgp-keys; filename="publickey - its.miroma@proton.me - 0x433A3299.asc"; name="publickey - its.miroma@proton.me - 0x433A3299.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - its.miroma@proton.me - 0x433A3299.asc"; name="publickey - its.miroma@proton.me - 0x433A3299.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgp4ak1FWmhVNnFSWUpLd1lCQkFI
YVJ3OEJBUWRBUk1JZ3BkbVJjL1gvZGFYemhsM1RhZjNXQmdSNTVMeWkKT2hlaEFXYUhoKy9OSzJs
MGN5NXRhWEp2YldGQWNISnZkRzl1TG0xbElEeHBkSE11YldseWIyMWhRSEJ5CmIzUnZiaTV0WlQ3
Q2pBUVFGZ29BUGdXQ1poVTZxUVFMQ1FjSUNaQmVLdkQ1VksrWWZnTVZDQW9FRmdBQwpBUUlaQVFL
YkF3SWVBUlloQkVNNk1wbFpsQVptTDhKT2dWNHE4UGxVcjVoK0FBQlhsd0QvY3c0bEQwUXAKbjd1
Q29ldkRmSWM1ZUprUWk4UkV5MW5VaUpRS01zRTRxMnNCQUlFcDVvZnRLSjJPQ1VUSDlvMVRlaEJR
Cm5VRktNcy95NHpaaHU2R3h4RDRBempnRVpoVTZxUklLS3dZQkJBR1hWUUVGQVFFSFFLSW5ya1pI
ZHNraAoyVm5BK3VvQmc4aVlhSzdXUGhOdGJoQlAySVpVNjZrNUF3RUlCOEo0QkJnV0NnQXFCWUpt
RlRxcENaQmUKS3ZENVZLK1lmZ0tiREJZaEJFTTZNcGxabEFabUw4Sk9nVjRxOFBsVXI1aCtBQUFr
OUFFQWxPcVB2WUloCmNRdE1pRnFpNzh0RXNsRk51UjRSYVhhTkJUcUhPeHFnNlNZQkFNOTdzRWpI
TUlCNEZoejdCY05XZFFKeQpJVG5JbGxVSUZIS2dVNHRuc0k4TQo9VzRjcAotLS0tLUVORCBQR1Ag
UFVCTElDIEtFWSBCTE9DSy0tLS0tCg==
-----------------------11ce497ff2de482a80672c4b5940b845--

--------6c439f51153e8f6f711a1eb8efceec85169f7355772356eac7d1f74fc0c5eab9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wrsEARYKAG0Fgmjr2x8JEF4q8PlUr5h+RRQAAAAAABwAIHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmdb5h7VWVcdYdsz+HjDYA509WdVZcttwAlfJ7bQ
UvbEvxYhBEM6MplZlAZmL8JOgV4q8PlUr5h+AACWgQEAmouWzM22khjc5JUL
y51ssk+H0QWOZIYoKDBkvl4wvCIA/2anOnFxh5nH2hgKPGTNoy4Ne5Tb+fN2
FPrJ0pMzXCwI
=13qv
-----END PGP SIGNATURE-----


--------6c439f51153e8f6f711a1eb8efceec85169f7355772356eac7d1f74fc0c5eab9--

