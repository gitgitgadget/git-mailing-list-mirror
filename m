Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34148264F96
	for <git@vger.kernel.org>; Fri,  3 Oct 2025 22:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759530019; cv=none; b=HA6N4mTUOm8L6f2onUfHPCx43FbZ5qjACu7w6NvFHm0h0wZ8I8cl/H6qFhVzuUcJfqvjb6EhcUNXqsLwxgRzXRRM0hgQDnHKJcfomF+gbPRBV6UEuI5ymjatePD82fumO+7VhuciONNivmZyY+ikV1voL8hNq/uDwdNYwR1nyVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759530019; c=relaxed/simple;
	bh=BOiKzFpHtLpYkbURbUAAUZcwynHcxFYYOIIuLyv5YsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rxaE7PydRQAbL8Gz5wgAQYt0HJa75vOxK6evvQfeY0G6B/NE/QNcF9GYX0bqxf032fFN9kbk/FIO7UbkyyGEa8vGF0BZ0mPlwYcQApv/KDOZcOS2mawAIpo9dEBqCRwJ2jT6d08bfxzafvYPVKK4BGo7oMYC3OrbaYpgTN4m/RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=tn4cvu4T; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="tn4cvu4T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1759530015;
	bh=BOiKzFpHtLpYkbURbUAAUZcwynHcxFYYOIIuLyv5YsQ=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=tn4cvu4TNl2inCP5Hn/smnfTgauKPPEqM1UZu6A4SeJxs76YJnD74ezovwOyNeWk8
	 AOghV8SzxZa3NMSlDtjpAmkjcoR6hrdUloQMSvTm0fkA/wLybDI51+HX02L4WesPkW
	 QAIj5T3gXyG/3bkYu16M5aSyS9YZtJ+55T7gp+M5xDqLxflg48sixZBH6rtkzix1Wf
	 D949u530mdu9vJT6B3NOw3TzcpfffZQX/t2+OkNJBaT6GNQi0+rpfoiJdLRXe9Q4B+
	 9X6WTu6C7ZpZ5H4bsfFP5jUJyvQV1n5T0Y6DaLS8lW75tczfTRzky7Mc3xHBBMzgWZ
	 UO19x8WDetTXjCxdmBR88xC1jQ6mJnv6o7C5aWAHkSSFcVgzrAKWNSEcJphhL9kMLq
	 ex+C+GoRGI1fwTH0TbcXfLWa/qljmrNPI/tiQNgLplk6DjHXR+/oGGI44qEW2/muBW
	 PAM+Wqyx2Uxjxq2j0q9A+ORTwuQYjSvFyXBcRZtp9UAN4A3b2I6
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:9a85:b88c:5160:2148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 8B98120119;
	Fri,  3 Oct 2025 22:20:15 +0000 (UTC)
Date: Fri, 3 Oct 2025 22:20:14 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Elijah Newren <newren@gmail.com>
Cc: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
	Rick Sanders <rick@sfconservancy.org>,
	Git at SFC <git@sfconservancy.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2] SubmittingPatches: add section about AI
Message-ID: <aOBMHqLxNd86vgjH@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
	Rick Sanders <rick@sfconservancy.org>,
	Git at SFC <git@sfconservancy.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
References: <xmqqcyalm0mh.fsf@gitster.g>
 <20251001140310.527097-1-christian.couder@gmail.com>
 <aN2fG-nS9fE5-2jD@fruit.crustytoothpaste.net>
 <CABPp-BFcg9M=XjqGPd+akrUOqJqREBmE9+NvO1Q05r4pUcOmEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Z/D6mM6p/pg1zXHj"
Content-Disposition: inline
In-Reply-To: <CABPp-BFcg9M=XjqGPd+akrUOqJqREBmE9+NvO1Q05r4pUcOmEQ@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--Z/D6mM6p/pg1zXHj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-10-03 at 20:48:40, Elijah Newren wrote:
> Would this mean that you wanted to ban contributions like d12166d3c8bb
> (Merge branch 'en/docfixes', 2023-10-23), available on the list over
> at https://lore.kernel.org/git/pull.1595.git.1696747527.gitgitgadget@gmai=
l.com/
> ?   We don't need to go theoretical, I've already contributed such a
> patch series before -- 2 years ago -- and it was merged.  Granted,
> that was entirely documentation, and I called out the usage of AI in
> the cover letter, and I manually checked every change (discarding many
> of them) and split it into commits on my own, could easily explain any
> change and why it was good, etc.  And I was upfront about all of it.

I think the main problem here is that we don't know the copyright
status of LLM outputs.  It is not uncommon for them to produce output
that reflects their training input and we see evidence of that in, for
instance, the New York Times lawsuit against OpenAI.

As I said, the situation is very unclear legally, with active litigation
in multiple countries, and we have to comply with pretty much every
country's laws in this situation.  Whether something is legal in the
United States, where you're located, is completely irrelevant to whether
it is legal in Canada, where I'm located, or Germany or the UK, where we
have other contributors.  We also have to consider whether it's legal in
all of the countries that Git is distributed in, which includes every
country in which Debian has a mirror[0], even countries under
international sanctions, such as Iran, Russia, and Belarus.

It doesn't matter if the person using AI has indemnification, either,
since that only covers civil matters, and at least in the U.S. and
Canada, knowingly violating copyright is also a criminal offence.

The sign-off process is designed to clearly state that a person has the
ability to contribute code under the license and I don't think, as
things stand, it's possible to make that assertion with code or
documentation generated from an LLM except in very limited
circumstances.  I don't allow LLM-generated code in my personal projects
that require sign-off for that reason, and neither does QEMU[1].  I
don't think I could honestly assert either (a) or (b) in the DCO with
LLM-generated code because it's not clear to me whether "I have the
right to submit it under the=E2=80=A6license."

To quote the QEMU policy:

  To satisfy the DCO, the patch contributor has to fully understand the
  copyright and license status of content they are contributing to QEMU. Wi=
th AI
  content generators, the copyright and license status of the output is
  ill-defined with no generally accepted, settled legal foundation.

  Where the training material is known, it is common for it to include large
  volumes of material under restrictive licensing/copyright terms. Even whe=
re
  the training material is all known to be under open source licenses, it is
  likely to be under a variety of terms, not all of which will be compatible
  with QEMU's licensing requirements.

I remember the SCO situation with Linux and how it really created a lot
of uncertainty with Linux because SCO created FUD around Linux licensing
and how that led to the DCO being created.  I am aware of the fact that
many open source contributors are very unhappy that their code has been
used to train LLMs without retaining credits and copyright notices or
honouring the license terms[2].  And I have spent many years working
with non-profits[3], where I have always been taught that we should
avoid even the appearance of impropriety.

It may matter less what the situation actually ends up being legally
(although it could end up being quite bad) and more whether someone can
imply or suggest that Git is not being distributed in compliance with
the license or contains infringing code, which could effectively make it
undistributable because nobody wants to take that risk.  And litigation,
even if Git and its contributors are successful, can be extraordinarily
expensive.

So I think, given the circumstances, yes, the right thing to do is to
ban LLM-generated contributions with a policy very similar or identical
to QEMU's.  If, in the future, the legal situation changes and it
becomes unambiguously legal to use LLMs across the world, then we can
reconsider that policy then.

[0] https://www.debian.org/mirror/list
[1] https://github.com/qemu/qemu/commit/3d40db0efc22520fa6c399cf73960dced42=
3b048
[2] Regardless of the legal concerns, this implicates professional
ethics concerns, such as =C2=A71.5 of the ACM Code of Ethics[4].  Ethics
requirements usually go well beyond what the law requires.
[3] Software Freedom Conservancy, which handles legal matters for the
Git project, is a non-profit.
[4] https://www.acm.org/code-of-ethics
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--Z/D6mM6p/pg1zXHj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaOBMHQAKCRB8DEliiIei
geSUAP95eycAqgpTLAG4ercvs+qi4YDV4/9Ej7NSPYmLsp7euAEAhYm47aTUECue
RXKoMXj9G2c7Lw2MOAsm/meyC1F2yAY=
=sKzi
-----END PGP SIGNATURE-----

--Z/D6mM6p/pg1zXHj--
