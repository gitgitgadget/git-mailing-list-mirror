Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E168538DC71
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 21:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791062263; cv=none; b=k/Lc0HG531ZL+ylOqO0EIuNGb+iisncNrCs1VhfkILf6doIZD4M8AM7Fg0hJ9Qpy8cE7b1sbj4fRNFGzqRDI4GddiTO0gs61rp8rjf4UufApHsIZxQEC+pFm9MYP/PUllhsPbWC+UnO1DMARc5WuUkSxRDuVSn+HqZuWnCkmojU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791062263; c=relaxed/simple;
	bh=sInEgSP1ptAfEs717opYozv7zEHXUsQID3bMEeSjM4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uRlFhBW3hpQR2i4ARNSho6bzOQaNEizCYDxaOxBem50Iuu75+0Qhr1wgF9PWtknyqDH4snGzURV0OyCpffGZZ7Wlak6jaleKjmbEsaqsJgXJDBBcFAtmSx5H10UiJTQ5bvTIMRAx0V9oE1x+v+j5dWUtfQXdVbsEzCfoEn7gBh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvHRHKlI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvHRHKlI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60FC31F0089B;
	Sat,  3 Oct 2026 21:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791062261;
	bh=hQteIY0BmHXCXls519TNyku1lC+QIhwZbsX5auDh7cA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kvHRHKlI+JrFzJQ8QhMVCfbxDZR5SYw3EgEkZjtxn2K9tvFbQXRLrvpKJSjew5i6n
	 X7ZLS07CPWbwEDZQOQnksVkkTcMfiiSrHXBpLZbsOP0Eu2m3mwBT0fxlMaws0HpFn2
	 AQKQr+k7vuHen3EultWLYKL7yPe7LzkpJkRk5CwH72RNUZUfP+syMj7EHSbBQbk/3c
	 YGp7FNgV3WJ8ibvKBLeA78B+KjijN6NEg9iHT0a8Tos8eydOJK9oTt2FJElVO32y1S
	 zISI91i5/e6ZnTn6X0dzuWpZNkHa09n+IAmwm98kgAJDKWfwFJntR0WK2eScWZ9D4B
	 UwqHSB2BFX/nQ==
Date: Sat, 3 Oct 2026 23:17:34 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Nico Williams <nico@cryptonector.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	Ben Boeckel <mathstuf@gmail.com>, Viktor Dukhovni <viktor@openssl.org>
Subject: Re: [RFC] git-brebase
Message-ID: <asFwatHbzTrGMAiK@debian>
References: <asFRVdMTpshsazgM@debian>
 <asFoDZKscLKqaIf+@ubby>
 <asFoq4gnl1caJM2U@debian>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zher2donqvx2yob7"
Content-Disposition: inline
In-Reply-To: <asFoq4gnl1caJM2U@debian>


--zher2donqvx2yob7
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Nico Williams <nico@cryptonector.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	Ben Boeckel <mathstuf@gmail.com>, Viktor Dukhovni <viktor@openssl.org>
Subject: Re: [RFC] git-brebase
Message-ID: <asFwatHbzTrGMAiK@debian>
References: <asFRVdMTpshsazgM@debian>
 <asFoDZKscLKqaIf+@ubby>
 <asFoq4gnl1caJM2U@debian>
MIME-Version: 1.0
In-Reply-To: <asFoq4gnl1caJM2U@debian>

> Date: 2026-10-03 22:56:32+0200
> From: Alejandro Colomar <alx@kernel.org>
>
> Hi Nico,
>=20
> > Date: 2026-10-03 15:39:41-0500
> > From: Nico Williams <nico@cryptonector.com>
> >
> [...]
> > > It might be confusing to have these three flags being dependent on
> > > another flag, and not being able to use this within a git-bisect(1)
> >=20
> > IMO that's not a problem at all.  There are a lot of Unix/Linux commands
> > that have flags that only make sense when used with other specific
> > flags.  So I still like a `--first-conflict` or `--onto-first-conflict`
> > option.
>=20
> Yeah, it could make sense.  I'm not sure, but it could be.
>=20
> > (I really like `--pre-exec` and `--post-exec`, BTW.)
>=20
> :)
>=20
> > > session, unlike other git-rebase(1) operations.  That might call for
> > > a new git command.
> >=20
> > That might still be the case in that this will be such a useful tool
> > that it deserves a name.  But also, `git-rebase(1)` should always have
> > been this useful, so that argues for this to be either... a new option
> > like `--onto-first-conflict`, or even a new default behavior.
> >=20
> > Does jj have a feature like this?  What do they call it?
>=20
> No idea.
>=20
> [...]
> > > while test $# -ge 1; do
> >=20
> > I normally use
> >=20
> >   while getopts +:<short-options-here> opt; do ...
> >=20
> > I also have a getopts_long-like function (see my gists) for bash if you
> > like.
>=20
> I think getopts(1) is not usable for git(1)-related scripts, because
> getopts(1) interprets '--' as the end of the options, but git(1) uses it
> for distinguishing commits from paths.  If anyone shows me how it can be
> used, I'd be interested, because I've hit this issue in the past with
> other script.
>=20
> > > [...]
> > >=20
> > > # Set up the callback script for 'git rebase run'.
> > > mktemp \
> > > | read -r callback;
> >=20
> > I like to set a `trap` to remove temp files.
>=20
> Hmmm, makes sense.  If so, I'll also try to filter out the line that
> prints the name of the command, since 'git bisect run' prints it, and we
> don't want users to try to open a file that doens't exist.
>=20
> > > cat >"$callback" <<__EOF__
> > > #!/bin/bash
> > > ...
> > > __EOF__
> > > chmod +x "$callback";
> >=20
> > Here what might be better is to have a command-line option to execute
> > this callback without having to write it to a file,
>=20
> How would you do it?
>=20
> > and use environment
> > variables to pass arguments to it.
>=20
> The callback doesn't really need any arguments, since 'git bisect run'
> won't pass any arguments to it.

Self-correction: 'git rebase run' does actually pass arguments to the
command.  However, I still don't see the need.


Cheers,
Alex

>=20
> > > # Perform the conflicting rebase
> > > git switch "$branch";
> >=20
> > Ah, that came from:
> >=20
> > > git rev-parse --abbrev-ref HEAD \
> > > | read -r branch;
> >=20
> > which means I can't use this in detached HEAD mode :(
>=20
> Oh!  I wasn't aware that git-rebase(1) supported detached HEAD mode.
>=20
> > I work in detached HEAD mode almost exclusively.  I know, that's..
> > weird.  But it works for me.
>=20
> Ouch!  Indeed.  :)
> Out of curiosity, are there any interesting reasons for such
> self-implied pain?
>=20
> > Can we avoid forcing the user to be on a
> > branch?
>=20
> I guess I could keep a variable that remembers the state of the HEAD
> across all the rebases.  It should be doable.  I'll have a look (maybe
> tomorrow).
>=20
>=20
> Have a lovely night!
> Alex
>=20
> > Nico
> > --=20
>=20
> --=20
> <https://www.alejandro-colomar.es>



--=20
<https://www.alejandro-colomar.es>

--zher2donqvx2yob7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrBcOcACgkQ64mZXMKQ
wqn9PBAAiGXvZJtj7ypdYb0dmRmZLdLYJxxhOimORJ7+CewmioGhBZo17lFi8E45
yzeTDCQ90nMSXuRC1EASlLT5fTrE5kyTDmSCRVdZyLEdpG3zhk3p0A6q1pIxf+6D
0rHX/A+9jlMYpgKIEwtoHZhUpaYa5y0TwjG73Ox03xvjdiXgwwEoDLHMfZ5eedfw
FMbBe+wi4ImTv8N9TOsroTKJKfM745FIDsWPgC/gRrHkdpPO1v9srMvqN9+JORln
32oOsehkRW+K5TuQcqrL0XArQfNq63dkvGF4MZ+AP/ePA6Cvqkc8Y8LW7Zu8gBCr
0zZdXbUbWfiHenhKrsF7lXPqAeuaPrEr1R01swfOC47d34Q9KsePpCyq/PlyTNQp
8OLAg57dwVx1qOQ5E+FVor58z2sv4FQ+RroeO4CdeAXjbGyt8cNiFH5oXIshsGWD
+NAnO5yiSYoc9Sw+khPueXhsGTrrcNCbK/qaGrFI2almou/LeAenjMrqCACLbVEA
TLu4vwFSlvuxB/G6mBarIVNtM2pvSvXA4pZu+zfjUAMtOUhH9YhwkpwKvpito4+o
BF240JDd+isM6U4X2ktSSKfYHgPd6BbNk7MAZZa8XRIu2bE4ExZKPFfYoxhL9KKC
qcrefaBUxQ6icHN1SRW35Y5iKZrDdsz20BSLUGmuWKJy+DGdvVw=
=M/US
-----END PGP SIGNATURE-----

--zher2donqvx2yob7--
