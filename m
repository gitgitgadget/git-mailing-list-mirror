Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C9B1D0B88
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 20:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728676884; cv=none; b=lagmBUXGr4euH6AqTe5+DseKOc/ZRMIMVgq6M+sdAsX9CE6YFYBPFhE6PheNHrJk8tmlA7EXzq4EKqXxun/Ah7/y6hD4MFZf4pprou9uXu4CEskiiyP6K9neJYk4xfpzWb+JP718P11v5zcx5/fG+LTtnPaIVLZ3F2RMI96pT0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728676884; c=relaxed/simple;
	bh=m8xcnEcCCfCmWbX5DKjXr5yMFvBdrM3Sc63aqzJg/f4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hNv0u52iN9dtU7clWZi7I0x0gGmQtI+cghwFo58I5sQrVfIPS5R4CrkbEzG84R65aKzD3hsC0/ckXrCKR1DReY8NyHl1mqVKeckUHsZp21sX19Mgus+4o2fa/oxTmDrJ7x1qASNmhwCkfufj0A0vAPgGaautj+PdxZwYNsTMSv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=FA7V5N3d; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="FA7V5N3d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1728676879;
	bh=m8xcnEcCCfCmWbX5DKjXr5yMFvBdrM3Sc63aqzJg/f4=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=FA7V5N3ditJgHmdBtY+wGhJbdwBdA8kLSiSrEwklGPjMN3Wmu+Q6AdgC8jFqiHUFz
	 fpZ7xvT+S511Qa6nuHrhmKyjcexxFrZ2MGLxQMuJuwGFUEr62t/RUhLZdEHvIhmfsH
	 YHiJNCfEEXtA5ni7p7nmjlmh7kcAf66gPNdLfi7bi8WEKq4tBIc4AEBk97eyCjKByh
	 zUtJtPox1SU1G+rBOePHbLWC6/mpOr6fgWCCQ+g10gjmqiGZRaJ5Q8K1jz3eY+dMgt
	 hs8zJLjfnZAxgV3lQ1y4VeAdnmOi2xUCjl/53EZVUfDrHSpIHSyYXfdF2egP8JX+Tf
	 uwFN/tQbJ000LMs0apADn2K7+SiL8wxhmKq08qWAWqBMViChFZz4VLyItwFRYUo/gY
	 riawr9p9ewR8+Q7zfthzdSkivQYMECITrsvURuhD3cK92lqdUIwzfTXZxnneiSjX4p
	 C2JhFXtGUCd5f9g2cKs00qvvH3I1HsP3DCYTWcuaStZigagqm/v
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id E35492008B;
	Fri, 11 Oct 2024 20:01:19 +0000 (UTC)
Date: Fri, 11 Oct 2024 20:01:18 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Alejandro =?utf-8?Q?R=2E_Sede=C3=B1o?= <asedeno@mit.edu>
Subject: Re: [PATCH 00/13] Update versions of libcurl and Perl
Message-ID: <ZwmEDt7ftJabvMUH@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Alejandro =?utf-8?Q?R=2E_Sede=C3=B1o?= <asedeno@mit.edu>
References: <20241010235621.738239-1-sandals@crustytoothpaste.net>
 <20241011074022.GC18010@coredump.intra.peff.net>
 <CAPig+cRmyZhq1qtomTFP7p7XMqrCP8-u7ah8D2+yUtrL880y7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Z9ANiiz1wSZmXUBo"
Content-Disposition: inline
In-Reply-To: <CAPig+cRmyZhq1qtomTFP7p7XMqrCP8-u7ah8D2+yUtrL880y7g@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--Z9ANiiz1wSZmXUBo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-10-11 at 18:09:14, Eric Sunshine wrote:
> I may be in the minority here, but I'm fairly negative on this entire
> patch series. As you say, supporting these old versions is effectively
> zero-cost, so how does this project benefit from these changes which
> potentially "break" Git for users on older platforms? I see no upside
> here. The cover letter provides no strong justification for
> (potentially) inconveniencing people; the argument about being able to
> utilize more modern Perl features is weak[1] at best and is not
> convincing.

It is not effectively zero cost.  When I want to write a patch, I must
make sure that it works on all the platforms we support, or my patch
will get reverted or not picked up.  That means I have to expend
additional effort when adding features to look through the supported
versions of our dependencies and either conditionally check them or skip
the feature.  Sometimes I have to rewrite that feature in a different
way, or ship a compatibility stub for a system that doesn't support it.

I have actually spent a decent amount of work getting things to work
across older versions of software, both in Git and elsewhere.  The more
we honour the policy we have already made and agreed upon, the less work
Git developers have to do to support adding and maintaining these
features.

I should be clear that I do very much value the portability of Git
across systems and architectures: my first laptop was a PowerPC Mac
running Linux and I've owned UltraSPARC, ARM64, and MIPS hardware.  I
really try to write code that doesn't have weird portability problems
across architectures or OSes, and that's relatively easy to do.  But I'm
not willing to do lots of extra work to reimplement features or
work around ancient systems because people can't upgrade their OS and
dependencies.

> Although brian is (quite rightly) concerned about security (or lack
> thereof with older installations), it is not this project's
> responsibility to "force" people to upgrade their insecure
> installations. And it is not at all uncommon in the "Real World" for
> decade-or-more old installations to be running in production
> environments, and programmers need to work within those environments,
> however, those installations are, for various business reasons (such
> as cost-effectiveness and known stability), unlikely to (ever) be
> upgraded to more modern versions. I, personally, deal with such
> installations on a very regular basis, and in my experience, the only
> time upgrades are undertaken (in production settings) is when the
> systems break completely and there is no choice but to replace them.

It isn't acceptable to run systems that don't have security updates
applied that are connected to the Internet, period.  In this day and
age, it's very easy to have bugs in things like TLS or HTTP libraries
that are written in C and have security-sensitive implications and that
are exploitable remotely.

No matter how stable your systems may be, it's very easy for unpatched
systems to quickly become part of a botnet, which is a problem for
everyone else.  Typically most businesses that sell to other businesses
have to be in compliance with certain security policies, especially if
they have user or corporate data.  My employer simply cannot refuse to
upgrade because we risk major legal problems (e.g., GDPR or PIPEDA
problems) or loss of most of our corporate customers because they won't
or can't (due to regulatory requirements) do business with people who
have lax security.  So I very much doubt that there is, in the general
case, any compelling business reason not to upgrade to a patched OS.

Certainly we cannot force people to upgrade, but we also don't have to
support those people.  Git is an open-source project, and people are
welcome to make changes that they want to it without our approval, as
long as they comply with the license.

I've worked at multiple companies where we had obsolete systems that
needed to be upgraded but hadn't been and have dealt with that pain,
including when it negatively affected us shipping Git.  I still think
that this is the appropriate policy to have.

There's also discussion about adding Rust to Git.  Assuming we do that,
we're going to have to work with Rust's requirements for OSes, which
usually follow major supported distros (for Linux) or upstream's policy
(for the BSDs).  So we're going to have the same problem in that people
are actually going to have to upgrade to a supported OS, except it's
really not going to be optional because the code simply won't compile.
We might as well get used to doing that now.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--Z9ANiiz1wSZmXUBo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZwmEDQAKCRB8DEliiIei
gWgUAP4n9px5eKEj6DW2ZdNsCG0egWs7YSWHKqikLOh4bxRY0QD9FEu5WfGeGzuy
WGuasff3WFGpZnc6XJDEdrjBx1+s3g0=
=38g2
-----END PGP SIGNATURE-----

--Z9ANiiz1wSZmXUBo--
