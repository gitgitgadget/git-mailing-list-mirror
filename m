From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCHv2 3/3] l10n: de.po: switch from pure German to German+English (part 3)
Date: Mon, 15 Jul 2013 23:53:49 +0200
Message-ID: <877ggr1ocy.fsf@hexa.v.cablecom.net>
References: <1371057331-3917-1-git-send-email-ralf.thielow@gmail.com>
	<1373478890-8480-1-git-send-email-ralf.thielow@gmail.com>
	<1373478890-8480-2-git-send-email-ralf.thielow@gmail.com>
	<1373478890-8480-3-git-send-email-ralf.thielow@gmail.com>
	<1373478890-8480-4-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <trast@student.ethz.ch>, <jk@jk.gs>, <stimming@tuhh.de>,
	<git@vger.kernel.org>
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 15 23:53:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyqiU-0007di-0V
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 23:53:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758128Ab3GOVxw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Jul 2013 17:53:52 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:32956 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758116Ab3GOVxv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Jul 2013 17:53:51 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 15 Jul
 2013 23:53:49 +0200
Received: from hexa.v.cablecom.net.ethz.ch (46.126.8.85) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 15 Jul
 2013 23:53:50 +0200
In-Reply-To: <1373478890-8480-4-git-send-email-ralf.thielow@gmail.com> (Ralf
	Thielow's message of "Wed, 10 Jul 2013 19:54:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230528>

Ralf Thielow <ralf.thielow@gmail.com> writes:

>  #: builtin/remote.c:187
>  msgid "specifying branches to track makes sense only with fetch mirr=
ors"
>  msgstr ""
> -"Die Angabe von zu folgenden Zweigen kann nur mit dem Anfordern von =
"
> +"Die Angabe von zu folgenden Branches kann nur mit dem Anfordern von=
 "
>  "Spiegelarchiven verwendet werden."

Spiegelarchiv -> Spiegel-Repository

> @@ -8058,18 +8057,18 @@ msgid_plural ""
>  "Note: Some branches outside the refs/remotes/ hierarchy were not re=
moved;\n"
>  "to delete them, use:"
>  msgstr[0] ""
> -"Hinweis: Ein Zweig au=C3=9Ferhalb der /refs/remotes/ Hierachie wurd=
e nicht "
> +"Hinweis: Ein Branch au=C3=9Ferhalb der /refs/remotes/ Hierachie wur=
de nicht "
>  "gel=C3=B6scht;\n"
>  "um diesen zu l=C3=B6schen, benutzen Sie:"
>  msgstr[1] ""
> -"Hinweis: Einige Zweige au=C3=9Fer der /refs/remotes/ Hierarchie wur=
den nicht "
> +"Hinweis: Einige Branches au=C3=9Fer der /refs/remotes/ Hierarchie w=
urden nicht "
>  "entfernt;\n"
>  "um diese zu entfernen, benutzen Sie:"

Not new, but refs/remotes/ probably shouldn't have a leading slash (at
least that's the convention in English).

>  #: builtin/remote.c:998
>  #, c-format
>  msgid "rebases onto remote %s"
> -msgstr "baut neu auf externen Zweig %s auf"
> +msgstr "baut neu auf Remote-Branch %s auf"

In the glossary you have

    rebase       =3D "rebase" benutzen
    rebase       =3D Rebase

So "neuaufbauen" seems to be out?

>  #: builtin/show-branch.c:675
>  msgid "show commits where no parent comes before its children"
> -msgstr "zeigt Versionen, wo kein Elternteil vor seinem Kind kommt"
> +msgstr "zeigt Commits, wo kein Eltern-Commit vor seinem Kind-Commit =
kommt"

Not specific to the German versions, but the "where" should really be
"in such a way", e.g. simply "so dass".

> @@ -8871,23 +8869,23 @@ msgid ""
>  "git tag [-a|-s|-u <key-id>] [-f] [-m <msg>|-F <file>] <tagname> [<h=
ead>]"
>  msgstr ""
>  "git tag [-a|-s|-u <Schl=C3=BCssel-id>] [-f] [-m <Nachricht>|-F <Dat=
ei>] "
> -"<Markierungsname> [<Zweig>]"
> +"<Tagname> [<Branch>]"

Not new, but <head> here should be <Commit>.

(Yes I know, it can even be another object type.  Let's not confuse the
users.)

> @@ -9735,8 +9731,8 @@ msgstr ""
>  #: git-pull.sh:203
>  msgid "updating an unborn branch with changes added to the index"
>  msgstr ""
> -"Aktualisiere eine ungeborenen Zweig mit =C3=84nderungen, die zur Be=
reitstellung "
> -"hinzugef=C3=BCgt wurden"
> +"Aktualisiere eine ungeborenen Branch mit =C3=84nderungen, die zum C=
ommit "
> +"vorgemerkt sind"

Gender mismatch in "eine ungeborenen".

>  #: git-submodule.sh:744
>  #, sh-format
>  msgid "Unable to find current revision in submodule path '$prefix$sm=
_path'"
>  msgstr ""
> -"Konnte aktuelle Revision in Unterprojekt-Pfad '$prefix$sm_path' nic=
ht finden."
> +"Konnte aktuelle Revision in Submodul-Pfad '$prefix$sm_path' nicht f=
inden."

Revision -> Commit as per the glossary?

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
