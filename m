Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D561E48A
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 17:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732554448; cv=none; b=W1aPeRO7uUgebaEtSszkCZJ+3WtKFV657HdaHWmtT0bZ8lLM6zGT/TVAnDCtUg8hobS+GtJmUQRfKzoNrFUuc2pc4jhe2VL8A71SNdeO7ZdfGXLpcpWuPg7CEHKI9PGQhK4H0KRivoWhd4VvK6O1VsPl3S9HjP/wQsi4vNlKLSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732554448; c=relaxed/simple;
	bh=HpYv3HkJXDF88MVFWOIVDOwsaXyZyArBe+Xc0fS9UiQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i86I74/TfPbkrGXVsHkp2Et8tcW3bXm3wAUwMKCInNmrpuWevKjsskN/f7oQvsTKm4A+iyoRj7WGF5hmNLFXQHVZj26gQEI5no85nk6ChpdDA5alvtN0jP3/+PSHKwWZV200rFQlpfXyGC4+5vt5KiV5n0/B616+dD76qMElTkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=cbJteShe; arc=none smtp.client-ip=185.70.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="cbJteShe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1732554438; x=1732813638;
	bh=HpYv3HkJXDF88MVFWOIVDOwsaXyZyArBe+Xc0fS9UiQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=cbJteSheDDWc4xIKdNvx5h04wjB3csV5P7mePNzF0mZ/+VG7AbiyLliPur+f6M2xa
	 seLvQO37089ve+4MWb56mv879oBNlLRmPP44rbbFlZJsGGeao8gXioPl7zTy7PfplA
	 WN9XSoYM4ZgcwR09w6bsK9ou6317kUICh7U+m6hFLDgAlCV+V3jyKdTbNtHD6/Rvbz
	 xmo5ttAtwuie70zlysh4Cjkvnc6jnN9aGKjHD/hCes1EllrGx2dHO84IEFwT2VbWIM
	 YEHpJlbqBzI1wuATRVtP01YjWW7DVbNOqB0wfgzILMOfhJh5dL9KSfoJTan5lmhK4A
	 tQReTYFpn3S9w==
Date: Mon, 25 Nov 2024 17:07:16 +0000
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
From: A bughunter <A_bughunter@proton.me>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [ANNOUNCE] Git for Windows 2.47.1
Message-ID: <se27x28T4xaSsSUxxGXWDjHliPEIctxMINzJzIKIxFwcUGCyAc2a3koOWnPN5RGAmuJB54cdbPReu80JNrMJDIQUGNQJjR0n6iiAgwSAPXE=@proton.me>
In-Reply-To: <e713d3c1-c1cf-abe5-ca24-d63a5e78d6a9@gmx.de>
References: <20241125150158.3347-1-johannes.schindelin@gmx.de> <e713d3c1-c1cf-abe5-ca24-d63a5e78d6a9@gmx.de>
Feedback-ID: 120910843:user:proton
X-Pm-Message-ID: 1728e4ee1eea4aa1d80c02ea9be6b8c03ec07068
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1=_DVaXlwkqzS8HRXOy2d456nwbw7uavxIUs6mNUo4Rw"

--b1=_DVaXlwkqzS8HRXOy2d456nwbw7uavxIUs6mNUo4Rw
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512





My reply is interleaved.

from A_bughunter@proton.me

Sent with Proton Mail secure email.

On Monday, November 25th, 2024 at 09:37, Johannes Schindelin <Johannes.Schi=
ndelin@gmx.de> wrote:

> Another Git for Windows announcement that was rejected as spam by the Git
> mailing list.

Why was this rejected as spam? It looks like a simple release notice.

> > Ciao,
> > Johannes
-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYKACcFgmdErsEJkKkWZTlQrvKZFiEEZlQIBcAycZ2lO9z2qRZlOVCu
8pkAAEmJAQCrwJTn7NRZ4u0DgyTH6ta37e1IVDYJTNSjXWfpRb88RQEAr0Ef
ob//X4eweKCH9UPvS7qYBxfRHovj00pn6BtRQQg=3D
=3DgX71
-----END PGP SIGNATURE-----

--b1=_DVaXlwkqzS8HRXOy2d456nwbw7uavxIUs6mNUo4Rw
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

--b1=_DVaXlwkqzS8HRXOy2d456nwbw7uavxIUs6mNUo4Rw
Content-Type: application/pgp-signature; name="publickey - A_bughunter@proton.me - 0x66540805.asc.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - A_bughunter@proton.me - 0x66540805.asc.sig"

wnUEABYKACcFgmdErsEJkKkWZTlQrvKZFiEEZlQIBcAycZ2lO9z2qRZlOVCu8pkAANcxAQD+/RY8
pZL1hRJbT0pI6VLVP/BCDuaZTRSLPar/CXge5QD/VqnsiC+B3MyXCAMtDK/UrDJ3/wyD2yPnDCcV
QHZXJgg=

--b1=_DVaXlwkqzS8HRXOy2d456nwbw7uavxIUs6mNUo4Rw--

