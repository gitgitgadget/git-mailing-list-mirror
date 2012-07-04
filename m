From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [RFC] l10n: de.po: translate 29 new messages
Date: Wed, 4 Jul 2012 09:20:40 +0200
Message-ID: <CAN0XMO+R3+JiuHSZ0O46py2WbXVh8D2Z+f7t_xofsN6ZrFwnQQ@mail.gmail.com>
References: <1341335086-6767-1-git-send-email-ralf.thielow@gmail.com>
	<2021839.rMjHRWft8I@cs-pc>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: trast@student.ethz.ch, jk@jk.gs, worldhello.net@gmail.com,
	git@vger.kernel.org
To: Christian Stimming <stimming@tuhh.de>
X-From: git-owner@vger.kernel.org Wed Jul 04 09:20:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmJtH-0003gf-FY
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jul 2012 09:20:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755961Ab2GDHUn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Jul 2012 03:20:43 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:60614 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755765Ab2GDHUm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Jul 2012 03:20:42 -0400
Received: by wgbdr13 with SMTP id dr13so7066337wgb.1
        for <git@vger.kernel.org>; Wed, 04 Jul 2012 00:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=CbirjVHFnP3QhJtYor7DmgScHo6PA7fEw2tNfkcqCGo=;
        b=H0VUjS4KxNVX3cIkXTUVsuosNU0GqMnOfgdZz7irGu8hA4qrJ7LnYpEjUxZdw0F0A0
         1yNQYcCezlV4QRhSE00LtT4zQ8Wb6iPP1yScWnD0rDwVGqT6Js+w7e9Nct96iXO4+tdP
         rEUIk5+p0+MSx9etaBm/g7MtxLi0OO2l9bKNENltSd3r4+dXxXqv9EyPrbQoO64JA0px
         WstiaLLIPgsiFSicvxhqb6ZdKFcvD8oHemJRfTTxC36NROv2ZbXVWKleNcD1ZS0TNgc/
         FcSUhnMMaXIMiOGajg5hwFdeiIGxoG0NI3Yr97bCQmeCwqrcFKkzg+09U0ZNG4BEjTPH
         6K1g==
Received: by 10.180.95.135 with SMTP id dk7mr37962859wib.14.1341386441002;
 Wed, 04 Jul 2012 00:20:41 -0700 (PDT)
Received: by 10.194.7.8 with HTTP; Wed, 4 Jul 2012 00:20:40 -0700 (PDT)
In-Reply-To: <2021839.rMjHRWft8I@cs-pc>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200989>

Hi Christian,

thanks for your review.

On Tue, Jul 3, 2012 at 10:03 PM, Christian Stimming <stimming@tuhh.de> =
wrote:
> Hi Ralf,

> Am Dienstag, 3. Juli 2012, 19:04:46 schrieb Ralf Thielow:
>>  #: wt-status.c:874 wt-status.c:884
>> -#, fuzzy
>>  msgid "You are currently rebasing."
>> -msgstr "Du befindest dich auf keinem Zweig."
>> +msgstr "Du bist gerade beim Neuaufbau."
>
> Is "rebase" =3D "Neuaufbau"? My last thought on this wording was "reb=
ase" =3D
> "Umpflanzen".

According to the current state of the glossary on GitHub, "rebase" as a
verb is translated as "neu aufbauen". There are already translations us=
ing
this. For example:

#: builtin/remote.c:998
#, c-format
msgid "rebases onto remote %s"
msgstr "baut neu auf externen Zweig %s auf"

In this translation, "rebase" is used as a noun for the very first time=
=2E
So, I simply translate it with "Neuaufbau". In fact, we can use differe=
nt
translations for verbs and nouns. Not really sure whether we should do =
this
for "rebase".

Using "Umpflanzen" for "rebase" as a noun, would result in
msgstr "Du bist gerade beim Umplanzen."
Using "Umplanzen" was a verb, would result in
msgstr "Du planzt gerade um."

=46or me, "Umpflanzen" sounds a bit like "working with plants
in the garden". I do not have a strong opinion on this, though.

Are there thoughts from others?

>>  #: wt-status.c:889
>>  msgid "You are currently splitting a commit during a rebase."
>> -msgstr ""
>> +msgstr "Du teilst gerade eine Version w=C3=A4hrend eines Neuaufbaus=
 auf."
>
> Maybe
> "Du teilst gerade eine Version auf w=C3=A4hrend eines Neuaufbaus."
>

I don't think that this is grammatically correct.

>>  #: wt-status.c:909
>>  msgid "You are currently cherry-picking."
>> -msgstr ""
>> +msgstr "Du f=C3=BChrst gerade \"cherry-pick\" aus."
>
> I thought "cherry-pick" =3D "pfl=C3=BCcken", or is there a different =
glossary choice?

At the moment we do not have a translation for "cherry-pick" in the glo=
ssary.
In older parts of the translation we left it as it is, and I prefer to
follow this
for now. If we decide to translate it, we should do this in the whole
translation.
I've added your suggestion to the glossary.

Thanks,
Ralf
