Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C1D47209F
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 16:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791305159; cv=none; b=W0HV8s4PigBVmc2eeFYs3tr/4TIGQcywhFvVRpCwogL+mZ2706dcONGZgiz6E2aafE/ufsSZtuZ3cx/sRUP6KYZHujizPRiZrgVLu8neksGXrlh14vgH58tELMkplrjN0uWqvsXhpDhpxmMd3D50znUd+To+Tr0GmZ9a1i8QoeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791305159; c=relaxed/simple;
	bh=j487JfcVa0EaY/y39ITYRY9BXOTs5W+OxUF34QPVbSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I33yVd2hINQpKaYUK+O9dTdoFDGIyvJQoAeX4TusHJBLjkAhADyEDbSUe60yRh5taNwWPgOiHkkQhScr3UkJGMNaQjAZ4Som1tF6eYr3nYUdfv3jf7XjcwXJu1k+hzbuV2iCCIJFOfA8BFD3oV0jthRFcALHcE5sbNI4rH9agYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJjhY3x0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJjhY3x0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E8AC1F0089B;
	Tue,  6 Oct 2026 16:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791305158;
	bh=q60AydLe9rgzj02I65XIp+XCEFOUHYFCqyBOqilvABc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IJjhY3x0s8njTCFzZY/c1DLSrMYZJUkTySD0xNI7pPi/s54DTDqw2x4JgtVzZ2yA1
	 8Glxx9xq/ykLR8YvJEj63lg89o9+pBaF4ls9c3UQ59K/ZX7u/wpOpiltGP13Hvuy5Z
	 SU1SjOocIqCE4LDS4bUbIbFTguGNDf+bNTuMhPYTqJTtI4odlQ4fip9J+biCgRwd1L
	 n9dqMdLLCIogdhsvVWBS4Mw6lLFC8r3uNgtlAi8iM1+Y0QtizRpqC2iI6Yyyue6KMa
	 N6c64DBcOKx4TbxtvDHrGpfDtkxSIK6YoWO86C+Wo/ULjFQ87puSDSsGWva8CdBGZy
	 t1jdT8oQAfrcg==
Date: Tue, 6 Oct 2026 18:45:52 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Nico Williams <nico@cryptonector.com>
Cc: phillip.wood@dunelm.org.uk, Patrick Steinhardt <ps@pks.im>, 
	git@vger.kernel.org
Subject: Re: git-rebase-walk
Message-ID: <asUiQhNERzwT_hWa@debian>
References: <ar5KL4_IKXYbx3Sb@debian>
 <ar5eereSq91xldo-@pks.im>
 <ar5-7ZtM6C23H-8m@debian>
 <ar9TTB5nmPPAdABE@pks.im>
 <95796d0d-5928-4108-bc27-b7ace4459d2a@gmail.com>
 <asOaLyiJUmINFFFH@debian>
 <asOnp8ed6AGStH60@debian>
 <792f4d41-bd60-4fae-a426-bd70cbad996c@gmail.com>
 <asUMkBi9NG0k6fu4@ubby>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ne4iscmrapggpzlx"
Content-Disposition: inline
In-Reply-To: <asUMkBi9NG0k6fu4@ubby>


--ne4iscmrapggpzlx
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Nico Williams <nico@cryptonector.com>
Cc: phillip.wood@dunelm.org.uk, Patrick Steinhardt <ps@pks.im>, 
	git@vger.kernel.org
Subject: Re: git-rebase-walk
Message-ID: <asUiQhNERzwT_hWa@debian>
References: <ar5KL4_IKXYbx3Sb@debian>
 <ar5eereSq91xldo-@pks.im>
 <ar5-7ZtM6C23H-8m@debian>
 <ar9TTB5nmPPAdABE@pks.im>
 <95796d0d-5928-4108-bc27-b7ace4459d2a@gmail.com>
 <asOaLyiJUmINFFFH@debian>
 <asOnp8ed6AGStH60@debian>
 <792f4d41-bd60-4fae-a426-bd70cbad996c@gmail.com>
 <asUMkBi9NG0k6fu4@ubby>
MIME-Version: 1.0
In-Reply-To: <asUMkBi9NG0k6fu4@ubby>

Hi Nico, Phillip,

> Date: 2026-10-06 09:58:24-0500
> From: Nico Williams <nico@cryptonector.com>
>
> On Tue, Oct 06, 2026 at 03:01:29PM +0100, Phillip Wood wrote:
> > On 05/10/2026 14:37, Alejandro Colomar wrote:
> > > > Below is a shell session performing such a rebase, which hopefully =
shows
> > > > why I need this to be multi-shot.
> >=20
> > To me it shows that we need to improve "git rebase --update-refs" so th=
at it
> > can rebase a tree of branches automatically. Doing it manually is labor
> > intensive and error-prone (your example output shows it is easy to forg=
et
> > when you're meant to be resolving a conflict instead aborting the rebas=
e and
> > checking out another branch).

It's easy to forget, but that's inconsequential.  What happened if
I abort and try again is that I'll meet the conflict again.  It's like
there's a barrier, and I won't cross it until I decide to cross it.

The very worst case is when bisect-rebase presents a conflict and you
forget to abort before solving it (to bring children closer before the
conflict), is that I'd have to resolve the conflict twice.  You face it
a few times, then you learn it.  But aborting too much is not a problem.
That doesn't increase your work.  It's just one more command, but the
same amount of conflict resolutions.  To summarize: aborting too much is
fine (which is what happened to me); forgetting to abort will lead to
having to resolve the same conflict twice (you'll eventually learn to
abort early, even a bit too much, just in case).

> > In the example below
> >=20
> >     git rebase --update-refs --rebase-merges main B
> >=20
> > will rebase A and B, but we don't have a way of including C.

--update-refs would need to present conflicts too.  After each conflict,
I --abort the current rebase, and do a bisect-rebase for each child that
brings childs into place.  Those bisect-rebase may themselves present
conflicts, which must be resolved immediately (before continuing the
main bisect-rebase), in case there are no grandchilds; but if there are
grandchilds, that also needs to be aborted, and grandchilds need to be
bisect-rebased to the child.  It's a recursive problem, and I don't
think we want to get into implementing a recursive rebase within rebase.

Plus, the order in which the recursion is made could be problematic (I
may prefer to tackle the branches in a certain order, due to personal
preferences).  It's not easy.

For now, I think the safest thing is to keep it multi-shot.  Once you're
familiar with the interface, we may discuss whether it can be integrated
into git-rebase(1).

Please, play with it for some time.  Try it with trees of branches, and
see how it works, and what you'd improve from it.  I've used it to
rebase some very old work of mine that had never found the energy to
rebase.  And it was amazing!  Nico seems to be having the same
experience.  I'm not convinced I'd have the same experience.

> But it's not the same problem.  This isn't about rebasing a set of
> stacked branches all at once.  This is about rebasing quickly across
> thousands of upstream commits.
>=20
> Naturally one _could_ use `--update-refs` with a bisect-rebase.  The two
> features are orthogonal.
>=20
> I've been using this bisect-rebase script to rebase an old branch off PG
> to the latest upstream -- that's 10,135 commits in my case(!).
>=20
> > > > On the simpler case of a single branch, I'd still prefer a multi-sh=
ot
> > > > approach where --continue only advances one rebase operation, becau=
se at
> > > > the end of it I want to stop, and check git-range-diff(1) to make s=
ure
> > > > it all makes sense.
> >=20
> > Perhaps we could insert "break" commands after each branch is rebased s=
o the
> > user can check the range-diff.
>=20
> The bisect-rebase scripts do stop when a conflict is found that the user
> should resolve.  The noise from the bisection's search for that
> appropriate commit is not that interesting except as a sort of progress
> meter.  Stopping at each point in the bisection where the bisection
> would continue is not going to be that useful unless the user could
> check if the conflicts are simple and obvious enough at each point and
> skip the rest of the bisection -- is that your idea?  But if so then the
> bisection will be very painful if the user would mostly elect to
> continue it.  That could be an option -- if it works, great, and if not
> start over without that option.

I guess we could insert break points at the end only in the rebases that
are known to fail (the "conflicting rebase" at the end of my script).
That "could" work.  I'm not convinced though.


Cheers,
Alex

--=20
<https://www.alejandro-colomar.es>

--ne4iscmrapggpzlx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrFJbkACgkQ64mZXMKQ
wqkIBg//cbRiqWvCFgtp7EGaA5tRz3+Rz75sGdaTCD5M1E1xMxIFYpYmvOHChrd4
bfsdI1RARKVVneqtZrsLT2Ana7iCO58mlAZM/TCwoJnJWoY6G8TOiq9E9P2xFNM1
zFnx4300I/lXW+3RtXtx0ExwTvZxY+cI/vcoCKDFuIBcXs+gteqerkzd5h9HIwT1
ye64ztloWcMgY2V6q2efE4jhLJaMxub4CB5rbwrgfjVHrHNuWeIarW7EOxleFUEe
2cTGyW1eoLYDRcfmEEp0sh6LXhbJGjhD9RyJSdZRZL9CBhEUlR1V44rIs5/iEpwT
SZ1WRFHoB2JgdVMpEP5y4gFfi7ZeNLtn9XrMvbOaFV4IJfjtErB6JNcW2rxHtFxR
m8ASoj6tkgfyatfFLgA4y2kT+SLYYdiPb+sKKgRisnW59XVm+DTROalSLZ5zkKoG
2IJBU7T5/U2cNBZqISUqH3QLSbbAz+w7SfuF6liTnFQp2m8pBIxQsxFFB0GPLn+n
+Zrxddwi/xFXgZstlA62y3FZmxJtAxW8Ep7FLfhdZRiOJpMWUQeyLwNpeh1iLkWs
31wKT7w7ITDjAHsTbtcGnyHa8J0URBQNmHDNjpntXBpUn/GSOFCQfGnxbwV1yDRU
iamlfR5awijH4yyQPQsojSZZa9ptH9tmDaEc1xF5HhxyAoSoscs=
=voPl
-----END PGP SIGNATURE-----

--ne4iscmrapggpzlx--
