Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47DDB1FE90
	for <e@80x24.org>; Tue, 18 Apr 2017 09:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932107AbdDRJkV (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 05:40:21 -0400
Received: from mail-ua0-f176.google.com ([209.85.217.176]:35757 "EHLO
        mail-ua0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932080AbdDRJkU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 05:40:20 -0400
Received: by mail-ua0-f176.google.com with SMTP id f10so66892299uaa.2
        for <git@vger.kernel.org>; Tue, 18 Apr 2017 02:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=aO4MuBLJXytAIOHqPNwkXWuo42FvtpKxxt/NA5WlGZI=;
        b=lJ2AqjwwdLwPYBY0XfxQJPsa+v46IZgw1qQ3lHcGUOWBTHds9pcxQZDHBSC70xWEKK
         Equ0/xB/jrvrPWHgHvYaDyVx+Y++PaEe1YYqxaikzKaQ26NSIc6AqoDubfu1TnXWblm4
         Y0A7yvmjXVsCD26K3ZMHjA+ACfbFNMIhObNIDEF07NFqwSne57SSY7HNwPvrNiRv/A0c
         jxw8Aih9MvPnfhjnRRqdAnpWqplvR9BTztahBHYKg4asHMJH+kZ8ei03X8GyeYIr50Nf
         7i5An22KfrzuMH7bQ9Yd4KyKyArV3FBD/vBPSDfyNGmt7LvIq9d1jtRses3/srDUOqhc
         O4Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=aO4MuBLJXytAIOHqPNwkXWuo42FvtpKxxt/NA5WlGZI=;
        b=FLcd2qhp7ruQpISY/OPuvw/I2r2X0VADGrIDonWuf0letovGFXWlCy1ji2EWBM2E+r
         v79Mcllt5LvtAokNvHMYG7a6r2vc0lMOnMwWj4j6fk5Hz/iqnl3LLEbw1AwSmvxvuUGl
         YHPGw3zRoeEYfPuOzh8qWMtiL3SyGn/0NlxeW8eZ58WQj5G5JZ1RmPsCpBtelm9A5KRE
         JROwcRQ68F/PIiBPJvnLpKrhkqL0z4vN+m/lOdlU8otvRDwHWvCTcfGOkGk3XDiLhZf/
         li4xjHqfZZZTZNPnJ8ts6r6rhzQOtcRV3BjyofvZUFfgKbulOGMGlo4JVp6DP0mizYcP
         6k9Q==
X-Gm-Message-State: AN3rC/6P5p57QZUhipimS4KhBzsowIB/oVDCW2KWS5yAKUElwq5MQg5C
        LG8BNk+BahSsrCCApKybwInK6KsiUg==
X-Received: by 10.176.77.211 with SMTP id b19mr7908689uah.63.1492508419239;
 Tue, 18 Apr 2017 02:40:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.6.105 with HTTP; Tue, 18 Apr 2017 02:39:38 -0700 (PDT)
In-Reply-To: <CAJgfmqXqfp3A+A74dfkKjQb_26ZNH9anY52-G2L5ipg=+6--2w@mail.gmail.com>
References: <CAJgfmqU+1Ex1YkP94H2amXV+oqscbQwvb-CueuCiM7-n0AAP8Q@mail.gmail.com>
 <CACBZZX4fDu-o+ERiTyjVq2rWkXK6rjErU4KyW33qMx1_6vjMCQ@mail.gmail.com>
 <xmqqpogblvfr.fsf@gitster.mtv.corp.google.com> <CAJgfmqWf9j=R1=qy-kGTL4+y_40O+8S5q=VZuD3A-DbfRJer2Q@mail.gmail.com>
 <CACsJy8BASVSxJ4RzNKVpj9MyD=fMR-fpspMdET1bT45yMrf_0w@mail.gmail.com>
 <CAJgfmqW4ck9SwBrT_Z7bTOzM2zG==_ONUhTfhbLJtRu=vT+wyg@mail.gmail.com>
 <xmqq60i2im72.fsf@gitster.mtv.corp.google.com> <CAJgfmqXqfp3A+A74dfkKjQb_26ZNH9anY52-G2L5ipg=+6--2w@mail.gmail.com>
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Tue, 18 Apr 2017 04:39:38 -0500
Message-ID: <CAJZjrdXBbBiy0f=RJ2m7iHnh70Nz97-tdHWkSJtYbW6CKBr5ow@mail.gmail.com>
Subject: Re: Feature request: --format=json
To:     "Fred .Flintstone" <eldmannen@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If for some reason your use case is so performance intensive that you
can't just `git cat-file commit` every entry in `git rev-list --all`
individually, then you can also pipe input into `git cat-file --batch`
and read output as you pipe input in, which will give you a very
simple mechanism for delimiting the cat-file output.

In any case, as developers, it's rare to have our job done for us.
That's why we write code.

I'm sure people would be happy to help if you submitted patches to
support --format=json.

On Tue, Apr 18, 2017 at 3:44 AM, Fred .Flintstone <eldmannen@gmail.com> wrote:
> Well the easiest way to work with that would be JSON.
> So the best would be if Git could output the data I want in JSON format.
> Then it would be easy for me to work with data.
>
> With git rev-list and git-cat file, its not so easy to reliably parse
> that output.
>
> On Tue, Apr 18, 2017 at 2:38 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> "Fred .Flintstone" <eldmannen@gmail.com> writes:
>>
>>> So I would either have to do:
>>> git rev-list --all
>>> Then iterate over each line and do git-cat-file commit <commit-id>.
>>>
>>> Or do:
>>> git rev-list --all | git cat-file --batch
>>>
>>> If I do it in a batch, then it will be tricky to reliably parse since
>>> I don't know when the message body ends and when the next commit
>>> starts.
>>>
>>> JSON output would have been very handy.
>>
>> I am somewhat puzzled.  I thought that you were trying to come up
>> with a way to produce JSON output and people are trying to help you
>> by pointing out tools that you can use for that.
