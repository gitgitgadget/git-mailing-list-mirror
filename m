From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 1/2] po/de.po: add German translation
Date: Mon, 6 Sep 2010 17:41:27 +0200
Message-ID: <201009061741.27840.trast@student.ethz.ch>
References: <AANLkTi=6ctLp-8FeqOGMZuhwvM_7DbaEp7+LK4nXfCaE@mail.gmail.com> <4c8197ab.1707e30a.3f10.714a@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jan =?iso-8859-1?q?Kr=FCger?= <jk@jk.gs>,
	Sam Reed <sam@reedyboy.net>, Jeff King <peff@peff.net>
To: <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 06 17:41:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsdpD-0004hH-2p
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 17:41:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753122Ab0IFPlb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 11:41:31 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:34257 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752822Ab0IFPla convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Sep 2010 11:41:30 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Mon, 6 Sep
 2010 17:41:28 +0200
Received: from thomas.site (129.132.153.233) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.0.702.0; Mon, 6 Sep
 2010 17:41:28 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.34-12-desktop; KDE/4.4.4; x86_64; ; )
In-Reply-To: <4c8197ab.1707e30a.3f10.714a@mx.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155578>

Hi Jan

=46irst off thanks for taking on the mammoth job of translating this.  =
I
skimmed the entire file, and apart from the comments below everything
looks sane, though I may of course have missed something.

I already like the translation way better than the one that
gitk/git-gui have, because it doesn't try so hard to translate *every*
term.  Maybe it would help to make a little translation glossary,
here's a start:

  bare repository       Lager-Repository
  blob object           Blob-Objekt
  branch                Branch (m.)
  checkout              auschecken
  commit                Commit/committen
  commit object         Commit-Objekt
  dangling ...          ... zeigt ins Leere
  detached HEAD         von HEAD abgetrennt  [but see below]
  directory             Verzeichnis
  fast-forward          Update ohne Merge
  fetch                 holen
  file system           Dateisystem
  index                 Index
  merge                 Merge
  object                Objekt
  origin                Ursprung
  parent                [unused, but would be interesting]
  pull                  [dito]
  push                  push [though only used as the command name so f=
ar]
  reference             Referenz
  reflog                Reflog
  refspec               Refspec
  repository            Repository
  resolve               aufl=F6sen
  revision              Revision
  tag                   Tag
  tracking branch       ... verfolgt ...
  tree                  Tree
  unmerged              verbleibende Konflikte
  upstream branch       Ursprung [note collision with "origin"]
  working tree          Arbeitsverzeichnis

As I said, I agree with the general idea of leaving certain terms
untranslated.  You said on IRC that you left all English terms that
are also used on

  http://de.wikipedia.org/wiki/Versionskontrolle

which seems a sound rule.  In any case it roughly matches (or still
stays slightly on the more-German side of) the colloquial usage in my
group, if that is any indication.

avarab@gmail.com wrote:
> +#, c-format
> +msgid "nothing added to commit but untracked files present%s\n"
> +msgstr "keine =C4nderungen f=FCr den Commit vorgemerkt, aber unber=FC=
cksichtigte Dateien vorhanden\n"

Loses the %s (which is used for advice).

> +#, c-format
> +msgid "unexpected diff status %c"
> +msgstr "unerwarteter Diff-Status %s"

Changes the format type.

[way earlier, and same goes for "by us" -> "hier" [lit. "here"]]
> +msgid "deleted by them:"
> +msgstr "dort gel=F6scht:"
[lit. "deleted there"]
> +
[...]
> +#, c-format
> +msgid "behind %d] "
> +msgstr "nur dort %d] "
[lit. "only there"]

This had me pause for a moment.  The concepts of "[merge side] theirs"
and "behind" are quite different; is it a good idea to translate these
to the same?

Especially so since later on you translate

> +#, c-format
> +msgid "path '%s' does not have our version"
> +msgstr "Pfad '%s' hat keine Version 'von uns' im Index"
[lit. "... 'of us' ..."]

I do agree that the best I can come up with, "von den anderen
gel=F6scht", would be quite awkward.

> +msgid "You are on a branch yet to be born"
> +msgstr "Der aktive Branch ist noch nicht angelegt"

ISTR you asked about this on IRC, very nice solution.

> +msgid "--patch is incompatible with all other options"
> +msgstr "--patch vertr=E4gt sich nicht mit allen anderen Optionen"

Nit: "... den restlichen Optionen" would be less ambiguous as to how
many of them you can give until it conflicts with --patch.

> +#, c-format
> +msgid "Remote branch %s not found in upstream %s, using HEAD instead=
"
> +msgstr ""
> +"Remote-branch %s nicht in Ursprung %s gefunden, benutze stattdessen=
 HEAD"
["Ursprung" is literally "origin"]

This also has a slight danger of confusion with the canonical upstream
'origin'.

> +#, c-format
> +msgid ""
> +" Lines starting\n"
> +"# with '#' will be kept; you may remove them yourself if you want t=
o.\n"
> +"# An empty message aborts the commit.\n"
> +msgstr ""
> +" Zeilen, die mit '#'\n"
> +"# anfangen, werden beibehalten; du kannst sie selbst entfernen, wen=
n du\n"
> +"willst. Ein leerer Kommentar bricht den Commit ab.\n"

The last line lacks a #.

> +msgid "Explicit paths specified without -i nor -o; assuming --only p=
aths..."
> +msgstr ""
> +"Pfade angegeben ohne ausdr=FCckliches -i oder -o angegeben, ich neh=
me -o an..."

There's a stray "angegeben".

> +# FIXME: ich hab keine Ahnung, worum es hier geht
> +#, c-format
> +msgid "'%s': short read %s"
> +msgstr "'%s': short read %s"

Judging from the code, the file size changed between lstat() and
read_in_full(), and/or read() failed to read the end of the file.
Maybe "unvollst=E4ndig gelesen".

> +msgid "You cannot combine --no-ff with --ff-only."
> +msgstr "Du kannst --no-ff nicht mit --ff-only kombinieren (wirklich =
wahr)."

:-)

> +#, c-format
> +msgid "%s - not something we can merge"
> +msgstr "%s ist etwas, das wir nicht mergen k=F6nnen"

That's the message you get if you say "git merge nonexistent" in an
unborn branch, so the implication (in the German version) that %s
exists is not accurate.  Maybe "Ich kann mit %s nichts anfangen" or
"%s taugt nicht f=FCr einen Merge"?

> +msgid "Fast-forward"
> +msgstr "Update ohne Merge"

Clever!

> +#, c-format
> +msgid "Pushing to %s\n"
> +msgstr "=DCbertrag zu %s\n"

"=DCbertrage"?

[probably out of order, I found it while compiling the glossary]
> +msgid "detached HEAD"
> +msgstr "von HEAD abgetrennt"

That's not strictly speaking true; HEAD always points to a commit
except in an unborn branch, and in any case (this is from commit.c)
points to a commit after this message is output.  You could try
"abgetrennter HEAD", "entkoppelter HEAD" or so...

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
