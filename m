Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981151D63F4
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 23:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729036598; cv=none; b=TKHtQYRNnb4DgNNOVhJvC2BoIk62zUur97jjGdAeiLiZf7nrpVCtGMaHUVjRZzjGcVpKK+T9/PiQzh45C0hE1a2u02EdVUo8Cp3njEhQm6CQbPVMlGvGY8bK3YoLHEJQQ93ZdSKzBw/Vrc6tLntLNg4rRS1lUHSBcpZz5u7rWpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729036598; c=relaxed/simple;
	bh=/ivRUOxrXnfvYyecYhv3C4Is1KhvLZb/N3xM0ufqUww=;
	h=Date:From:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fMaq+cJ7OlY+hOixx9lPwQOnoN0F3xJweGr5tIy/Xt3p3YG965ZIuQ3qqu1uQjIdrarbhzflNB5ZCql571xIJVzQvkfjiOO6JMt8gNtjjpYRGmJW3L2mjDW7WIu6Oi/CdJYn+Ck8BaipGMsORDRTt1OwVVF6XSjbx17tZxuSoWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=wn8GKmUY; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="wn8GKmUY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1729036594;
	bh=/ivRUOxrXnfvYyecYhv3C4Is1KhvLZb/N3xM0ufqUww=;
	h=Date:From:Cc:Subject:References:Content-Type:Content-Disposition:
	 In-Reply-To:From:Reply-To:Subject:Date:To:CC:Resent-Date:
	 Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=wn8GKmUYopmqr5KL5AnV6rHV4g4STu/1dzcCuNpvBAN7jCCYchTnopUpKubxBVI93
	 F+GR0yq6kb2zSC27i/xLbL6KbaQL+RHzPSsYOKzZUb1ztoVzGwa5bcEuS2Iuc+j78Z
	 egtTMU3ouWrruVHx70cojR8AgHA4Mew6z3Jmk0Axe/FUyfXzutNzLm9py8HJFGEBON
	 ySpNolCmglRjHegG/IYHeUqLDGjqhrKl3K0pdajiHrtuLI7WaxH57N98AnDSTOd13M
	 v2GldwaJnEbWQ4O1QTDtz2Mth5YYR1Y6vSpFqPf3VJ1fJDHPcMUrKYEutTnqyGBo7C
	 zG3E0Pd2+CsKgoCiKapHM5yAwuD/4KYj2oZst/WeNCPMrDe4FmdnhNFEamEziwmxPS
	 fDoG5a0UQyeAsB/MC5br9qlw6XGUCI+g7AbinBQnzRM3bsXnEeN3e4gjSH9DG0pIlJ
	 jJQ15c8doliI/KmPUA8oNNRH5FHA0BXwsZZvpZz0/+BONK01Gjb
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 6997F2008B;
	Tue, 15 Oct 2024 23:56:34 +0000 (UTC)
Date: Tue, 15 Oct 2024 23:56:32 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Alejandro =?utf-8?Q?R=2E_Sede=C3=B1o?= <asedeno@mit.edu>
Subject: Re: [PATCH 00/13] Update versions of libcurl and Perlg
Message-ID: <Zw8BMEYHaH2ImMmY@tapette.crustytoothpaste.net>
References: <20241010235621.738239-1-sandals@crustytoothpaste.net>
 <20241011074022.GC18010@coredump.intra.peff.net>
 <CAPig+cRmyZhq1qtomTFP7p7XMqrCP8-u7ah8D2+yUtrL880y7g@mail.gmail.com>
 <ZwmEDt7ftJabvMUH@tapette.crustytoothpaste.net>
 <CAPig+cS0vkTXeZX7qt6oOq3QpkWovfJnXuH7c3JtyAKOfnq1Ww@mail.gmail.com>
 <Zw7AVzBORjvxrvKh@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KmJqkzVH7lzA6SiW"
Content-Disposition: inline
In-Reply-To: <Zw7AVzBORjvxrvKh@nand.local>
User-Agent: Mutt/2.2.13 (2024-03-09)


--KmJqkzVH7lzA6SiW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-10-15 at 19:19:51, Taylor Blau wrote:
> I agree with Eric that we should first and foremost consider the
> user-impact of any changes we make to Git.

> I think in reality there must be a balance between the two. We should
> make reasonable decisions when presented a trade-off between supporting
> users and making the lives of Git developers easier. For instance, if
> there is some change we could make which would involve a manageable
> amount of additional effort, but would somehow benefit the lives of many
> users (e.g., supporting more versions of a dependency, improving
> performance, fixing a widespread bug, etc.), then we should do that
> thing.
>
> On the other hand, if we are bending over backwards as developers to
> support a small portion of the user-base (e.g., by maintaining some
> ancient version of a dependency that is no longer reasonable because we
> can assume that 99.99% of users have a newer version), then we should
> consider our options and investigate. What are the ongoing costs to
> maintain that minimum version? What features are we missing? How many
> users would be affected by dropping support for that version, etc.?

Right now, we have a clearly documented policy about what we support
which was discussed extensively on the list.  This is the project's
policy, not mine.  I agree with it, but I'm not the only person who has
advocated for it or thought it was an acceptable policy.

The policy was going to be even stricter in that we were going to
require people to set up CI in order to be a supported platform.  My
concern with that, which I mentioned at the time, is that less common
architectures don't run in GitHub Actions or most other CI platforms (or
don't run fast enough or correctly enough in emulation to be reasonably
tested), and so we'd essentially be excluding all non-x86 processors,
which I don't believe to be acceptable.  That is a position that I think
is definitely in the interests of users.

However, the fact is that nobody is testing the platforms I'm proposing
to drop support for.  Nobody has even bothered to set up a single CI job
for any variant of those platforms at all or to request that one be set
up, nor stepped up to be a maintainer.  I should point out that setting
up tests in a VM in GitHub Actions is very easy and I linked to an
example I use in other projects in the thread where we adopted this
policy.

Nobody, outside of the FreeBSD maintainer, has even bothered to set up
CI for a platform other than the three major ones.  The patches to fix
SunOS 5.10 also don't include any tests or CI.  I don't think it's
reasonable for us to go out of our way to support these systems if
nobody using those platforms has bothered to provide even the most
rudimentary check that they work.  How can we expect developers who
don't use these systems to even know if they work without some basic
tests, even if it's for only one architecture, especially given that in
many cases it involves adding just three lines to the workflow file?

I think the answer is that we can't.  Since we don't have anyone who has
demonstrated that there's basic interest in helping the contributors
support their platform by setting up tests or volunteering to be the
maintainer, we can't support those platforms specifically and we're
essentially left with just honouring the policy that we've set, which is
what I'm doing here.

> I am not entirely sure whether the jump that brian is proposing is
> reasonable or not. The current minimum version of Perl, for example, is
> from 2003, but the proposed new minimum is from 2017. While the new
> version is certainly not new, I am not sure how many users would be
> affected by dragging the minimum version forward by some 14 years.

I don't think we can actually know in the general case.  It will exclude
people on obsolete systems, but it should not exclude anyone with an OS
shipped in the past 5 years.  The only major OS distributions that I see
supporting more than a 5-year regular LTS life span are RHEL and SLES,
and I've considered them here.  Again, I don't think asking people to
upgrade an OS every five years is in any way unreasonable, and I have
even considered people farther back.

It's also reasonably easy to build new versions of Perl with things like
perlbrew or other toolchain tools, and those are the common suggestion
that people use when they have a toolchain that's out of date.  I've
worked at a company which did some very unusual things with Perl
(specifically compiling it to C for performance) and who I think had at
one point used the oldest Perl I'm aware of being used at a Perl shop
(at the time, 5.6) for major development, and I know they're now using a
modern Perl and wouldn't be affected.  In fact, people doing Perl
development professionally are overwhelmingly using very modern Perl, so
the practical implication is that we only need to consider the distro
Perl here, since everyone will be using something at least that new (or
will have an easy way to build such a version).

I will point out that I specifically dropped it down from Perl 5.30 to
5.26 in the interests of SLES, even though I don't believe they're a
major Linux distro anymore.  I felt that given the fact that it was easy
to support SLES, it would be better to do so, even if it sees relatively
little use.  I'm not aware of any other reasonably common distro
supporting an older Perl.

> I do not think it is our responsibility to force people to upgrade their
> systems. But OTOH we should not bend over backwards here either to
> support ancient versions of dependencies when there are compelling
> reasons *not* to use those versions.

As I said, nobody is supporting these systems.  We, as contributors,
cannot get a suitable (secure and functional, available at no charge)
system to test on.  Nobody has stepped up to volunteer to do this work
and maintain these systems for the project.  Our own policy, which we've
discussed and agreed upon, is not to support them.

Absent somebody volunteering to do the work here, I'm proposing to drop
support for them.  I'm willing to do the work to adequately support
Debian on all its architectures (to the best of my ability), and I'm
willing to take into consideration other major platforms for which we
have CI or for which I can reasonably be expected to test.  I'm not
willing to consider other systems where nobody has volunteered to step
up and be responsible.

If other people in this thread are volunteering to be maintainers for
these systems and add suitable CI jobs so that we can find problems
before they land in `master`, I'll happily adjust my series accordingly.
Please also propose a patch for the platform support policy which
clearly states what our new policy should be so it can be discussed.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--KmJqkzVH7lzA6SiW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZw8BMAAKCRB8DEliiIei
gUoDAQC+Wc9EP2PE2LbrCJdjyFqWF5CXVYEi2fLX/uWH+HkdqwEArfJp0e3seQMj
RwtBEKywP8zzMitJ7e9VGkCS9u8YGQs=
=J5Lh
-----END PGP SIGNATURE-----

--KmJqkzVH7lzA6SiW--
