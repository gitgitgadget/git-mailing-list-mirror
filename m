Received: from mailgate02.uberspace.is (mailgate02.uberspace.is [185.26.156.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9630347FEA
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 08:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.26.156.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770365935; cv=none; b=tiPmjcFF3lxPYVzTgsWYE3/HgIrCB4y6rj7Vj5yPzyT9rQsQ/5wp924oD2QY7iny7KBlvPWxevfYhS2AGspgPojHsYDnrzhY0sVxtjYWiBlDeD7OScrASY3DR56/bPLQGvOpoAJaMsubwolai6BzHK5EoLwB9oAv00KV1P8CpyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770365935; c=relaxed/simple;
	bh=YTuqXmdyvlNtHindljEH/52sTKColWMYLZrRuOa/z6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VTeAz+E6iqLqFjex/xoku2QTgRQH1H15LrOcdIdnhwiaJjVYay5ZBlSCvIlhpUSPBxod8/AbUvKGsFnlhdMCge1fH/hG8qbcGKZ+lSDitwxL/IAXD8QGds7cG09EFxb3HHW8zVqTwhSJELWHghSvkSnzr5Yk/65sfG/rzBBPj00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=beyermatthias.de; spf=pass smtp.mailfrom=beyermatthias.de; dkim=fail (0-bit key) header.d=beyermatthias.de header.i=@beyermatthias.de header.b=eBhwr+Cx reason="key not found in DNS"; arc=none smtp.client-ip=185.26.156.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=beyermatthias.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=beyermatthias.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=beyermatthias.de header.i=@beyermatthias.de header.b="eBhwr+Cx"
Received: from cressida.uberspace.de (cressida.uberspace.de [185.26.156.202])
	by mailgate02.uberspace.is (Postfix) with ESMTPS id 2BAA018036B
	for <git@vger.kernel.org>; Fri, 06 Feb 2026 09:18:53 +0100 (CET)
Received: (qmail 13173 invoked by uid 989); 6 Feb 2026 08:18:53 -0000
Authentication-Results: cressida.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
	by cressida.uberspace.de (Haraka/3.1.1) with ESMTPSA; Fri, 06 Feb 2026 09:18:52 +0100
Date: Fri, 6 Feb 2026 09:18:50 +0100
From: Matthias Beyer <mail@beyermatthias.de>
To: Jacob Keller <jacob.keller@gmail.com>
Cc: git@vger.kernel.org, pyokagan@gmail.com, peff@peff.net
Subject: Re: git-am applies commit message diffs
Message-ID: <hn6q2mdjdqezzvtxfxffmatctnlf4ttvwedfk7wnw7xw75gy4g@hetctv53f7bh>
References: <bcqvh7ahjjgzpgxwnr4kh3hfkksfruf54refyry3ha7qk7dldf@fij5calmscvm>
 <CA+P7+xqcBcV8uySGgDfvt2ruAnFmfgaUy6aRbUC2zCzmCgPubw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xufhlxj5cozn3gwn"
Content-Disposition: inline
In-Reply-To: <CA+P7+xqcBcV8uySGgDfvt2ruAnFmfgaUy6aRbUC2zCzmCgPubw@mail.gmail.com>
X-Rspamd-Bar: --
X-Rspamd-Report: SUSPICIOUS_RECIPS(1.5) MID_RHS_NOT_FQDN(0.5) SIGNED_PGP(-2) MIME_GOOD(-0.2) BAYES_HAM(-2.760958)
X-Rspamd-Score: -2.960958
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=beyermatthias.de; s=uberspace;
	h=from:to:cc:subject:date;
	bh=YTuqXmdyvlNtHindljEH/52sTKColWMYLZrRuOa/z6U=;
	b=eBhwr+CxwhDdFYJssQc3e1lhAwEh4KFJukmbXOoVu7rHXlJa+vXI9y0dXCO0P0EsPuBw4R9Atk
	EzTrFSN8V8C9wiMdZIvi4tWYsoHs+aQ1XWODUG+NeT/GVy5r0f4C5LO9AWv/AnwpwmWAHjW0ghrR
	fBkyxI8loHz+5hpzqwa75mzsAna0usGo9hFCzGAkkvxY8knHC1Pl3NLNra34LKNL/it/hIynVVwP
	C01WeZkDiS3QglOBjSQTwehwafsjh8NSP0x83vYuqcoEyewsiQrFsxmtdzOBATkTmP9srBaMRGDG
	px+4MvHVTSHi8nmQBakLSQifQ5/Z52oE5PNfsu30lCUWm1x5hujQi5yqNniPAPKVh8bEp6iIMKSB
	gC5WvEg0693d7IC/7xvr5u7RJxTXkNfKoYr+v/OoH3d3K1lMM1PbyZyP4LspM8ZFtCCfL2I1JuuY
	JXEVQGASjFOyVPeErDYYnFJ+FLLiHz0XEsThEW8T8nHyJbnRIKtcvC3S/v957FkhmznGPazCdR6g
	YPMgpdejJiP1KZ4Vg5YRA3wuLcEpWeLy6WgYrxqkaRlqVJIZXkXGYWe7SpC1RQbEyCYIJvXelCZj
	M6KDa2G+rapngV9Jzl0Datm51RNHHGnpb5stwHyzngvtJu6NKUAqCXSfRMc/RhGjQ8CouTVoxnlg
	c=


--xufhlxj5cozn3gwn
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: git-am applies commit message diffs
MIME-Version: 1.0

Hi,

CCing some git-am contributors, hope that's alright for you!

On Fri, Feb 06, 2026 at 12:04:54AM -0800, Jacob Keller wrote:
> On Thu, Feb 5, 2026 at 11:50=E2=80=AFPM Matthias Beyer <mail@beyermatthia=
s.de> wrote:
> >
> > Hi,
> >
> > I am not sure whether this was already reported, searching the lore did
> > not yield anything for me, but I might have overlooked it...
> >
> > This was just posted on mastodon[0]:
> >
> >     PSA: Did you know that it=E2=80=99s **unsafe** to put code diffs in=
to your commit messages?
> >
> >     Like https://
> >     github.com/i3/i3/pull/6564 for example
> >
> >     Such diffs will be applied by patch(1) (also git-am(1)) as part of =
the code change!
> >
> >     This is how a sleep(1) made it into i3 4.25-2 in Debian unstable.
> >
> > TL;DR: If you put a diff in the commit message, that diff will be
> > applied by git-am.
> >
> > This looks clearly like unintended and might be an attack-vector, right?
> >
>=20
> It is certainly surprising. I am not certain I would consider it an
> attack-vector since you should definitely be reading the commit
> messages before applying, but I could see the fact that its
> unintentional is a problem.
> [...]
>
> > [0]: https://mas.to/@zekjur/116022397626943871

As per the issue linked in that toot I quoted above, the issue clearly
seems to be that it is not intentional that a diff embedded in the
commit message will be applied.
Nobody ever guessed that and that `sleep 1` that was in the commit
message made it into debian unstable because people assumed it to work
as intended.

I call that sheer luck, that it was only a `sleep 1` and not a "here is
how I made this into a backdoor and here is a patch to fix it",
ultimately getting the backdoor in which was written as a diff in the
commit message, instead of the "fix" in the "patch part" of the email.


That said, I am no expert in either C or the git codebase at all, but
=66rom what I saw from reading the git-am codebase, it looks like it tries
to find the patch by looking for three dashes on a line with a linebreak
behind ("---\n").
=46rom what I read, it looks for that from the first line.
What I would think of here is looking for that "patchbreak" from the
_end_ of the email rather than from the top, that would have prevented
this issue, right?

Best,
Matthias

--xufhlxj5cozn3gwn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEUJGUus1GMTrRclzcEKWX9Kitz80FAmmFo+oACgkQEKWX9Kit
z82RrQ//eatt9kpwACun/JqUCwTI5yly1y84NnBQgkSpk+/kVV+o2SKY/pEc6Sb2
S0JZ0DGLQof5/bgE/G+J/Ok/Pk/cFGiX3ZRkfpcgd/fo2aDUo2KPfaQyMQ7b4dpe
1JkjYRpg2GiZXQJKFh7bxoaqRN9ueuSihewjC7D9JETh7gY4m2K1oOHSBUxJR3tU
VSZP2bdQDHn07CUhixEKSiXL4P+CnF51bfzZRtmVNheBsWNgCBmKJUmJ5B5btBEu
Qqy4zOKM4ybfhlPb7SNgpKfRW63UiyUlnoQlXsARm5WgtFg+RpeW972GX52UvGFi
+Fys5QSsKqPCkG/ekCxBApcQIWAQDw4nirT0DzhX4SDGs9DQdLRgM/jKTVX0yIK7
EAnn8S+lJTV04l1J3FZkde/P8KRVeDdn1CK8PmGLSkKyBEKSAzDx8OGqo1zLrrEc
1qGQDD3B8ROHgBEf9hY/xMD/N3QHNho1lDMCVIyiTuJbrBZ1CnyCg209/js1Od1R
cV+HL7QS/bc1AkXLLJR+WV+BGUhtNI7vHMSuD7aWcniBFSjGzAz05TdZ9DXMbdv4
IxdnoXz27CDGtZkaKQsr/5uwrHhUADNwQIilQ8ablYBBs18Lvydz1806y136/LIO
349u1SJuhDDoUlMvVazQyMm9uvNz0eqaPnuz/nFrp3+sFQIX6l8=
=ljiz
-----END PGP SIGNATURE-----

--xufhlxj5cozn3gwn--
