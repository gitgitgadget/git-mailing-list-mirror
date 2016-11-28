Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83E3B1FBB0
	for <e@80x24.org>; Mon, 28 Nov 2016 17:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752299AbcK1Rzm (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Nov 2016 12:55:42 -0500
Received: from mail-lf0-f54.google.com ([209.85.215.54]:34328 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751203AbcK1Rzk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2016 12:55:40 -0500
Received: by mail-lf0-f54.google.com with SMTP id o141so102468366lff.1
        for <git@vger.kernel.org>; Mon, 28 Nov 2016 09:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cmfwj3asS9FKxBcdKn9VOHRYJK1lKeAv9DKVEJEzBRI=;
        b=VVZvb0ezhPXarT5WgEAyLTZF9F485pR6y01+0Nw9QbMGPn/EiVu4TtMWiORu2htCw0
         Xn1+yOJKTSB/TgJjYMn+fTeBQwH19PRUmSjpxT0gtsBbQyMT1bl23V4nTu7nAglj0oDh
         xDeo8CliQiAYO2SQZNWK2j2OUcw30PVdwmggx0/G2K0ASpWpFsvb4aDb5pnDFA7vB9gG
         WyUTFqYacxCQmNGClkPE9siKEvoGUO7TgD3rt3OYZBhsU9q9VMt4aAnNa43krHl/hakY
         MixAss2ydf/5Sl+FMI/rYX4FsM1mB17p6m4IXRYquQ5TTa0qb1HTuxXIC4copoOh18A+
         GWfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cmfwj3asS9FKxBcdKn9VOHRYJK1lKeAv9DKVEJEzBRI=;
        b=Rt0qfxJ90/hV0umfuwjHUp/2iUgvARAAC5x5s70aQHq3EW5OrC1BkFp7F/eUHbd7vF
         vAnnuJGkOpZT8oHolBuFErXXK6gq8k8lbnkEQPHUHnnuB/GSWCReUCwRwhgMVFCYDBlS
         96/JWrPYnzms+U9KbqkTWrfCm4bHFIPt4dJFbsotDZuKi6bDK1TJuXa71rzZW2lFvlzS
         O+wtxc3NfCScKyknHB3C1p48S5lTPaUkkb1SRe6Rff36oC1RdaEo63a7EOUObzHdYlt9
         30Az+nPAO6DgB7JJwzQtffW8qGyZ0ysr4EV5DBGTq3SbeiErY2ZTip7N67h0wZkwEMsf
         XCDA==
X-Gm-Message-State: AKaTC00HlLHgNi3cTOo4Vx3DJFFv7bLI6EZ0rxSUN1MJ7+0MkTqAb2LsbcesGJOTJalZbpNvtNymmPPVDl/ZcQ==
X-Received: by 10.25.193.8 with SMTP id r8mr7215581lff.148.1480355738750; Mon,
 28 Nov 2016 09:55:38 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.33.129 with HTTP; Mon, 28 Nov 2016 09:55:38 -0800 (PST)
In-Reply-To: <CANYiYbEzoN8S0o7_1N4hpO6OHZqq5Y4cMPxPPLEMA4TJ2n-d1g@mail.gmail.com>
References: <20161124182500.6875-1-ralf.thielow@gmail.com> <CANYiYbEzoN8S0o7_1N4hpO6OHZqq5Y4cMPxPPLEMA4TJ2n-d1g@mail.gmail.com>
From:   Ralf Thielow <ralf.thielow@gmail.com>
Date:   Mon, 28 Nov 2016 18:55:38 +0100
Message-ID: <CAN0XMOJ0mQ7KF_f2dh9YFA62a4RxoYJMkT7HXUpArK5CdHimew@mail.gmail.com>
Subject: Re: [PATCH] l10n: de.po: translate 210 new message
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>,
        Christian Stimming <stimming@tuhh.de>,
        Phillip Sz <phillip.szelat@gmail.com>,
        =?UTF-8?Q?Matthias_R=C3=BCster?= <matthias.ruester@gmail.com>,
        =?UTF-8?Q?Magnus_G=C3=B6rlitz?= <magnus.goerlitz@googlemail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2016-11-28 15:21 GMT+01:00 Jiang Xin <worldhello.net@gmail.com>:
> 2016-11-25 2:25 GMT+08:00 Ralf Thielow <ralf.thielow@gmail.com>:
>>  #: sequencer.c:251
>> -#, fuzzy, c-format
>> +#, c-format
>>  msgid "could not write eol to '%s"
>
> Unmatched single quote has been fixed in l10n round 3.
> You can rebase and update de.po file.
>
> BTW, Git 2.11.0 will be released tomorrow, please send PR in time.

I've rebased, fixed the subject line and send a pull request to you.

Thanks

>
>> -msgstr "Konnte nicht nach '%s' schreiben."
>> +msgstr "Konnte EOL nicht nach '%s' schreiben."
>
> --
> Jiang Xin
