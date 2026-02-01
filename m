Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F9024B45
	for <git@vger.kernel.org>; Sun,  1 Feb 2026 16:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769964002; cv=none; b=Cflcakz1KwxyYyuDxcN/yonIYBoKn6HhmjzcXBi5a5rVKaZ6fC2fQoVThZy6MhvWvE1tw5o2YZJgiJ7td6cWmAn6Fd3OJh/36Q5rjgiT+UX1MpV6fkFfoj5PgAtkwD8F0cXUY7736h14+Gx34ZTwl3PDoex1W0cAZlkjCNH3NQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769964002; c=relaxed/simple;
	bh=dM7oNBS5/RCWrCPEKuOrzGuNIpkQFfFQsYSWpXsk91c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QS5C7z80f6yGTYQSxeOQJBhQY5Cuy3dBy10JSPRLT+3nSxl2VlCMcqKM2pTYLXyCOrofImnx3M8UEZYDQsJvGk3DMhvxVK7Dv/Ko974JqZD2SORRLeYNKOyGb8xI8u5kmL/Hu7mRIGpwS6c5QjbGCxNvRqK0huwYnMKrigqZE98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=NwRsJQUz; arc=none smtp.client-ip=212.27.42.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="NwRsJQUz"
Received: from piment-oiseau.localnet (unknown [IPv6:2a01:e0a:d1:f360:36a6:8106:c8f9:14e1])
	(Authenticated sender: jn.avila@free.fr)
	by smtp1-g21.free.fr (Postfix) with ESMTPSA id 38879B00548;
	Sun,  1 Feb 2026 17:39:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1769963991;
	bh=dM7oNBS5/RCWrCPEKuOrzGuNIpkQFfFQsYSWpXsk91c=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=NwRsJQUzVnDo9y47ErvrYltLCsKITBf1qnQeOkV4HrBsC18OeyTOXJewrJpFqkVkX
	 helQ9AiK3bfU7EUThTpBM3VfUk2s5qR8+LA90BBVoromKyElVsIDOKntQLTXdTKtqX
	 rp3JxG729SXivRd5N5fx1W3t5da7VJBRRpfYYnURz+Uds14zrABLLY5wSQEBXfQARJ
	 6XlkMRqG/rHLfAWqUur7PgnXDYOynsq5xIyN2abZ5ozBW/8SpK153Noi0WoEJw+D1j
	 YgXj2+ygOxztPuiOvDwlmVAqF8ORajKaZTPnn5yHE8Fq1UaUTMfjdmgWN+rzB89owh
	 K/UlNzzV0Xeqg==
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <jn.avila@free.fr>
To: =?UTF-8?B?SmVhbi1Ob8OrbA==?= Avila <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2 4/4] doc: convert git-show to synopsis style
Date: Sun, 01 Feb 2026 17:39:48 +0100
Message-ID: <9570525.CDJkKcVGEf@piment-oiseau>
In-Reply-To: <14561b83-c976-46b2-a441-45fdeced1912@app.fastmail.com>
References:
 <pull.2036.git.1769202903.gitgitgadget@gmail.com>
 <f6314e580d62702d84c7b173800f6e09c9a16ed4.1769462744.git.gitgitgadget@gmail.com>
 <14561b83-c976-46b2-a441-45fdeced1912@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Sunday, 1 February 2026 13:12:47 CET Kristoffer Haugsbakk wrote:
> >  +
> >  This format is used to refer to another commit in a commit message and
> >  is the same as ++--pretty=3D\'format:%C(auto)%h (%s, %ad)'++.  By defa=
ult,
>=20
> Not a change here but while `--pretty...` has all the symbols it is
> partly rendered, partly not.
>=20

> > -** `prefix=3D<value>`: Shown before the list of ref names.  Defaults to
> > "{nbsp}++(++".
> > -** `suffix=3D<value>`: Shown after the list of ref names.  Defaults to
> > "+)+".
> > -** `separator=3D<value>`: Shown between ref names.  Defaults to
> > "+,+{nbsp}".
>=20
> These are rendered serviceably.
>=20
> > -** `pointer=3D<value>`: Shown between HEAD and the branch it points to,
> > if any.
> > -		      Defaults to "{nbsp}++->++{nbsp}".
>=20
> This one is just `->` but it=E2=80=99s a bit confusing:
>=20
>     " -> ".
>=20
> (the spaces may be more narrow in the HTML?)
>=20
> And the `-` has verbatim typeface while `>` does not.
>=20
> I said the preceding ones were serviceable in the sense that they don=E2=
=80=99t
> look great but you see what they are. This one is questionable.
>=20
> > -** `tag=3D<value>`: Shown before tag names. Defaults to "`tag:`{nbsp}".
> > +`prefix=3D<value>`;; Shown before the list of ref names.  Defaults to
> > "{nbsp}++(++".
> > +`suffix=3D<value>`;; Shown after the list of ref names.  Defaults to
> > "+)+".
> > +`separator=3D<value>`;; Shown between ref names.  Defaults to
> > "+,+{nbsp}".
> > +`pointer=3D<value>`;; Shown between HEAD and the branch it points to, =
if
> > any.
> > +	      Defaults to "{nbsp}++->++{nbsp}".
> > +`tag=3D<value>`;; Shown before tag names. Defaults to "`tag:`{nbsp}".
>=20
> Here I feel some deja vu.
>=20
> >  +
> >=20
> > ---
> >=20
> >  For example, to produce decorations with no wrapping
> >=20
> >  or tag annotations, and spaces as separators:
> > -
> > ++
> >=20
> >  ++%(decorate:prefix=3D,suffix=3D,tag=3D,separator=3D )++
> >=20
> > ---
>=20
> Here is a a problem. The pluses in `++...++` are apparently markup. But
> the line starts with `+%` here:
>=20
>     + %(decorate:prefix=3D,suffix=3D,tag=3D,separator=3D )
>=20


OK, I understand that you are using asciidoctor for compilation. This is a=
=20
difficult problem to sort out. For the translations, I'm working on an actu=
al=20
parser:
https://github.com/jnavila/git-manpages-l10n/blob/master/asciidoctor-extens=
ions.rb

When the parsing fails, the formatting rolls back to simple verbatim=20
formatting.

After polishing it a bit, this could make it into the git source, if the ne=
w=20
dependency is accepted.

In the mean time, all I can propose is to remove all formatting when=20
asciidoctor will not process it correctly and the output will be confusing.




