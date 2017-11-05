Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27EAE20450
	for <e@80x24.org>; Sun,  5 Nov 2017 07:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752133AbdKEHa6 (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Nov 2017 02:30:58 -0500
Received: from mail-vk0-f44.google.com ([209.85.213.44]:44117 "EHLO
        mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751917AbdKEHa5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Nov 2017 02:30:57 -0500
Received: by mail-vk0-f44.google.com with SMTP id x65so4066089vkx.1
        for <git@vger.kernel.org>; Sun, 05 Nov 2017 00:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Fxi7DDzlVrD4n8xN6CLK7utcXS3jTH08JNFDMf1dmIY=;
        b=O8KZJhKF3mG1xw98GrbJXUEQPrngPiTtR63n8xH7V1r2j98wdGDPFiW+E7u0RVsGcD
         wXR9JDGGAm5wohAUTCJ2lVQjqEpu5CeWYwaccBhwlNVaMIzN7gZ70OfckOYq3Taik+mB
         aZ+5UXL7D3hKNVbI1tFCWldetZ5eShY+m71fmXuvN/28aehrsaQ7QvA8rS1fQY2dw22Q
         9VYCkgvwHxVLYxkdUD4vwKGK+AwGcksFZ7V/5Lh6gz3zQUcfNq7L59Ao3spcmmi+MXHK
         8BltRO3ZqB5vceyZkKb8N3guyZCBlke4oE7i/WFIX+c37nqbo+GnWxBZgs6LdOU4yS0F
         NKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Fxi7DDzlVrD4n8xN6CLK7utcXS3jTH08JNFDMf1dmIY=;
        b=Cdv0j/O2U6ASbIYq3Fn1qCekLBZ7mcsrZ3iCVq8yMY7f7XPp2S7et+0I5JyCC84DxX
         VbMUr80WuI7LizCuqtHOa7wY9fkAqbp7J3qZMGX0XHkLFFowdzYDQf7w1HrM0MWN1HWm
         t4Kq35/R1Yf42ad48gnf/hX0oAysOuKENZMj54Fs5fqu8tCHMKKlXPTjiGvojuHUsY/2
         9X0uj4++XOGTxcXgcDbqdSunonBiDegvvKxsBb6ISMF7ssY7LCY2e73C3It3hUvlkCBW
         ahOiikzFbQZLAWi4SDSN3ku2mf6VTFmAezAf2IDeW574tUIL10wOkYcIyw9U58sgSqXI
         BzVw==
X-Gm-Message-State: AMCzsaVM2RmIwNqWz7kZ5hnY/u60ebLJQ7B1pIW58SzCkbEbjXxf+cZK
        t878OA/G/k8ay/YFoGSRfWaIsPDu+alEVnTxMV8=
X-Google-Smtp-Source: ABhQp+QXE2bAq6a0zk8cHScuJ+7VaZI+n1P/wXeuPBeQZOm0qOjRsv+b0WB245m2YUhwvto0E0yeUgxaZkKiiXAy4mw=
X-Received: by 10.31.16.35 with SMTP id g35mr9460468vki.131.1509867056951;
 Sun, 05 Nov 2017 00:30:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.159.56.100 with HTTP; Sun, 5 Nov 2017 00:30:56 -0700 (PDT)
In-Reply-To: <CAGHpTB+23H=iC_uv0K=GajnCBHSVRsUYgGFUn9-bAdcX=azL-w@mail.gmail.com>
References: <CAGHpTBJTm=3f_VCnNLeE=V4CwvC6dM8qCmGRPDap6rszcpb65A@mail.gmail.com>
 <alpine.DEB.2.21.1.1711031658190.6482@virtualbox> <alpine.DEB.2.21.1.1711031711530.6482@virtualbox>
 <CAGHpTB+23H=iC_uv0K=GajnCBHSVRsUYgGFUn9-bAdcX=azL-w@mail.gmail.com>
From:   Orgad Shaneh <orgads@gmail.com>
Date:   Sun, 5 Nov 2017 09:30:56 +0200
Message-ID: <CAGHpTBJFR2Y+Sg-xQzBpC6qu+NKPDSYyMwSe9Py9FtD2-bRAXg@mail.gmail.com>
Subject: Re: Regression[2.14.3->2.15]: Interactive rebase fails if submodule
 is modified
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 4, 2017 at 8:04 PM, Orgad Shaneh <orgads@gmail.com> wrote:
> On Fri, Nov 3, 2017 at 6:20 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>> Hi Orgad,
>>
>> On Fri, 3 Nov 2017, Johannes Schindelin wrote:
>>
>>> On Thu, 2 Nov 2017, Orgad Shaneh wrote:
>>>
>>> > I can't reproduce this with a minimal example, but it happens in my project.
>>
>> Whoa, I somehow overlooked the "can't". Sorry.
>>
>> I inserted a `git diff-files` here, and it printed exactly what I
>> expected:
>>
>> ++ git diff-files
>> :160000 160000 62cab94c8d8cf047bbb60c12def559339300efa4 0000000000000000000000000000000000000000 M      sub
>>
>>> +             git rebase -i HEAD^^
>>> +     )
>>> +'
>>
>> There must be something else going wrong that we did not replicate here.
>> Maybe the `error: cannot rebase: You have unstaged changes.` message was
>> caused not by a change in the submodule? Could you run `git diff-files`
>> before the rebase?
>
> It's the same before and during the rebase:
> $ git diff-files
> :160000 160000 c840225a7cf6bb2ec64da9d35d2c29210bc5e5e8
> 0000000000000000000000000000000000000000 M      sub
>
>
>>
>> This does *not* refresh the index, but maybe that is what is going wrong;
>> you could call `git update-index --refresh` before the rebase and see
>> whether that works around the issue?
>
> Nope.
>
> If I run git submodule update, then rebase --continue works fine, so
> it's definitely somehow caused by the submodule.

I just checked out v2.15.0.windows.1 and reverted ff6f1f564c - it
solves the problem. I still have no idea how to minimally reproduce
(in my project it's easily reproducible) :)

- Orgad
