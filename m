From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [RFC/PATCH] l10n: de.po: translate 825 new messages
Date: Fri, 30 Nov 2012 00:02:57 +0100
Message-ID: <87ehjcj9lq.fsf@pctrast.inf.ethz.ch>
References: <1349200849-7436-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>, <trast@student.ethz.ch>, <jk@jk.gs>,
	<stimming@tuhh.de>
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 30 00:03:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TeD8s-0008EH-9C
	for gcvg-git-2@plane.gmane.org; Fri, 30 Nov 2012 00:03:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754807Ab2K2XDD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Nov 2012 18:03:03 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:46747 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753217Ab2K2XDB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Nov 2012 18:03:01 -0500
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 30 Nov
 2012 00:02:55 +0100
Received: from pctrast.inf.ethz.ch.ethz.ch (46.126.8.85) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 30 Nov
 2012 00:02:57 +0100
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210881>

Hi Ralf

Here is the final third of my review.

>  #: builtin/prune-packed.c:7
>  msgid "git prune-packed [-n|--dry-run] [-q|--quiet]"
> -msgstr ""
> +msgstr "git prune-packed [-n|--dry-run] [-q|--quite]"
                                                 ^^^^^
typo at the far end

>  #: builtin/prune.c:133
> -#, fuzzy
>  msgid "report pruned objects"
> -msgstr "kann Objekt %s nicht lesen"
> +msgstr "meldet entfernte Objekte"

If you translate "pruned" as "gel=C3=B6scht" or some such, that avoids =
the
ambiguity with "remote".

>  #: builtin/prune.c:136
>  msgid "expire objects older than <time>"
> -msgstr ""
> +msgstr "l=C3=A4sst Objekte =C3=A4lter als <Zeit> verfallen"

"verfallen" is nice!

>  #: builtin/push.c:391
>  msgid "check"
> -msgstr ""
> +msgstr "=C3=9Cberpr=C3=BCfung"

I think the original string should not be translatable to begin with.
The manpage says

  --recurse-submodules=3Dcheck|on-demand
      Make sure all submodule commits used by the revisions to be pushe=
d
      are available on a remote tracking branch. If *check* is used git
      will verify that all submodule commits that changed in the
      revisions to be pushed are available on at least one remote of th=
e
      submodule. If any commits are missing the push will be aborted an=
d
      exit with non-zero status. If *on-demand* is used all submodules
      that changed in the revisions to be pushed will be pushed. If
      on-demand was not able to push all necessary revisions it will
      also be aborted and exit with non-zero status.

So 'check' is not translatable.

>  #: builtin/push.c:395 builtin/push.c:396
>  msgid "receive pack program"
> -msgstr ""
> +msgstr "Programm zum Empfangen von Paketen"

Or perhaps "'receive-pack' Programm".

>  #: builtin/read-tree.c:111
> -#, fuzzy
>  msgid "only empty the index"
> -msgstr "Konnte die Bereitstellung nicht lesen"
> +msgstr "leert nur die Bereitstellung"

"Only" here means it doesn't read-a-tree, but empty the index.  So
dropping the "nur" would probably be better.

  #: builtin/remote.c:11
>  msgid "git remote [-v | --verbose]"
> -msgstr ""
> +msgstr "git remove [-v | --verbose]"
                  ^^^
typo

>  #: builtin/remote.c:173
>  msgid "set up remote as a mirror to push to or fetch from"
>  msgstr ""
> +"Aufsetzen der Fernarchivs als Spiegelarchiv zum Versenden und Anfor=
dern"
              ^^^
des?

>  "Run \"git rev-parse --parseopt -h\" for more information on the fir=
st usage."
>  msgstr ""
> +"git rev-parse --parseopt [Optionen] -- [<Argumente>...]\n"
> +"   or: git rev-parse --sq-quote [<Argumente>...]\n"
> +"   or: git rev-parse [Optionen] [<Argumente>...]\n"
> +"\n"
> +"F=C3=BChre \"git rev-parse --parseopt -h\" f=C3=BCr weitere Informa=
tionen bei erster "
> +"Verwendung aus."

Should use 'oder:' in the case split, shouldn't it?

>  #: builtin/rm.c:134
> -#, fuzzy
>  msgid "do not list removed files"
> -msgstr "Kann ge=C3=A4nderte Dateien nicht aus der Bereitstellung her=
ausnehmen"
> +msgstr "listet keine entfernten Dateien auf"

Again removed->gel=C3=B6scht or some such avoids an ambiguity.

>  #: builtin/show-branch.c:651
> -#, fuzzy
>  msgid "show remote-tracking and local branches"
> -msgstr "Kein externer =C3=9Cbernahmezweig f=C3=BCr %s von %s"
> +msgstr "zeigt externer =C3=9Cbernahmezweige und lokale Zweige an"
                      ^^^
[...]
>  #: builtin/show-branch.c:653
> -#, fuzzy
>  msgid "show remote-tracking branches"
> -msgstr "Kein externer =C3=9Cbernahmezweig f=C3=BCr %s von %s"
> +msgstr "zeigt externer =C3=9Cbernahmezweige an"
                      ^^^

extern*e*

>  #: builtin/tag.c:464
> -#, fuzzy
>  msgid "use another key to sign the tag"
> -msgstr "konnte Markierung nicht signieren"
> +msgstr "benutzt einen Schl=C3=BCssel um die Markierung zu signieren"

The original says *another* -- maybe

  benutzt einen anderen Schl=C3=BCssel um die Markierung zu signieren

>  #: builtin/update-index.c:750
>  msgid "mark files as \"not changing\""
> -msgstr ""
> +msgstr "markiert Dateien als \"not changing\""

Neither original nor translation are very helpful.  Maybe

  Always assume this file to be unchanged
  Betrachte diese Datei immer als unver=C3=A4ndert

>  #: builtin/update-index.c:756
>  msgid "mark files as \"index-only\""
> -msgstr ""
> +msgstr "markiert Dateien als \"index-only\""

Likewise, but here I don't even understand what the manpage is trying t=
o
tell me, in particular I don't see how it would be different from
assume-unchanged.  Maybe "see manpage" would be the best documentation.

>  #: builtin/update-index.c:776
>  msgid "repopulate stages #2 and #3 for the listed paths"
>  msgstr ""
> +"wiederholte Ausf=C3=BChrung der Phasen #2 und #3 f=C3=BCr die aufge=
listeten Pfade"

ISTR we settled on something for 'stage', but it's not in the glossary.
Either way I don't think this is it.  "Ausf=C3=BChrung der Phasen" woul=
d mean
that it's some part of a process, whereas the stages are a state.


Yay, that's it.  Even in three parts it was tedious, and I cannot begin
to imagine what *writing* 825 new translations must have felt like.
Thanks for your work!

- Thomas

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
