Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCF01F561D
	for <git@vger.kernel.org>; Wed,  5 Mar 2025 22:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741214618; cv=none; b=CmSPqM0Ou03uJI6peQzobaiUtcd3ubDNz3ggOibN/J0V6dVGOMM+mqf0vd6lFs0yJjAbDYh9ZZG/hz4YdUmiS7GJmNwpn1oyZcEdpQChnKXyneH4kxY721q2W64nPN1o2zKLBeiSywRZJQIOqL4tPtr/F3KMCOfCX+re+fgW/fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741214618; c=relaxed/simple;
	bh=LyLIu8gcKqB8O4W77Zww/2EAWvEER3eC1GDx3pete/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HlUW/VEYkkoqxlREXit2YxUSr0+WCY/fWdSreyS/Fntr5nsJHUSeu7SdCgOnyVq/zu7nvP2zFyHlUaBStVCInHzSQSPGi5gnVCyQ8FL6lqG7YUhS9w5eGMmyXVodUqj/lsFx3QWE7XAHfVkE49XhhT31x9typ7PvlhBDoqS9wqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=yju9Mz9o; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="yju9Mz9o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1741214607;
	bh=LyLIu8gcKqB8O4W77Zww/2EAWvEER3eC1GDx3pete/U=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=yju9Mz9oDN//yIRezsERlUhakIqxa/JEM8l7Q3yBRp8HTRwWSqHsuowwniLj+KKiM
	 BHlqyT5+dbwgRQeHZJlPaddUUAfeXGzF9aNlYN14mZ2GvgF3cp1QoXByrm1ko8q5o7
	 J5VdNUGY6qqjl1VmDCdUMTbrndPIYhePX0693cyxHm+frJrTKyryEnXkMBnNdvRI/H
	 8EcIkFVljE01SQu+F1d+Xm6CEryxqcWHb76GYlTqJiKcoz/cNfIBH1PNXLD3cZbePW
	 iQ7n2f09Yx7GNe5d1VUqpjUCSQhGDx9htGlPj/5IihkXlt7Be1HzbkBP+LpWswDYXi
	 mVIAtFi+jduHWps5CaQixgNpXSuLd8t4uhGFKOtZ6t5m30W5Zr6uoCgZybnFoIQnSf
	 Fhgv3aBskKpcWLnmMOuj6jJzx14nayK0ySzH67Tcw6rvJhpVQ7Mq+8dUyNO51PEBg8
	 5WTZ6GlwmeW30cbvhcjGl7EI5DVHH1jdtbLBSDfgML4Fb+8gS69
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:9ec0:b846:49f:a41d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id BB751200B3;
	Wed,  5 Mar 2025 22:43:27 +0000 (UTC)
Date: Wed, 5 Mar 2025 22:43:26 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Tech Kenya <techkenya@protonmail.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Suggestion: Enhance git init with Language-Specific Templates
Message-ID: <Z8jTjt1CQ7hp8KSP@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Tech Kenya <techkenya@protonmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
References: <qMn1k_iuZCe353x0BBxdD5z4-17Abk_ZHoPr8nVDLOgLhGf8Nxb3-bsXPH2GiATUsuGLVqAaEESua5G9qBaW0qqxwz-7AbcNyRwSXJzbKMs=@protonmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HfPQWn11EX86UgHL"
Content-Disposition: inline
In-Reply-To: <qMn1k_iuZCe353x0BBxdD5z4-17Abk_ZHoPr8nVDLOgLhGf8Nxb3-bsXPH2GiATUsuGLVqAaEESua5G9qBaW0qqxwz-7AbcNyRwSXJzbKMs=@protonmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--HfPQWn11EX86UgHL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-03-04 at 11:49:14, Tech Kenya wrote:
>=20
>=20
> I would like to propose an enhancement to git init that allows users to s=
pecify a language or framework when initializing a repository, automaticall=
y applying an appropriate .gitignore template.
>=20
> Proposal
>=20
> Introduce a flag to git init that enables users to initialize a repositor=
y with a predefined .gitignore based on the project's language or framework=
=2E For example:
>=20
> git init --golang
> git init --python
> git init --node
>=20
> This would generate a .gitignore file using well-established templates, s=
uch as those from Toptal's Gitignore Generator https://www.toptal.com/devel=
opers/gitignore/ or GitHub's official .gitignore repository.

I think this is an interesting idea, but unfortunately, I think it's
going to be practically difficult to implement.  You've mentioned three
very common languages, but there are a lot of programming languages and
even more compiler environments, and it wouldn't be practical for us to
try to support them all.

For instance, I use Neovim, and the version I'm using ships with 693
different syntax files, which means that there's about 693 different
programming languages supported.  I was recently exposed at work to some
languages that I'd never heard about before and which are not supported
by Neovim, and presumably those users would also want similar
functionality.

That is compounded by the fact that there are a lot of OS- and
environment-specific configuration.  As an example, a C project on macOS
might want to ignore XCode-related files, but for a project that's only
on Linux, that wouldn't be necessary.  Similarly, that C project might
create shared libraries that should be ignored, but those might end up
with any of `.so`, `.sl`, `.dylib`, or `.dll` extensions.

You mentioned some possible sources for this configuration, but we try
not to prioritize specific outside projects.  So just because GitHub is
widely used and some GitHub employees contribute to Git doesn't mean we
give it special precedence or privileges, and we wouldn't want to
prioritize their specific collection (or any other), nor would be want
`git init` to attempt to make a network connection.  We also don't want
to maintain this collection ourselves, since it's very project specific.

What Git _does_ provide is a way to create a template of objects that
should be in the `.git` directory using the `--template` option.  It's
possible to create a template that contains an initial commit with a
`.gitignore` file.  I personally would not recommend this approach,
since it will not work gracefully with alternate ref formats or hash
algorithms, but it is an option for people who want to use it.  This was
in common use for setting up the default branch name before `git init`
added the `-b` option and it's related config, so it is well tested.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--HfPQWn11EX86UgHL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ8jTjgAKCRB8DEliiIei
gSc2AQCOvkZhefCXp7rSooYjy6KiuPmIcbBl9CmB3wsi2+CqewEA75sqN/YlA4uC
Rg8/g1hIXVn+p55Pb+KjBU1eUOD4RwA=
=/jx0
-----END PGP SIGNATURE-----

--HfPQWn11EX86UgHL--
