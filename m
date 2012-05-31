From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: Re: [PATCH v2] l10n: de.po: translate 41 new messages
Date: Thu, 31 May 2012 16:49:53 +0200
Message-ID: <CAN0XMO+gqCB=OLRAKkrxc4GPNSiTtyokLB6x3tW2fBRc-BkRrQ@mail.gmail.com>
References: <1338395981-8094-1-git-send-email-ralf.thielow@googlemail.com>
	<1338412586-12116-1-git-send-email-ralf.thielow@googlemail.com>
	<87zk8o3c8v.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jk@jk.gs, stimming@tuhh.de, worldhello.net@gmail.com,
	git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu May 31 16:50:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sa6hN-0001OX-1T
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 16:50:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752331Ab2EaOtz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 May 2012 10:49:55 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:46852 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751581Ab2EaOtz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 May 2012 10:49:55 -0400
Received: by wibhn6 with SMTP id hn6so1023111wib.1
        for <git@vger.kernel.org>; Thu, 31 May 2012 07:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=6JOubgHUSTfN0yJ+PlqR5CEqB2kxoCMrar9GNHcm1Pw=;
        b=U5x69JZTxYp7q5xSQSlg0AShdO5r5u9pUGFBqZJNE2ORnHC5sGuQosZEqQ1nOYpMTy
         dsoPMrAyexmFvR/ykQqj/8sWFU+uLS7l8ozdTUQaY1HGSXcrPK6j2omGU7TX+lcVqlS3
         bkzzKUIXxBQe17dTeQcgrd7XcuKU0lker+7mfu95sXUGKKpVoL5O+cfKV5N4xYh1JyMG
         jOmrEHA0j1Q5X/np3iKSGrlcZTTJexw3BG+W+vOyVKWOR2X/v7zKwShYs0vd7uvOIK+A
         NMXPfPlu1TQMi/CFx7E7jdwkx/AGIFwZxjOrlStPdawxxGNaN25qEvoC3YbbxXPRb4KT
         l8Zw==
Received: by 10.216.225.23 with SMTP id y23mr1887758wep.67.1338475793619; Thu,
 31 May 2012 07:49:53 -0700 (PDT)
Received: by 10.194.0.132 with HTTP; Thu, 31 May 2012 07:49:53 -0700 (PDT)
In-Reply-To: <87zk8o3c8v.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198916>

On Thu, May 31, 2012 at 11:56 AM, Thomas Rast <trast@student.ethz.ch> w=
rote:
>> +#: builtin/apply.c:3974
>> +msgid "instead of applying the patch, output diffstat for the input=
"
>> +msgstr "anstatt der Anwendung des Patches, wird die Differenz f=C3=BC=
r die Eingabe "
>> +"ausgegeben"
>
> diffstat has no precedent, so we get to bikeshed (yay). =C2=A0I added=
 a
> placeholder to your glossary. =C2=A0(I also added some other diff-rel=
ated
> terms.) =C2=A0My current best suggestion, sadly, is "diffstat" simply=
 because
> it matches the option name.

Thanks for updating the glossary. I think it's ok to don't translate "d=
iffstat"
for now. Acutally, we did the same for "dirstat".

>
>> +#: builtin/apply.c:4000 builtin/apply.c:4003
>> +msgid "ignore changes in whitespace when finding context"
>> +msgstr "ignoriert =C3=84nderungen in Leerzeichen bei der Suche des =
Kontextes"
>
> I interpret "Leerzeichen" as being (specifically) the ASCII space
> character. =C2=A0Is it just me? =C2=A0Otherwise I suggest we find a m=
ore general
> translation for whitespace.
>

Yeah, "Leerzeichen" is only a part of what whitespace could mean. We
don't need to use
one word for translation. If we can reduce the meaning to ASCII space
characters and tabs,
we could translate it as "Leerzeichen oder Tabulatoren"!? Maybe this
is also just one half
of the truth.

>> +#: parse-options.h:156
>> +msgid "no-op (backward compatibility)"
>> +msgstr "Keine Operation (R=C3=BCckw=C3=A4rtskompatibilit=C3=A4t)"
>
> "Kein Effekt" might be less confusing?
>

Yeah, "Kein Effekt" sounds better to me. Thank you

Ralf
