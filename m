Received: from mail-10696.protonmail.ch (mail-10696.protonmail.ch [79.135.106.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D819B1A0BFA
	for <git@vger.kernel.org>; Sun, 31 Aug 2025 22:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756678873; cv=none; b=toLOL/T/yi/PirsOXb6wHpwDiiBmEDODyWbI3t7QiVl0EtjvLt2Z6nR3npv6zAi4tG2mWBbxl/KauIUUnn6h0c5SR0gcLJTQ3N+r0AsW2ddJ3ROYG0Gq5NRmkQgHCZrG2Te0QcU5ZnnbVs5VFZA5nQSmd6DiAkpfFJQVm+bUujQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756678873; c=relaxed/simple;
	bh=DzBW0jB5YdolYq/FPH6vxktKCMNqKUl/UYubMxnj5XQ=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=C8lKzrBr+jOwls/nX/qaS7FhWIgUsNpnpBYF2eiWIJmEkfFENwbWjmxY5Qr/CF5ZVA33jTKwZDcBw5O9qee+vgqZgupgZJu1QezvkL3A6WOCi0KPPC/iylak/EO15KU/oNcI9wKK2a629cdtMlk2MkuTWnUZKuPBf2p6lDbe864=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=GFGyCQ+Q; arc=none smtp.client-ip=79.135.106.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="GFGyCQ+Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1756678868; x=1756938068;
	bh=DzBW0jB5YdolYq/FPH6vxktKCMNqKUl/UYubMxnj5XQ=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=GFGyCQ+QjOO0LO/B+4DsZoEb1yu3y5guADg7vaqFqj778ZBDDsPctcTASu+9IlV12
	 ZAAwUYxh9FhmJyn9dxgkS5l4+P1pTYn4JM19Rf/Vch2L99Gn40tUkC3rNhwvVc7ZIq
	 uCbC0j0iVRq0fX515ce5tA7G2bQY07WtXdfcLeG3qVBq2xv5cTd/joEHvl/UtDBBRG
	 WMcf4D9DYPcfUFpgljEi/v+5ueWk1r9UmoY2lDxMfGCX1mbirKDnHHGYwbayregAmO
	 hVg1n/NhIAxjpIee1TBXS1eBRQVZIlMYJOjYBaO9khy5yqbDfL7D3NJ0KjGWZrXMPQ
	 pbhWWwV2nue1Q==
Date: Sun, 31 Aug 2025 22:21:05 +0000
To: "git@vger.kernel.org" <git@vger.kernel.org>
From: wafkse@proton.me
Subject: I still use this!
Message-ID: <z0DSzYCJ68tvrJA8fIF-14x3u0CvVyuA7lSRrUJy-78qEySmZEUs8frQxRMPvaar4qfTFdtkv0ZLhVNfkpbVyOle8auxRPLIWGfge9AQT7c=@proton.me>
Feedback-ID: 130273331:user:proton
X-Pm-Message-ID: 98a0fe49f455051571307f23951150e14a38311f
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------63087c10c32b8da7d0d55e58b94d3d7aadd05dd6673147a0c4ad1820f3b45668"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------63087c10c32b8da7d0d55e58b94d3d7aadd05dd6673147a0c4ad1820f3b45668
Content-Type: multipart/mixed;boundary=---------------------c4640309517e79e2edb3fef302bd30e0

-----------------------c4640309517e79e2edb3fef302bd30e0
Content-Type: multipart/alternative;boundary=---------------------589fce62c768e01be0b23027f816102a

-----------------------589fce62c768e01be0b23027f816102a
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

Yes, I still use `git whatchanged`.=C2=A0

In fact, its one of the first or the first git command I run after pulling=
 from a remote.

Please do not make it go! My muscle memory is too used to it to migrate to=
 `git log`...
-----------------------589fce62c768e01be0b23027f816102a
Content-Type: multipart/related;boundary=---------------------ce5e305c9381a6e5b65810ebfd974c91

-----------------------ce5e305c9381a6e5b65810ebfd974c91
Content-Type: text/html;charset=utf-8
Content-Transfer-Encoding: base64

PGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6IEFyaWFsLCBzYW5zLXNlcmlmOyBmb250LXNpemU6IDE0
cHg7IGNvbG9yOiByZ2IoMCwgMCwgMCk7IGJhY2tncm91bmQtY29sb3I6IHJnYigyNTUsIDI1NSwg
MjU1KTsiPlllcywgSSBzdGlsbCB1c2UgYGdpdCB3aGF0Y2hhbmdlZGAuJm5ic3A7PC9kaXY+PGRp
diBzdHlsZT0iZm9udC1mYW1pbHk6IEFyaWFsLCBzYW5zLXNlcmlmOyBmb250LXNpemU6IDE0cHg7
IGNvbG9yOiByZ2IoMCwgMCwgMCk7IGJhY2tncm91bmQtY29sb3I6IHJnYigyNTUsIDI1NSwgMjU1
KTsiPjxicj5JbiBmYWN0LCBpdHMgb25lIG9mIHRoZSBmaXJzdCBvciB0aGUgZmlyc3QgZ2l0IGNv
bW1hbmQgSSBydW4gYWZ0ZXIgcHVsbGluZyBmcm9tIGEgcmVtb3RlLjxicj48YnI+UGxlYXNlIGRv
IG5vdCBtYWtlIGl0IGdvISBNeSBtdXNjbGUgbWVtb3J5IGlzIHRvbyB1c2VkIHRvIGl0IHRvIG1p
Z3JhdGUgdG8gYGdpdCBsb2dgLi4uPGJyPjxicj48L2Rpdj4=
-----------------------ce5e305c9381a6e5b65810ebfd974c91--
-----------------------589fce62c768e01be0b23027f816102a--
-----------------------c4640309517e79e2edb3fef302bd30e0--

--------63087c10c32b8da7d0d55e58b94d3d7aadd05dd6673147a0c4ad1820f3b45668
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wrsEARYKAG0Fgmi0ysMJkLlwcVnrOQO4RRQAAAAAABwAIHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmejcex9NQ1Cy+Yo9SocKS74bgOrHZB6ZxeyezmH
qmsYQRYhBGO52wRpUqjoyUrkELlwcVnrOQO4AABG1AEAvLIQSalgEQ1V3fzU
IF541WLAsZvGfx+Dzv8LXEMFKPoA/idGU18A82cwRBLEFZa3hWc91AKzwQzD
Ez6w2bso89kB
=+yWp
-----END PGP SIGNATURE-----


--------63087c10c32b8da7d0d55e58b94d3d7aadd05dd6673147a0c4ad1820f3b45668--

