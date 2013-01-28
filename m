From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] l10n: de.po: translate 11 new messages
Date: Mon, 28 Jan 2013 11:33:09 +0100
Message-ID: <87sj5l38d6.fsf@pctrast.inf.ethz.ch>
References: <1359353699-3987-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <jk@jk.gs>, <stimming@tuhh.de>, <git@vger.kernel.org>
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 11:33:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tzm1w-0007Il-EG
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 11:33:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755018Ab3A1KdO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jan 2013 05:33:14 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:43732 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751773Ab3A1KdM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Jan 2013 05:33:12 -0500
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 28 Jan
 2013 11:33:09 +0100
Received: from pctrast.inf.ethz.ch.ethz.ch (129.132.153.233) by
 CAS22.d.ethz.ch (172.31.51.112) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Mon, 28 Jan 2013 11:33:09 +0100
In-Reply-To: <1359353699-3987-1-git-send-email-ralf.thielow@gmail.com> (Ralf
	Thielow's message of "Mon, 28 Jan 2013 07:14:59 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214826>

Ralf Thielow <ralf.thielow@gmail.com> writes:

> Translate 11 new messages came from git.pot update
> in 46bc403 (l10n: Update git.pot (11 new, 7 removed
> messages)).

>  #: builtin/log.c:104
>  msgid "Use mail map file"
> -msgstr ""
> +msgstr "verwendet \"mailmap\"-Datei"

Note that case differs here, but it's the English one that doesn't fit
the pattern -- option descriptions usually start with lowercase.

>  #: builtin/reset.c:275
> -#, fuzzy, c-format
> +#, c-format
>  msgid "Failed to resolve '%s' as a valid revision."
> -msgstr "Konnte '%s' nicht als g=C3=BCltige Referenz aufl=C3=B6sen."
> +msgstr "Konnte '%s' nicht als g=C3=BCltige Revision aufl=C3=B6sen."

You don't have "revision" in the glossary[1] yet.  Wouldn't it be
appropriate to treat it as "commit", and translate as "Version" to avoi=
d
introducing yet another term?

Or am I missing some subtle distinction between commit and revision?

Since it's only a single nit, feel free to add my ack when you reroll:

Acked-by: Thomas Rast <trast@inf.ethz.ch>


[1] https://github.com/ralfth/git-po-de/wiki/Glossary

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
