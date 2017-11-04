Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D2B5202A0
	for <e@80x24.org>; Sat,  4 Nov 2017 18:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932400AbdKDSE1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Nov 2017 14:04:27 -0400
Received: from mail-vk0-f46.google.com ([209.85.213.46]:56570 "EHLO
        mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932148AbdKDSE0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Nov 2017 14:04:26 -0400
Received: by mail-vk0-f46.google.com with SMTP id g11so3559104vkd.13
        for <git@vger.kernel.org>; Sat, 04 Nov 2017 11:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NqbOA0y8msqhDyCDjPNoGgQnYhJvILTA6Tc3/546r68=;
        b=c8+PnZIEnRE6xcZ2asYa1M6uOBcdMzPmS5mH4sWN2Ubk4sUqYKmjDH19I7dOgHVhDy
         f+mY3QvtzyFmcgUO1qD/ZJjn18gUDFUiLOU6abf/VaNO9goTbOXiwhyyhRflJyx7MxAi
         UjG4ObNo5YoXUoGJXIEgGY4Xohq464+e9KDLkDN8WwcAG7wXWxQQkSrW1BKSZ6LuHk55
         ejURweQgHdFjphzv8Sdh310Ohd3aZCiUdgsVjZWSGKVmp8fmO9Gj7JR6dOvAprIIqRVO
         /WI+5abMKxXQeySBuaY/2w1l7pUsnSmevqBinFLVrNRzYuCx95h5aWHmj9J8s24dVByf
         n7+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NqbOA0y8msqhDyCDjPNoGgQnYhJvILTA6Tc3/546r68=;
        b=AKljlwZdJ7H9UHhJ9zxLGEKdjKW5Ei60N3Gs6Hq6dT8VLTXP6Znw4Xk7/FShzJkenq
         P6kfB7Yo+A6M0fQzvSJ/JvHSiaGpyaj9y5J1C8Xhf2ztjgRy+lsLQv5URqWHB8IK10S7
         pd+vzkWoFdZwXKK5k4HrT2U406eDNanm32xHBlA7rge1XwRyCnkoqPBUbeqtOT5RAwvZ
         QRyIOIS03ixTvYLRFKjpKuWURw41X/Ixq8Uq5MR0IEd3c2U+uqRF8WZD5lw4/gKs/O3y
         fZZvNv319oXV1Hu4AdeaMcQrO94G9JQxbZO1QdzDKkFpBuTIbbNOKb1cxvkaw0ISUtM2
         dsoQ==
X-Gm-Message-State: AMCzsaVcdrD3ZNrwX+20r7XlhXQVqYwBkyUGyX6bPjObmTAXJIM2epwF
        snhQWfkn0es6fpVL9d0SeMjAok//7L5S5r0WNkM=
X-Google-Smtp-Source: ABhQp+Rj99haYmkGEWVmbKCtAh5iVvj8QMux1b6CHYWq7tmDsBTEYGYf6tDfVVYw6D6yuzCDqlqiZze1HY/Xxuw9JSo=
X-Received: by 10.31.16.35 with SMTP id g35mr8526949vki.131.1509818665331;
 Sat, 04 Nov 2017 11:04:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.159.56.100 with HTTP; Sat, 4 Nov 2017 11:04:24 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1.1711031711530.6482@virtualbox>
References: <CAGHpTBJTm=3f_VCnNLeE=V4CwvC6dM8qCmGRPDap6rszcpb65A@mail.gmail.com>
 <alpine.DEB.2.21.1.1711031658190.6482@virtualbox> <alpine.DEB.2.21.1.1711031711530.6482@virtualbox>
From:   Orgad Shaneh <orgads@gmail.com>
Date:   Sat, 4 Nov 2017 20:04:24 +0200
Message-ID: <CAGHpTB+23H=iC_uv0K=GajnCBHSVRsUYgGFUn9-bAdcX=azL-w@mail.gmail.com>
Subject: Re: Regression[2.14.3->2.15]: Interactive rebase fails if submodule
 is modified
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 3, 2017 at 6:20 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Orgad,
>
> On Fri, 3 Nov 2017, Johannes Schindelin wrote:
>
>> On Thu, 2 Nov 2017, Orgad Shaneh wrote:
>>
>> > I can't reproduce this with a minimal example, but it happens in my project.
>
> Whoa, I somehow overlooked the "can't". Sorry.
>
> I inserted a `git diff-files` here, and it printed exactly what I
> expected:
>
> ++ git diff-files
> :160000 160000 62cab94c8d8cf047bbb60c12def559339300efa4 0000000000000000000000000000000000000000 M      sub
>
>> +             git rebase -i HEAD^^
>> +     )
>> +'
>
> There must be something else going wrong that we did not replicate here.
> Maybe the `error: cannot rebase: You have unstaged changes.` message was
> caused not by a change in the submodule? Could you run `git diff-files`
> before the rebase?

It's the same before and during the rebase:
$ git diff-files
:160000 160000 c840225a7cf6bb2ec64da9d35d2c29210bc5e5e8
0000000000000000000000000000000000000000 M      sub


>
> This does *not* refresh the index, but maybe that is what is going wrong;
> you could call `git update-index --refresh` before the rebase and see
> whether that works around the issue?

Nope.

If I run git submodule update, then rebase --continue works fine, so
it's definitely somehow caused by the submodule.

- Orgad
