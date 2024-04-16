Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0592317C9
	for <git@vger.kernel.org>; Tue, 16 Apr 2024 00:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713228520; cv=none; b=irxjcuDr7H6aRffQD0X3Z5JFUrJMbri0jQnyex/bH29GOA5NUmOLVqmnRCygSCzIDbAS2T4PxoQV3HbaR4EO2Wuew/mJHrLV0/3XOHLYXvIvkdcjm9hRLmcgWBb+eCJkUw0RgYlGSa+xGDK+XIcVngsd2BIRJGa9iIlNcUKfd/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713228520; c=relaxed/simple;
	bh=3DqDWCc733u9n7ukE5f0Za5ti/VxVlqerFY5O615Y0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PwLjoiHEs1+O3PyTp9b6nPcw/vDbcGtxN0Vl3iigWfZVbNXqp4Lnu7d5bCeWVvVKo8eU2EtHZxSQ2u2DjxZZTXyBCCUhjFNdhbgHst0kzfT3CuIYOip3EdoNXBr3wTiM4BGVSS+MtujOvnH9KeEsqZhGCDvSNrzWOA4oyQWXcOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=NkoG58mY; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="NkoG58mY"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 22C585D4DB;
	Tue, 16 Apr 2024 00:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1713228511;
	bh=3DqDWCc733u9n7ukE5f0Za5ti/VxVlqerFY5O615Y0g=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=NkoG58mYVjlCjW9qKJErRw96YivH790+FQm+2FydTtBFNwhb6eyVR6hMHNP0CoO5v
	 dKaWUyePE5I9y2BhE5cVWuk2TMEfPK13SCuPaWeaxKjVSgwvLMCoWZJCeEDqlYvNiO
	 7nbk49lLcVPkX+ffPQODkmqN3hXwkHV+sUJq04ZkNfK/QWsAKgx8hAgxqedfC3NmJv
	 pVBvSOJ2Jq2uTvLe/2yx9AOVV2QJkpNU3eFYLj/4RpoRvp8Si8k2AsQT856WkwE+hE
	 dIbXGSsuZdihgFk5jzR/B4oAthbvEhJV/dAkym/9A3VV60aN1widlpKtVG+wJ1b5pA
	 NM348GXghm1fi+vt25SFxm97iIuZ0vkZmFoClzOHXUitztsyvI9ei1g47apot3PKyc
	 WvIwziGy9rFsVmu2QxfvpCzhEMDGYTwXB7pF+D47cwMwHnEYhReN4anIjCxxJ6Ekmy
	 1n6ADrdaAlmjI9suf9qwTHB+0dLSxGrqXy23rhw0IuKVpzz3ymH
Date: Tue, 16 Apr 2024 00:48:29 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2024, #05; Fri, 12)
Message-ID: <Zh3K3aDxWMPCNlOA@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqfrvqhwlg.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UrIzczazEvJ/Y0JD"
Content-Disposition: inline
In-Reply-To: <xmqqfrvqhwlg.fsf@gitster.g>
User-Agent: Mutt/2.2.12 (2023-09-09)


--UrIzczazEvJ/Y0JD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-04-13 at 01:36:59, Junio C Hamano wrote:
> * bc/credential-scheme-enhancement (2024-03-27) 12 commits
>  . credential: add support for multistage credential rounds
>  . t5563: refactor for multi-stage authentication
>  . docs: set a limit on credential line length
>  . credential: enable state capability
>  . credential: add an argument to keep state
>  . http: add support for authtype and credential
>  . docs: indicate new credential protocol fields
>  . credential: gate new fields on capability
>  . credential: add a field for pre-encoded credentials
>  . http: use new headers for each object request
>  . remote-curl: reset headers on new request
>  . credential: add an authtype field
>=20
>  The credential helper protocol, together with the HTTP layer, have
>  been enhanced to support authentication schemes different from
>  username & password pair, like Bearer and NTLM.
>=20
>  Expecting a reroll.
>  cf. <ZgSQ5o_KyqDaxz1m@tapette.crustytoothpaste.net>
>  source: <20240324011301.1553072-1-sandals@crustytoothpaste.net>

I'm working on a reroll and expect to send it out a little later this
week.  I believe it's currently finished and I'm running the tests with
`git rebase -x` now, so assuming that passes v2 should be out soon.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--UrIzczazEvJ/Y0JD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZh3K3AAKCRB8DEliiIei
gerjAP4qWI8tpENatZ+ra8nflkIyl9PkH+sZipeokFsaSsN+4gEA9jguaAk3y/RC
9CjxXZU4amCmU9Tarf5Lv7KDY7hOdAA=
=87Me
-----END PGP SIGNATURE-----

--UrIzczazEvJ/Y0JD--
