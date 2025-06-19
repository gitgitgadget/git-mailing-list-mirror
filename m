Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8864A25E478
	for <git@vger.kernel.org>; Thu, 19 Jun 2025 22:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750373777; cv=none; b=Q9y/fq1cx4A52tGnsI2Q1valZ+FVjLkdx0ter03xwX2o9wzRjRP26Xq2Eck9y1LAxUhCc/vRjtPgI7G5CEOIN27XE1fuC1R5iJLuv6fU034HWYIx1Si43GxlFlwI0N6FpeJoNyKbITM5vpf+A5c2ouVGihghpD+155SrjxKJlXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750373777; c=relaxed/simple;
	bh=fB3SSL2vKwtyke+OwFRRBGWW8zcmxE+4HLyokEIt8MU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a3cjCjtoGdgGBUsTmCQC+wk3Q3G545AZM3gF3zcP2yydJIZLcqB/9yjRuwYjkMJADtDrBuLFwFsvBByOHuCrtwfCOE7E5mTrrJk7NWUhEwslByLi45KqzE3CeqrIBgWiwpyYBoSWT0HtmCAa8PsThq9nxhBnV/BJWPxQvKOHYrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=xIA7WJ8t; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="xIA7WJ8t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1750373767;
	bh=fB3SSL2vKwtyke+OwFRRBGWW8zcmxE+4HLyokEIt8MU=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=xIA7WJ8tV3ubOCS8jVX6O0VIlwdo7KKnJD8dwBdOYKqe/NIvUxlKXPHj2n4F/ErUK
	 nUF0OYJWsWy6gPMCn39CQMwI9Q0z3tRM/2TY4+BKy2rzE5tiIypzZjA7bbvly/mIRq
	 U2K2xbHpOntyY7Hie2o/CAQ5UkwrlQaqx01NdcMVMg0bVvXbb9Ex6DW8oVDIiTX8X4
	 UxxJQnEjQ9CNw+7TxXdO/USRgWNVV3ZWkTppYnQjfbsMVcl5xLAsmFppML+oSZ3jfW
	 HibfWx5H9gMwkZ7e5RtDJNcc7hmm1MMgJHQg/Yz7XOiQoJ0DkHtJ+ZkriWEr4dORtU
	 lRqHBC6gpZpKRvgoiG/2nSlDYACZaain3yedoFOvEw9b7DUgE/mvIoph8xPJy7BD7+
	 CH/xJ9rmbxbSX/a5U9J4k3jF4vsUI7UqIIlRK7oydru6SgPYVQt9tZ2rNqCP7MxNud
	 xbPww/TBjCw28tsD/0kafrtQGXVaThl7qo4tL1Zy8IM2snwe5Dg
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:f445:674a:9eb4:f272])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id DF8D620069;
	Thu, 19 Jun 2025 22:56:07 +0000 (UTC)
Date: Thu, 19 Jun 2025 22:56:06 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Collin Funk <collin.funk1@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: .clang-format: how useful, how often used, and how well
 maintained?
Message-ID: <aFSVhpnNnj6p3r7n@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Collin Funk <collin.funk1@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
References: <xmqqmsa3adpw.fsf@gitster.g>
 <aFR-Yf0PMj30ex2O@fruit.crustytoothpaste.net>
 <87msa3quzs.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pPRADS+4MutTNH41"
Content-Disposition: inline
In-Reply-To: <87msa3quzs.fsf@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--pPRADS+4MutTNH41
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-06-19 at 21:31:03, Collin Funk wrote:
> From what I remember, clang-format is not at all stable between
> releases. Newer versions will produce different output than old
> ones (usually better, but that does not matter).
>=20
> For the reasons that you already mention, it ends up being a chore, in
> my opinion. I don't think we should expect everyone to build/install a
> clang-format version that is newer or older than what their distro ships
> with, just to align the output with the project.

Yeah, then in that case, we probably want to ship some sort of container
and script that can do that.  Our default Rust target is Debian stable,
so that seems like a decent target if we need to pick a distro.  It's
also a very common distro used in containers, so it's widely available
to contributors using container-based development environments.

I still think that if we're going to have this functionality and expect
it to be used, we need to make it the default, build appropriate
tooling, and check it in CI.  If it's not fire-and-forget, people won't
use it.

> If you wanted to be help avoid badly formatted patches adding a .vimrc
> and .dir-locals.el file would cover most people, I think. For Emacs, the
> .dir-locals.el would be something simple like:
>=20
>     (c-mode . ((c-file-style . "linux")
>                (fill-column . 80)
>                ((indent-tabs-mode . t))))
>=20
> At least with Emacs it is easy to type things that break these rules. So
> one can avoid diffs like this, which clang-format would produce:
>=20
> > -		/* Warn on any additional signatures, as they will be ignored. */
> > +		/* Warn on any additional signatures, as they will be ignored.
> > +		 */
>=20
> I assume this is similar for vim, but I do not use it enough.

Certainly there are a lot of Vim and Emacs users in this project, but
there are also many people who are not.  I use Neovim myself and still
have to deal with wrapping lines at 80 characters.

I also don't think Vim actually honours per-directory configuration like
`.dir-locals.el` by default without turning on the `exrc` option, which
is rightly documented as a security risk.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--pPRADS+4MutTNH41
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.7 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaFSVhQAKCRB8DEliiIei
gTYHAP9h0QmZe/9koIG757bHrc1C2PlF1ti6qm4FiX3EDAvF1wEA+JuQYeMktxRp
iJQsiUWGF3XfRaCXTRKcsr6cmoDmhgU=
=Obog
-----END PGP SIGNATURE-----

--pPRADS+4MutTNH41--
