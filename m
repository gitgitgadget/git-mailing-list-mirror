From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH] l10n: de.po: correct translation of "bisect" messages
Date: Sat, 23 Feb 2013 19:16:28 +0100
Message-ID: <CAN0XMOKi1+yFCmpVWs_wPo8pd6HhcPQXc7TzjTSO-d5xgUAiOA@mail.gmail.com>
References: <1361639092-6564-1-git-send-email-ralf.thielow@gmail.com>
	<87ehg76iy9.fsf@pctrast.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: trast@student.ethz.ch, jk@jk.gs, stimming@tuhh.de,
	git@vger.kernel.org
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Feb 23 19:16:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9JeZ-0003Bp-7d
	for gcvg-git-2@plane.gmane.org; Sat, 23 Feb 2013 19:16:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753952Ab3BWSQa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Feb 2013 13:16:30 -0500
Received: from mail-we0-f177.google.com ([74.125.82.177]:64528 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754547Ab3BWSQ3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Feb 2013 13:16:29 -0500
Received: by mail-we0-f177.google.com with SMTP id d7so1384613wer.8
        for <git@vger.kernel.org>; Sat, 23 Feb 2013 10:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=Mx4DbBu1gQxjCboljanGLgMkMaWoJ2P7ZRmv8oyTCpQ=;
        b=rOShN7pHH+Xcn+0IRsSnsriFn+xnCsAhNGIfUQW9vP80iHlGNtg36sa5ZSoLiYDgrO
         qzceaQe7lrudn1IO6eUmyfs1q9RS+c/dWNuuLBch57SFPZ4bxyEYG02BcXYPeKm5P6gU
         vIBG47H1EFVsmQRzaeP01IrjyMQd6dvTSDub703xHh1IU5nWHzbNm+aMpPVHvbamGTyK
         KeC1WYRuCWD2NmTbgxaTIYHMHRgQG9AtyAyR2BvZ0ex8IqJ+fuJYd0Jcx1yWt61F8Ymb
         DxiLT75MGSZTRNj+ubDwUOjxx9L2HgwkNyN1jJ33x4DK+EsoDzb20UWMeBpIAWvehpE1
         wVSA==
X-Received: by 10.194.90.168 with SMTP id bx8mr10051865wjb.59.1361643388552;
 Sat, 23 Feb 2013 10:16:28 -0800 (PST)
Received: by 10.194.25.134 with HTTP; Sat, 23 Feb 2013 10:16:28 -0800 (PST)
In-Reply-To: <87ehg76iy9.fsf@pctrast.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216906>

2013/2/23 Thomas Rast <trast@inf.ethz.ch>:
> Ralf Thielow <ralf.thielow@gmail.com> writes:
>
>> diff --git a/po/de.po b/po/de.po
>> index c0e5398..58a1a46 100644
>> --- a/po/de.po
>> +++ b/po/de.po
>> @@ -1349,11 +1349,11 @@ msgstr " (alle Konflikte behoben: f=C3=BChre=
n Sie
>> \"git commit\" aus)"
>>  #: wt-status.c:958
>>  #, c-format
>>  msgid "You are currently bisecting branch '%s'."
>> -msgstr "Sie sind gerade beim Halbieren in Zweig '%s'."
>> +msgstr "Sie sind gerade bei einer bin=C3=A4ren Suche in Zweig '%s'.=
"
>                            ^^^
>
> "an"?  Or is that again my Swiss non-German interfering?
>

I think "bei" is correct when a search is in progress.
"bei einer Suche sein", "an einer Suche beteiligen" but not
"an einer Suche sein", IMO
Unfortunately, I haven't found a serious proof on the internet.
There is a picture with a subheading on
http://www.duden.de/rechtschreibung/Suche
which says "...bei der Suche nach...", though.

>>  #: wt-status.c:962
>>  msgid "You are currently bisecting."
>> -msgstr "Sie sind gerade beim Halbieren."
>> +msgstr "Sie sind gerade bei einer bin=C3=A4ren Suche."
>
> Same here.
>
>>  #: git-bisect.sh:140
>>  msgid "won't bisect on seeked tree"
>> -msgstr "\"bisect\" auf gesuchtem Zweig nicht m=C3=B6glich"
>> +msgstr "bin=C3=A4re Suche auf gesuchtem Zweig nicht m=C3=B6glich"
>
> Does cogito actually have a German translation?  The comment right ab=
ove
> this message says it's only for cogito users.
>
> Then again cogito has been deprecated since 2006.  Maybe the English
> message should instead be rewritten to say "stop using cg!". ;-)
>
>>  #. TRANSLATORS: Make sure to include [Y] and [n] in your
>>  #. translation. The program will only accept English input
>> @@ -9310,7 +9310,7 @@ msgstr ""
>>
>>  #: git-bisect.sh:347 git-bisect.sh:474
>>  msgid "We are not bisecting."
>> -msgstr "Wir sind nicht beim Halbieren."
>> +msgstr "keine bin=C3=A4ren Suche im Gange"
>                        ^
>
> s/n / /
>

Thanks.

> --
> Thomas Rast
> trast@{inf,student}.ethz.ch
