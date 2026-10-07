Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF62D37647B
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 21:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791409359; cv=none; b=Hj4sZa7AR1pWwMP3I+Jt1Is0axXiXAY+MII2SwSl0KjW8goW2NyuiC4xEU7kwYsAG46w7iuemODFnQHJh18MhCLUkpENpEbraxoDwQ94bEE1FkP6RNVp26ZTPm/DfI/MbpkngcRO8bEwj2fS7dGgMXdM1FMZargg0ruwIDrgrcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791409359; c=relaxed/simple;
	bh=qWHnAXEaJMNwIkgYcCjWDDAns1fzo9t3+7DfjnZRjw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QTfL2adCju5eIUSHNSj+8ZHtatR3Z9zZ5J91BW+YeVs+iZLaNfL00QLRk5etR8FsxMix3R7tYdA4QFewr8ikBmRPZH3FSV7b4fwwmFRCVP+8oxLHi+Dk4t9CehwPxI9zSgQ+Z0S1BishYRLH2ivXsEd4/hhuT9Y7q9uTMp61x7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=vHjpY/Ps; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="vHjpY/Ps"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1791409356;
	bh=qWHnAXEaJMNwIkgYcCjWDDAns1fzo9t3+7DfjnZRjw8=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=vHjpY/PsOhn9vsbTLbKCk1wK1ZkWBkc8i82tho+XoY5fXwbOFhcpcJNyimH6rJJnn
	 LcuLAx/eqjQGYuOxw0cIuOM3OFB6faS8nyt6TzFhN4LeX8khNxHLjbkFLhFzp+0g5x
	 jFLLKsWVfZXyjfq5WM6UEMOPUTZvMNM3lKzhaungfqPPiq3nP8Lx0NGinWG/Nile1N
	 43wIsTOjT8ElaMig3FT/d9KzlxLzJp3w3FaEZ9QCyrBdqJRRR8gUfOnDaknl9Yne+e
	 aw83qR0R4oBQm+o+b/ybMc43e39KYP5e3Ut0u30cElUwoYaua5SV0dri5W/4Epxm8k
	 USPVP+MTAVBEDUWE/gcGdfS8dXIz0tAOcGvyj90lcx0QGzHZtl5Gy3NQ8+6kCkvHNo
	 ofD1BEsY1H7NKafQSC+l6eEwXe3WMtircjoN0wDfwAdzStIk0+s5RrvKTVVgDhz8nZ
	 O3VdHyOB1VgWQYZVYaVhIwsVJ033KMKjir9rQTlAt/ytKJO+wQR
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:66aa:1c10:d66e:dab7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id CFAC62012C;
	Wed,  7 Oct 2026 21:42:36 +0000 (UTC)
Date: Wed, 7 Oct 2026 21:42:35 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Scott Chacon <scott@gitbutler.net>
Cc: git@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] SubmittingPatches: allow responsible AI
 assistance
Message-ID: <asa8ymCv4hoRJcZM@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Scott Chacon <scott@gitbutler.net>, git@vger.kernel.org
References: <20261007142954.31761-1-scott@gitbutler.net>
 <20261007142954.31761-2-scott@gitbutler.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Beyn1L3MANAGhpTG"
Content-Disposition: inline
In-Reply-To: <20261007142954.31761-2-scott@gitbutler.net>
User-Agent: Mutt/2.4.1 (2026-07-04)

--Beyn1L3MANAGhpTG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-10-07 at 14:29:54, Scott Chacon wrote:
> The AI section encourages careful use of AI tools, but also says we
> will reject anything that looks AI generated. That leaves contributors
> without a clear path for submitting useful, reviewed, understood work and
> can discourage disclosure of the assistance they received.
>=20
> Allow AI-assisted contributions under the usual quality and licensing
> requirements. Require human understanding, appropriate testing, and
> disclosure of substantial assistance. Retain the DCO without changing
> its terms, and require contributors to consider provenance and meet
> applicable license obligations. Reviewers can ask for further evidence
> or decline work they cannot confidently assess.
>=20
> Replace the appearance-based rejection rule with these concrete
> expectations. AI assistance neither excuses an inadequate submission
> nor prevents an otherwise acceptable one from being considered.
>=20
> As an example, an OpenAI model was used to help me research, compare and
> craft the appropriate legal language for this policy change to help us
> match the modern, legally reviewed approaches now taken by peer GPL
> projects such as the Linux kernel [1].

I don't think I'm in favour of this policy.  All the major models have
been trained on a large variety of code from a large variety of sources,
including sources such as news reports or personal websites that do not
allow copying, modification, or distribution.  Given that LLMs are known
to reproduce portions of their training set or craft code or text which
is very similar to items in the training set, how can anyone honestly
assert the DCO without knowing all of the sources that were used to
create it?

Even if the model were, for instance, trained only on MIT-licensed code,
the license still requires a copyright and permission notice on every
copy, so the fact that the code generated from an LLM doesn't contain
that would seem to violate the license and prohibit us from using it.

The DCO was created to help us unambiguously state that the code is
acceptable to be included to avoid any later claims that the code was
copied from somewhere that it shouldn't have been.  Given the fact that
nobody knows what the sources are with a current LLM, it doesn't seem
that a reasonable person could make such an assertion.

I'm a distributor of Git and I don't want to be sued or arrested because
I end up distributing code that I don't have the right to distribute.
Large companies may have lawyers and lots of money to fight those
claims, but I do not (nor does the Git project) and I don't want to
spend my resources fighting allegations of copyright infringement or
have my reputation besmirched for that reason.  Just because other
projects think it's okay to do legally and ethically questionable things
doesn't mean we should as well.

I'll add that if Git were to include a portion of my MIT- or
BSD-licensed code without including a copyright or permission notice
because it was laundered through an LLM, I would absolutely file a
copyright complaint, and rightfully so.

I refer you to policies from other major open source projects that cover
this exact provenance issue:

* Gentoo: https://wiki.gentoo.org/wiki/Project:Council/AI_policy
* NetBSD: https://www.netbsd.org/developers/commit-guidelines.html

I also will point out the notes from the Contributor Summit where we
discussed this issue in some depth and proposed an approach for further
discussion.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--Beyn1L3MANAGhpTG
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmrGvMsJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ10HQ5pBzQ5U907mimQmoMCYieBHYOFfxZk76O9bU5Nn
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAA3cAQDylBlEfFTypfl/muuGKxfUkwqG
n6lpl2r4WXnSqjIywgEAnoQW9cay3sejSiLmhSPjdaw1qBMLJYQ+GYQsofA70w4=
=Q4Rs
-----END PGP SIGNATURE-----

--Beyn1L3MANAGhpTG--
