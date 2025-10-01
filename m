Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF97128643C
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 21:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759354656; cv=none; b=E6o0Hlh4GYqqcnY19OYdGmgLUJp3PYziGBU3GMF8/dMuNBtywm9dsWHNr1c0J2sy9ZxOc1pvBDDdsfXGClazPQeSup+X3bkldrWdCbyx3T8yYonQnC4CJv0XhtgXyO9Z1RHTAlqhIh9GckC2tpbp8EMUcwpO8gAwfqejTvmptqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759354656; c=relaxed/simple;
	bh=/DvSHUZ0Hw6OVGwAWHDyx2JaTUMY9A8eAVIy0KuUdKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dn3Fk9jGgD9GyM+74KR31Gr23HGNPFswrGQbQRBP44Bp7GugKpqVz5NPdWjd/HZG1K4zdHnNXXFzZEa7nhxqnVAXOfV2uuug7qR4CLyFiiQ86Hrod1Kr2Sr6ms7FL7YaydWfQ7BV1XGg1QzvrrqVZ3EN8W/nxEObBQ+KyEo310s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=D0lNtD7F; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="D0lNtD7F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1759354652;
	bh=/DvSHUZ0Hw6OVGwAWHDyx2JaTUMY9A8eAVIy0KuUdKc=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=D0lNtD7F77aGIbpdi43kGayPP9cXT5TylbvkPuNQqRp3d55OGyKF+RugNyFlBFHfA
	 F3tRFYrecZVGaWwjQeZTJsSxB2efxAIbmUwvU50x8D3SapowrA7cF9xofRDOkZFOSp
	 4guGQIXm14yi1aRzlO70ts189VSiiyEjYmnJjMlFtC8/mu1S+eHntsiSmIYMht16CE
	 cXLQHwut6RoPs8yB7csTXhxsrOLJaMurmppdJQdTRkwB3uDXH4P4uTKy4DF1KdbFyO
	 +SnONjvzL/5+TjkmfF/RuwiPm6vn/zesUd4sesSNbIS4E2KtPc/RWHOtKkWLFOU5Cz
	 SA+9lGPtf2WzsLLcmluCSdyPO8uvPncubnyQubfa5hmV2JZdSFPKsR7i39z5T8E9YE
	 jkllFki+475I+Y6sJRFEK2IGLuJf+o5Y0ry1mpZQp1CyYFllvqbk58R9eto2a/g+ks
	 6rmL2qbGo4sg5NcU3o5pj3rTthSkBTvNrta6xXxTQfWPaYtqkAl
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:eb6:3c64:95b3:ebcf])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 8777020113;
	Wed,  1 Oct 2025 21:37:32 +0000 (UTC)
Date: Wed, 1 Oct 2025 21:37:31 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>,
	Rick Sanders <rick@sfconservancy.org>,
	Git at SFC <git@sfconservancy.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2] SubmittingPatches: add section about AI
Message-ID: <aN2fG-nS9fE5-2jD@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
	Rick Sanders <rick@sfconservancy.org>,
	Git at SFC <git@sfconservancy.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
References: <xmqqcyalm0mh.fsf@gitster.g>
 <20251001140310.527097-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="paBm3hYwLF1QrVCi"
Content-Disposition: inline
In-Reply-To: <20251001140310.527097-1-christian.couder@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--paBm3hYwLF1QrVCi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-10-01 at 14:02:50, Christian Couder wrote:
> +[[ai]]
> +=3D=3D=3D Use of Artificial Intelligence (AI)
> +
> +The Developer's Certificate of Origin requires contributors to certify
> +that they know the origin of their contributions to the project and
> +that they have the right to submit it under the project's license.
> +It's not yet clear that this can be legally satisfied when submitting
> +significant amount of content that has been generated by AI tools.

Perhaps we'd like to write this:

  It's not yet clear that this can be legally satisfied when submitting
  significant amount of content that has been generated by AI tools,
  so we cannot accept this content in our project.

If we're going to have a policy, we need to be direct about it and not
let people draw their own conclusions.  Many people don't have English
as a first language and we don't want people trying to language lawyer.

We could say something like this:

  Please do not sign off your work if you=E2=80=99re using an LLM to contri=
bute
  unless you have included copyright and license information for all the
  code used in that LLM.

This allows the possibility that, say, Google trains an LLM entirely on
their own code, such that there is only one copyright holder and they
can license it as they see fit.  I don't think we _need_ to consider
that case if we don't want to allow that (say, for code quality
reasons), but we could if we wanted to.

> +Another issue with AI generated content is that AIs still often
> +hallucinate or just produce bad code, commit messages, documentation
> +or output, even when you point out their mistakes.
> +
> +To avoid these issues, we will reject anything that looks AI
> +generated, that sounds overly formal or bloated, that looks like AI
> +slop, that looks good on the surface but makes no sense, or that
> +senders don=E2=80=99t understand or cannot explain.

I've definitely seen this.  LLMs also typically do not write nice,
logical, bisectable commits, which I personally dislike as a reviewer.

> +We strongly recommend using AI tools carefully and responsibly.

I think this is maybe not definitive enough.  If we don't believe it's
possible to sign-off when code is generated using LLMs, then we should
say definitively, "Contributors may not use AI to write contributions to
Git," or something similarly clear.

Right now, this sounds too ambiguous and it might allow someone to write
substantial code that they think is of good quality using an LLM because
in their view that's careful and responsible, when we don't think that
users can sign off on that and therefore that's not possible.  Telling
people to use tools "carefully and responsibly" is like telling people
to drive "a reasonable and prudent speed" without further qualification
and then being surprised when they go 200 km/hr down the road.

I'd like to see the language be more like our code of conduct in that it
is broad and covers a wide variety of behaviour but also explicitly
states what is and is not acceptable to avoid ambiguity, confusion, or
argument.

> +Contributors would often benefit more from AI by using it to guide and
> +help them step by step towards producing a solution by themselves
> +rather than by asking for a full solution that they would then mostly
> +copy-paste. They can also use AI to help with debugging, or with
> +checking for obvious mistakes, things that can be improved, things
> +that don=E2=80=99t match our style, guidelines or our feedback, before s=
ending
> +it to us.

This kind of use I feel is less objectionable.  I think it might be
acceptable to use an LLM as a guide, a linter, or a first-pass code
review.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--paBm3hYwLF1QrVCi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaN2fGgAKCRB8DEliiIei
gSEcAQCQLE8ErHx/P1SsMvajI33eJ7A5adlqlQDsjeTYtcoUSAD8DjkN8zjrzQXN
I6ttpFrBLBZM9BlKh+oEJiZMDk+bYAE=
=GXis
-----END PGP SIGNATURE-----

--paBm3hYwLF1QrVCi--
