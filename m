Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84821266EE7
	for <git@vger.kernel.org>; Fri,  8 Aug 2025 13:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754658054; cv=none; b=t5dPs9kY3+LUeyozo3AYgwp2mgvStVGdvX0NvMgL7sb6T7QopuXurVM+6fGRxnzmfREwugPlQxcgZj8Dybv9emni3+vQvb3CS7hnf3IxnOZZDrKWK/nI3Ll1ciN/mPhW7/ypxM9rMsDG6BDmfs0BLjmNtBkTHfm79i+SrLSOb0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754658054; c=relaxed/simple;
	bh=7b3h/vq/RXyQfGuibDNJrW1qVabHyUa8h0XGZ6VZYog=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a8guRRie7S9Z2fmjirp5t8eKHfrQLhVvMtdBDXPjHBfncS0HhDv17rZbpCeCab/E4s0SHtRLn2jrKWk9wcu9w22XZJbUhVwnfjrDlb8pfZ3y+dJOcIapH9Ge7rdkyrcUiu2uX/54yyddv8wTKiAWD2FX1oXEGojvden8R3tYdlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=gE36Ewwf; arc=none smtp.client-ip=212.27.42.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="gE36Ewwf"
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 6B9F2DF9D0B
	for <git@vger.kernel.org>; Fri,  8 Aug 2025 15:00:42 +0200 (CEST)
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:c2d2:c7d2:a4cd:bda7])
	(Authenticated sender: jn.avila@free.fr)
	by smtp3-g21.free.fr (Postfix) with ESMTPSA id 9D81E13F86E;
	Fri,  8 Aug 2025 15:00:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1754658034;
	bh=7b3h/vq/RXyQfGuibDNJrW1qVabHyUa8h0XGZ6VZYog=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=gE36Ewwfe8RttpL6iYlHSEJD8a1sP7Dqz+rKhMRB+EKUWjDFhxOXGRunZyVvy/mzN
	 /AkK6vO44dglIYbO+7YqcwZI6p8husp7258gZEGhibm7sG6pOoICfJcOOt5t4xuImO
	 vaVRHqwKVZVcCkMeWKTE48Hh747Y4bMTI6DndfDAUXEoIiQL3zTuCpCAclukxEma4J
	 eCAyLsiHcfHZRz3v2g8TL6V0FJ4BF7bwbh5o0f6N0YM7UdIkvtvthEglnx/mrr748+
	 ozFYydjDdzkAn7nnahAXNVAkiYRXKUa5C2cINt09ulcx6MxPFaX7jgFVf/1k2QvzUd
	 VCP8wadTio/RA==
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <jn.avila@free.fr>
To:
 =?UTF-8?B?SmVhbi1Ob8OrbA==?= Avila via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject:
 Re: [-SPAM-] [PATCH v2 3/6] doc: check for absence of multiple terms in each
 entry of desc list
Date: Fri, 08 Aug 2025 15:00:32 +0200
Message-ID: <12718405.O9o76ZdvQC@cayenne>
In-Reply-To: <0b6e4b7d-e294-4721-9ae1-3d10f5898276@ramsayjones.plus.com>
References:
 <pull.1945.git.1754399033.gitgitgadget@gmail.com>
 <5806390052b7a7cbdb8dc843bfcc24102604e2f6.1754421046.git.gitgitgadget@gmail.com>
 <0b6e4b7d-e294-4721-9ae1-3d10f5898276@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Tuesday, 5 August 2025 22:30:23 CEST Ramsay Jones wrote:
> On 05/08/2025 20:10, Jean-No=C3=ABl Avila via GitGitGadget wrote:
> > From: =3D?UTF-8?q?Jean-No=3DC3=3DABl=3D20Avila?=3D <jn.avila@free.fr>
> >=20
> > Due to portability issues, the script generate-configlist.sh was fixed =
to
> > not use carriage returns in the output. However, the result is that it =
no
> > longer correctly handles multiple terms in a single entry of the=20
definition
> > list.
> >=20
> > We now check that these entries do not exist in the documentation.
> >=20
> > Signed-off-by: Jean-No=C3=ABl Avila <jn.avila@free.fr>
> > ---
> >=20
> >  Documentation/Makefile                      | 10 +++++++++
> >  Documentation/git-check-attr.adoc           |  3 ++-
> >  Documentation/git-check-ignore.adoc         |  9 +++++---
> >  Documentation/git-http-fetch.adoc           |  4 +++-
> >  Documentation/lint-documentation-style.perl | 24 +++++++++++++++++++++
> >  Documentation/technical/api-path-walk.adoc  |  5 ++++-
> >  shared.mak                                  |  1 +
> >  7 files changed, 50 insertions(+), 6 deletions(-)
> >  create mode 100755 Documentation/lint-documentation-style.perl
> >=20
> > diff --git a/Documentation/Makefile b/Documentation/Makefile
> > index 76a9e1d02b26..ac8a21e3015c 100644
> > --- a/Documentation/Makefile
> > +++ b/Documentation/Makefile
> > @@ -508,6 +508,15 @@ $(LINT_DOCS_DELIMITED_SECTIONS):
> > .build/lint-docs/delimited-sections/%.ok: %.ado>=20
> >  .PHONY: lint-docs-delimited-sections
> >  lint-docs-delimited-sections: $(LINT_DOCS_DELIMITED_SECTIONS)
> >=20
> > +## Lint: Documentation style
> > +LINT_DOCS_DOC_STYLE =3D $(patsubst
> > %.adoc,.build/lint-docs/doc-style/%.ok,$(MAN_TXT)) +$
(LINT_DOCS_DOC_STYLE):
> > lint-documentation-style.perl
> > +$(LINT_DOCS_DOC_STYLE): .build/lint-docs/doc-style/%.ok: %.adoc
> > +	$(call mkdir_p_parent_template)
> > +	$(QUIET_LINT_DOCSTYLE)$(PERL_PATH) lint-documentation-style.perl $<=20
>$@
> > +.PHONY: lint-docs-doc-style
> > +lint-docs-doc-style: $(LINT_DOCS_DOC_STYLE)
> > +
> >=20
> >  lint-docs-manpages:
> >  	$(QUIET_GEN)./lint-manpages.sh
> >=20
> > @@ -537,6 +546,7 @@ lint-docs: lint-docs-gitlink
> >=20
> >  lint-docs: lint-docs-man-end-blurb
> >  lint-docs: lint-docs-man-section-order
> >  lint-docs: lint-docs-delimited-sections
> >=20
> > +lint-docs: lint-docs-doc-style
> >=20
> >  lint-docs: lint-docs-manpages
> >  lint-docs: lint-docs-meson
> >=20
> > diff --git a/Documentation/git-check-attr.adoc
> > b/Documentation/git-check-attr.adoc
> > index 503b6446574d..15a37a38e3f7 100644
> > --- a/Documentation/git-check-attr.adoc
> > +++ b/Documentation/git-check-attr.adoc
> > @@ -19,7 +19,8 @@ For every pathname, this command will list if each=20
attribute is
> > 'unspecified',>=20
> >  OPTIONS
> >  -------
> >=20
> > --a, --all::
> > +-a::
> >=20
> > +--all::
> >  	List all attributes that are associated with the specified
> >  	paths.  If this option is used, then 'unspecified' attributes
> >  	will not be included in the output.
> >=20
> > diff --git a/Documentation/git-check-ignore.adoc
> > b/Documentation/git-check-ignore.adoc index 3e3b4e344629..a6c6c1b6e5be=
=20
100644
> > --- a/Documentation/git-check-ignore.adoc
> > +++ b/Documentation/git-check-ignore.adoc
> > @@ -25,11 +25,13 @@ subject to exclude rules; but see `--no-index'.
> >=20
> >  OPTIONS
> >  -------
> >=20
> > --q, --quiet::
> > +-q::
> >=20
> > +--quiet::
> >  	Don't output anything, just set exit status.  This is only
> >  	valid with a single pathname.
> >=20
> > --v, --verbose::
> > +-v::
> >=20
> > +--verbose::
> >  	Instead of printing the paths that are excluded, for each path
> >  	that matches an exclude pattern, print the exclude pattern
> >  	together with the path.  (Matching an exclude pattern usually
> >=20
> > @@ -49,7 +51,8 @@ linkgit:gitignore[5].
> >=20
> >  	below).  If `--stdin` is also given, input paths are separated
> >  	with a NUL character instead of a linefeed character.
> >=20
> > --n, --non-matching::
> > +-n::
> >=20
> > +--non-matching::
> >  	Show given paths which don't match any pattern.  This only
> >  	makes sense when `--verbose` is enabled, otherwise it would
> >  	not be possible to distinguish between paths which match a
> >=20
> > diff --git a/Documentation/git-http-fetch.adoc
> > b/Documentation/git-http-fetch.adoc
> > index 4ec7c68d3b9e..dcb05890aefd 100644
> > --- a/Documentation/git-http-fetch.adoc
> > +++ b/Documentation/git-http-fetch.adoc
> >=20
> > @@ -25,8 +25,10 @@ commit-id::
> >          Either the hash or the filename under [URL]/refs/ to
> >          pull.
> >=20
> > --a, -c, -t::
> > +-a::-c::
>=20
> > +-t::
> s/-a::-c::/-a::
> -c::/ ?
>=20
> ATB,
> Ramsay Jones

Yep, the newline is inserted too late.

Thank you for the review. Will reroll in a couple days.

Jean-No=C3=ABl Avila



