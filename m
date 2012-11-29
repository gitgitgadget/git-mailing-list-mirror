From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC/PATCH] l10n: de.po: translate 825 new messages
Date: Thu, 29 Nov 2012 12:40:00 +0100
Message-ID: <50B74990.5000804@drmicha.warpmail.net>
References: <87wqx7s22j.fsf@pctrast.inf.ethz.ch> <1354126970-5356-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: trast@inf.ethz.ch, git@vger.kernel.org, jk@jk.gs, stimming@tuhh.de
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 12:40:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Te2Tc-0000Ie-PJ
	for gcvg-git-2@plane.gmane.org; Thu, 29 Nov 2012 12:40:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754127Ab2K2LkD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Nov 2012 06:40:03 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:56775 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753626Ab2K2LkC (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Nov 2012 06:40:02 -0500
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 8E52721805;
	Thu, 29 Nov 2012 06:40:01 -0500 (EST)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute4.internal (MEProxy); Thu, 29 Nov 2012 06:40:01 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=XrPL2VVHKt99vBzdYVxadi
	qqkI0=; b=L6kFH+Ny+iyOrFRW7tp1odm8Uj6YVEVS1WWaFjNl1fyy5gm2KzYgAJ
	uSHF6KaCWJ/BaWXDHLgK4UHOhycWmssohdG3kb5zgxi0jtW78NkwKuXFqH6DgRKw
	HG0SKCa3XPBWsqwlhbo5jsXiBAaPncKI1c0UAa7/CcYHzfu+58enc=
X-Sasl-enc: WUhmXDD7UTJPzgCCvEjRRBYwdpIx4AH6kjdTb9CjJCT0 1354189201
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id B23F98E05B2;
	Thu, 29 Nov 2012 06:40:00 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <1354126970-5356-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210828>

Ralf Thielow venit, vidit, dixit 28.11.2012 19:22:
>> Hi Ralf,
>>
>> This is the middle third of my review.  Sorry for the long wait!  I =
hope
>> it can still be useful.
>>
>=20
> Hi Thomas,
>=20
> no problem. Thanks for your review. Of course it's very useful.
> Some of the mistakes I made are so obvious that I can't say what
> I've had in mind when translation these messages :/ But some aren't,
> so thanks for the further explanations within your review.
>=20
>> I don't really share your apparent aversion to just using "<n>" :-)
> I don't really have one :) so I'm fine with using <n>.
>=20
>> This would be a good time to settle on a good translation for
>> "rewriting".  Perhaps "neu schreiben".  "=C3=9Cberschreiben" to me i=
mplies
> On some other places we actually use "neu schreiben".

How about "umschreiben"? "neu schreiben" is more like "write from
scratch", whereas "rewrite" is more often about taking a given base and
modifying it.

>>> -msgstr ""
>>> +msgstr "erzeugt kleinere Pakete"
>>
>> Smaller is not really the point: they are packs that do not have the
> [...]
>> You could call them "abgespeckt" ;-)
> I used "d=C3=BCnner"!?
>=20
> Furthermore I've unified the translation of "email" to "Email",
> not "eMail". You'll see the result below. I hope I haven't missed
> something.
>=20
> Thanks,
> Ralf
>=20
> ---
>  po/de.po | 95 ++++++++++++++++++++++++++++++++----------------------=
----------
>  1 file changed, 47 insertions(+), 48 deletions(-)
>=20
> diff --git a/po/de.po b/po/de.po
> index fe6e8cf..1a75ea2 100644
> --- a/po/de.po
> +++ b/po/de.po
=2E..
>  #: builtin/fsck.c:608
>  msgid "git fsck [options] [<object>...]"
> @@ -4521,7 +4521,7 @@ msgstr "erzeugt Kopfknoten des Referenzprotokol=
ls (Standard)"
> =20
>  #: builtin/fsck.c:620
>  msgid "also consider packs and alternate objects"
> -msgstr "betrachtet auch Pakete und wechselnde Objekte"
> +msgstr ""

"alternate objects" (hopefully) don't change much, so that "wechselnde"
is misleading.

Is there a set translation standard for the "alternative object store"
mechanism in git (alternates)? Otherwise "alternative Objekte" may be
choice which is close to the original and conveys the aspect that they
are objects from an alternative store.


>  #: builtin/grep.c:817
>  msgid "indicate hit with exit status without output"
> -msgstr "kennzeichnet =C3=9Cbereinstimmungen mit Beendigungsstatus, o=
hne Ausgabe"
> +msgstr "zeigt =C3=9Cbereinstimmungen mit Beendigungsstatus, ohne Aus=
gabe"

maybe "zeigt =C3=9Cbereinstimmungen nur durch Beendigungsstatus an"

"mit" sounds like "including", "additionally". Also, nothing is shown
("zeigt"), but something is indicated ("zeigt an").


>  #: builtin/log.c:102
>  msgid "decorate options"
> -msgstr "Ausgabeoptionen"
> +msgstr "decorate Optionen"

"decorate-Optionen" (unless we want to match the standard set by the ba=
d
old K&R translation ;) )


>  #: builtin/log.c:1098
>  msgid "add To: header"
> -msgstr "f=C3=BCgt Kopfteil \"To:\" hinzu"
> +msgstr "f=C3=BCgt  \"To:\" Header hinzu"

Here and in the following I'd a "-", e.g.

msgstr "f=C3=BCgt  \"To:\"-Header hinzu"

>  #: builtin/log.c:1100
>  msgid "add Cc: header"
> -msgstr "f=C3=BCgt Kopteil \"Cc:\" hinzu"
> +msgstr "f=C3=BCgt \"Cc:\" Header hinzu"
=2E..
> -"l=C3=A4dt Konfiguration f=C3=BCr <Kommando> beim =C3=9Cberschreiben=
 von Versionen "
> +"l=C3=A4dt Konfiguration f=C3=BCr <Kommando> beim Neuschreiben von V=
ersionen "
>  "(impliziert --stdin)"

"Umschreiben" (if that becomes the agreed upon term for "rewrite").

Just my two Pfennig ;)

Michael
