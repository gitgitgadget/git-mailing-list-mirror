From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH] l10n: de.po: translate "index" as "Index"
Date: Tue, 2 Jun 2015 18:07:39 +0200
Message-ID: <CAN0XMOLavKP6kSQpArGjnqSPePuvP-WR=LxngBRo17RT6ZiSTw@mail.gmail.com>
References: <1432925644-26231-1-git-send-email-ralf.thielow@gmail.com>
	<556C0BFD.3060806@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
	Thomas Rast <tr@thomasrast.ch>,
	=?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>,
	Phillip Sz <phillip.szelat@gmail.com>,
	=?UTF-8?Q?Matthias_R=C3=BCster?= <matthias.ruester@gmail.com>,
	=?UTF-8?Q?Magnus_G=C3=B6rlitz?= <magnus.goerlitz@googlemail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Jun 02 18:08:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzojJ-0003NX-Ps
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 18:07:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759479AbbFBQHp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Jun 2015 12:07:45 -0400
Received: from mail-wg0-f51.google.com ([74.125.82.51]:35001 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758947AbbFBQHk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Jun 2015 12:07:40 -0400
Received: by wgme6 with SMTP id e6so144108862wgm.2
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 09:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=WXmax9k9lMAEUXn3DMrJ7fdT2c5E7F/zunMJV4cSU0g=;
        b=mynkcljEtfM3r3GqQLVFMCQxbAcQAXfRVyxXx8UXuSUfcGoQptH5L+mIRA4NWmjRVV
         3XGhi0VUkNbI+VJ3EGs6+KJZPNKqmj3RL/fxHTb0t7JD8pMPspzJ0rmtlvPak5cR44Vx
         wNoY/ZTU9JIrPygs3q966aBDmoIV0PRo/xra+XyNz/xJHEvKEMS6Cce1tYpCkU3i+izN
         Z5h6gHUoDLDXJ299p/Gd9PNJTrX3ncACxxWZNUivnwDBFG0Ki1Yq9Ik3qKdReQCPfYeb
         x6ttnCglSeWTbsNewMOdo1UEzFTmJ2otq0AdsDNDj4Vr1Cg/zlrKqW4aCS4hl/917x6y
         T6ew==
X-Received: by 10.194.5.103 with SMTP id r7mr50872318wjr.47.1433261259226;
 Tue, 02 Jun 2015 09:07:39 -0700 (PDT)
Received: by 10.194.152.197 with HTTP; Tue, 2 Jun 2015 09:07:39 -0700 (PDT)
In-Reply-To: <556C0BFD.3060806@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270560>

Am 1. Juni 2015 um 09:38 schrieb  <git@drmicha.warpmail.net>:
> Ralf Thielow venit, vidit, dixit 29.05.2015 20:54:
>>  #: sequencer.c:501
>>  #, c-format
>> @@ -1294,12 +1294,12 @@ msgstr "leere Menge von Commits =C3=BCbergeb=
en"
>>  #: sequencer.c:661
>>  #, c-format
>>  msgid "git %s: failed to read the index"
>> -msgstr "git %s: Fehler beim Lesen der Staging-Area"
>> +msgstr "git %s: Fehler beim Lesen des Indexes"
>
> Now we have to decide whether we flex "Index" like a foreign word in
> German or like a German word:
>
> der Index, des Index, ...; die Indizes (pl.)
>
> or
>
> der Index, des Indexes, ...; die Indexe (pl.)
>
> I'd vote the former.
>

I'd vote for the former, too, for that reason.

>>  #: builtin/fsck.c:613
>>  msgid "make index objects head nodes"
>> -msgstr "Objekte in der Staging-Area pr=C3=BCfen"
>> +msgstr "Index-Objekte im Index pr=C3=BCfen"
>
> Maybe "Alle Index-Objekte als head betrachten."? I don't know how we
> translate "head object". But the point is that this option makes fsck
> walk from the index objects, i.e. check their whole object ancestry, =
nit
> just those objects.
>

There are actually two messages using "head nodes". That's why I
didn't fix it here. Currently we don't have a translation for "head nod=
es".
What about translating
"make index objects head nodes" with
"Index-Objekte in Erreichbarkeitspr=C3=BCfung einbeziehen"
and "make reflogs head nodes (default)" with
"Reflogs in Erreichbarkeitspr=C3=BCfung einbeziehen (Standard)"

What do you think?

>>  #: git-am.sh:53
>>  msgid "You need to set your committer info first"
>> @@ -10478,8 +10474,7 @@ msgstr ""
>>  #: git-am.sh:142
>>  msgid "Using index info to reconstruct a base tree..."
>>  msgstr ""
>> -"Verwende Informationen aus der Staging-Area, um einen Basisverzeic=
hnis "
>> -"nachzustellen"
>> +"Verwende Informationen aus dem Index, um einen Basisverzeichnis na=
chzustellen"
>
> "ein", not "einen" (unrelated fix)
>

Thanks. This is already fixed by you in
http://article.gmane.org/gmane.comp.version-control.git/269346
I based this commit on master branch without your patches being applied=
=2E
In the future I'll base the patches on my latest version, not on master=
=2E
