Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C3576034
	for <git@vger.kernel.org>; Thu, 19 Jun 2025 20:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750366295; cv=none; b=QeuxCKQ/3fBVUCiTreuy0ju/1MsQ6d7pMoVpNojMQloFfWJecPMdJjmVPCunyZOr/Oll+ek8Mt2eB9bJauBjdEwRTwpCnjxQ/wjCO2MVHSl4OB6nteyOlOqV+4JPVweHAF1fNHayk5g5Rs0ZbP7Eqr+vCg8Rfgvro4Y1wtoWDL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750366295; c=relaxed/simple;
	bh=bXflWunJBmpGoNV3viHMt3JxzyZWHRhw3FNITQ+2QNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A/csgcDhAYJaF1UXNwow8mQPBF5Wk2qXdzuysMTETXjINVpWfVECx+D2HBwzR2TRwnHpdWTc9eSm5GcdIe5Vy9vShxRGmFfOY9ArXkvE13MPYzlPkE/aRz5lT3FznMI8bl+QRpm2gAy3xCX2zVW4D+s1K9t3kC6WdrEBe2F1jvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=MzacJkA1; arc=none smtp.client-ip=212.27.42.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="MzacJkA1"
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 6245B83456E
	for <git@vger.kernel.org>; Thu, 19 Jun 2025 22:51:22 +0200 (CEST)
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:7da4:fda3:31ce:17c])
	(Authenticated sender: jn.avila@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id 71808780331;
	Thu, 19 Jun 2025 22:51:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1750366275;
	bh=bXflWunJBmpGoNV3viHMt3JxzyZWHRhw3FNITQ+2QNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MzacJkA1oynbnnC064InzVowdOjzZdk0hEIj2dEXOQuOIR8gKFBBIUvCL2fDmUEBF
	 051f7OttElYY1hIbrKgmxvvPtAqyDK03bjqK3yxQjW2tVNmunlA0UbrOQItRnnuN/H
	 yFSEGRY2rHeUxWggomnzlAj3B0pmBFsqh1ImJ/OP76yrX5BP1gSr5kg0u3FLAf4wZU
	 bP3P8a9M2T80CqrcYpurxwlQwuedfeTRe02UIoeqGMw5FO1OixxHyLrKIXm64tCcIe
	 mbvLBLajFTxAcZyRfMhgYtXsEQ2+C5RxHU1QQmStdVDkWGdrTfW9f7De2g3UXUC42X
	 mfBiINSmIxFHw==
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <jn.avila@free.fr>
To:
 =?UTF-8?B?SmVhbi1Ob8OrbA==?= Avila via GitGitGadget <gitgitgadget@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/9] doc: convert git-log to new documentation format
Date: Thu, 19 Jun 2025 22:51:13 +0200
Message-ID: <5897216.DvuYhMxLoT@cayenne>
In-Reply-To: <xmqq5xgvz3ws.fsf@gitster.g>
References:
 <pull.1933.git.1749373787.gitgitgadget@gmail.com>
 <1ce06a184817d0493f4e56725aeb8ed5ccae1ba4.1749373787.git.gitgitgadget@gmail.com>
 <xmqq5xgvz3ws.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Tuesday, 17 June 2025 01:02:11 CEST Junio C Hamano wrote:
> "Jean-No=C3=ABl Avila via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > From: =3D?UTF-8?q?Jean-No=3DC3=3DABl=3D20Avila?=3D <jn.avila@free.fr>
> >=20
> > - Switch the synopsis to a synopsis block which will automatically
> >=20
> >   format placeholders in italics and keywords in monospace
> >=20
> > - Use _<placeholder>_ instead of <placeholder> in the description
> > - Use `backticks` for keywords and more complex option
> > descriptions. The new rendering engine will apply synopsis rules to
> > these spans.
> >=20
> > Signed-off-by: Jean-No=C3=ABl Avila <jn.avila@free.fr>
> > ---
> >=20
> >  Documentation/git-log.adoc | 83 ++++++++++++++++++++------------------
> >  1 file changed, 44 insertions(+), 39 deletions(-)
>=20
> This hunk (lightly edited to shift contexts) ...
>=20
> > ---no-decorate::
> > ---decorate[=3Dshort|full|auto|no]::
> > -	Print out the ref names of any commits that are shown. If 'short'=20
is
> > -	specified, the ref name prefixes 'refs/heads/', 'refs/tags/' and
> > -	'refs/remotes/' will not be printed. If 'full' is specified, the
> > -	full ref name (including prefix) will be printed. If 'auto' is
> > -	specified, then if the output is going to a terminal, the ref names
> > -	are shown as if 'short' were given, otherwise no ref names are
> > -	shown. The option `--decorate` is short-hand for `--
decorate=3Dshort`.
> > -	Default to configuration value of `log.decorate` if configured,
> > -	otherwise, `auto`.
> > +`--no-decorate`::
> > +`--decorate[=3D(short|full|auto|no)]`::
> > +	Print out the ref names of any commits that are shown. Possible=20
values
> > +	are:
> > ++
> > +----
> > +`short`;; the ref name prefixes `refs/heads/`, `refs/tags/` and
> > +	`refs/remotes/` are not printed.
> > +`full`;; the full ref name (including prefix) is printed.
> > +`auto`:: if the output is going to a terminal, the ref names
> > +	are shown as if `short` were given, otherwise no ref names are
> > +	shown.
> > +----
> > ++
> > +The option `--decorate` is short-hand for `--decorate=3Dshort`. Defaul=
t to
> > +configuration value of `log.decorate` if configured, otherwise, `auto`.
>=20
> ... does more than what the three-bullet list in the proposed log
> message describes.  The result is certainly easier to follow and
> more extensible to have these possible values in an enumerated list
> than in a prose.

True. That may become a new rule too.

>=20
> > +`--decorate-refs=3D<pattern>`::
> >=20
> > +`--decorate-refs-exclude=3D<pattern>`::
> >  	For each candidate reference, do not use it for decoration if it
> >=20
> > -	matches any patterns given to `--decorate-refs-exclude` or if it
> > -	doesn't match any of the patterns given to `--decorate-refs`. The
> > +	matches any of _<pattern>_ given to `--decorate-refs-exclude` or=20
if it
> > +	doesn't match any of _<pattern>_ given to `--decorate-refs`. The
>=20
> "any patterns" in the original may not be grammatical, but the
> rewritten "any of _<pattern>_" does not sound grammatical, either.
> "any of the _<pattern>_s"?  I dunno what the convention should be
> when more than one <placeholder> instances have to be referenced.

Good question for which I was more inclined to consider placeholders as=20
invariant, even if the result may sound "ungrammatical". This also simplifi=
es=20
the translation process where the plural forms can be complicated in some=20
languages.



