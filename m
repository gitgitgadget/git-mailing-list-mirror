Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 142C020899
	for <e@80x24.org>; Thu, 27 Jul 2017 18:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751595AbdG0SGH (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jul 2017 14:06:07 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:36719 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750981AbdG0SGH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jul 2017 14:06:07 -0400
Received: by mail-wr0-f174.google.com with SMTP id y43so146654764wrd.3
        for <git@vger.kernel.org>; Thu, 27 Jul 2017 11:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=APK++K7JfXEhViLVLDjUR4hxbTYmPVjI7QK1k8dEwa0=;
        b=Q97XiHjxIRAz7dIZ22F1kwJjp2sScE0sGyG0PGHJRtlOOHMp+HMLvyii1R7tdTcotK
         9AX+nFRLCkpYRYFpvJEalu6Z8Ujs38yUuqnMifAYhrrTdery4s40MBkC0VFdBScgTgGT
         bToFg9Yj9WXc48aRbrtkXhg7IS92etkWss1b0do2OSj35AtEG19Rz6BuUWBhvD/221fs
         aNSWVa+zddzT/AXdRlGD1DQ+Xd4JLr80BaudKvopw4zYY0wy2Ih7NSrf6vli2y+/XqX2
         W7DytMlVwtMPiEUe4RMpdKDkSpeuB8XBGu/EAxhVn5h+PphhcvICybqxp9VaN5VH0q/X
         FK1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=APK++K7JfXEhViLVLDjUR4hxbTYmPVjI7QK1k8dEwa0=;
        b=Qj2EuFkV5FjoUTYvit2/Vu2EAHdOvP/D0Jjw0iIZhKXXHPU6RepVUjnQ6YgyWwNdr1
         JlCPIV8VzOy4dgcgozwdiucMuCdfiYvwGfWDDIxAK9iTx56OK5VXwnbdtJ/PbiMNeQEe
         PA5HLqtC0/4SLjD+TwWKNsLIqlHDgLWEa0mq6W4XXKyRuplcP77HPLgxEtEXbfroEs5/
         4HWDIke5MaUkMlnoNx4APdaJPjV45XTn6Sr9H5H6AL9hSHf/fCEI3L3TFPtI9QSy/q52
         LoLtQpnnVLXMiHG+p09olwstsTuFeW8y5vVIcbwhoqseXqEJAZCAVFpipvm0rRego5GW
         dBPQ==
X-Gm-Message-State: AIVw113+OyB0P9dI8KSda0psFtz3/kFSh/E3k2YEt0SJsY24QQIQlP6R
        XcLdeIRJ4jS4Wj0hJmxKEI4vr6n2Cg==
X-Received: by 10.223.177.26 with SMTP id l26mr4659721wra.65.1501178765703;
 Thu, 27 Jul 2017 11:06:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.193.66 with HTTP; Thu, 27 Jul 2017 11:06:04 -0700 (PDT)
In-Reply-To: <CAGZ79kYWhaUUWviq2Kx4h+dEEfRkE8JjGa=JUq6b1Vd8ZUWa9w@mail.gmail.com>
References: <20170727173028.8863-1-ralf.thielow@gmail.com> <CAGZ79kYWhaUUWviq2Kx4h+dEEfRkE8JjGa=JUq6b1Vd8ZUWa9w@mail.gmail.com>
From:   Ralf Thielow <ralf.thielow@gmail.com>
Date:   Thu, 27 Jul 2017 20:06:04 +0200
Message-ID: <CAN0XMO+qdTQZe=7L6MZqn1_7V48tN-o3rHqhoywmApdrva6QjA@mail.gmail.com>
Subject: Re: [PATCH] l10n: de.po: various fixes in German translation
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Hartmut Henkel <henkel@vh-s.de>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>,
        Christian Stimming <stimming@tuhh.de>,
        Phillip Szelat <phillip.szelat@gmail.com>,
        =?UTF-8?Q?Matthias_R=C3=BCster?= <matthias.ruester@gmail.com>,
        =?UTF-8?Q?Magnus_G=C3=B6rlitz?= <magnus.goerlitz@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2017-07-27 20:00 GMT+02:00 Stefan Beller <sbeller@google.com>:
> This patch looks good to me, but some unrelated comments
> that I feel would improve the translation even more.
>
> Thanks,
> Stefan
>
>> @@ -1465,7 +1465,7 @@ msgstr "Konnte '%s' nicht aufheben."
>>
>>  #: connect.c:50
>>  msgid "The remote end hung up upon initial contact"
>> -msgstr "Die Gegenseite hat sich nach dem erstmaligen Kontakt aufgehange=
n."
>> +msgstr "Die Gegenseite hat nach dem erstmaligen Kontakt abgebrochen."
>
> erstmalig reads funny here. Maybe "ersten" instead?
>
>
>> @@ -3360,7 +3360,7 @@ msgstr "gespeicherte \"pre-cherry-pick\" HEAD Date=
i '%s' ist besch=C3=A4digt"
>>  #: sequencer.c:1658
>>  msgid "You seem to have moved HEAD. Not rewinding, check your HEAD!"
>>  msgstr ""
>> -"Sie scheinen HEAD verschoben zu haben. Keine Zur=C3=BCcksetzung, pr=C3=
=BCfen Sie HEAD."
>> +"Sie scheinen HEAD verschoben zu haben. Keine R=C3=BCckspulung, pr=C3=
=BCfen Sie HEAD."
>
> Maybe "Sie scheinen HEAD veraendert zu haben" here?
> This could also be reflected in the code and we put "changed HEAD" ,
> but in English it seems to fit "moving " HEAD.
>
>> @@ -11258,7 +11258,7 @@ msgstr "Fortschrittsanzeige anzeigen"
>>  #: builtin/pack-objects.c:2881
>>  msgid "show progress meter during object writing phase"
>>  msgstr ""
>> -"Forschrittsanzeige w=C3=A4hrend der Phase des Schreibens der Objekte a=
nzeigen"
>> +"Forschrittsanzeige w=C3=A4hrend der Phase des Schreibens von Objekten =
anzeigen"
>
> Maybe elide "der Phase" here?

I agree with all of that.

Thanks
