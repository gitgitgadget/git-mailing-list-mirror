From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH v4] l10n: de.po: translate 28 new messages
Date: Sat, 8 Feb 2014 21:36:11 +0100
Message-ID: <CAN0XMOKq5gtb2+uhaD=AdfMvH5=vJUhGBY_xyt8gMfCafkouXw@mail.gmail.com>
References: <1391581141-4609-1-git-send-email-ralf.thielow@gmail.com>
	<1391888440-4140-1-git-send-email-ralf.thielow@gmail.com>
	<87r47dbbzt.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Thomas Rast <tr@thomasrast.ch>,
	=?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>,
	Xin Jiang <worldhello.net@gmail.com>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sat Feb 08 21:36:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCEdl-0001c3-6M
	for gcvg-git-2@plane.gmane.org; Sat, 08 Feb 2014 21:36:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbaBHUgN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Feb 2014 15:36:13 -0500
Received: from mail-we0-f182.google.com ([74.125.82.182]:49032 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071AbaBHUgN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Feb 2014 15:36:13 -0500
Received: by mail-we0-f182.google.com with SMTP id u57so3173626wes.41
        for <git@vger.kernel.org>; Sat, 08 Feb 2014 12:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=hO8W1Hb5gMv0mqfnXLxTlmr8qsz+WRlcBFxY62CKQ1Y=;
        b=WCW8qa0I45gnWJg+xAVjWKEp8FVfF0d6buoCeTugxnIrOVmqnRbd22csJZSzH2/79Y
         t3rS2fz8cR8Wg/T1PjcoBCHRlgAYbspK9cF2n8TxWgPSwt+otLJgWHEuTvh0tDi6wknf
         B7a0MK0ew/KWC+JakF9WG2EQ7x7BYBqiRZFRA7ZEo0UQ/6jt+lUFxViPgSrpWkQ1xZn9
         7Uf4LjUuaytZPk9puhCr5kUgZGBHlshO8/JnjOmA0+1XvX24mKOF+7nJsBeRSH2UNp3F
         tYgvactIL4RtAEkz/dktnANUzK+D+bodOFGjvwcOpBfGvDbql1PGJnebmBFg9IZxQZf3
         Y3Gg==
X-Received: by 10.194.142.170 with SMTP id rx10mr15724980wjb.13.1391891771658;
 Sat, 08 Feb 2014 12:36:11 -0800 (PST)
Received: by 10.194.23.1 with HTTP; Sat, 8 Feb 2014 12:36:11 -0800 (PST)
In-Reply-To: <87r47dbbzt.fsf@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241854>

2014-02-08 21:11 GMT+01:00 David Kastrup <dak@gnu.org>:
> Ralf Thielow <ralf.thielow@gmail.com> writes:
>
>> Translate 28 new messages came from git.pot update in
>> df49095 (l10n: git.pot: v1.9 round 1 (27 new, 11 removed)
>> and d57b24b (l10n: git.pot: v1.9 round 2 (1 new)).
>>
>> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
>> ---
>>
>> v4 corrects some translations according to Thomas' review.
>> Thanks for that.
>> With this we also change the translation of "shallow" which
>> was translated as "flach" as in "flacher Klon". Now we translate
>> it as with "Klon/Repository mit unvollst=C3=A4ndiger Historie".
>
> I've already stated that I'd just use "oberfl=C3=A4chlich" here.
>

The Git glossary says "A shallow repository has an incomplete history..=
=2E",
and I think "Klon/Repository mit unvollst=C3=A4ndiger Historie" is less=
 confusing
than "oberfl=C3=A4chlich". I'd keep "unvollst=C3=A4ndige Historie" with=
 a
"(shallow)" behind
of each usage to give the user a hint of what's really meant. I'll
send a reroll soon.


> @@ -1633,6 +1629,8 @@ msgid ""
>  "Do not touch the line above.\n"
>  "Everything below will be removed."
>  msgstr ""
> +"=C3=84ndern Sie nicht die Zeile oberhalb.\n"
> +"Alles unterhalb wird entfernt."
>
> That's not even grammatical.
>
> "=C3=84ndern Sie nicht die obige Zeile.
> Alles unterhalb von ihr wird entfernt."
>

Thanks

> --
> David Kastrup
