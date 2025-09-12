Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5720C41C63
	for <git@vger.kernel.org>; Fri, 12 Sep 2025 21:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757711066; cv=none; b=HG1N3V48oBhZ1eBGpp7guR1h/NuopkRmC2cxFuq9Gqettkq6EE796sWHeFFY67GGRmj3vpJmbzEVM27gMQgoDk4H2DNLX+cYktKvk3mpWsAZVFprYpqRadCk+Zd1v96pJkOE14YwLup7m/8tVDJZ79paTeXku4rO5m1YAT4Or1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757711066; c=relaxed/simple;
	bh=XzU8ZWgutTeRWkGJOCobb55hjrkSa+DnT/SLI0ej44E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HBmnjYMpad8cRCIrT9o8WZJc1Y+waYylIU+9LnJ+Zovo+FWqtfD6itm93QkyGPOEQe7T78W11MLxbZ3GEPDJ6Z/bb6KKryNL0WnY3D9RoPTGMIwg2icI1ywjpReZ6pq06cGg80a56hbP6DVsdVBLiGKGo/Ww1Th472USU8PiMGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=C0bhf4/G; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="C0bhf4/G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1757711056;
	bh=XzU8ZWgutTeRWkGJOCobb55hjrkSa+DnT/SLI0ej44E=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=C0bhf4/GvExVuKqE331MXE86s3r97FT4xasLDJMiTXVHzvGpJ75wJTRuAVfHfR5j6
	 pbbCWIUUie20HU4i2J1s7dGS9OtmufzQXMl4J8gz3EeHSeEBoiA++mQyVyv9XXPqqk
	 3nFNF7I+IPeMhbSiIFnCwgS8Y7wy3jKvzNFWQWB4sbvD5pYeQi7Z3un2Bp0YmJ39lt
	 CvoyvuTeOQ7otvkMu+xwi9H4kAK+im2t9fElWETpSaWilHLjsmJXA2j1X770JftwsO
	 MSqnfpNCuKAf+L6qMxqO8MJcIWXfOZU8BuGYqPWbD7ogWuThcCvlm/nqe4z2u00IGO
	 qpFzUcE6D3+jgSniL+ASIPKar1rdaO3lWa/kBNWfjQQa+iKyQLcytvu84EB8i3tHID
	 8KJ5xDy4vSDePzbXxsA0Fakq4N5h6a45a2IaAFU9eLwWMJmZlB0B5hBf8LPYXcFvaS
	 hHfET7sDRGUU0abLc1s+BKBVwCgpqWsVIvhP6PQhTsV+jSyBcRE
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:15f2:efe9:8d23:8468])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 0853520105;
	Fri, 12 Sep 2025 21:04:16 +0000 (UTC)
Date: Fri, 12 Sep 2025 21:04:14 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Emily Shaffer <nasamuffin@google.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: What kind of help is needed for SHA-256 work in the next ~year?
Message-ID: <aMSKztysdyCKK50X@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Emily Shaffer <nasamuffin@google.com>,
	Git List <git@vger.kernel.org>
References: <CAJoAoZm+yeF7KUbVBqUh0zc58b1jXVPEtWimrUutX_5ifixxgw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RF0GnXKeqgbhAnTm"
Content-Disposition: inline
In-Reply-To: <CAJoAoZm+yeF7KUbVBqUh0zc58b1jXVPEtWimrUutX_5ifixxgw@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--RF0GnXKeqgbhAnTm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-09-12 at 17:59:06, Emily Shaffer wrote:
> brian has been working on the SHA-256 implementation and now on the
> interop, pretty much solo, for quite some time. I realize that it's a
> bit late in the party to ask, but as we're talking about switching the
> default for new repositories in Git 3.0, I think it is past time for
> the rest of the project to pitch in if we can.

I do very much appreciate you asking this.

> What kind of help would be useful to you at this point, brian? How
> much of the work is planned and ready for you to delegate to someone
> else (and what's the timeline like, if you have one)? Do you need help
> with testing any parts of the existing code in scaled scenarios? My
> understanding is that you have a roadmap to guide your own work, but
> if it's not shareable, is that something you could use some program
> management help with? Anything like that?

I have about 93 patches in my `sha256-interop` branch right now, which
is based off v4 of Patrick's Rust series.  Much of the functionality
works: the legacy loose object maps (which I'm replacing with the new
binary format), pack index v3, full clones and pushes, and some shallow
functionality.

A lot of what I need help with is getting these patches production ready
and sent to the list.  (Some of them are clearly marked as WIP with a
comment why.)  For instance, pack index v3 works just fine, but we need
more tests for it.  I haven't done any sort of scale testing yet,
either, so if that's something we want, then help with that would be
great.

Similarly, even when the binary loose object maps work, we'll still need
to prune old objects from them and compact the maps as part of `git gc`,
which would be something I'd appreciate help with.

I do have permission to work on this as part of my job (starting in
about October), but we want to release in a year and I'm expecting at
least 200 (if not 300 or more) total patches for this project.  What I
don't want to do is try to shovel several 50-patch series in at the last
minute, which would be unkind to reviewers and not produce the best
quality code, so trying to get the existing patches cleaned up and in
relatively soon would help us make more progress at a more leisurely
pace.  I also still do have other duties at work as well (after all, my
team is responsible for serving your Git traffic, which I think we'd all
like to continue), so assistance would be super helpful.

There are also a giant heap of broken tests when run in compatibility
mode.  Some of those tests are broken because, say, we lack support for
partial clone, and we'll fix those by implementing partial clone. But
there are lots of tests that are broken for boring reasons, such as the
fact that in compatibility mode we can't accept broken objects (because
they can't be mapped into the other algorithm), and those need to be
marked or fixed accordingly.  Getting those marked or fixed would be a
super helpful contribution (I even have a test prerequisite for this
purpose), as would fixing other routine test failures.

I have some tests for fetching and pushing in interoperability mode
which will run even when the entire testsuite is run in single-hash
mode, but I think we're also going to want more tests: HTTP, the Git
protocol, protocols v0 and v2, single-hash servers and dual-hash clients
and the reverse, unsupported cases[0], and so on.  That would also be very
helpful since it will help us make sure our changes are very robust.

We'll also need to implement partial clone and submodule support.
Submodules are especially tricky because to look up the object mapping,
we also need the submodule to be in interoperability mode.  And, because
people are absolutely going to want this kind of thing, we ideally need
some script or command to convert repositories from a single-hash (say,
SHA-1) to dual-hash (interoperability) mode taking into account
submodules (which must be done _before_ the main repo) and all the other
edge cases, whether that's in place[1] or to a separate (bare or non-bare)
repository[2].  Someone picking that work up would be greatly appreciated.

And there's still more beyond that as well.  Some of this I can pick up,
but assistance would of course be appreciated.

I'm going to spend the next week kind of tying up some loose ends in my
current work and getting things in my branch in a state where someone
could pick some of this work up.  I'll also write up a complete list of
what still needs to be done in case folks would like to help out and
send it to the list in reply to this thread.

As for project management, I would be fine with simply using
GitHub/GitLab/Forgejo issues/projects in an otherwise empty repository
for tracking who's working on what if that's acceptable to others.  I do
feel some sort of tracking like this would be useful if we have multiple
contributors, since it will help avoid accidentally working on the same
thing as someone else, but I'm not super picky as to what it is.

> I can't guarantee that Google will be able to jump on and help right
> away, but at least understanding what needs doing is a good start for
> me to be able to ask around - especially if we're looking ahead to
> 2026, that gives me more room to try and get help. I thought to ask on
> the list instead of mailing brian directly because I assume that's the
> case for the other corporate contributors to the project, too ;)

I appreciate the offer.  I think with our desired timeframe, there's
definitely enough work for two or three, and possibly more, people.  I
would be very grateful for any assistance that can be provided here.

[0] For instance, we cannot do a shallow or partial clone to a dual-hash
client unless the server supports mapping using both algorithms, since
those types of clone have incomplete history and therefore the client
cannot perform all of the conversion themselves.  We will want to
provide a nice error message to the user and some documentation for this
case.
[1] In place is ideal, since that could also be useful for forges who
want to do this conversion, but any command is better than no command.
[2] I think a shell command would be fine for this, although Dscho and
the other Windows folks may not love the performance.  This might also
be an exciting opportunity to write some Rust if the authors prefer that
approach.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--RF0GnXKeqgbhAnTm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaMSKzgAKCRB8DEliiIei
gWxZAQD/hgL9KhlKzSmuwBGnaoTee95LNV72sOaxb8XYg3PnyQEAtbz4AlodfalA
KsOXYjp6J0pMykJlYlMANE11yZSB2AE=
=mk5i
-----END PGP SIGNATURE-----

--RF0GnXKeqgbhAnTm--
