From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] l10n: de.po: fix some minor issues
Date: Mon, 21 Jan 2013 20:21:58 +0100
Message-ID: <87622ql4tl.fsf@pctrast.inf.ethz.ch>
References: <1358794945-4254-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <jk@jk.gs>, <stimming@tuhh.de>, <git@vger.kernel.org>
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 21 20:22:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxMwt-0006SF-Ip
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 20:22:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756113Ab3AUTWE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Jan 2013 14:22:04 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:50743 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755704Ab3AUTWD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2013 14:22:03 -0500
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 21 Jan
 2013 20:21:56 +0100
Received: from pctrast.inf.ethz.ch.ethz.ch (129.132.208.154) by
 CAS22.d.ethz.ch (172.31.51.112) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Mon, 21 Jan 2013 20:21:59 +0100
In-Reply-To: <1358794945-4254-1-git-send-email-ralf.thielow@gmail.com> (Ralf
	Thielow's message of "Mon, 21 Jan 2013 20:02:25 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.208.154]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214150>

Ralf Thielow <ralf.thielow@gmail.com> writes:

> This fixes some minor issues and improves the
> German translation a bit. The following things
> were changed:
> - use complete sentences in option related messages
> - translate "use" consistently as "verwendet"
> - don't translate "make sense" as "macht Sinn"
>
> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>

It would be easier on the reviewers if you could split out such
search&replace changes as s/benutzt/verwendet/ into a separate patch.

I'm not sure though which one would be more error-prone.  As it stands,
it's very tiring to review because of the very similar s/// changes, an=
d
I am unlikely to spot any other change or mistake in a message that
undergoes the substitution.  With my proposal, I'd just skip reviewing
the s/// patch :-)

[No, don't change it for this patch; not worth the splitting effort.]

>  #: builtin/checkout.c:964
>  msgid "paths cannot be used with switching branches"
> -msgstr "Pfade k=C3=B6nnen nicht mit dem Wechseln von Zweigen benutzt=
 werden"
> +msgstr "Pfade k=C3=B6nnen nicht mit dem Wechseln von Zweigen verwend=
et werden"
> =20
>  #: builtin/checkout.c:967 builtin/checkout.c:971
>  #, c-format
>  msgid "'%s' cannot be used with switching branches"
> -msgstr "'%s' kann nicht mit dem Wechseln von Zweigen benutzt werden"
> +msgstr "'%s' kann nicht mit dem Wechseln von Zweigen verwendet werde=
n"

Not new, but they sound a bit strange to me.  Perhaps "kann nicht *beim=
*
Wechseln von Zweigen verwendet werden"?

>  #: builtin/clone.c:734
>  #, c-format
> @@ -3293,7 +3297,7 @@ msgstr "Abstand zwischen Spalten"
> =20
>  #: builtin/column.c:51
>  msgid "--command must be the first argument"
> -msgstr "Option --command muss zuerst angegeben werden"
> +msgstr "Die Option --command muss zuerst angegeben werden."

Not new either, but also took a second reading.  Maybe "muss an erster
Stelle stehen"?

>  #: builtin/describe.c:482
>  msgid "--dirty is incompatible with committishes"
> -msgstr "--dirty ist inkompatibel mit Versionen"
> +msgstr "Die Option --dirty ist inkompatibel mit Versionen."

I think in this case it would sound nicer if you used the "Die Option
--dirty kann nicht mit Versionen verwendet werden" pattern instead of
the "inkompatibel" one.

>  #: builtin/grep.c:866
>  msgid "--open-files-in-pager only works on the worktree"
> -msgstr "--open-files-in-pager arbeitet nur innerhalb des Arbeitsbaum=
s"
> +msgstr "Die Option --open-files-in-pager kann nur innerhalb des "
> +"Arbeitsbaums."

=2E.. " verwendet werden"!

>  #: builtin/grep.c:897
>  msgid "--[no-]exclude-standard cannot be used for tracked contents."
> -msgstr ""
> -"--[no-]exlude-standard kann nicht mit beobachteten Inhalten benutzt=
 werden"
> +msgstr "Die Option --[no-]exlude-standard kann nicht mit beobachtete=
n "
> +"Inhalten verwendet werden."

Typo in --no-exClude-standard.  (It was in the old version, too.)

>  #: builtin/log.c:1218
>  msgid "--name-only does not make sense"
> -msgstr "--name-only macht keinen Sinn"
> +msgstr "Die Option --name-only kann nicht verwendet werden."

If you were curious as to the point of the message (even in English):
it's only triggered by format-patch.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
