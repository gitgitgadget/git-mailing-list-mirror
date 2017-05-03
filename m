Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21BB81F829
	for <e@80x24.org>; Wed,  3 May 2017 16:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751696AbdECQiY (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 12:38:24 -0400
Received: from mail-wr0-f182.google.com ([209.85.128.182]:34638 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751159AbdECQiX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 12:38:23 -0400
Received: by mail-wr0-f182.google.com with SMTP id l9so113097261wre.1
        for <git@vger.kernel.org>; Wed, 03 May 2017 09:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Msl0mvGr+IwCYRqtOYQf4k8TC0uS1b7O40eoTON3hF8=;
        b=EZ516/mfqokOsO3ynK4BvSRPg49rVWs1pZrAQvFukiCxOALOFhHscNWdylc2QbD8Ew
         sSiDYYsWHYZqda35MH5C8SNyRMd4aj7hrBN/OzcVgFvJ13TOzlc6+i4zmXaz8bYladu+
         Hi5KF/A4ZnLBqqhkaYqIW3A8Js18DhbKgaAgw/8SFufvVPZ0FrFZAdqyAeEDmMPLQIUG
         TN1MAL0Ti62DtDsdgntdZC/9f5BK18unpKWC5MBV50iP/T9H92eIHIMug5BrHqsV+oTP
         IGeeCenbJY5awbVG6XUcLhCl2TYA3Nh57sexHZ+VlD9W6z7/iPCi2htnqjXNLdrYDybr
         Upng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=Msl0mvGr+IwCYRqtOYQf4k8TC0uS1b7O40eoTON3hF8=;
        b=nc/qsauoWfjJ6L4ypyWPl+fp4mv9SxhLOrFC+o8kPqfmx9J6nroNfW5PabQjHNcDXH
         li8KG+sYbaCbm8YSRGHJrQqliHx6gHjmSmxFxuqpE0/GO27RLP4UFHugcw9H7yKYGQ4a
         fTtLQi1pu5zoWRB+UKMJhWVIGIn4U6Dg+D8veH3h+DpbfQsjOCG7useS5meWYrA25xbU
         LkGXeuHz8wIXqdRP5w7d7f2Dowjgd93DZLlofy5v93n5HP/RmJCSkuirzsQGna440RBu
         2C1+M4X5FeC5uwnn4D2QHPOSa0KJlEcBfyxFvaUdX55u7TxO5t3ee7HsOe6JrBpE4e+X
         safg==
X-Gm-Message-State: AN3rC/5i0g7ab1/+18jU3Arc2HH4AhYJs2xx8AmaI5JQYt+MBe3tcNHx
        vOP+tR/wJ05h/Ss37dtXwEsmTQtuEA==
X-Received: by 10.223.146.193 with SMTP id 59mr23421582wrn.165.1493829501624;
 Wed, 03 May 2017 09:38:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.28.146 with HTTP; Wed, 3 May 2017 09:38:20 -0700 (PDT)
In-Reply-To: <20170503123826.GE30941@256bit.org>
References: <20170430191149.19290-1-ralf.thielow@gmail.com>
 <20170502163612.3381-1-ralf.thielow@gmail.com> <20170503123826.GE30941@256bit.org>
From:   Ralf Thielow <ralf.thielow@gmail.com>
Date:   Wed, 3 May 2017 18:38:20 +0200
Message-ID: <CAN0XMOKMwzYEwHJECk0w5rJBRr4CAGo+wzfN=u55OxCYN+WcSw@mail.gmail.com>
Subject: Re: [PATCH v3] l10n: de.po: update German translation
To:     Ralf Thielow <ralf.thielow@gmail.com>, git <git@vger.kernel.org>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>,
        Christian Stimming <stimming@tuhh.de>,
        Phillip Szelat <phillip.szelat@gmail.com>,
        =?UTF-8?Q?Matthias_R=C3=BCster?= <matthias.ruester@gmail.com>,
        =?UTF-8?Q?Magnus_G=C3=B6rlitz?= <magnus.goerlitz@googlemail.com>,
        Simon Ruderich <simon@ruderich.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 3. Mai 2017 um 14:38 schrieb Christian Brabandt <cb@256bit.org>:
> Hallo Ralf!
>
> Ralf Thielow schrieb am Dienstag, den 02. Mai 2017:
>
>> @@ -1260,6 +1260,8 @@ msgstr "Speicher verbraucht"
>>  #: config.c:191
>>  msgid "relative config include conditionals must come from files"
>>  msgstr ""
>> +"Bedingungen f=C3=BCr das Einbinden von Konfigurationen aus relativen P=
faden muss\n"
>> +"aus Dateien kommen."
>
> Bedingungen [...] m=C3=BCssen aus Dateien kommen
>
>>  #: fetch-pack.c:1150
>>  #, c-format
>>  msgid "Server does not allow request for unadvertised object %s"
>> -msgstr ""
>> +msgstr "Der Server erlaubt keine Anfrage f=C3=BCr nicht angebotenes Obj=
ekt %s."
>
> Double negation does not sound good. Perhaps:
> "Der Server lehnt Anfrage nach nicht angebotenem Objekt %s ab."
> or possibly (still double negation)
> "Der Server erlaubt keine Anfrage f=C3=BCr nicht =C3=B6ffentliches Objekt=
 %s."
>>  #: builtin/for-each-ref.c:46
>> -#, fuzzy
>>  msgid "print only refs which don't contain the commit"
>> -msgstr "nur Referenzen ausgeben, die diesen Commit enthalten"
>> +msgstr "nur Referenzen ausgeben, die diesen nicht Commit enthalten"
>
> "nur Referenzen ausgeben, die diesen Commit nicht enthalten"
>
> refs are here translated as Referenzen
>
>>  #: builtin/grep.c:1189
>> -#, fuzzy
>>  msgid "--no-index or --untracked cannot be used with revs"
>> -msgstr ""
>> -"Die Optionen --no-index und --untracked k=C3=B6nnen nicht mit Commits =
verwendet "
>> -"werden."
>> +msgstr "--no-index oder --untracked k=C3=B6nnen nicht mit Commits verwe=
ndet werden"
>
> refs are here translated as Commits?
>
>>  #: builtin/grep.c:1195
>> -#, fuzzy, c-format
>> +#, c-format
>>  msgid "unable to resolve revision: %s"
>> -msgstr "Konnte %s nicht nach %s verschieben"
>> +msgstr "Konnte Commit nicht aufl=C3=B6sen: %s"
>
> same here
>

Ref or Reference is translated as "Referenz" while
Rev or Revision is translated as "Commit" so I think
the translation is correct.

Thanks for your findings and suggestions!

>>  #: builtin/tag.c:421 builtin/tag.c:423
>> -#, fuzzy
>>  msgid "print only tags that don't contain the commit"
>> -msgstr "nur Tags ausgeben, die diesen Commit beinhalten"
>> +msgstr "nur Tags ausgeben, die diesen nicht Commit enthalten"
>
> "nur Tags ausgeben, die diesen Commit nicht enthalten"
>
> Best,
> Christian
> --
> Wie man sein Kind nicht nennen sollte:
>   Anna Na=C3=9F
