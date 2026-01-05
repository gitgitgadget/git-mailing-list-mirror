Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAE3279DB4
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 22:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767653025; cv=none; b=qQ9+b6A/B0ZdncQ6KjeR7mfvGzn2oo1eCQjL2MzOScxxWBwOeKC8WWfN2w1aUIdvc1VuTUSJNnntz8qoK/fn9rUXWt6HFiwhJAwitatO3pegLnNHl046dkNDpaa7+xQxxgnV299usb6hybEnwzssMFHus0aGOuZEuuXuI11uKDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767653025; c=relaxed/simple;
	bh=er/+x+UkPyYAW3vAwIj7RuxUs01LAKQudjj+kFj7aAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o8Yu5oyBZhC1lDiCvicOhzYF4LibWkHIubR9jXt0oNEVcO8jekAZseBh+Yf1H2NiWwD0o3XM4fyu+XKhSFjLXqwryegHC1z/1h+GqsgbSsvzbwlkZ3GU/rHtbazyMDWzskZ8ipO3/zkAPj8gkvXwola5tGzuM180wqlo7ucQUvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=HuC4PJT1; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="HuC4PJT1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1767653016;
	bh=er/+x+UkPyYAW3vAwIj7RuxUs01LAKQudjj+kFj7aAo=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=HuC4PJT1yh0jynwm4ASNxGJXl913aX+33ce1KC2+V4grRtU7NrXAadnIIBQTEO+YP
	 tg0nYPxsKHAGeYbutxpGSF6N/4e7iPd5EOV2IRZE1TG50J7IqC0Y20XrIlBAasXENo
	 l74oQ18TrKfsMjOInr3LlwYoJGPHC/h05YSlBNGujy3FE01qJkyxBft5Zw1xPi9YwC
	 C8Y9gtuzRXSwVYj+yj9+GtX3eksF2XpT/LgPpcxI6e2pQHynhUgtj6pHqHPEj9cCaC
	 ttG1VykM/x8hwkfto3qQEbpr7ZhAD5N0i4R/AF+53oSVniSd4gguKOcjgfBOSVtOw8
	 mpPLigYrGFeXwV93EewxzyrB0nTHE6/QgNXSRyt3sKDGOB6IymBPYJgFt1iFqWmx/o
	 atK7aFxmd/LYGoeJo4qP/4h4MvOja6EOFaBezZBF2UODOCYryXeM8y2gDqZl77u8kk
	 rFBHVcxx4hRxil4/4rvAxEo+bdN2AWuXYASjp8EcMcmpP6+JYoa
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:13f6:f352:da06:5630])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 4F50F200B3;
	Mon,  5 Jan 2026 22:43:36 +0000 (UTC)
Date: Mon, 5 Jan 2026 22:43:35 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Son Luong Ngoc <sluongng@gmail.com>
Cc: git <git@vger.kernel.org>
Subject: Re: contrib/bazel interest check
Message-ID: <aVw-l-vi4PegDhY3@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Son Luong Ngoc <sluongng@gmail.com>, git <git@vger.kernel.org>
References: <CAL3xRKfeij_3OUzVPv6Mr4bXjwkB_m7DZt6cbisL-VD473QLpQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JxaKb1cbkye1zjjQ"
Content-Disposition: inline
In-Reply-To: <CAL3xRKfeij_3OUzVPv6Mr4bXjwkB_m7DZt6cbisL-VD473QLpQ@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--JxaKb1cbkye1zjjQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-01-05 at 15:34:45, Son Luong Ngoc wrote:
>   Hi folks,
>=20
>   For my personal use case, I have bootstrapped building libgit and git
>   using Bazel, an open-sourced build tool by Google (1).  Currently, the
>   code is squashed into a giant commit (2) in my repo at
>   github.com/sluongng/git in the branch sluongng/next-bazel.  The commit
>   is based on the 'next' branch from upstream.
>=20
>   Similar to Meson, Bazel requires fine-grained BUILD files to be
>   sprinkled throughout the repo.  So it's fairly invasive to try to get
>   this merged.
>=20
>   I also won't have the capacity to maintain this setup for every new
>   upstream topic that comes up.  Though I am willing to spend the effort
>   to maintain it for major releases.
>=20
>   I want to send this as an interest check to see if there are folks who
>   are willing to co-maintain this with me in-tree style inside git.git.
>   Otherwise, I plan to send this to the Bazel Central Registry (3), the
>   public package registry for the Bazel ecosystem, in overlay mode.  The
>   overlay shall be applied on top of the checkout copy before Bazel
>   starts the build.

We already have two officially supported build systems (Make and Meson),
plus CMake in contrib.  I don't think adding a fourth build system would
be a good idea, especially since it's already burdensome enough to deal
with the main two.

I'd also like to encourage you not to send this as-is to the Bazel
Central Registry, since it hard-codes various values that are intended
to be configurable, such as `SHELL_PATH`[0], `PERL_PATH`, and
`PYTHON_PATH`.  It also hard-codes a variety of define values which are
not necessarily correct for all systems (for instance, my Debian
unstable system _does_ have `strlcpy`).  Shipping a build system like
this would be a regression in functionality and result in broken
packages on a variety of systems[1].  If you're suggesting to the public
that this is an appropriate way to build Git in general, it would be
nice if it were no less functional and flexible than our existing build
system.

[0] For instance, I set `SHELL_PATH` to test building and running Git
against zsh from time to time.
[1] As an example, this would not work correctly on the version of Git
a previous employer ships because they ship their own version of Perl
and Python that should be used instead of the system one.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--JxaKb1cbkye1zjjQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaVw+lgAKCRB8DEliiIei
gdW+AP4leapUBjwc2PJopwPra4zx4bkF09ZKMYGptpYTJB8V2wEAhcIFkk/jyfsm
y81cuHJR/xu38es+mEw2LDk+YW8rFwA=
=7L5e
-----END PGP SIGNATURE-----

--JxaKb1cbkye1zjjQ--
