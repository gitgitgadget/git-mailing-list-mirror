Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4A432021E
	for <e@80x24.org>; Mon, 31 Oct 2016 15:27:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S944017AbcJaP14 (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Oct 2016 11:27:56 -0400
Received: from mail-yw0-f176.google.com ([209.85.161.176]:36725 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S943837AbcJaP1z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2016 11:27:55 -0400
Received: by mail-yw0-f176.google.com with SMTP id l124so3580985ywb.3
        for <git@vger.kernel.org>; Mon, 31 Oct 2016 08:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fDx52noUkTknNvJk/WHV66zyq//hkCntR+SBaxFN5XE=;
        b=nAbGP8tD2BCQF5LtaLmOcCcg9HzKTaGkzRV1/kmyqzORlI/MJ0anTcJ/q0/c1eiuIR
         fXvczU+Elf+q5Tp2X+pRRn+9/R0cM04zwviQlkeDIUDgTTccnqQ3u1OGbMm83yMQoSWp
         PzFPU5wPy1HgoraBIixx9i9+zJ+9QXErnUfe6xegqTAvx9WhufYV4ZkcXIrj+Q+8MpTh
         YYl/uu2mx8nsb44kCAlVogwHmqsdbe6aNg/CUsvg+Vk13cknmdOPAL5Te4ztdcuHM2+l
         TyuZgWVjKE/CbIoUKXYr7tlSBjW2kmj4YmXgYn54T73aKO5b+33C1TVZrE87No5RoYZA
         n3Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fDx52noUkTknNvJk/WHV66zyq//hkCntR+SBaxFN5XE=;
        b=NpQPG6nheqzJs6Sr89vE4qxX5O0w07Jl5ITlZILoVeIgQo+p0gOlZGNbtTaEIoGQUn
         sP81wrpt82qDsGaE4mV4zaaXHaxQilLolq0d5efbgYz8quiwi3QGA79I06HM4bJzQJvO
         Id1rtoV482YH7bGg9pYZaeQmeGmsxhRWim059DdRq1vKAIlFAYf53KSnWj3L/RaEuxz+
         9EjjRqkuSEtAIlYEuEKd1lYbswfYO7xrLLFEdL7WF20q74Ds4uePuwXL64ImYwNg2OH2
         4JDNKmQ92HwzWosiac6/6k83xRsBvV5j7dJy2+UuNlOJSjMXOXyr2Zgg/a5c5UXCvs2J
         boHg==
X-Gm-Message-State: ABUngvcrr1m8tmnCLJo3M1YSC01SYpSFTv5tcKmsk4I5cdrTlC8M68tyyWhlY0NhdJ1Pgv7Xf7vyE3n5mYFEQA==
X-Received: by 10.107.140.84 with SMTP id o81mr19993911iod.206.1477927674079;
 Mon, 31 Oct 2016 08:27:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.48.20 with HTTP; Mon, 31 Oct 2016 08:27:33 -0700 (PDT)
In-Reply-To: <CALhvvbYJ8G12Lbe2FgP8PWKZ-LABcw2M-M-zWPkT12UUqq1vaw@mail.gmail.com>
References: <CAKkAvazX1gDzwhQLTbRvxc84sjz72ONy2-P7qWijQUnQqJ+K8g@mail.gmail.com>
 <CALhvvbYJ8G12Lbe2FgP8PWKZ-LABcw2M-M-zWPkT12UUqq1vaw@mail.gmail.com>
From:   ryenus <ryenus@gmail.com>
Date:   Mon, 31 Oct 2016 23:27:33 +0800
Message-ID: <CAKkAvay4YuRuGhub6W308+DmrZtrO3+NWu8NvfB--Mb9Z59Xzw@mail.gmail.com>
Subject: Re: [git rebase -i] show time and author besides commit hash and message?
To:     Alexei Lozovsky <a.lozovsky@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> It is possible to change the format globally via config option
> rebase.instructionFormat:
>
>     $ git config rebase.instructionFormat "%an (%ad): %s"
>
> The format is the same as for 'git log'. This one outputs author
> name, date, and the first line of commit message.

Thanks for the prompt response!
I tried immediately, it works just as you have pointed out.

Just it seems coloring is not supported? probably because
we're inside an editor?

> This option is supported since Git 2.6.

I missed it, what about including a note about this option as
part of the comment in git rebase -i? since that's the place where
people would most likely think about it?

> Or are you interested in a command-line option that can change
> the format on per-invocation basis? I think there isn't one.
> It can be interesting to add it, but I don't think it has much
> utility...

Not much, for git log I'd rather setup an alias "git la", than having to
remember various fields, colors, padding options to have a nice output.
