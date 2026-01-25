Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F502F3620
	for <git@vger.kernel.org>; Sun, 25 Jan 2026 21:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769375511; cv=none; b=oRV1gPtJvCkLNXky5ER8/Z7E42R1HmR8wcDWSmYNJ5e1nrnoq3M2qzayNDG9EMcxIyLZZmVBzXAe0rp0n/hwgxcaQNAhp1kQwrij8EMHFtUYQ7HfiXN8H8hPNyfYLn508upqfX6QtjX4cjAEnhI9FquP9yxmeNAhMl74mY38p4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769375511; c=relaxed/simple;
	bh=v0paC9cXnnFqlhchzFmcKUtF64N8ibsqx7n7eXGsQAk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lZGa4gObjr33HMi0N2q1CsVkatDgq65klCI6tDUdxjE98kgUFIRgucfvbaJPTCvCpeGJRaJvIkpGizEJNZiR5W9Dv0hbcYPmCAhva8afpig0xtKDnGM53Q5VplqVZ+uj1Q5clDscMZoq+HSMTx6Rls3N4WgSjXxbDnnCuHSrf7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=lLcAVa3E; arc=none smtp.client-ip=212.27.42.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="lLcAVa3E"
Received: from piment-oiseau.localnet (unknown [IPv6:2a01:e0a:d1:f360:8f32:f2ea:1014:8a99])
	(Authenticated sender: jn.avila@free.fr)
	by smtp5-g21.free.fr (Postfix) with ESMTPSA id 9A2155FFB1;
	Sun, 25 Jan 2026 22:11:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1769375499;
	bh=v0paC9cXnnFqlhchzFmcKUtF64N8ibsqx7n7eXGsQAk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=lLcAVa3EWuQeL1GmYDABElkZyyfp5D+h7EqbFDmmzonrnQoNX0+OJtMKb/Xt2+Y2u
	 PTjbZJPB3nBzhWKZJAMG1/O0dT/qFTpqqvN1SWqc60A1ZFCYSwLHqo2bEClJ67ZM4j
	 FgozQ1Inj3xJVdQk01OZGMsdUoVHf9xFAaPiZj5TOszHbOBlTkUW4DpQZpssh7JZXc
	 eVzG+yX/H2ObRvTzUE1l4uzlHz4QhD9UV/vOSTk5pSrTHe/BpgXZnOb2kcuHBuYaUS
	 w3jLqEhKirNSkPdq00/oX3m6CZXvjsBb1jwfjCFGibh0jRxmdN6NQ0zhsk0l02kskr
	 l8u3E7vs3UR+Q==
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <jn.avila@free.fr>
To:
 =?UTF-8?B?SmVhbi1Ob8OrbA==?= Avila via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH 4/4] doc: convert git-show to synopsis style
Date: Sun, 25 Jan 2026 22:11:37 +0100
Message-ID: <3926333.kQq0lBPeGt@piment-oiseau>
In-Reply-To: <51016c02-40de-431f-a4ba-e08cb1bb8235@app.fastmail.com>
References:
 <pull.2036.git.1769202903.gitgitgadget@gmail.com>
 <d078e1d94fcf8511743787623f0c1abfd0321849.1769202903.git.gitgitgadget@gmail.com>
 <51016c02-40de-431f-a4ba-e08cb1bb8235@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Sunday, 25 January 2026 20:27:38 CET Kristoffer Haugsbakk wrote:
> On Fri, Jan 23, 2026, at 22:15, Jean-No=C3=ABl Avila via GitGitGadget wro=
te:
> > From: =3D?UTF-8?q?Jean-No=3DC3=3DABl=3D20Avila?=3D <jn.avila@free.fr>
> >=20
> >  * add synopsis block definition in asciidoc.conf.in
>=20
> This is for e.g. ``<hash> <title-line>`` it looks like. Is the intent to
> use italics on placeholders like `<hash>`?

Yes, it is. It turns out that asciidoc.py treats differently, paragraph sty=
les=20
and block styles. Until now, we only used paragraph style for synopsis.

> >  For plain blobs, it shows the plain contents.
> >=20
> > -Some options that 'git log' command understands can be used to
> > +Some options that `git log` command understands can be used to
>=20
> Same here.
>=20
> It could be nice to s/`git log` command/linkgit:git-log[1]/ either on
> this commit or in a separate one.

The problem is that pretty-formats.adoc is also included in git-log.adoc an=
d I=20
don't think it makes sense to self-cross-reference. If we want to generaliz=
e,=20
it would need some conditional inclusion/replacement.=20

> >>=20
> >  built-in formats:
> > -* `oneline`
> > -
> > -	  <hash> <title-line>
> > +`oneline`::
> > ++
> > +[synopsis]
> > +--
> > +`<hash> <title-line>`
> > +--
>=20
> HTML looks wrong in git-show(1) and others that include it. Something
> like this:
>=20
>     oneline
>         __<hash>__ __<title-line>__
>=20

The first edit was `<hash> <title-line>` but the rendering odd with the=20
following items which where more spaced. So, I changed to synopsis block bu=
t=20
forgot the back-ticks.

Will reroll.

> This doesn=E2=80=99t happen when I run asciidoc(1) or asciidoctor(1) dire=
ctly.
>=20

<snip>
>=20
> (For these pretty formats) The diff got confused I think but the
> conversion looks correct.
>=20

It looks better but not perfect. It is difficult to render correctly when t=
he=20
usual grammatical signs are in fact keywords. See below for better=20
explanation.

> >  +
> >  This format is used to refer to another commit in a commit message and
> >  is the same as ++--pretty=3D\'format:%C(auto)%h (%s, %ad)'++.  By defa=
ult,
>=20
> Not changed in this patch but this doesn=E2=80=99t render correctly for m=
e. It=E2=80=99s
> not inline verbatim/code all the way through. But it is correct if I
> remove the `\`.
>=20
> I don=E2=80=99t know why `++` was used either.

That's where the synopsis style fails. If we use backticks for this span, t=
he=20
parenthesis are interpreted as grammar signs, whereas here, we intend to pa=
ss=20
the whole span as verbatim.


=46or asciidoc.py, using the verbatim form '++' ensures that the whole span=
 is=20
treated as such. On my computer (asciidoc.py version 10.2.1), this renders =
as=20
correctly.=20

=46or asciidoctor unfortunately, the synopsis processing is performed very =
late=20
in the generation, after all parsing has been done. So, the '++' verbatim i=
s=20
processed the same way as backticked contents. I haven't found a better=20
alternative. The output is this wrongly processed span here.

This is the least breaking way I found. It means that for asciidoc.py, we c=
an=20
bypass the synopsis style with '++' formatting.

If I remove the backslash in this, the span inside the single quotes is=20
converted to italics by both engines.

Can you describe your setup?



>=20
> This looks correct just looking quickly over.
>=20
> > -** `prefix=3D<value>`: Shown before the list of ref names.  Defaults to
> > "{nbsp}++(++".
>=20
> All of these use the "(" style which doesn=E2=80=99t look good in my
> opinion. But I=E2=80=99m guessing it has to do with some of them using sp=
aces in
> them and `"` being used as a boundary.

Same here as above. I get the correct rendering for asciidoc.py. For=20
asciidoctor, this is rendered as normal text. Not correct but not completel=
y=20
bogus.

> >=20
> > -++%(describe++`[:<option>,...]`++)++::
>=20
> > +++%(`describe++``[:<option>,...]`++)++::
> This renders with backticks in HTML:
>=20
>     %(describe++`[:<option>,...]`)++
>=20

Ah, thanks for spotting. I mixed again synopsis and plain verbatim.
Will reroll.



> >=20
> >     the literal formatting codes described above. To use comma as
> >     separator one must use `%x2C` as it would otherwise be parsed as
> >     next option. E.g., +%(trailers:key=3DTicket,separator=3D%x2C )+
> >     shows all trailer lines whose key is "Ticket" separated by a comma
>=20
> Might as well s/"Ticket"/`Ticket`/ ?

Difficult to say. This is not a keyword per se. Changing is ok for me.

> The rest looks okay.




