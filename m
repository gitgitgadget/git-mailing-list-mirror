From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCHv2 1/3] l10n: de.po: switch from pure German to German+English (part 1)
Date: Mon, 15 Jul 2013 23:53:38 +0200
Message-ID: <87a9ln1od9.fsf@hexa.v.cablecom.net>
References: <1371057331-3917-1-git-send-email-ralf.thielow@gmail.com>
	<1373478890-8480-1-git-send-email-ralf.thielow@gmail.com>
	<1373478890-8480-2-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <trast@student.ethz.ch>, <jk@jk.gs>, <stimming@tuhh.de>,
	<git@vger.kernel.org>
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 15 23:53:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyqiJ-0007Xz-RH
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 23:53:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758114Ab3GOVxn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Jul 2013 17:53:43 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:38705 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758100Ab3GOVxl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Jul 2013 17:53:41 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 15 Jul
 2013 23:53:36 +0200
Received: from hexa.v.cablecom.net.ethz.ch (46.126.8.85) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 15 Jul
 2013 23:53:39 +0200
In-Reply-To: <1373478890-8480-2-git-send-email-ralf.thielow@gmail.com> (Ralf
	Thielow's message of "Wed, 10 Jul 2013 19:54:48 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230526>

Ralf Thielow <ralf.thielow@gmail.com> writes:

>  #: merge-recursive.c:268
>  msgid "error building trees"
> -msgstr "Fehler beim Erstellen der B=C3=A4ume"
> +msgstr "Fehler beim Erstellen der Verzeichnisse"

This should remain "B=C3=A4ume" or possibly '"Tree"-Objekte', as it ref=
ers to
a failure within write_tree_from_memory().

>  #: merge-recursive.c:1815
>  #, c-format
>  msgid "merging of trees %s and %s failed"
> -msgstr "Zusammenf=C3=BChren der B=C3=A4ume %s und %s fehlgeschlagen"
> +msgstr "Zusammenf=C3=BChren der Verzeichnisse %s und %s fehlgeschlag=
en"

Similarly; here merge_trees() is failing.

>  #: pathspec.c:99
>  #, c-format
>  msgid "'%s' is beyond a symbolic link"
> -msgstr "'%s' ist =C3=BCber einem symbolischen Link"
> +msgstr "'%s' ist hinter einem symbolischen Verweis"

Good fix for a pretty bad preimage :-)

>  #: remote.c:1787
>  msgid "  (use \"git push\" to publish your local commits)\n"
> -msgstr "  (benutzen Sie \"git push\" um lokalen Versionen herauszubr=
ingen)\n"
> +msgstr "  (benutzen Sie \"git push\" um lokale Commits herauszubring=
en)\n"

I don't see this in the glossary.  "Publizieren" is a perfectly good
german word, can't we use this?  "Herausbringen" allows some other
interpretations that "publizieren" doesn't.

>  #: sequencer.c:1119
>  msgid "Can't revert as initial commit"
> -msgstr "R=C3=BCcknahme-Version kann nicht initial sein."
> +msgstr "Revert-Commit kann nicht initial sein."

Not a new problem, but how about

  Kann nicht als allerersten Commit einen Revert ausf=C3=BChren.

(This should then go into the glossary for "initial commit".)

>  #: sequencer.c:1120
>  msgid "Can't cherry-pick into empty head"
> -msgstr "Kann \"cherry-pick\" nicht in einem leeren Zweig ausf=C3=BCh=
ren."
> +msgstr "Kann \"cherry-pick\" nicht in einem leeren Branch ausf=C3=BC=
hren."

Could reuse the same formulation as above; the symptom is the same,
though not the English message.

> @@ -1494,7 +1496,7 @@ msgstr "  (alle Konflikte behoben: f=C3=BChren =
Sie \"git commit\" aus)"
>  #: wt-status.c:970
>  #, c-format
>  msgid "You are currently reverting commit %s."
> -msgstr "Sie nehmen gerade Version '%s' zur=C3=BCck."
> +msgstr "Sie nehmen gerade Commit '%s' zur=C3=BCck."

"Revert" is partly untranslated in other messages.  Any strong opinions=
?
If you would like to consistently leave it untranslated, this message
could be

  Sie sind gerade an einem Revert von Commit '%s'.

>  #: builtin/apply.c:3850
>  #, c-format
>  msgid "corrupt patch for subproject %s"
> -msgstr "fehlerhafter Patch f=C3=BCr Unterprojekt %s"
> +msgstr "fehlerhafter Patch f=C3=BCr Submodul %s"

We could change this on the English side too, though the patch format i=
s
frozen and calls them "subprojects" (sigh).

> @@ -2330,12 +2331,12 @@ msgstr "erwartet keinen Kontext"
>  #: builtin/apply.c:4406
>  msgid "leave the rejected hunks in corresponding *.rej files"
>  msgstr ""
> -"hinterl=C3=A4sst zur=C3=BCckgewiesene Patch-Bereiche in den entspre=
chenden *.rej "
> +"hinterl=C3=A4sst zur=C3=BCckgewiesene Patch-Bl=C3=B6cke in den ents=
prechenden *.rej "
>  "Dateien"

Not a new problem, but "in entsprechenden *.rej" (dropping the article)
would be more accurate, wouldn't it?

>  #: builtin/blame.c:2369
>  msgid "Ignore whitespace differences"
> -msgstr "Ignoriert Unterschiede in Leerzeichen"
> +msgstr "Ignoriert Unterschiede in Whitespaces"

  Ignoriert Unterschiede in Whitespace

(dropping the final s)?

I saw that you matched the German gender of the English words to the
gender that your favorite translation has in German, which I think is
fine.  But whitespace is not countable (at least in my ears), and I
think that should be inherited into the pseudo-German usage.

>  #: builtin/branch.c:585
>  #, c-format
>  msgid "(no branch, bisect started on %s)"
> -msgstr "(kein Zweig, Neuaufbau begonnen bei %s)"
> +msgstr "(kein Branch, Rebase begonnen bei %s)"

You turned bisect into rebase (not new, but still).

>  #: builtin/checkout.c:1053
>  msgid "new unparented branch"
> -msgstr "neuer Zweig ohne Elternversion"
> +msgstr "neuer Branch ohne Elternversion"

Elternversions should become Eltern-Commit according to the glossary.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
