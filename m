From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC/PATCH] l10n: de.po: translate 825 new messages
Date: Mon, 03 Dec 2012 15:59:36 +0100
Message-ID: <50BCBE58.30805@drmicha.warpmail.net>
References: <87ehjcj9lq.fsf@pctrast.inf.ethz.ch> <1354510131-2881-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: trast@inf.ethz.ch, git@drmicha.warpmail.net, git@vger.kernel.org,
	jk@jk.gs, stimming@tuhh.de
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 03 16:00:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TfXUx-0003wh-Q7
	for gcvg-git-2@plane.gmane.org; Mon, 03 Dec 2012 15:59:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752992Ab2LCO7m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Dec 2012 09:59:42 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:55269 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753142Ab2LCO7j (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Dec 2012 09:59:39 -0500
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id D9C1E20D05;
	Mon,  3 Dec 2012 09:59:37 -0500 (EST)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute5.internal (MEProxy); Mon, 03 Dec 2012 09:59:37 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=RGP3YQ0woB/MjV7GJ0a5kc
	+KqOs=; b=DNvs9bMj2gQSPi8GDgiuJLHL59Aw1mBsqiAL5zfPBU7/lM1fBe8v2J
	VfGDzbJOKRJGfGLiYPLskhpL9yasayPJtsPxwlB8ym9PX5FhIOmGfukh2qwPnCck
	t7JYJ9omNwu0FmfppScdhHbItdFLCtTOdYvIRY/WA9tRdh8o58XaE=
X-Sasl-enc: DSPfCmAMcByfTn0CBnHJ3mlDrGQ1fyPG8BMH07w8WLdy 1354546777
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id DF0A24827D0;
	Mon,  3 Dec 2012 09:59:36 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <1354510131-2881-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211039>

Ralf Thielow venit, vidit, dixit 03.12.2012 05:48:
> Thanks Thomas and Michael!
>=20
> 2012/11/30 Thomas Rast <trast@inf.ethz.ch>:
>=20
>>>  #: builtin/update-index.c:756
>>>  msgid "mark files as \"index-only\""
>>> -msgstr ""
>>> +msgstr "markiert Dateien als \"index-only\""
>>
>> Likewise, but here I don't even understand what the manpage is tryin=
g to
>> tell me, in particular I don't see how it would be different from
>> assume-unchanged.  Maybe "see manpage" would be the best documentati=
on.
>=20
> I'm not really sure what to do with it. In this version (see below) I=
 kept
> it. Did you mean we should add "(siehe Hilfeseite)" or something in t=
he
> translation, or does it belong to the original message and the transl=
ation
> would just follow?
>

I'd say the translation above is fine, and no matter what language the
user messages are in, the user would have to consult the man page for
this very special feature, but I don't think we have to say so explicit=
ly.

>>> +"wiederholte Ausf=C3=BChrung der Phasen #2 und #3 f=C3=BCr die auf=
gelisteten Pfade"
>>
>> ISTR we settled on something for 'stage', but it's not in the glossa=
ry.
>> Either way I don't think this is it.  "Ausf=C3=BChrung der Phasen" w=
ould mean
>> that it's some part of a process, whereas the stages are a state.
>>
> I've changed it to
> "wiederholtes Einpflegen der Zust=C3=A4nde #2 und #3 f=C3=BCr die auf=
gelisteten Pfade"
> What do you think?
>=20
> ---
>  po/de.po | 123 +++++++++++++++++++++++++++++++----------------------=
----------
>  1 file changed, 61 insertions(+), 62 deletions(-)
=2E..
>  #: builtin/fsck.c:620
>  msgid "also consider packs and alternate objects"
> -msgstr "betrachtet auch Pakete und wechselnde Objekte"
> +msgstr ""

Oops ;)

>  #: builtin/push.c:391
>  msgid "check"
> -msgstr "=C3=9Cberpr=C3=BCfung"
> +msgstr ""

Is this meant to omit the text? (I may have missed the pertaining
discussion.)


>  #: builtin/update-index.c:753
>  msgid "clear assumed-unchanged bit"
> @@ -8568,7 +8567,7 @@ msgstr "f=C3=BCgt Eintr=C3=A4ge von der Standar=
d-Eingabe der Bereitstellung hinzu"
>  #: builtin/update-index.c:776
>  msgid "repopulate stages #2 and #3 for the listed paths"
>  msgstr ""
> -"wiederholte Ausf=C3=BChrung der Phasen #2 und #3 f=C3=BCr die aufge=
listeten Pfade"
> +"wiederholtes Einpflegen der Zust=C3=A4nde #2 und #3 f=C3=BCr die au=
fgelisteten Pfade"

I can't seem to find the other occurence in de.po, but state should be
the same as in

"copy out the files from named stage" (checkout-index).

"Zustand" seems to be appropriate.

Cheers,
Michael
