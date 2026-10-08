Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183ED35E948
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 16:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791476158; cv=none; b=ctUaDl8mUAnKE5BVXpjikun1cLZFAH9y4JbDsqjjUx4mrTIy9PH9+CHV035RGuIAImmvB4xXPaejKeICGTvX5nLru3rMi5FYUaneucbUYPFPIoBvEdTUiijQBnCpW7tOHTNuiUfy6j12fkqzv3MmgHttQE5QDH0+NQEpjKbWvFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791476158; c=relaxed/simple;
	bh=bmQOSd8vR+LC8FVEL0PwOICMi2iPhAWKAzpjycu1y40=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYidnhVYFd5qBtKNnp6bd1hJIPaHVD33cwAZLmho7ZuI7sIqHyC4NItKt60iVghEU131riI03Fh7UEx7UADZb4RIDBnHgKxr7r3G7UAwFUwwLaV0vFi2DV4Xt0FXsvleylcn7iu5EvLY2Nbu8D19sVCVqJN9i+Bu+LqMelpHf08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=SmfCe0+v; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="SmfCe0+v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1791476149;
	bh=bmQOSd8vR+LC8FVEL0PwOICMi2iPhAWKAzpjycu1y40=;
	h=Date:From:To:Subject:References:Content-Type:Content-Disposition:
	 In-Reply-To:From:Reply-To:Subject:Date:To:CC:Resent-Date:
	 Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=SmfCe0+vtNV8dd1aPr/9OTIg6BIaNtH98GcoKllcbNkfdVE30x0ALjpSZ33qamisV
	 Rxv0Byiw5ZP0P0qTLLppy+L8TcIOYO1hONhsnnBJ1K4bpYwgEiiaBwUZTOvV00K2cH
	 oLHUCYO/Xd0KXH2jn0RwWWjtx/HdURwNBRluVVolNXXAHn3ckIeLkDiOklSFLY3h0r
	 yHlbEyoIuOg9B92RGCxIyuGWRRJondCNfc+j0GqP++HZ4/rBDs4r03nPVrK2cFnW/F
	 hGfvGyunQubv9q2Paw51EZDXZJZGeMdyp9AyPt9nHBnbK0pmHMh3v4NAI3nHBLeveI
	 IjeCI2gjhg23/dP00gfRDJRJydMZbFMmc3SEe5VmdrrHPxFP6faVqZwRnelVCKxgan
	 7JKkcjHq/oFTrSsspV69tMx2a3RbOzNW5R4p5hKtBJLrc4Th/cgQWzLfV3mIyqmCAu
	 o1hi83gFKb7KVDWKIaB1qTb+FXSc33H9M6P74YpmdsDKAL5ysB0
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:66aa:1c10:d66e:dab7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 4F993200FF;
	Thu,  8 Oct 2026 16:15:49 +0000 (UTC)
Date: Thu, 8 Oct 2026 16:15:47 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Scott Chacon <schacon@gmail.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] SubmittingPatches: allow responsible AI
 assistance
Message-ID: <asfBs6CdPwcuZ9Bn@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Scott Chacon <schacon@gmail.com>, git@vger.kernel.org
References: <20261007142954.31761-1-scott@gitbutler.net>
 <20261007142954.31761-2-scott@gitbutler.net>
 <asa8ymCv4hoRJcZM@fruit.crustytoothpaste.net>
 <CAP2yMa+kgphMe-cpcZSvPSqwm-npUDVp=HaNRW+MPmPzZ_aOXw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t3DtcHK28R7lDe6k"
Content-Disposition: inline
In-Reply-To: <CAP2yMa+kgphMe-cpcZSvPSqwm-npUDVp=HaNRW+MPmPzZ_aOXw@mail.gmail.com>
User-Agent: Mutt/2.4.1 (2026-07-04)

--t3DtcHK28R7lDe6k
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-10-08 at 04:49:27, Scott Chacon wrote:
> Again, a lot of my argumentation here was directly taken from the
> SFC's recommendations [1], which Git is a member project of.
>=20
> https://sfconservancy.org/llm-gen-ai/llm-backed-generative-ai-recommendat=
ions.html

I'm in agreement with most of those policies.  I'm just not in agreement
that we should accept LLM-generated contributions and that document
doesn't say we should.

What it does say is that we shouldn't shun people who submit
LLM-generated contributions even if that violates our policies, and I
think we've respected that.  Every time this comes up=E2=80=94and it comes =
up
more often than it should, given that we have a documented policy and
that people should know to look for one=E2=80=94we've handled this gracious=
ly.
As far as I know, nobody has been blocked or excluded for having sent an
LLM-generated patch to Git and we usually explain the policy in a calm,
rational way.

Section 8 says we should avoid jumping to legal conclusions.  I agree; I
have said consistently on the list that one of the reasons we should
reject LLM-generated contributions is because the legal status is
unclear.  I have strong views that LLMs are unethical because of the way
they've been trained and the lack of credit, among other reasons, but I
have been very clear that the legality is uncertain.

The final thing that it says that kind of supports your argument is =C2=A71=
1.
However, it's not the case that accepting LLM-generated contributions
would massively accelerate improvements to our codebase.  Git has a
reputation for high quality and we perform thorough reviews.  Those are
already a bottleneck for us even with only human-generated code and
welcoming LLM-generated code and documentation would submerge us under a
deluge of patches.  As we discussed at the Contributor's Summit, we're
already underwater on the security list due to the flood of LLM-assisted
bug reports, a number of which are of dubious quality, and we shouldn't
replicate that on the public list as well.

One thing that supports my argument is that we should support people who
"outright reject LLM-gen-AI systems."  Because of the way this list
works, if we accept LLM-generated code, contributors who don't want to
work with that content are going to receive unwanted patches that are
CC'd to them and then have to deal with those, whereas in a project like
Rust, one can simply block the LLM bots and then never have to deal with
that content at all.  So I don't think we can honour that term while we
allow LLM-generated content unless we change our development approach.

I would also say that we are not obligated to follow SFC's guidance at
all.  SFC also recommends that we leave GitHub[0], which obviously
neither of us are following, nor are most of our contributors, and many
people would disagree.  Regardless of their guidance, our project can
set our own policies and structure as we see fit.  QEMU is also an SFC
project and has adopted a policy very similar to ours[1], so there is
clearly precedent here.

[0] https://sfconservancy.org/GiveUpGitHub/
[1] https://gitlab.com/qemu-project/qemu/-/blob/master/docs/devel/code-prov=
enance.rst?ref_type=3Dheads
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--t3DtcHK28R7lDe6k
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmrHwbMJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ+HD0SVNARN3z+anZ+nZ4tl6J/rqymtv/MbzVNKdVkDr
FiEECCzmip28ZfuD0cORfAxJYoiHooEAALZYAP0U7mIYi0z48uDtzQQmkLQJOCem
6SZySdnnCVs5elYF6AEA82cjViSab1kajr/Nu1R3oSdtoSpu4OqwJY4X9eXUcAI=
=f3lk
-----END PGP SIGNATURE-----

--t3DtcHK28R7lDe6k--
