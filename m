From: =?utf-8?B?T25kxZllaiBCw61sa2E=?= <neleai@seznam.cz>
Subject: Re: [PATCH] More typofixes.
Date: Mon, 29 Jul 2013 17:38:49 +0200
Message-ID: <20130729153849.GA8111@domone.kolej.mff.cuni.cz>
References: <20130729081821.GA6758@domone.kolej.mff.cuni.cz>
 <51F6826D.2010606@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Mon Jul 29 17:39:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3pXH-0007gM-Le
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jul 2013 17:39:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755001Ab3G2Piz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Jul 2013 11:38:55 -0400
Received: from popelka.ms.mff.cuni.cz ([195.113.20.131]:36393 "EHLO
	popelka.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752847Ab3G2Piy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jul 2013 11:38:54 -0400
Received: from domone.kolej.mff.cuni.cz (popelka.ms.mff.cuni.cz [195.113.20.131])
	by popelka.ms.mff.cuni.cz (Postfix) with ESMTPS id 3617C438AD;
	Mon, 29 Jul 2013 17:38:50 +0200 (CEST)
Received: by domone.kolej.mff.cuni.cz (Postfix, from userid 1000)
	id F1DF860135; Mon, 29 Jul 2013 17:38:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <51F6826D.2010606@xiplink.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.97.6 at popelka.ms.mff.cuni.cz
X-Virus-Status: Clean
X-Spam-Status: No, score=-1.8 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	UNPARSEABLE_RELAY autolearn=ham version=3.3.1
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	popelka.ms.mff.cuni.cz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231292>

On Mon, Jul 29, 2013 at 10:55:41AM -0400, Marc Branchaud wrote:
> On 13-07-29 04:18 AM, Ond=C5=99ej B=C3=ADlka wrote:
> > Hi,
> >=20
> > I improved my tool and it catched following additional typos.
> >=20
> > As with any big project best way to catch errors is to have automat=
ed
> > checks that catch them ( Other possibility would be to read everyth=
ing ten
> > times to get error rate down but nobody wants to do it).
> >=20
> > If you want you could add a pre-commit hook=20
> > stylepp-spellcheck --hook
> > that checks comments for likely typos (misspells by aspell and not
> > occurring in code). It uses aspell to identify them so you need to=20
> > teach aspell which words are valid.=20
> >=20
> > I would like make possible to share dictionaries so teaching phase =
can
> > be done only once instead for each person but I did not found suita=
ble
> > workflow yet.
>=20
> Unfortunately no automated system is perfect (see some of my comments=
 below).
>  I'm all for an automated system that identifies potential misspellin=
gs, but

> > that checks comments for likely typos (misspells by aspell and not
> > occurring in code)

It just prints likely typos, nothing more.=20

> I'm wary of anything that attempts to automatically correct perceived=
 errors,
> or that can't be overruled.  In the end a human must make the final d=
ecision.
>=20
Its more about minimizing time human must spend to review.
It is faster to read sentences with corrections and check if they make
sense and fix few that do not than switching between find typo,=20
read sentence, look up alternatives, decide which one makes sense.

It is natural that there will be errors in generated corrections; I lac=
k
neccessary domain knowledge for start.

> > Signed-off-by: Ond=C5=99ej B=C3=ADlka <neleai@seznam.cz>
> >=20
> > diff --git a/pathspec.c b/pathspec.c
> > index 6ea0867..27ffe77 100644
> > --- a/pathspec.c
> > +++ b/pathspec.c
> > @@ -40,7 +40,7 @@ void add_pathspec_matches_against_index(const cha=
r **pathspec,
> >  /*
> >   * Finds which of the given pathspecs match items in the index.
> >   *
> > - * This is a one-shot wrapper around add_pathspec_matches_against_=
index()
> > + * This is an one-shot wrapper around add_pathspec_matches_against=
_index()
>=20
> As many others have already said, this is not a typo.
>=20
> The use of "a" or "an" depends on whether or not the O's sound is har=
d or
> soft.  So although we say "an orange" we also say "a one-in-a-million=
 chance".
>=20
Well it slipped through my filter and review. Ideally a script could
just look up pronunciation in dictionary but I did not find downloadabl=
e
one yet.

> >=20
> >  [ ... snip ... ]
> >=20
>=20
> > diff --git a/Documentation/RelNotes/1.7.9.1.txt b/Documentation/Rel=
Notes/1.7.9.1.txt
> > index 6957183..e8fddb8 100644
> > --- a/Documentation/RelNotes/1.7.9.1.txt
> > +++ b/Documentation/RelNotes/1.7.9.1.txt
> > @@ -20,7 +20,7 @@ Fixes since v1.7.9
> >     submodule that only has uncommitted local changes in the patch
> >     prepared by for the user to edit.
> > =20
> > - * Typo in "git branch --edit-description my-tpoic" was not diagno=
sed.
> > + * Typo in "git branch --edit-description my-topic" was not diagno=
sed.
>=20
> Here "tpoic" is illustrating the typo that was being misdiagnosed.
>=20
yes, domain knowledge.
> >=20
> >  [ ... snip ... ]
> >=20
>=20
> > diff --git a/Documentation/config.txt b/Documentation/config.txt
> > index e0b923f..8420aff 100644
> > --- a/Documentation/config.txt
> > +++ b/Documentation/config.txt
> > @@ -434,11 +434,11 @@ core.repositoryFormatVersion::
> >  	version.
> > =20
> >  core.sharedRepository::
> > -	When 'group' (or 'true'), the repository is made shareable betwee=
n
> > +	When 'group' (or 'true'), the repository is made sharable between
> >  	several users in a group (making sure all the files and objects a=
re
> >  	group-writable). When 'all' (or 'world' or 'everybody'), the
> >  	repository will be readable by all users, additionally to being
> > -	group-shareable. When 'umask' (or 'false'), Git will use permissi=
ons
> > +	group-sharable. When 'umask' (or 'false'), Git will use permissio=
ns
>=20
> "Sharable" is the North American spelling.  AFAIK git doesn't specify=
 what
> kind of English the documentation source files should use.  Perhaps o=
ne day
> there'll be en_UK and en_US translations, and all the sources will be=
 written
> in Klingon...
>=20
> Until that day, or until the git project starts to care a lot more ab=
out
> English style, I think patches that translate spellings between Engli=
sh
> variants are a bit of a waste of time.
>=20
I need better dictionary that aspell currently has.

My replacements were mostly generated from commit histories of several =
projects
where I looked when wrong word changes to correct one and letters stay
mostly same.=20

This caused false positives like this.

> >=20
> >  [ ... snip ... ]
> >=20
>=20
> > diff --git a/Documentation/user-manual.txt b/Documentation/user-man=
ual.txt
> > index fe723e4..1491d69 100644
> > --- a/Documentation/user-manual.txt
> > +++ b/Documentation/user-manual.txt
> > @@ -3116,7 +3116,7 @@ Trust
> >  If you receive the SHA-1 name of a blob from one source, and its c=
ontents
> >  from another (possibly untrusted) source, you can still trust that=
 those
> >  contents are correct as long as the SHA-1 name agrees.  This is be=
cause
> > -the SHA-1 is designed so that it is infeasible to find different c=
ontents
> > +the SHA-1 is designed so that it is unfeasible to find different c=
ontents
> >  that produce the same hash.
> > =20
> >  Similarly, you need only trust the SHA-1 name of a top-level tree =
object
>=20
> Both "infeasible" and "unfeasible" are in common usage.  If you want =
to avoid
> future patches going back and forth on this, try "not feasible".
>=20
> 		M.
