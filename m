From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Git's translations need to be updated for submission
Date: Sat, 9 Jul 2011 18:45:41 +0200
Message-ID: <CACBZZX4=nD0j7S-3q97fa7iqXo_7-CGWnxwuA6X6g-bkhE7bmw@mail.gmail.com>
References: <CACBZZX4dP-OsrZ3wBOeSkzDFy6XBgeY=eqJUF2acyLC8W-3Vpg@mail.gmail.com>
	<alpine.LNX.2.01.1107082144240.23703@frira.zrqbmnf.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	=?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>,
	=?UTF-8?Q?Marcin_Cie=C5=9Blak?= <saper@saper.info>,
	Peter Krefting <peter@softwolves.pp.se>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sam Reed <sam@reedyboy.net>
To: Jan Engelhardt <jengelh@medozas.de>
X-From: git-owner@vger.kernel.org Sat Jul 09 18:45:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qfaf6-0006Kn-I5
	for gcvg-git-2@lo.gmane.org; Sat, 09 Jul 2011 18:45:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753953Ab1GIQpn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Jul 2011 12:45:43 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:45917 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753779Ab1GIQpm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Jul 2011 12:45:42 -0400
Received: by fxd18 with SMTP id 18so2828998fxd.11
        for <git@vger.kernel.org>; Sat, 09 Jul 2011 09:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=8pvYJtEA2SuSXWgLeKKsqo2xnOtRlX7Pnrb78XPUwqE=;
        b=UNFlzHOogMafwYb/76jEIzejg6okme4AymljxiMPmr5BEen678FhrqATg8DwV7DrZT
         helxf2ONJeCfCeub+KZzosx30FqW26iBA3TAoyLGVLPegQaVNTLRxEtaLpFuPiZjXuza
         01rQ17Fwr2blC4qhYm396F72O7DaWrFY77k4Y=
Received: by 10.223.5.212 with SMTP id 20mr4884246faw.40.1310229941504; Sat,
 09 Jul 2011 09:45:41 -0700 (PDT)
Received: by 10.223.114.208 with HTTP; Sat, 9 Jul 2011 09:45:41 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.01.1107082144240.23703@frira.zrqbmnf.qr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176818>

On Fri, Jul 8, 2011 at 21:45, Jan Engelhardt <jengelh@medozas.de> wrote=
:
> On Wednesday 2011-07-06 21:34, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason=
 wrote:
>
>>I was going to submit Git's po/*.po files from the i18n branch but I
>>found that while everything else has been cooking they've become out
>>of date:
>>
>> =C2=A0 =C2=A0$ parallel -v -k 'msgfmt --statistics {}' ::: *.po
>> =C2=A0 =C2=A0msgfmt --statistics de.po
>> =C2=A0 =C2=A0622 translated messages, 58 fuzzy translations, 21 untr=
anslated messages.
>> =C2=A0 =C2=A0msgfmt --statistics en_GB.po
>> =C2=A0 =C2=A03 translated messages, 698 untranslated messages.
>> =C2=A0 =C2=A0msgfmt --statistics hi.po
>> =C2=A0 =C2=A014 translated messages, 45 fuzzy translations, 642 untr=
anslated messages.
>> =C2=A0 =C2=A0msgfmt --statistics is.po
>> =C2=A0 =C2=A024 translated messages, 36 fuzzy translations, 641 untr=
anslated messages.
>> =C2=A0 =C2=A0msgfmt --statistics pl.po
>> =C2=A0 =C2=A024 translated messages, 46 fuzzy translations, 631 untr=
anslated messages.
>> =C2=A0 =C2=A0msgfmt --statistics sv.po
>> =C2=A0 =C2=A0531 translated messages, 80 fuzzy translations, 90 untr=
anslated messages.
>>
>>In particular the fuzzy translations have to be fixed (in some cases
>>they're completely wrong), and it would be nice to have the
>>untranslated messages translated.
>
> Please retrieve from
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git://dev.medozas.de/git i18n

Willdo, Thanks a lot.
