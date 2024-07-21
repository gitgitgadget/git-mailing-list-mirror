Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B9A433A8
	for <git@vger.kernel.org>; Sun, 21 Jul 2024 13:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721567800; cv=none; b=Z+B0W/4thgSnKEHUIJNLYnUbVahSpWth+4pp4DAT9NigT/vPJkMkc/UMU9YOVupaO2jdU0n7l3zHRjQ+I90zPSd9ZegxV8GdO+P5I9yGgHFbDmNz0tCXk7cvAiohvEkjlVz4BmH26bkgg+d9vkjABROEk1UBbAmaVPygvzP8afs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721567800; c=relaxed/simple;
	bh=Y/DT3VzJAYCxwBeukuRt/ANNhFzcxiGvNMc9WrmQBCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mc9EbRYkMIQtruD51H3kagFXJN/JaHvuicT2Q6awXZmI1TW+QdiPBDeQcKMPjSx0NpBsS3EcY2qGYhD0vCA/LGjz7JimBhO9DD0pSBmt+sUQCnfM9qEWj+5yaw0MV4isIHTUMmS+5BfCSL3x8WS14ZPviAnjMp/11QDELhSJM1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=tS8WIRNw; arc=none smtp.client-ip=212.27.42.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="tS8WIRNw"
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id AD39D871F1E
	for <git@vger.kernel.org>; Sun, 21 Jul 2024 15:08:56 +0200 (CEST)
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:84f9:8e32:233e:cb6e])
	(Authenticated sender: jn.avila@free.fr)
	by smtp4-g21.free.fr (Postfix) with ESMTPSA id 1F7E919F5A5;
	Sun, 21 Jul 2024 15:08:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1721567329;
	bh=Y/DT3VzJAYCxwBeukuRt/ANNhFzcxiGvNMc9WrmQBCw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tS8WIRNwKQ+GnoirPGcoPgS9ysbzoQ33t8tRCfEo8Fcjzs6U/mvg5JsJdDqp0LWeY
	 67yD8Smwtqr/rnKbScAjiAIAk5EGWVUx5/IveYXX4Ty53Q3PptIPJectRQgJ+DKjUH
	 ewl8a0CJqKplDRnBlc/ZbHKWHMoO0dn6dGabwEuShUFYpEa770Pee10i60RkWRLOH1
	 2DFrjaUbUG9BLvIHN7gdDHaErqRqAoTazuHMQECgFTzNVHYLLSRtsJ67CBzdBGGcuD
	 1+dWabF78/9j1vOWXQEYPhZJSqbN3bXjoMWQ4iEjhJZpTPq6Hh1v+YXvXeD7wMSS7T
	 m8s83/f4xZSxw==
From: =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To:
 =?ISO-8859-1?Q?Jean=2DNo=EBl?= Avila via GitGitGadget
 <gitgitgadget@gmail.com>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject:
 Re: [PATCH] doc: git-clone fix discrepancy between asciidoc and asciidoctor
Date: Sun, 21 Jul 2024 15:08:46 +0200
Message-ID: <8404759.T7Z3S40VBb@cayenne>
In-Reply-To: <xmqq8qxvhcy5.fsf@gitster.g>
References:
 <pull.1765.git.1721496853517.gitgitgadget@gmail.com>
 <xmqq8qxvhcy5.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Le dimanche 21 juillet 2024, 01:16:02 CEST Junio C Hamano a =E9crit :
> "Jean-No=EBl Avila via GitGitGadget" <gitgitgadget@gmail.com> writes:
>=20
> > From: =3D?UTF-8?q?Jean-No=3DC3=3DABl=3D20Avila?=3D <jn.avila@free.fr>
> >
> > Asciidoc.py does not have the concept of generalized roles, whereas
> > asciidoctor interprets [foo]`blah` as blah with role foo in the
> > synopsis, making in effect foo disappear in the output. Note that
> > square brackets not directly followed by an inline markup do not
> > define a role, which is why we do not have the issue on other parts of
> > the documentation.
>=20
> This was utterly misleading, at least to me, and it took a few times
> of reading for me to really understand what you wanted to say.
>=20
> It does not matter that "generalized roles" is not known by
> AsciiDoc.  What really causes the breakage is that a string inside
> [square brackets] followed by string inside `a pair of back quotes`
> is interpreted by Asciidoctor as "generalized roles" (whatever it
> is), even though we do not care at all about such a feature here.
>

Sorry for not being clear. Indeed I was wrong, Asciidoc.py also has this ro=
le=20
management  behavior for any other inline markup (++, _, *, ^,  ~) except f=
or=20
back-quoted text.
=20
> How about phrasing it more like so?
>=20
>     Writing a string inside [square brackets], immediately followed
>     by a string inside `a pair of back quotes`, causes asciidoctor
>     to eliminate the string inside [square brackets], because it is
>     a syntax to trigger a "generalized role" feature, which we do
>     not care about in the context of the synopsis section here.
>=20
>     Work it around by inserting an otherwise no-op {empty} string to
>     forbid asciidoctor from triggering that feature here.  AsciiDoc
>     is not affected negatively by this additional empty string.
>=20

OK, but let's get rid of the "generalized role" stuff, then.=20

> The reondered result _might_ be easier to read than pre-2.45 version
> of documentation, but I somehow find the updated SYNOPSIS section
> almost impossible to work with in the source form.  And the need for
> these otherwise no-op {empty} makes it even less pleasant to work
> with.

I can only agree. The fact that this "feature" is too easily triggered almo=
st=20
voids all the "painless technical doc editing for the rest of us" argument=
=20
that is the main selling point of Asciidoc, Markdown and other lightweight=
=20
markup systems.

>=20
> I wonder if there is a magic incantation that says "everything
> should be typeset in monospace in this block, unless ..." so that we
> can lose all these `back quotes`?  And then the part that follows
> "unless ..." would say how we mark up the <placeholder> part which
> is the only thing exempt from "everything is in monospace" default.

While doing the styling of synopsis, I tried to be smarter than that. There=
=20
are basically 3 semantic entities in the grammar:

 * the _<placeholders>_ in italic
 * the `keywords`, in monospace
 * the grammar signs: [, ], |, ..., (, ), etc. These signs are not typeset.

Setting everything in monospace would mix keywords and grammar.

With this schema in mind, I don't find difficult to understand how the syno=
psis=20
is written (putting aside the  {empty} hack). Fair enough, this is more=20
difficult than just plain text, but the aim is still to get decent output.



