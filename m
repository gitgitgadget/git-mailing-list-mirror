Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B70156968
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 21:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736284922; cv=none; b=LER6Vy0gvwssjCDAbU5ay2bWwav9mN0m4akDgiyMlVBGwaPRsXhTh360GkV1krIhP9vPFMDEAlAvTgUbJtnDH0AQPdst+6CY6BpVrKMwuQOo/LOlKcMMyHIQ9HAsK8uv8cwV9qtmdowhPDREi4vyhxmVr51w9FUTGtAUnTtO4ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736284922; c=relaxed/simple;
	bh=/eyB+cUJx9HYyB3RMcltsy/zevrImURtoSzCbobuyPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nFf5kMsWUcFBJe5ZbgJWf9jMefRRoGI8tS4FAIQmOM2Bl8xzuGL7YYOZ+hQLgQx7BnhzcEDajqvenpFdXsjVMcX9uXr3lT/bq4FXpivxwSKD/gjYgTxdjBw6yhXaF0D5BnVPFVTBHkHfKAJdQepftDrooGNt5pWbAyq6GqvngEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=Uvozm9Ou; arc=none smtp.client-ip=212.27.42.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="Uvozm9Ou"
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 67F16DF8EF1
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 22:14:24 +0100 (CET)
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:420b:f4aa:dd4f:83c9])
	(Authenticated sender: jn.avila@free.fr)
	by smtp5-g21.free.fr (Postfix) with ESMTPSA id 084905FF88;
	Tue,  7 Jan 2025 22:14:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1736284457;
	bh=/eyB+cUJx9HYyB3RMcltsy/zevrImURtoSzCbobuyPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Uvozm9OulxSkR1cQ2FNCWLo1ZoEcx9wR+7L5+d4seqQmk/LJQWE4kWyAQfuAUHVUt
	 rNdUrdfU3fKFCIMjzYzZ741Eetoy0ud9hMCX3muv7NtAAAfKTnnoLzRiq/+NEYmd97
	 myFhDH0ov4ruM5DF9G+3n+v1KWEpn8GyVdfbAjYJ2TaB1gHlrr6r/tA4fzE87/zLio
	 d88bS1h0F4bP8J0+RwW4L9gh/KtC+4zljc5mbji7uJCE7xLMv726bgwE2QduP51DZ3
	 myNfLoipLVYLUBOnnxh7szTAxYXo6gQys/+nb2kDDZxBKpzJwkskYCRPfZil1xvtet
	 mT0MkQ4dIGJPg==
From: =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To:
 =?ISO-8859-1?Q?Jean=2DNo=EBl?= Avila via GitGitGadget
 <gitgitgadget@gmail.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/3] doc: git-commit: apply new documentation guidelines
Date: Tue, 07 Jan 2025 22:14:14 +0100
Message-ID: <2353488.ElGaqSPkdT@cayenne>
In-Reply-To: <Z3uIZA0bIXzaUxlH@pks.im>
References:
 <pull.1845.git.1735912046.gitgitgadget@gmail.com>
 <dfd907fc3147b438222bbfad9b0a7ca61df642a5.1735912046.git.gitgitgadget@gmail.com>
 <Z3uIZA0bIXzaUxlH@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Le lundi 6 janvier 2025, 08:38:19 CET Patrick Steinhardt a =E9crit :
> On Fri, Jan 03, 2025 at 01:47:24PM +0000, Jean-No=EBl Avila via GitGitGad=
get=20
wrote:
> > From: =3D?UTF-8?q?Jean-No=3DC3=3DABl=3D20Avila?=3D <jn.avila@free.fr>
> >=20
> > The documentation for git-commit has been updated to follow the new
> > documentation guidelines. The following changes have been applied to
> > the series of patches:
> >=20
> > - switching the synopsis to a synopsis block which will automatically
> >   format placeholders in italics and keywords in monospace
> > - use _<placeholder>_ instead of <placeholder> in the description
> > - use `backticks for keywords and more complex option
> > descriptions`. The new rendering engine will apply synopsis rules to
> > these spans.
> >=20
> > Additionally, some option descriptions have been turned into
> > imperative mood to make them more consistent with the rest of the
> > documentation.
>=20
> Same comment here regarding the commit message as on the other two
> series. We should use imperative mood for it, as well :)

Thanks for reviewing.

Being consistent with myself is imperative ;-)

>=20
> > diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> > index c822113c111..b08a398e31d 100644
> > --- a/Documentation/git-commit.txt
> > +++ b/Documentation/git-commit.txt
> > @@ -58,139 +58,139 @@ summary of what is included by any of the above f=
or=20
the next
> > --z::
> > ---null::
> > +`-z`::
> > +`--null`::
> >  	When showing `short` or `porcelain` status output, print the
> > -	filename verbatim and terminate the entries with NUL, instead of=20
LF.
> > +	filename verbatim and terminate the entries with _NUL_, instead of=20
_LF_.
> >  	If no format is given, implies the `--porcelain` output format.
> >  	Without the `-z` option, filenames with "unusual" characters are
> >  	quoted as explained for the configuration variable=20
`core.quotePath`
> >  	(see linkgit:git-config[1]).
> > =20
> > --F <file>::
> > ---file=3D<file>::
> > -	Take the commit message from the given file.  Use '-' to
> > +`-F <file>`::
> > +`--file=3D<file>`::
> > +	Take the commit message from _<file>_.  Use `-` to
>=20
> I think it would make sense to move changes like this, where the actual
> wording changes, into a separate commit. That'd make it way easier to
> spot the non-mechanical changes from those that may require some
> discussion.

True. There are other parts where I introduced the place holder as an echo =
to=20
the option description. The idea is to be less verbose and more contextual.

>=20
> > @@ -257,19 +256,18 @@ default::
> >  The default can be changed by the `commit.cleanup` configuration
> >  variable (see linkgit:git-config[1]).
> > =20
> > --e::
> > ---edit::
> > -	The message taken from file with `-F`, command line with
> > -	`-m`, and from commit object with `-C` are usually used as
> > -	the commit log message unmodified. This option lets you
> > -	further edit the message taken from these sources.
> > +`-e`::
> > +`--edit`::
> > +	Let the user further edit the message taken from  file
>=20
> There's a double space here. I was also wondering whether this should
> say _<file>_ here to further clarify that this refers to the same
> placeholder as the placeholder in `-F`. Might be confusing though, I
> dunno.

This would sound a bit repetitive, but it is still better than making the=20
reader refer to the entries for each option, in which case I would also add=
=20
the placeholders when listing the options.

>=20
> > diff --git a/builtin/commit.c b/builtin/commit.c
> > index ef5e622c077..a7315ed67cc 100644
> > --- a/builtin/commit.c
> > +++ b/builtin/commit.c
> > @@ -44,7 +44,7 @@
> >  #include "trailer.h"
> > =20
> >  static const char * const builtin_commit_usage[] =3D {
> > -	N_("git commit [-a | --interactive | --patch] [-s] [-v] [-u<mode>]=20
[--amend]\n"
> > +	N_("git commit [-a | --interactive | --patch] [-s] [-v] [-
u[<mode>]] [--amend]\n"
> >  	   "           [--dry-run] [(-c | -C | --squash) <commit> | --
fixup [(amend|reword):]<commit>]\n"
> >  	   "           [-F <file> | -m <msg>] [--reset-author] [--allow-
empty]\n"
> >  	   "           [--allow-empty-message] [--no-verify] [-e] [--
author=3D<author>]\n"
>=20
> I guess this change is required to make t0450 happy?


Yes it is. To be honest, I was about to try to complete the synopsis for al=
l=20
commands, but finally let this task for another round, because I'm not even=
=20
clear on what is alternative and what can be combined.

>=20
> Patrick
>=20
>=20




