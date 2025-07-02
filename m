Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D102405FD
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 21:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751493366; cv=none; b=OuGFVcxubuvQ6NOaRWKe9a08rdKnj/sIODnZ09fmWhSRW1yqGZEOPT+v7wJAPqmolyIbVCyEKMuFB6Xr6trclPZwrt+qDV3/TKZXu18a7+qNoWZSxk6PmCsiJy/R7mpLMv3hV1TIHbB1aEeoAiftafkpEPA61hLw9Gufh0q/xdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751493366; c=relaxed/simple;
	bh=4kgJslZQwJIzC8jee2WrkdPlHdAv0jgDddde1gSY0gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rwF+s57IPdZV7vR7XtlO9Mzh/VNKbKKIw4lEQsT6yZ1DBWQLBtXkJhF+2g1vU0g/rqO1YVUsuYl/Z/mWdcwwMJW/Qr70m0QpySK0FTTW+gPDrsSm7bdRp5bhkI5MiHO9waqKjUwcMrwjctBRaNpo+Tpq2/yRXK7vARet5elzAFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=W3o/RUgk; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="W3o/RUgk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1751493359;
	bh=4kgJslZQwJIzC8jee2WrkdPlHdAv0jgDddde1gSY0gk=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=W3o/RUgkDQIA43+TzjD71FKhEJ7WpE+uLCwP2Dw2WB6MdtexMXqPnVs/wSwUM9NK4
	 GC0QJSEz3j+b67jVjRbWNpUhR6wejbAUdVPNFMM/C7ofPgQedxUrk59rT2ZBULuqwD
	 5zSaey0xKq0jPbZlrouaK2HH64eLYbGYXqKNDcUR1KQxOgGav2qbOva2LfvBXt8Mkb
	 zeMhVeb98OuMMFhp8ys4Zl4ZI+J4mPA8kuO0u51svrLeyDc3uvtiqRehcZ7QV2sn+w
	 /s89bwKWQbduozKGuNx9RDu/mDoxnoRusDAf0WbVXYmS3bnyS92hweceIWgRmpElwb
	 ylnI+3erseGUd4j+nZFHEXrr5KJGgjiKa/yY+0+Hzan42irk/34ezw5jVg8cQ/AaSj
	 vrQLNp747pcD6+KrDC8bDEsPRVsTPwnSfDj594YMu80CJWSh1/mHXb487g18p4wglL
	 Qp/P6h92vNSfoKhcq1uec0gmTjl25T9gutfsrMvdNTG7EQqfZyk
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:ba1:ff85:fdc6:571a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id B23EA2003B;
	Wed,  2 Jul 2025 21:55:59 +0000 (UTC)
Date: Wed, 2 Jul 2025 21:55:58 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Suraj Bhadrike <surajbh2233@gmail.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Feature Request git snap, Lightweight Commit Workflow for
 Iterative Development
Message-ID: <aGWq7vBSYuuKW69o@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Suraj Bhadrike <surajbh2233@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
References: <CAPGv+4ZT774b-LGMFpyv3cJYUrpWPMpkCGn25AfwD7MHskbV=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aTNo/P8OwGcQ2Ctc"
Content-Disposition: inline
In-Reply-To: <CAPGv+4ZT774b-LGMFpyv3cJYUrpWPMpkCGn25AfwD7MHskbV=g@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--aTNo/P8OwGcQ2Ctc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-07-02 at 18:30:17, Suraj Bhadrike wrote:
> Hi Git contributors,
>=20
> This proposal introduces a new command git snap  designed to support
> highly iterative development workflows nowdays  influenced by AI
> coding assistants.
>=20
> The rise of AI assistants and agentic AI workflows has changed the
> pace and nature of coding. A developer might cycle through dozens of
> variations of a function or component in a short period while
> collaborating with an AI.

I mean, I do this too without an AI.  I frequently want to make changes
until something works, and then snapshot it and modify it to polish it
and make it more presentable.

> This feature would provide a soft commit or snapshot capability,
> allowing developers to save their work state frequently and create a
> new commit every time as a snapshot or checkpoint without a commit
> message and flag where We can provide an option for developers to
> include files at the start of snap Session.

I think a lot of this is achievable with current functionality, just in
a slightly different way.  At the beginning, you could save a set of
pathspecs in a file (equivalent to your `--include` and `--exclude`
options) and create a random ID (also in a file).  You then do `git add`
with your pathspecs and do a `git commit -m "WIP: snap <random ID>"`.

For subsequent commits, you can just do the same `git add` with the
pathspecs and then do a `git commit --squash HEAD` or `git commit
--fixup HEAD`.  When you're done, you can use `git rebase --autofixup`
to squash all the commits down into one.

These are things you can create with an alias pretty easily and I have
similar functionality to make this easy.  Or you can create an external
`git-snap` command that simply does this under the hood.  I don't think
this is functionality we need in core Git because we can already achieve
most of it pretty easily with a few shell aliases.

If you do create this as an external command, then please do not accept
multiple patterns in the `--include` and `--exclude` options; take
multiple options instead.  Git LFS did what you're proposing to do and
it means that files or patterns with a comma in them can't be matched.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--aTNo/P8OwGcQ2Ctc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.7 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaGWq7QAKCRB8DEliiIei
geTxAQDEd3na4Lc6uyhvG+kfkykxKw++lDP4tou2KBCwLacBOQD/WObTmRmH58JQ
RgknALj1voGr39Cv7RSX73soSEO5AgQ=
=9AcJ
-----END PGP SIGNATURE-----

--aTNo/P8OwGcQ2Ctc--
