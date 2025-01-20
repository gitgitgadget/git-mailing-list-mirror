Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5A414830F
	for <git@vger.kernel.org>; Mon, 20 Jan 2025 22:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737410904; cv=none; b=WzWqBObM61r/jrPtRfK94y146o74vTg3HrSgOpg9ZaKVQ+jmpI4B9IyH7C/vo47PxD18Vc6DuQr6bhsm3rGc7HSE8BmjJF+uIm9nFgfkUvhf4ELQhWYlBObFEx7zcf9AcCdJSj+asqIkG+7MQ+zQQ/curUU4RsRh6GJZZbXDxQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737410904; c=relaxed/simple;
	bh=nB2k5YHeCavjWma0V6LdJyqdPiokBeS+aVK0O+ojC5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vumge9HM+zUhI2c8P+29PW8Sp60BBFILSnvZMSPiVpa2sVBhLcDLuyzaq2qQXLKPE/zBywKRN6tAMCzTLBoyBmgpGuDBaBozkywIb/k09wWsrtPi9hPNVrxgSbtAxGk1zWBuNQT4AdXrA6K2fT5FPwbasXrW9gAaNJ7Xm/zmN9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=V/LJ6QQ5; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="V/LJ6QQ5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1737410899;
	bh=nB2k5YHeCavjWma0V6LdJyqdPiokBeS+aVK0O+ojC5U=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=V/LJ6QQ5NTTI7jaRUqeqiXM9ZHlr7acy//zPHF+ixiripdhyCihdZKymOAun3HQVM
	 2LAM6iY4bPq3tXrZ/EnlAB5BoCQGbIL/+QQ7ZTyocoLwVX6Bv0dsm2xnvL5wxtfPBC
	 KOxVCLlwTYSlWYcI+YhDorClyS8poNUMp+FQBU7efIK5bQBQSzYKjltHcopM8exHTO
	 SNHed5hyv/E9Y3LvEWIRbhQgCZYfCvJPv6URDS1mBdVVrvl77864EBSPXnqfwx8VeH
	 Ys3FVxm1NryciinqGsNfq5Ehb1J2TpPwo3WLDrYM37r2/G9xC8XNXmSwEx/kLrajCF
	 3riCB4jbrl5QQOhrAOjDN756gwZ4Kcd3tANu3uxhikmFJUSKIWv7HEaTnE0ABnRFat
	 G2UGCkvqpi0VR8B/bbgdqn+rRXFfrQaRyfKIckwWGEYdSsrmEXfJSNaCvF2ub4QjWw
	 +FQTQrBNwYp6m2Jhf4ExSE3Mb2H1OBLGzudxdjXXsaoWqznciZW
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 2FD3520033;
	Mon, 20 Jan 2025 22:08:19 +0000 (UTC)
Date: Mon, 20 Jan 2025 22:08:17 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH 4/5] doc: use .adoc extension for AsciiDoc files
Message-ID: <Z47JUbdzMtz1CTMg@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	M Hickford <mirth.hickford@gmail.com>
References: <20250120015603.1980991-1-sandals@crustytoothpaste.net>
 <20250120015603.1980991-5-sandals@crustytoothpaste.net>
 <46cec27d-ee66-4dfb-8271-953b032d0b2f@free.fr>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1PQQTLVWNe1UcQ2b"
Content-Disposition: inline
In-Reply-To: <46cec27d-ee66-4dfb-8271-953b032d0b2f@free.fr>
User-Agent: Mutt/2.2.13 (2024-03-09)


--1PQQTLVWNe1UcQ2b
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-01-20 at 20:37:10, Jean-No=C3=ABl Avila wrote:
> Maybe for users of the end product of the documentations compiled here,
> but there are other users who use the source files and this change
> breaks their workflow pretty bad. I am one of those users for the
> git-scm.com website and the manpage translation projects.

I appreciate that this is a big change, but we do also sometimes make
those and contributors and downstreams need to change over eventually.

> If the purpose of this change is clear, the breakage of backward
> compatibility is an issue. When documentation writers know how to turn
> on the asciidoc mode in their editor, they surely know how to enable it
> on .txt files in this specifically in this directory.
>=20
> For instance in emacs, create a `.dir-locals.el` in the Documentation
> directory with the following line:
>=20
> ((auto-mode-alist . (("\\.txt\\'" .  adoc-mode))))

Vim doesn't offer a secure way to do this.  There's the `.exrc` file,
which is not generally secure because setting `exrc` applies to all
directories and allows arbitrary Vimscript (and thus, arbitrary code
execution), and modelines, which we've already rejected, since they're
editor-specific.

You could, of course, put the configuration in your `.vimrc` with an
autocommand for Git's worktree, but it's pretty gross to have to
special-case one project in your dotfiles, and I don't think that's a
general solution here.

I appreciate that Emacs may provide this functionality, but we also have
to deal with a variety of editors that don't.

> Maybe a smoother transition could be performed by creating links between
> txt and adoc files.

I'd prefer if we didn't do that, but we could.  My concern is that will
actually make the patch even larger, possibly to the point it might not
fit on the list.

We'll also want to eventually drop the symlinks if we add them now,
which means that the breaking changes you mentioned above that you
didn't want to make will need to be made eventually.  Is it that you
want more of a grace period to do that, or that you're opposed to having
to make the change at all?
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--1PQQTLVWNe1UcQ2b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ47JUQAKCRB8DEliiIei
gX/yAQDhaQvBg/I4RRpFii+zP/57Nvc8UVvryo64+Me2g4t4UQD+I9k89m1NNXoc
r10U7YtRY4rK3exu43evANkYP7juYAg=
=I7tm
-----END PGP SIGNATURE-----

--1PQQTLVWNe1UcQ2b--
