Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446BD4438B
	for <git@vger.kernel.org>; Mon, 22 Jul 2024 21:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721683855; cv=none; b=Zxm+UnFyS8WEcDo5lBwSu5r5HWupeH1I0ncxO3CAaJ/YgTANhMkjoL/EWDwCJ9ijFRtnQ3O65Ofx7KCqDO804wr4hCRwn9hJlSWouYrIYwZiVyFJ5vQi/Csv1vXnXcFREGSvEcYkInGRi48xEP5s0bZ2BbJPknwj3s/qK7n6NnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721683855; c=relaxed/simple;
	bh=1Dkznp153vLO0H1fLAqwqP+J0xOjqeQZyveGQbDWZh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hz2jjsm1+eV3T8+j/eJslFyTDm5al95Q4oLlcXu5BLKnSfPRnZ+zVVzq6EmxmoNdQNZ/FMxrka0CkyddTzXslwbjVl07v/y3iw/eg4TG1+Tx3f5AQKvmwMkYmy/XFgXlQyIvc5FjN4cxPF62hlCLdBgAA7VOK9aQbY8bkTZ1IVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=zyby0+Xj; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="zyby0+Xj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1721683845;
	bh=1Dkznp153vLO0H1fLAqwqP+J0xOjqeQZyveGQbDWZh4=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=zyby0+XjI0my7B55ChWzB63XdNml8mBs9RMKMq/bZxm2tCFd4iv4DldA8PXVdvqC1
	 BuVX1QJbl2zskGqXuPqtvUI6sNx8JCo05YCzfwPxTzV6hwPb0Z1rZ6ymsPtCT5USXD
	 IPHLUqerUVz0uMk+J66HDZVMtm7axQ8cUGu1Y8fxtdDL7qFb4M0Si1qHgfvi+HCAwv
	 tE1RVa7zRuCWqpI34Tsl9v9mnxKTA2Dk+RlCKvM5TavfWml6WXiQbsInK8UrDbU5HD
	 4LCNddi6geeDMVJSt0SKHSNAH2ao94p6RnB6ysyfLnlGyhhdHETmTQb3KoMtDjFHzX
	 qa3bq/Iuy+4ioFVCTIAHJUCQMkwBY5tT0b6ohCWC0HHYr+TKydj4d4vVoHdUqzlLVB
	 8zOoTfKEPBsch6pTvB3h0gdyP4podD/HGNwq7kus52AaC53ayC1QXdkXQ+cjDlhjlO
	 Z038EV7OdwGoIj/ekRi6VnUrN+VEj/Ot1TOSBc9ESRtIN6OjpVy
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 73323209B3;
	Mon, 22 Jul 2024 21:30:45 +0000 (UTC)
Date: Mon, 22 Jul 2024 21:30:43 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Thaina Yu <thainayu@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [feature request] Is it possible to have git tag can be sorted
 and filtered by semver?
Message-ID: <Zp7Pg7ZOlBZcfJei@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Thaina Yu <thainayu@gmail.com>, git@vger.kernel.org
References: <CADeMgjBeyWkE3mp+-x57NSsyNLQf3cTta+Xm5uyVOQE-rpT6yg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5INLHbCR/K1Iwb60"
Content-Disposition: inline
In-Reply-To: <CADeMgjBeyWkE3mp+-x57NSsyNLQf3cTta+Xm5uyVOQE-rpT6yg@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--5INLHbCR/K1Iwb60
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-07-22 at 16:58:11, Thaina Yu wrote:
> Currently there is `ls-remote` and `tag` that has option to
> --sort=3Dversion:refname which is really useful when we have tag as
> version format and let it sort as numeric version
>=20
> But it could be better if we can also sort and filter the version in
> the range of semver format. So we can use git system as dependency
> management system natively
>=20
> So I would like to propose a new sort option semver:refname
>=20
> `git ls-remote --sort=3Dsemver:refname myRepoUrl refs/tags/v{^0.*.*}`
> where brace {} can be used to define semver versioning ranges for the
> patterns in addition to glob filter

Assuming we add such a feature, how does sorting by SemVer differ from
the current version sorting?  That is, where is the current version
sorting deficient for SemVer?  Also, what do you want to happen when a
tag doesn't meet SemVer requirements (note that the "v" prefix is not
allowed in SemVer, although it's customary in tags)?

As for the special range syntax, I think the typical suggestion is to
filter the output of ls-remote or for-each-ref by piping it to a
suitable program.  Perl or Ruby are common choices here, and both could
easily parse SemVer tags.  For example:

  git for-each-ref --sort=3Dv:refname refs/tags/ |
  ruby -ne 'if %r[\trefs/tags/v(\d+)\.(\d+)\.(\d+)$]; ver =3D Regexp.last_m=
atch[1..3].map(&:to_i); puts $_ if [[2, 6, 3], ver, [2, 15, 2]].sort[1] =3D=
=3D ver; end'

Git is intentionally designed to support this kind of shell scripting.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--5INLHbCR/K1Iwb60
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZp7PggAKCRB8DEliiIei
gdoYAQCqUG1ZwQ/RsNQy3zuJRf26shXEVT+gmwfncNb9W+vMrQEAgqSnetiDuOIy
YieEM54VmYoEcdCR5xqM0/5OUclF+Q0=
=bHk7
-----END PGP SIGNATURE-----

--5INLHbCR/K1Iwb60--
