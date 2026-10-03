Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9AE3537E5
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 15:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791040412; cv=none; b=sfDoV4+lQhYKEGF21bFY+iDdPgmCAyeQmWq3k/59BaFC5Kpt1LkvqDuSAvRhET0nvZKGtZuQbG7darA62FYkfaWt20sbZYwAoAFpiuPNmyVpckJK7qeFrTqNHiEW4+egHTEkbt6Acv7XSp0QrG79tRb/oSpvfNxXtZcxjuo4IwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791040412; c=relaxed/simple;
	bh=SstV/d0oJ4BIHLYCbBI/JlPqmSFUZuqUlhA8PRIbIog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ux9ixZOln70qRSZMuS7fRHQqMX9h5okVAO8zmuPd/IXZCiFwIyB/stHhHgfVyM7xYfWiKPwzwKl4qmfjHoAXNxx+DFEERgF7+4VHnsAdXwnZDV+031hs+zmD6QPmbW5mtjQ+lJsrIX8NfsdP+DuZ+bhFE9g6APsV+9Py9QW2Hqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bpO3EgoM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bpO3EgoM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B97741F0089B;
	Sat,  3 Oct 2026 15:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791040410;
	bh=hmmqOLqlyexNflirD1LrxHVFSWnVA36doCoOxqT03Yw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bpO3EgoMwZqXNwX11FZv116naezhbKQf5bHofjKooiE29y0e+hzuPZDMCmiwgnSnV
	 Rr/rmb1busor78M4INEL4OvVHDXUYNr6UYPmjWFYY8uHums846vlmCw/X3IrRYjjem
	 mWsJQ0tL94IF4bmSFzw4JfNVp98LjYSzJp1THiiip71zIsY6mLq9rdXMpFQzT+qhgd
	 e414NGl0i4x20OH2y6PaAqLg240eaPLHLqU5fqRmHpcDDqwJkk1rX3Be4UxXK+3l62
	 /E4zLV/wg6OA71dkpao4WpXDHApNxP7DnhnNRIf3p1caYBBOVXbnEuYu4rsTuKM1o9
	 bpL7A0PbAdbVQ==
Date: Sat, 3 Oct 2026 17:13:26 +0200
From: Alejandro Colomar <alx@kernel.org>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: git-visualize(1) plumbing equivalent
Message-ID: <asEa_Lp01DVJ2ThZ@debian>
References: <asDTWsH-RuIJOyne@debian>
 <CALnO6CCUY2KF8rEotihdVNy+D10mmzuW0RXbH8nqhSS9jsgQUg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jk6iwv5t33me7fs7"
Content-Disposition: inline
In-Reply-To: <CALnO6CCUY2KF8rEotihdVNy+D10mmzuW0RXbH8nqhSS9jsgQUg@mail.gmail.com>


--jk6iwv5t33me7fs7
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: git-visualize(1) plumbing equivalent
Message-ID: <asEa_Lp01DVJ2ThZ@debian>
References: <asDTWsH-RuIJOyne@debian>
 <CALnO6CCUY2KF8rEotihdVNy+D10mmzuW0RXbH8nqhSS9jsgQUg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CALnO6CCUY2KF8rEotihdVNy+D10mmzuW0RXbH8nqhSS9jsgQUg@mail.gmail.com>

Hi Ben,

> Date: 2026-10-03 09:45:17-0400
> From: "D. Ben Knoble" <ben.knoble@gmail.com>
>
> On Sat, Oct 3, 2026 at 6:13=E2=80=AFAM Alejandro Colomar <alx@kernel.org>=
 wrote:
> >
> > Hi!
> >
> > I have this code, which I use to loop in a script using git-bisect(1):
> >
> >         while
> >                 git bisect visualize --oneline \
> >                 | wc -l \
> >                 | xargs -I{} test {} -gt 1;
> >         do
> >                 if
> >                         git rebase $gropts BISECT_HEAD >/dev/null 2>/de=
v/null;
> >                         test $? -eq 0;
>=20
> Aside: this "test $? -eq 0" is a bit redundant, no? "if cmd" in shell
> works by checking whether "cmd" exits 0 or not.

Ouch!  Indeed.  IIRC, I originally had the test reversed (-ne 0), and
later probably flipped without thinking it could be removed.  :)

>=20
> >                 then
> >                         echo 'Rebase: success';
> >                         git bisect good BISECT_HEAD;
> >                 else
> >                         echo 'Rebase: conflict';
> >                         git rebase --abort >/dev/null;
> >                         git bisect bad BISECT_HEAD;
> >                 fi;
> >         done;
> >
> > (
> > I know this resembles "git rebase run", but I'm avoiding it, because
> > passing all of that as a command is non-trivial (and I'd like to avoid
> > having to write a separate script to pass its name to "git bisect run").
> > )
> >
> > Having read the documentation for git-bisect(1), visualize reads several
> > environment variables, and thus this code doesn't seem robust.  What
> > would be the plumbing version of the while-loop condition?
> >
> >                 git bisect visualize --oneline \
> >                 | wc -l \
> >                 | xargs -I{} test {} -gt 1;
> >
> > The goal is to know whether git-bisect(1) has found a commit yet or not,
> > to stop looping.
>=20
> I think you are probably looking for the (size of the) set of commits
> between bisect/bad and all the bisect/good-* refs. So you might need
> to "git refs list" the good ones, and feed those as negated refs
> alongside bisect/bad to rev-list?

Yup, this seems to work:

git refs list | grep refs/bisect/ | sed '/good/s/^/^/' | cut -f1 -d' ' | xa=
rgs git rev-list=20

>=20
> In the general case, that wouldn't account for skipped commits as I
> understand it, where multiple commits are left at the end of the
> bisect, but in your script it doesn't look like you skip any.

Hmmmm.  I'm now working on adding the ability to skip commits, so this
would be a problem.  Do you have any idea on how to deal with that?


Have a lovely day!
Alex

>=20
> --=20
> D. Ben Knoble

--=20
<https://www.alejandro-colomar.es>

--jk6iwv5t33me7fs7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrBG48ACgkQ64mZXMKQ
wqnIyxAAmeH+ox+kNFAkzj5L2JkHK1WS7QFBNjqB74Wl9CDBS/OzQq+rIuoglUAC
Qx1wQ52mE2zWsuDh5+xyjXf0zg8K64tBUxyeRZbk79ouqyXLigZJwdqT8J6qKqdm
JADvLu6YEGsgdxWaYU1KFV4vFHMI/lvFd/HUs7MB6arpXwwvk/k4V1t8EwFjihX2
ZVXY8SE4dDFVBCl/ODJKKKxFRpTlJ2pncHNIqMWuSUL5/9GnqzcQ8Ms5ja6CXg/P
acpUzjohwF+NF3HhSSuKzL2EnW4qJAj/neqOrDwkL1JXFCBUKsqqAG/C+zMmpvYf
18v3zFPxPHpqqV8ucsrLsD6zyEwWiY+yNT06Q3mjKte2eHDDFFn5F5M8kG33vj3s
c+334IODGZqNCUulJ2250BR9tdv2b7VYtsLoXLGx8Buwjjj447LyKyfzL2MT/r1G
io5HoY+o62LzgqB+B0nrhOQCJnytqUfzdi4CA+RRjJxc54CB3l8zBISKRQXBrTnT
5LqtAhS6sAepd6zD1pvsQLPJ04NYdDOEXWCSW0DTkNsfnI27z900InUl5ceb3mOX
+r97l8Bit9D1eNFinQMm4CE4QOlm7HUkdaIgFkaTUTqfEYocHK5dYkF0QRJUlIlU
KnJAqh+lDEo5b36G0Qfe1mmRSqcbNMnHhABYwTXZrzpD87016Ek=
=UAce
-----END PGP SIGNATURE-----

--jk6iwv5t33me7fs7--
