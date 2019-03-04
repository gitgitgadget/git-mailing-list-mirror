Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9993420248
	for <e@80x24.org>; Mon,  4 Mar 2019 07:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726001AbfCDHxB (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 02:53:01 -0500
Received: from mail-io1-f42.google.com ([209.85.166.42]:44517 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfCDHxB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 02:53:01 -0500
Received: by mail-io1-f42.google.com with SMTP id y13so3257194iop.11
        for <git@vger.kernel.org>; Sun, 03 Mar 2019 23:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LpRUFCJepTCAmLIqwGul5xJQ0t9KBK3+L703jzHYwg4=;
        b=KnBhXE8KRyy4dwqOQeMd4RzxKExIt8J/AOleYsL/2Dg9Wgo/HqkcJxJ5DHVEiyAJX3
         KAjie6P15pmgf1u4DcXknwcqTpxKfH85PJBRTzkCz0qicO7/XKgYkoPjcLNFmd6FbxzE
         ml6wDVvNrfU2Md5+2xSVQ+cT2BZQ2CoCHCeIzEAXySjzFNjVcNgtcG+JjNZc1PJdpA/G
         EMnXlfGt1S4pSz23bmE3EpPUcAyk6WluvwRucvm8lFZittwGa7BNqytlxdJMr0SyL3B7
         lrHTuywToL890dJ3zidrjG74wk6nklKOnOA2ATfzroguS+3TjZGPyus8vIy4PPYJZx/N
         WiXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LpRUFCJepTCAmLIqwGul5xJQ0t9KBK3+L703jzHYwg4=;
        b=h52O0PcSMw+edmblHH4H9MqLZJ6BOPe9slOgaqNi2CxTgzR9765wl+jliikdeu6DHP
         yOry6Q/Qkl3AxCpNQ9d09u4/D2zcEktUDRyBPOm0WYyaGI3h/AjGFdLUYCQ5mBrjM4J9
         Ao6pEoD86g6vp41xdxeCM+AmZgiKXexi3hyMhs/P0A5j8L80sXu0yCchokWETetSY71c
         neq2oVsZffl+7LKr8qGVC1DKLipN6WDg1nbptXnfUkIQ/LBg/bDjDJaBHIDFILmBdo8G
         x8CLm9aGwCPP8nGnHN0oUvbVJszpzHAOfPW/gi2//kIipNvKRvIHbQowU4p6f8n21Zw0
         7j1g==
X-Gm-Message-State: APjAAAVTTKz9MB0sroPuNc0nNXo7dz7COKvyL9AY/Mq9+5ejMGqi8DIy
        8+zmgzhB8/S1fklVOTAZQPeGg7w87dk01mt+vDM=
X-Google-Smtp-Source: APXvYqxjODvO6ls5rBzsBE73wMMqjo0zXL2Me2WXfKvD9YDeblfJVjQuIXeBfiTxoIeaOYZ0wwlhGdvqpOzDgam8GrE=
X-Received: by 2002:a5d:9357:: with SMTP id i23mr7573190ioo.236.1551685980342;
 Sun, 03 Mar 2019 23:53:00 -0800 (PST)
MIME-Version: 1.0
References: <636CE77F-B137-47EC-A39B-8D70B8C15A22@gmail.com> <xmqqd0n7w0he.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqd0n7w0he.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 4 Mar 2019 14:52:34 +0700
Message-ID: <CACsJy8BfPHAY1ZidstLK7SuviS7bF1ZmMOiZv+6vnh+jfN6Eig@mail.gmail.com>
Subject: Re: [GSoC] Query regarding microproject
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Umang Parmar <umangjparmar@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 4, 2019 at 2:43 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Umang Parmar <umangjparmar@gmail.com> writes:
>
> > I am interested in micro project "Add configuration options for
> > some commonly used command-line=E2=80=9D. So can you point me out to
> > implementations of some current commands which have configuration
> > options and also for which command to add config options.
>
> It is not a homework assignment.

True. But the last step could be really intimidating at the beginning.
I'll give another hint, do

git log --oneline -- Documentation/config.txt

Look for some interesting changes (e.g. "add something") then "git
show" on that commit, which gives some starting point to focus on.

> Studying the current system to
>
>  - learn what commands are available (hint: "man git" and read from there=
)
>
>  - learn what commands and command line options are commonly used (hint:
>    learn from your own use of the system)
>
>  - pick one of the commands and its options that interests you
>
>  - find out where that particular command is implemented
>
> are all part of a GSoC microproject.
>
> Thanks for your interest ;-)
--=20
Duy
