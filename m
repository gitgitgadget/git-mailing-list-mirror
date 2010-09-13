From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH 2/2] Add Swedish translation.
Date: Mon, 13 Sep 2010 08:15:48 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1009130810580.31516@ds9.cixit.se>
References: <20100912202111.B11522FC00@perkele> <AANLkTikg1vD33f6Rj4UEzsbrUemta6NbRWWH22h2Y0-B@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 13 09:16:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ov3Gg-0005qm-VB
	for gcvg-git-2@lo.gmane.org; Mon, 13 Sep 2010 09:15:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752791Ab0IMHPx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Sep 2010 03:15:53 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:50432 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752377Ab0IMHPx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Sep 2010 03:15:53 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id o8D7Fmor000328
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 13 Sep 2010 09:15:48 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id o8D7FmgA000322;
	Mon, 13 Sep 2010 09:15:48 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <AANLkTikg1vD33f6Rj4UEzsbrUemta6NbRWWH22h2Y0-B@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Mon, 13 Sep 2010 09:15:48 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156071>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:

> * Doesn't follow the "Initializing a .po file" docs in
>   t/README. Here's what you get after applying the little Perl
>   cleanup program there to it:

Well, I just used the standard commands for creating it.

>        @@ -1,54 +1,38 @@
>        -# Swedish translation of git
>        -# Copyright =C2=A9 2010 Peter krefting <peter@softwolves.pp.s=
e>
>        -# Peter Krefting <peter@softwolves.pp.se>, 2010.
>        -#

That's a standard header, which is good to keep for clarity. If we want=
 to=20
go through Translation Project (which I still do recommend), it is requ=
ired.

>        -"PO-Revision-Date: 2010-09-12 21:07+0100\n"

That's a good reference header to see how out-of-date the translation i=
s.

>        -"Last-Translator: Peter Krefting <peter@softwolves.pp.se>\n"
>        -"Language-Team: Swedish <tp-sv@listor.tp-sv.se>\n"

These are standard headers to make it easier to find out who to blame t=
he=20
translation on. I haven't actually submitted my translation for review =
on=20
the Swedish list yet, but will do so soon enough.

>        -#: wt-status.c:56

These context lines are invaluable when figuring out how to translate s=
tuff,=20
and to track back strings after the fact. I do not like the idea of rem=
oving=20
them.

> * Commit message should be "po/sv.po: add Swedish translation". It
>   makes it much easier to `git log --grep=3Dpo/` or `git log
>   --grep=3Dpo/sv.po` in the future.

Git has that information already, no need to put it in the commit messa=
ge :-)

> * You're translating the TEST: messages, it's redundant except for
>   Icelandic (which uses it for git.git tests), but I can see how it
>   can be painful to have non-100% translation coverage.

I just copied them verbatim, I didn't actually translate them. Without=20
translating them I can't tell if I've translated everything when doing =
a=20
"msgfmt -vvv --check sv.po".

--=20
\\// Peter - http://www.softwolves.pp.se/
