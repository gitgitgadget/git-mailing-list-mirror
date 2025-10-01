Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3C83594A
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 23:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759361558; cv=none; b=OmrHbQ+izrSqmoXNtftz0AiF2sORhYj6ElyCm13ehjUxRj0U4qixrBz3hjd9Z5t/wJMe5479ew7gbqiBK7gTQgGM0rLtVehJT45z7WFguWobRdAyBEMOcgWBvts15qLrPPck9K/xCMAqKGXgAyFluMX4tkQctP7Egt1Nr4s3cLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759361558; c=relaxed/simple;
	bh=n3DO7XUN9F5LefVPmklbqmUNwjnYUJyPTb51DBXgqHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BTM6fX3Qar8SOdiw4jYw9xp4cZz8mRl50Zuoa4msCBoXxdyFVGd0A/L9oo715t4Yyzt5TnR8M3y5X8jRFFIzJY9PAoq0GezsRt2VahgZLYiGldI62bQOo2YQ/qEig7bC/bnC7sDFtkNJVIma6CqGScRdmvRF5BgB3cOk3j0s73g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=Ihog01nA; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Ihog01nA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1759361548;
	bh=n3DO7XUN9F5LefVPmklbqmUNwjnYUJyPTb51DBXgqHs=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=Ihog01nAScTGVP8uDvkRHrACxw12fkXAam0xtcJW6poPUJdwEYfSKo2ixI8sXHAdo
	 kIPBPutC7igTEWFbdp/oAat2DLqv4gqDZk43tugR49TsHRf6rLRD5L3eAFdPqvBGQD
	 7WlMBCtcslYuoqlIkidrqsXestCDhCxmNrxf5ewACKm3EkDyjR2T2j/EEZSMDM9lMx
	 FRq7O6AXzq2J95CdKwZ9KOuAFepSy3LXGKkNIemUeO6imY1nLukZiNds/LAA2C+GqQ
	 7IL1XlHpfeBvAIFb/S8FhhsZIo9YZUyxHAPc5V9bnP4DkAiqM9b3uDEm57Z5F1WJzn
	 vSGn37epQOmuRBF2vmUd2hdAJIpTosv2+FbIVPgHp3UFy/pkCs8fRsDInyscRv8rMh
	 IDI6rBg7uX8hiJZK+JsV7BQoIbbZ+Df0jXyae68XKaFkpKMk1SViAFwu7j3L9OBMqt
	 32RRBYFaX0mi+odX4UGlx2eYvBj4l0TjmkILk5cQmeXK0Z7FNyL
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:eb6:3c64:95b3:ebcf])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id BDEDC20113;
	Wed,  1 Oct 2025 23:32:28 +0000 (UTC)
Date: Wed, 1 Oct 2025 23:32:27 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Chuck Wolber <chuck@wolber.net>
Cc: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
	Rick Sanders <rick@sfconservancy.org>,
	Git at SFC <git@sfconservancy.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2] SubmittingPatches: add section about AI
Message-ID: <aN26C68pxi-eJgn8@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Chuck Wolber <chuck@wolber.net>,
	Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
	Rick Sanders <rick@sfconservancy.org>,
	Git at SFC <git@sfconservancy.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
References: <xmqqcyalm0mh.fsf@gitster.g>
 <20251001140310.527097-1-christian.couder@gmail.com>
 <DD77TA1H1OOO.351R9WDH93UZ5@wolber.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8YwF7zvAgwkIyZOt"
Content-Disposition: inline
In-Reply-To: <DD77TA1H1OOO.351R9WDH93UZ5@wolber.net>
User-Agent: Mutt/2.2.13 (2024-03-09)


--8YwF7zvAgwkIyZOt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-10-01 at 18:59:31, Chuck Wolber wrote:
> 1. It repeats what is said just a few paragraphs earlier in the document.=
 I
> understand _why_ it does this, but moving the essence of this topic up to=
 the
> DCO section avoids the repetition and avoids diluting the project's legal
> guidance.
>=20
> 2. What am I supposed to do with "It's not yet clear"? This is worse than
> telling me nothing. It introduces a vague question with no clear guidance=
=2E It
> is _true_ that no clear guidance exists, but what are the consequences wh=
en it
> _does_ exist? The worst case scenario is that we have to go back and
> rework/remove AI generated patches. So why not just require something lik=
e a
> declaration of AI content like the one proposed at declare-ai.org?

I agree that this is unclear, which is why I suggested we be more
definitive.

Many of the companies that develop LLMs are headquartered in the United
States.  Many of the people that contribute to Git or distribute Git are
not.  For instance, I am located in Canada, which has different
copyright laws (we have the more limited fair dealing like the UK,
instead of the US's fair use) and has moral rights.  It is entirely
possible that the use of an LLM could be legal in one country or
jurisdiction but not another.

By accepting code that is written using LLMs into Git, we expose our
contributors (who implicitly distribute Git code by uploading it to
servers) and distributors (such as Linux distros or their distributors)
to potential liability if the use of a particular LLM or LLMs in general
are found to be illegal in their jurisdiction.  Unlike most of the
companies that develop LLMs, most contributors and distributors of Git
are individuals or non-profits with limited resources.  Even as someone
who works in the tech industry and is paid accordingly, defending a
copyright claim would be extremely expensive and probably financially
devastating for me and I really do not want to take that risk.

That's why simply declaring LLM use is not acceptable: because it
exposes others who have limited resources to legal risk.  Note that
ripping it out afterwards would require rewriting the Git history and
would not solve the problem of all of the people who are distributing or
using older versions (which would have been judged to violate copyright
law) or relieve them of the fact that they would have been exposed to
legal liability for their distribution.

The avoidance of legal problems is why we require sign-off.  If
Developer X signs off a patch that was later judged to violate copyright
law, then they have made a legally binding statement to that effect and
they have effectively accepted the entire legal liability for that[0].  If
we don't believe people can legally make certain types of contributions,
then we should explicitly tell people that they should not make that
legal statement to avoid any ambiguity.

This is very different from situations where companies make a decision
to incorporate LLM-generated code into their own codebases.  They can
hire lawyers to determine whether LLM-generated code is legal in their
given jurisdiction and obtain whatever legal necessities are required to
operate in compliance with the law.  They also usually have substantial
resources to address any problems that come up.  We, on the other hand,
are effectively a global project, must engage in behaviour that is legal
in all or nearly all jurisdictions, and have very limited resources.

> That reads like a full stop rejection of all AI generated patch content.
>=20
> What if AI were to generate a great patch whose technical quality is exem=
plary
> in every way? How is that any different from a great patch of exemplary
> technical quality submitted by a person who is unambiguosly evil?

There are a couple of problems here: one, some AI code (including
documentation or other text) is of poor quality; two, regardless of the
quality, many people submit AI-generated code they do not understand;
and three, AI-generated code is a legal minefield.

A technically great patch solves the first but not the other two.  We
still need people who submit code to be able to explain their changes
and respond to questions about the code.  What decisions were made?  Why
were they made?  What are the tradeoffs and downsides?

> Taking your words at face value, the prior paragraph reads as if the Git
> project is declaring an outright ban on _all_ AI generated content (and I=
 am
> nearly certain that is _not_ what you intended to say). If so, why bother
> continuing on with a PSA (Public Safety Announcement)? It reads like a
> non-alcoholic drink that has the words, "Drink Responsibly" printed on th=
e side
> of the can.

I think this is actually what they intended to say, but did so poorly.
I agree clarification would be valuable.

> AI is not going away, and we need to find a way to use it productively
> _without_ losing our sense of self-reliance. If we fail to develop this a=
bility
> when AI is hardly more skilled than an above average intern, full of hubr=
is and
> zero real world experience, imagine how unqualified we will be when AI be=
comes
> competent enough to manipulate and mislead us?

I think you assume LLMs can have intelligence.  They are glorified
prediction engines, effectively fancy Markov chains.  In some cases,
that can be useful and valuable and we can do interesting things with
them, but they cannot actually have intelligence, creativity or reason.

And LLMs already manipulate and mislead people.  They have been
implicated in goading teenagers to suicide or leading people into
conspiracy theories.  Some LLMs espouse racist, anti-Semitic, or
otherwise hateful views.  That's a good reason to be wary of them and
how they're incorporated to our lives, at least until such a time that
they have appropriate safety measures and regulation in place (if that
ever happens).

[0] I refer you to the common-law doctrine of promissory estoppel.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--8YwF7zvAgwkIyZOt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaN26CgAKCRB8DEliiIei
ga5zAQD5kJpZrbI4WPhMQZOmSG8/9uQVIJ7FKijGpxTRXkBbVQEAzXrAK9Ib4MZn
C+sBglqfvpAAwGtXsm9cFbpO9sLpxgI=
=Ps1L
-----END PGP SIGNATURE-----

--8YwF7zvAgwkIyZOt--
