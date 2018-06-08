Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0A9E1F403
	for <e@80x24.org>; Fri,  8 Jun 2018 03:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752769AbeFHDve (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 23:51:34 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:41405 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752621AbeFHDvd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 23:51:33 -0400
Received: by mail-qk0-f178.google.com with SMTP id w23-v6so7983300qkb.8
        for <git@vger.kernel.org>; Thu, 07 Jun 2018 20:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=aKSPvCL/P2fSDqHsLqybahjJO4WmO3NCrAYdVYJJs3E=;
        b=GCwdV8+2pP9K3QPLyHnR/ornhWrraOwz5XFqDeYrI38IqT3NOOKYQywEmCCZ+qlm6+
         wDC0+2HBLr+rMCPNRZwAx1rI5xmDU1kudaYO8Fa5LH2958gOEeWuHx0Q5nc1MF+EdiHp
         WRFYL3k3hHoPPf5r/NO9pAH9eFszXNr6VrzvWC0VnkDTiSihxrWl7mXWMuuEKho/xDUL
         5IzfK7GcWIbaoGIYj6Qj6gtGBDtvzl/hvEd03E26+rsy8BmO6SuRilQpFsUOUvPkREVy
         vRS3GeuRhFUb1ieDONGUXNI6TGfyF/zcrrcoPxtawsighYbD25EcF8J25Hp/kZ8VsTqB
         iWcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=aKSPvCL/P2fSDqHsLqybahjJO4WmO3NCrAYdVYJJs3E=;
        b=WKXSt8TLu+K+sTtaTnZ8ATx+ET76HhammEbwFxd3c9eTyER4OsWIMLcxqEfLgbhY3i
         OOpilp+KxWOh4BusHawcz0piAkFYks3UWmh46w6UOQphs6a9hS22iZ00Qqr35RLjkHG5
         k2vRgRchuxSl+bbiJ2VIk2u7tidsxxQavRlCGLs6+cBByXCjq9OAVxmzQhOTjl2OX77i
         OAsWxtYtpb6nBI/5ls7sHMx05XKnNWHoDRzD1jH3VqbUxCh/2+jWM6Jp/PITEl8k+Lrn
         ISKoDNbU89AOthDldHjKZnYqkSEyeqIZfEBdeVkWjmz/Cpc9pPiQKTSyaIQ/KMQ2/NUU
         S8Lg==
X-Gm-Message-State: APt69E2dLVK1D5jqlK0wM/reyPKKpkT89QPQ4Z4SLluD0rhcEmstmxRx
        nh5wSKQbEnHjgCTS/LL80Cjf0y1lNDTRmP4zgDQ=
X-Google-Smtp-Source: ADUXVKJNsO5C7YYfLBLeu5AnrBUwEsxYhu8ZPXFi5iT/FypaECZT92s0Qmb5vzMLQ/Ml7GzIyqINdqklTqkb/mTuct4=
X-Received: by 2002:a37:ddd1:: with SMTP id u78-v6mr4069638qku.363.1528429893129;
 Thu, 07 Jun 2018 20:51:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:b490:0:0:0:0:0 with HTTP; Thu, 7 Jun 2018 20:51:32 -0700 (PDT)
In-Reply-To: <CANYiYbGF=jr8EoUg-0sMDP-c6N8kN41NRJtGHGXOUOQc7aRPQQ@mail.gmail.com>
References: <CANYiYbGF=jr8EoUg-0sMDP-c6N8kN41NRJtGHGXOUOQc7aRPQQ@mail.gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Fri, 8 Jun 2018 11:51:32 +0800
Message-ID: <CANYiYbHbh+mTCRgo1GdBNqVUsoSxrOEuWre_H3LLXU7pwJRCvg@mail.gmail.com>
Subject: Re: [L10N] Kickoff for Git 2.18.0 l10n round 2
To:     Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        =?UTF-8?Q?Christopher_D=C3=ADaz?= <christopher.diaz.riv@gmail.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
        Marco Paolone <marcopaolone@gmail.com>,
        Changwoo Ryu <cwryu@debian.org>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All these 144 new messages in this round of Git l10n are introduced by
commit f318d73915 (generate-cmds.sh: export all commands to
command-list.h). The updated script `generate-cmds.sh` will export
more commands and one line introductions in file `command-list.h` than
v2.18.0-rc0:

    $ git checkout -q v2.18.0-rc0 && ./generate-cmdlist.sh
command-list.txt | wc -l
      38

    $ git checkout -q v2.18.0-rc1 && ./generate-cmdlist.sh
command-list.txt | wc -l
      207

2018-06-08 9:21 GMT+08:00 Jiang Xin <worldhello.net@gmail.com>:
> Hi,
>
> Git 2.18.0-rc1 has been released, and introduced 36 more messages (144
> total) need to be translated. Let's start the 2nd round of l10n for
> Git 2.18.0.
>
> The new "git.pot" is generated in commit v2.18.0-rc1:
>
>     l10n: git.pot: v2.18.0 round 2 (144 new, 6 removed)
>
>     Generate po/git.pot from v2.18.0-rc1 for git v2.18.0 l10n round 2.
>
>     Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
>
> You can get it from the usual place:
>
>     https://github.com/git-l10n/git-po/
>
> As how to update your XX.po and help to translate Git, please see
> "Updating a XX.po file" and other sections in "po/README" file.
>
> --
> Jiang Xin
