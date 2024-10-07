Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64E81D1E8A
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 16:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728320374; cv=none; b=k3icQv+Imog2LQgkbfmGjvZgWDX4kn6D1C7EDV3QxPVPlwCpxVYwq72ROZrC0xVhgPfvv06N3DL39R7quAU8ZmeF39s86CbfRwiEBmdlglwBg2U60LdyaY0W7zk88uf8MWKO3Q9jFKht/Z35RBMBHz0csBZ5IW/IkXHZXkdgncU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728320374; c=relaxed/simple;
	bh=nsMMC15hf7oxrG637AhGB4FZ4EzTYErRRdKufX5/la8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nPlpStbUHwLN2esjaucdAvi5WPBZ62xHHBcxQKTybsOlmUUTCkjoXXa4EZxnjSGZnjWLAfl4V8yCd0feuxRrohxMivQtilHsybuv89Oj82PsWPnC1Y/rEya+z3d7wGPpeSK0qYVC6tU66AbEZGePLJ0Cd9ppgdOdHrqihf9KLl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=HbyNTJUg; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="HbyNTJUg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728320365; x=1728579565;
	bh=nsMMC15hf7oxrG637AhGB4FZ4EzTYErRRdKufX5/la8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=HbyNTJUgxW1o8WSiCAy841MWoY3n8AaLz0NKpXWt+dcKcC7b5+ksjfdX1nV1s5m1g
	 5XG3xgrXwUrwYnMzfGqCQxp5llpjBDXIo9xCaWtrSGkJqdo4QAXdn6A862tRvRCLRC
	 N8jr80ztbj1Kkd46X9whV5oPtcq4jx4x8zvN5byjXZ1d5zVWXayq7EntR37UNsq7pS
	 3hJZ+/mljkejaqA02g7smZfO6COq1jZWdMYXQZyV+Ik6AfUdyzRGXR/tMLYb3z97Dw
	 DWxoykOzpNtwvubkUwV0FldiCVK3gZ+LuRRovTchQwk7VkIdPwsyJrBP30f6/SK3Ai
	 UXOrfequ0S63w==
Date: Mon, 07 Oct 2024 16:59:21 +0000
To: shejialuo <shejialuo@gmail.com>
From: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 2/4] worktree: link worktrees with relative paths
Message-ID: <XhMvjO_NVmnkqWATQ8dMn0D7igePOHd7t0zfhKOr8ZTzd90-zslpej19uaEhtjpZi0nT1JalpyViubAEBBc5VRq6YI-AsrTftI180UJWc7c=@pm.me>
In-Reply-To: <ZwNZRX1LHlxawJJc@ArchLinux>
References: <20241006060017.171788-1-cdwhite3@pm.me> <20241006060017.171788-3-cdwhite3@pm.me> <ZwKuptTMf9ECd-kf@ArchLinux> <I3BmSHTyOELt2DzfSaLhRYLouu5iAPZIZGZ2Ne73AygO35CM0mq44INa68t6VD4XV61DgzbrfUW0m8fivd3N9Rejgm-tecXQHXQRs1BP9CQ=@pm.me> <ZwNZRX1LHlxawJJc@ArchLinux>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 2c3c7e1d877cb9bfb86a39cb7ca4a88ed8f92bfe
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------e3f7d810ef9a0816b9825691eb632585b675be96a1f9fbfdcf65aaf0092bcd31"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------e3f7d810ef9a0816b9825691eb632585b675be96a1f9fbfdcf65aaf0092bcd31
Content-Type: multipart/mixed;boundary=---------------------facbdf54bae9041a7cc653d0cf77f53d

-----------------------facbdf54bae9041a7cc653d0cf77f53d
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

On Sunday, October 6th, 2024 at 22:45, shejialuo <shejialuo@gmail.com> wro=
te:
> You don't need to create a new "strbuf" for each of the paths. You could
> just use "strbuf_reset" for only one "struct strbuf".
> =


> struct strbuf file =3D STRBUF_INIT;
> =


> if (...) {
> strbuf_addf(...);
> strbuf_reset(&file);
> strbuf_addf(...);
> =


> }
> =


> strbuf_release(&file);

Ah, this is a better design---I've updated this to use a single strbuf, th=
anks!
-----------------------facbdf54bae9041a7cc653d0cf77f53d--

--------e3f7d810ef9a0816b9825691eb632585b675be96a1f9fbfdcf65aaf0092bcd31
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAnBYJnBBNaCZAy5Kywm9vL4hYhBE+hHqFr3OG0O+P29TLkrLCb
28viAABZ7ggAhSSeuNTZGlvBLWMO2XhwJByPfU7lA51XjShHio4Gx6cYNG+n
fEWDNiPHFSWouUbbyaQWaDh61DjIgdAatU67wTtpAEOnTsPLFM4+Ohn6YQCD
yMqLNfx0mZey/GzXUZTwvz5WHT5P3uZV4c3T4EJeHydHcN8l9UU9toYr/c/j
nsm73J2Tr1LZngUqwvCRav2ZBtiOxhGYRpU0v9FOd8yBsp65/wh6hZ6ruLYq
KB/3PD91LGDjUeMXt6rdpPSOkAYsqbA/QfgwpBovet6UkwSTnpYOcLtXQb/g
xz3lQnP8c5LAGjC5RpUP2MEEDHY8ffrE/G7RKFqhMJa2oPGGRwUU2w==
=lT+7
-----END PGP SIGNATURE-----


--------e3f7d810ef9a0816b9825691eb632585b675be96a1f9fbfdcf65aaf0092bcd31--

