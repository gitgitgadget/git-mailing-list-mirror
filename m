Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E939334B1B0
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 17:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791049835; cv=none; b=BUdb3kdQ5Qy7ChidRVHVtnJI+PLz5/kQZpx0q/0Rcuqecd8rmF2OA/DxgHawr7m/m0bWec13RSLFsslBcqCuxxORpgETT88mPDw3XfAUPzz8LkcHlPb/5NI3lvrodfJXtLChrdxcY4CLKJmh/PSai2EyoW09ZVROa0/OdcacZnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791049835; c=relaxed/simple;
	bh=pDpyAUOE5vQh6gFj4wMA2Zcd+4ZwAiSGionFvEzuKhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TEQI4G96kBsdfgYe/N9AsgnNamdmHBLivknNx/SxDX/Pol0SDOYThwWsxn4W8XeP4x6kGX+5bLPa9IVQtXEmcqkXmvxpmdXRJTA+b+1qluAvsmoyzqFFOimgUJGAZdvrkgciiRKY0vOmb5SbiIaupQZCal4aa5jqD8ZVXojuruc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8ObFeCI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8ObFeCI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53B551F0089B;
	Sat,  3 Oct 2026 17:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791049833;
	bh=/SupTvsBkq37dV2WPP/c5DtzJJDWfFGeWNmSnIRs/vc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=e8ObFeCIGdOFvbHBj6egFoKKSXY94QxjcI9lzsDqcuzkINH1zvY1rkLB0cD9LwK71
	 7lDalgXEuhOUL71/R9m/4bHtcsEgZt5PPnjJewUNsVF21ouYTo/H5TecmS1wpUl00m
	 qp75R7PPX/y2kU4jt8G2M2tAatAr9iDskyJxk52vmtHq/NAndQb8GAr55FXEMI1bR0
	 XiEJeRfwE5kWgW3Hj6fhQUosDXNSU2HoYUcfySH+z4+ZAK/Mp6NZ44+qiQkeblIJ4R
	 i9/8HZ5PXOAy07Tr9KmzMTIeb1P0NJyy/1f/Im4sadyy0Riski7mAdpjfX8/Ss+Vuq
	 Yt8vnI7rl41jg==
Date: Sat, 3 Oct 2026 19:50:28 +0200
From: Alejandro Colomar <alx@kernel.org>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: git-visualize(1) plumbing equivalent
Message-ID: <asFAEwomFDbC2Dec@debian>
References: <asDTWsH-RuIJOyne@debian>
 <CALnO6CCUY2KF8rEotihdVNy+D10mmzuW0RXbH8nqhSS9jsgQUg@mail.gmail.com>
 <asEa_Lp01DVJ2ThZ@debian>
 <CALnO6CAsd36-XEnRQWNhAsmH7Bg6ZoHv7qb2xQ1m0cW4-Decmw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nysnurtf37cud5bs"
Content-Disposition: inline
In-Reply-To: <CALnO6CAsd36-XEnRQWNhAsmH7Bg6ZoHv7qb2xQ1m0cW4-Decmw@mail.gmail.com>


--nysnurtf37cud5bs
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: git-visualize(1) plumbing equivalent
Message-ID: <asFAEwomFDbC2Dec@debian>
References: <asDTWsH-RuIJOyne@debian>
 <CALnO6CCUY2KF8rEotihdVNy+D10mmzuW0RXbH8nqhSS9jsgQUg@mail.gmail.com>
 <asEa_Lp01DVJ2ThZ@debian>
 <CALnO6CAsd36-XEnRQWNhAsmH7Bg6ZoHv7qb2xQ1m0cW4-Decmw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CALnO6CAsd36-XEnRQWNhAsmH7Bg6ZoHv7qb2xQ1m0cW4-Decmw@mail.gmail.com>

Hi Ben,

> Date: 2026-10-03 13:10:43-0400
> From: "D. Ben Knoble" <ben.knoble@gmail.com>
>
> On Sat, Oct 3, 2026 at 11:13=E2=80=AFAM Alejandro Colomar <alx@kernel.org=
> wrote:
> >
> > Hi Ben,
> >
> > > Date: 2026-10-03 09:45:17-0400
> > > From: "D. Ben Knoble" <ben.knoble@gmail.com>
> > >
> > > On Sat, Oct 3, 2026 at 6:13=E2=80=AFAM Alejandro Colomar <alx@kernel.=
org> wrote:
>=20
> [snip]
>=20
> > > > Having read the documentation for git-bisect(1), visualize reads se=
veral
> > > > environment variables, and thus this code doesn't seem robust.  What
> > > > would be the plumbing version of the while-loop condition?
> > > >
> > > >                 git bisect visualize --oneline \
> > > >                 | wc -l \
> > > >                 | xargs -I{} test {} -gt 1;
> > > >
> > > > The goal is to know whether git-bisect(1) has found a commit yet or=
 not,
> > > > to stop looping.
> > >
> > > I think you are probably looking for the (size of the) set of commits
> > > between bisect/bad and all the bisect/good-* refs. So you might need
> > > to "git refs list" the good ones, and feed those as negated refs
> > > alongside bisect/bad to rev-list?
> >
> > Yup, this seems to work:
> >
> > git refs list | grep refs/bisect/ | sed '/good/s/^/^/' | cut -f1 -d' ' =
| xargs git rev-list
> >
> > >
> > > In the general case, that wouldn't account for skipped commits as I
> > > understand it, where multiple commits are left at the end of the
> > > bisect, but in your script it doesn't look like you skip any.
> >
> > Hmmmm.  I'm now working on adding the ability to skip commits, so this
> > would be a problem.  Do you have any idea on how to deal with that?
>=20
> Not offhand, sorry :/ I'm not totally sure how bisect represents that sta=
te.

Thanks anyway!  I think this is getting hard enough, that it might be
worth piping a heredocument into a mktemp(1) file within the script, and
passing that to 'git bisect run'.


Cheers,
Alex

--=20
<https://www.alejandro-colomar.es>

--nysnurtf37cud5bs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrBQGQACgkQ64mZXMKQ
wqnT5Q//fRwY5NgG7d+FnvzP+VAsI6yn+ZSFX6Vgkehwdi9uhSExQJeexpA4TIrE
PMlammVM/xklR09kOm2+hrix21/9bm8F89vXC3ZuEb1laI8+E5V3tht7EoB6/AFq
F7ALnDSv+VZEE/4WDaKUAd6qmBoOBTwZ0xaz464Zsg6kxPSrEC1dqPjylMPnt52u
1PE7q2jYD0yrfar2IS5SFvz2TwAZyXEbXx5Zovt1gm9sLJ9DDQvq9rD4DusLZZhQ
Whd+ogOhpuC58EAs49uRnxn3S0aXuymRAeYqeYbly9HakcgLcMWC0gzDBBTqBg97
uFkjoSWkoQm9G+0cVU7xwhCu0nprmt7rNeBJ/g5JX0KX7b7wzUm8RBQTNKaPuN49
RpOH2TZoP3ahCmUYHQ9YfvMVNiQp7eljRrkgZtADVJBuS09vDdabJTrnBxPgoTie
BWi4Ke8OO8ozP3kROCVXcl2dX0cusjtd/a1b57nLkI6ZmL5yKj0MvE2jz/7R14Uq
zmIlQ7Dmq1bJ9wOqxbJIzWFOjFYQIbGoF2TieMjlf6N85WuYWKqjLpQxifwUFH0C
+B0jiQUL/eEdhETtmK9UM4WBUvePLODGkLqRYmZHMTLqAyReWIWdBT5GKFlvTKBf
kizR11ZgPEVgyXMSJZtNRcImYJH0LyU7EWRtYceGqx9OaRQzoY4=
=NBdU
-----END PGP SIGNATURE-----

--nysnurtf37cud5bs--
