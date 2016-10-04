Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99C3920986
	for <e@80x24.org>; Tue,  4 Oct 2016 17:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753008AbcJDRFT (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 13:05:19 -0400
Received: from mail-lf0-f44.google.com ([209.85.215.44]:35024 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752918AbcJDRFS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 13:05:18 -0400
Received: by mail-lf0-f44.google.com with SMTP id l131so190824113lfl.2
        for <git@vger.kernel.org>; Tue, 04 Oct 2016 10:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=O7jhRq1Mkow+n2varke8lDEflyD69KmKP/DvYYKdPl8=;
        b=cJQ3jeP8FFSOB8Lflsp0m6JSzWOk4a7iYTHC2H6P7rA1DIksWZp9ZdsoXgjNe9ipEd
         P0Si3TGteE7xVh/zdlXEe6uxbLUadw/AUfMzwaZNTRlhRigzK9t4NRjZaDHj5SJ6JYR2
         5qOtBflYTa7Ef9DnfWzqGwvaPy86E67sYDZfIIyMVOdhTrseD2tg2jK0rsyt5hPZrA3a
         I/gJYzvj1cD0J3ftnG24k/KW74zkaLE5otKnBto+KrTPPxSO8EdiTUFbRY/FEeswr7PS
         Do35W8DEEx9z+XNftHRNK4/D4LxiuipFYP4/11eozwqbifwQ3E+xvCZ604HIRJqnET0K
         0Ckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=O7jhRq1Mkow+n2varke8lDEflyD69KmKP/DvYYKdPl8=;
        b=Tm6y33+gEFv79yyS8ErtRESZGvqTGKAyq6EQpkibhddMpUFjVy5C6cZB/bTlhc+zN3
         G3gOB+fb+WCH+Atn3KZeLn8ChjNF6J0XEf+jLjn8F1Byin3967k7oKRFnN/jgTf95jxB
         B/4N33/H4HKlpsoMX0KvqqF1VbE5x1vtiATlKGgj272CHDTHWWcgUqkKuRh2NFHOBN5S
         4a3kf/Ryuz5NnfPqyLvv8CH3T2svpL+35lwfx3MxTHFjnImqjWxjrWGSCMJ/dTiTLnP3
         /CjCqfv4hmiMR5emGvj2Li8davsrbmrAe2LsOfZfFdqDM0gQkqnNzAk9B36qw4knEULi
         8C/g==
X-Gm-Message-State: AA6/9RlFND+EvVejLqzNZWXra8a1nRWrLmJaVgki6JWkhK8hobt7rnlzMcEFJaH2bqEXofE+8eOS5IT2ay4rMA==
X-Received: by 10.25.205.211 with SMTP id d202mr1854431lfg.64.1475600716377;
 Tue, 04 Oct 2016 10:05:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.15.88 with HTTP; Tue, 4 Oct 2016 10:05:15 -0700 (PDT)
In-Reply-To: <0de216d5-8a47-bd1d-b9d6-8346a62bc489@gmail.com>
References: <20161002165946.19656-1-ralf.thielow@gmail.com> <0de216d5-8a47-bd1d-b9d6-8346a62bc489@gmail.com>
From:   Ralf Thielow <ralf.thielow@gmail.com>
Date:   Tue, 4 Oct 2016 19:05:15 +0200
Message-ID: <CAN0XMOK906ef474aSY10XYUi7swdSXBid=Aj0NAUdyW2QLkRYA@mail.gmail.com>
Subject: Re: [PATCH] l10n: de.po: translate 260 new messages
To:     =?UTF-8?Q?Matthias_R=C3=BCster?= <matthias.ruester@gmail.com>
Cc:     git <git@vger.kernel.org>, Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>,
        Christian Stimming <stimming@tuhh.de>,
        Phillip Sz <phillip.szelat@gmail.com>,
        Magnus G <magnus.goerlitz@googlemail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Matthias,

thanks for review!  Your findings and suggestions are very good and
I will integrate them in a new version.

2016-10-03 0:23 GMT+02:00 Matthias R=C3=BCster <matthias.ruester@gmail.com>=
:
>>  #: builtin/merge.c:960
>>  #, c-format
>>  msgid "Bad value '%s' in environment '%s'"
>> -msgstr ""
>> +msgstr "Fehlerhafter Wert '%s' in Umgebungsvariable '%s'"
>
> I do not know the context but I would translate it to:
> "... Umgebung '%s'"
>

That was my first translation, too.  Then I was wondering what environment
can Git even mean and looked at the sources.  It turned out it really is
about an environment variable.

>
>>  #: git-rebase--interactive.sh:147
>>  msgid ""
>>  "\n"
>>  "Commands:\n"
>>  " p, pick =3D use commit\n"
>>  " r, reword =3D use commit, but edit the commit message\n"
>>  " e, edit =3D use commit, but stop for amending\n"
>>  " s, squash =3D use commit, but meld into previous commit\n"
>>  " f, fixup =3D like \"squash\", but discard this commit's log message\n=
"
>>  " x, exec =3D run command (the rest of the line) using shell\n"
>>  " d, drop =3D remove commit\n"
>>  "\n"
>>  "These lines can be re-ordered; they are executed from top to bottom.\n=
"
>>  msgstr ""
>> +"\n"
>> +"Befehle:\n"
>> +" p, pick =3D Commit verwenden\n"
>> +" r, reword =3D Commit verwenden, aber Commit-Beschreibung bearbeiten\n=
"
>> +" e, edit =3D Commit verwenden, aber zum Nachbessern anhalten\n"
>> +" s, squash =3D Commit verwenden, aber mit vorherigem Commit vereinen\n=
"
>> +" f, fixup =3D wie \"squash\", aber die Log-Nachricht des Commits verwe=
rden\n"
>> +" x, exec =3D Befehl (Rest der Zeile) mittels Shell ausf=C3=BChren\n"
>> +" d, drop =3D Commit entfernen\n"
>> +"\n"
>> +"Diese Zeilen k=C3=B6nnen umsortiert werden; Sie werden von oben nach u=
nten\n"
>> +"ausgef=C3=BChrt.\n"
>
> In my opinion fixup needs a more detailed description here.
> Something like:
>
> "fixup: wie \"squash\", aber die Commit-Beschreibung vom Vorg=C3=A4nger
> verwenden\n".
>
> or:
>
> "fixup: wie \"squash\", aber diese Commit-Beschreibung verwerfen\n".
>

I think this one is the correct translation.  The first can be
confusing or wrong
when there are squashes before, I think.

Thanks!

Ralf
