From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH] l10n: de.po: translate 27 new messages
Date: Sat, 08 Feb 2014 19:39:08 +0100
Message-ID: <877g95motv.fsf@thomasrast.ch>
References: <1390511452-6553-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jk@jk.gs, stimming@tuhh.de, git@vger.kernel.org,
	worldhello.net@gmail.com
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 08 19:39:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCCoK-0005xv-1r
	for gcvg-git-2@plane.gmane.org; Sat, 08 Feb 2014 19:39:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752062AbaBHSjY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Feb 2014 13:39:24 -0500
Received: from ip1.thgersdorf.net ([148.251.9.194]:34131 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751991AbaBHSjX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Feb 2014 13:39:23 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 937F04D656A;
	Sat,  8 Feb 2014 19:39:19 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Dg2PCcmX6GTK; Sat,  8 Feb 2014 19:39:09 +0100 (CET)
Received: from linux-1gf2.thomasrast.ch (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 4248D4D64BD;
	Sat,  8 Feb 2014 19:39:09 +0100 (CET)
In-Reply-To: <1390511452-6553-1-git-send-email-ralf.thielow@gmail.com> (Ralf
	Thielow's message of "Thu, 23 Jan 2014 22:10:52 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241841>

I see you are defining new glossary terms:

  shallow     unvollst=C3=A4ndig
  grafted     gesondert eingeh=C3=A4ngt

I guess the first one is reasonable if we don't call anything
"incomplete"?  (I don't think we do, just checking.)

I don't really like 'gesondert eingeh=C3=A4ngt', how about 'transplanti=
ert'
instead?  Or just say graft=3DGraft and use 'mit Grafts' or some simila=
r
workaround, since it is a highly specialized term.


Ralf Thielow <ralf.thielow@gmail.com> writes:

>  #: diff.c:113
>  #, c-format
> @@ -975,21 +975,23 @@ msgid ""
>  "There is nothing to exclude from by :(exclude) patterns.\n"
>  "Perhaps you forgot to add either ':/' or '.' ?"
>  msgstr ""
> +"Es gibt nichts, was durch :(exclude) Muster ausgeschlossen wird.\n"
> +"Vielleicht haben Sie vergessen entweder ':/' oder '.' hinzuzuf=C3=BC=
gen?"

Doesn't sound right -- the original seems to describe the situation
where you are using :(exclude) without any non-excluded paths, whereas
the German first sentence sounds like you are using :(exclude) when it
doesn't match any paths.

Perhaps it works if translated very liberally:

":(exclude) Muster, aber keine anderen Pfadspezifikationen angegeben.\n=
"
"Vielleicht haben Sie vergessen entweder ':/' oder '.' hinzuzuf=C3=BCge=
n?"

>  #: remote.c:753
> -#, fuzzy, c-format
> +#, c-format
>  msgid "Cannot fetch both %s and %s to %s"
> -msgstr "Kann keine Commit-Beschreibung f=C3=BCr %s bekommen"
> +msgstr "Kann 'fetch' nicht f=C3=BCr %s und %s nach %s ausf=C3=BChren=
=2E"
[...]
>  #: remote.c:761
>  #, c-format
>  msgid "%s tracks both %s and %s"
> -msgstr ""
> +msgstr "%s folgt %s und %s"

In both of these the key point is "both".  Perhaps use "sowohl... als
auch".

>  #: wt-status.c:275
> -#, fuzzy
>  msgid "new file"
> -msgstr "neue Datei:   %s"
> +msgstr "neue Datei:"
[...]
>  #: wt-status.c:285
> -#, fuzzy
>  msgid "typechange"
> -msgstr "Typ=C3=A4nderung: %s"
> +msgstr "Typ=C3=A4nderung:"
> =20
>  #: wt-status.c:287
> -#, fuzzy
>  msgid "unknown"
> -msgstr "unbekannt:    %s"
> +msgstr "unbekannt:"

Do we still need the trailing colon?

--=20
Thomas Rast
tr@thomasrast.ch
