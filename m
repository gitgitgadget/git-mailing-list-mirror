Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D40A20D12
	for <e@80x24.org>; Fri,  2 Jun 2017 07:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751126AbdFBHk1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 03:40:27 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:35007 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750747AbdFBHkZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 03:40:25 -0400
Received: by mail-it0-f46.google.com with SMTP id m62so258546itc.0
        for <git@vger.kernel.org>; Fri, 02 Jun 2017 00:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=55vsXd+5XmeV8Aq2GOmwCwgjNuYCKDN6dBfFTQrkTOQ=;
        b=ZxV/82Y8E0fPhRAzhwHGb/2yx4TQcV29Uj6dTJPMBtXfVsDZQGzSoFNqx4HpmKkBSK
         sHhpd7In5GLfRLdyrd3wraruxujyKLl6nwWJG10bzjzSWQrRnJ1tM3xkiRmoYonT9Tix
         DDZTPLl2+kw+bU/sNyN59F9con1XO8T+NShSUlcrKK+PDpOtU28EbJUikuX5e7Fq42X2
         ghYjYqiT4K+7Ar6Ww1XElEdcrWpEBfTfTTLhvpDsAoFyiMTdIYZtoJJKz+NbT5+cCL2T
         HjNK0c3zOyZpqshyqUPKg+fgJHIjuRCDQdL07OWDbyV2WQ7IPfv2ALn/8IwuKC/aaQ6q
         jmAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=55vsXd+5XmeV8Aq2GOmwCwgjNuYCKDN6dBfFTQrkTOQ=;
        b=VHqQaP9Hn8Py+KePa5cZ8+Tjimw2XP0Bp+fBxn3gV2j00CWNScW6CxDgXV+Ktm226a
         lJi9jS1/2zdL1wX70D0C/Kw+SO9GVdCXhId5brG0bLgkMd71IvzPGE45SnNyKy2PEAAo
         LG6c5bVYdmr+ykUPo3nn9kD6yhGxTTpq2U2nk2sfcQtNErFnNkS7fwJfKTYBI1+KzdnO
         lV/PjwWCex2vFmVBYaLeHZAClaCj0yWIR6ViycnHTl7wd/8C8F49FumYRf7PEL9bEX/f
         bebtmKQpp9UiM4AEqf8XiDR511bHBGYfFR5NKQDVpdkxivVhp6cjyX9p3Yb8quekrBqr
         PXPw==
X-Gm-Message-State: AODbwcDinuI+iSC7wnxIol3jgwId8Wfwzdpm3CQXAt7ex7iJcthJlAfb
        Ue2FlyLchcsdBbl7/weVrZbiEF/L6A==
X-Received: by 10.36.29.150 with SMTP id 144mr3097831itj.71.1496389153656;
 Fri, 02 Jun 2017 00:39:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Fri, 2 Jun 2017 00:38:52 -0700 (PDT)
In-Reply-To: <xmqqy3tayi53.fsf@gitster.mtv.corp.google.com>
References: <CAH8yC8k9pJHLuzWneb4aRAEF2zOTCVO_5YJxrCpw28x8bDox0A@mail.gmail.com>
 <CAH8yC8mjTXQ_5uRedHi=fytKtQttyq_WemGFNQTP9C3PK4x5cQ@mail.gmail.com>
 <20170602070052.3lq22arcncuh6rrl@tigra> <CAH8yC8nGR1heD9_xRuHRG-oerdoQr6Pi8mT=ZpFhoeH6LaFK2w@mail.gmail.com>
 <xmqqy3tayi53.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Fri, 2 Jun 2017 09:38:52 +0200
Message-ID: <CACBZZX4vEOD-4a-eK-uBxmFrb1GLSvJKxHW51whCSbCZdh7amQ@mail.gmail.com>
Subject: Re: How to avoid "Please tell me who you are..."?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeffrey Walton <noloader@gmail.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 2, 2017 at 9:15 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeffrey Walton <noloader@gmail.com> writes:
>
>> Is there no switch? Its the most efficient way to accomplish the task.
>
> This is a safety to help normal human users from hurting themselves,
> and it does not make any sense to have "I have no name, so record
> garbage, please" option, switch or setting that is different from
> "Here is the name I want you to use when recording things".
>
> The switch _is_ to set the names with whatever standard way.

Presumably OP doesn't want to mess with the env for whatever reason,
in that case:

    git -c user.name=Nobody -c user.email=nobody@example.com
cherry-pick <commit>
