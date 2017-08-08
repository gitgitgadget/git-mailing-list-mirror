Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AB7E20899
	for <e@80x24.org>; Tue,  8 Aug 2017 17:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752105AbdHHRk1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 13:40:27 -0400
Received: from mail-lf0-f45.google.com ([209.85.215.45]:34072 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752030AbdHHRk0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 13:40:26 -0400
Received: by mail-lf0-f45.google.com with SMTP id g25so18008779lfh.1
        for <git@vger.kernel.org>; Tue, 08 Aug 2017 10:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PCmFELiB2UxairimEc+I0Wc0I+KLmIO/8EUYypjUx2w=;
        b=qrs40mpulyB33ZVnGx4Orf0y7b+cM2EFHRXkUvzJvT6xVamLZMclr9xZpPiCg9hOCr
         70pLbQUUODMjOK1VNMlBYVrZ1pL3e0xt+wT7TiVBwk+7nUfZyiL2P576vA2tUlaBMbze
         poBIiGEdwns7QnOY2/WRbUAQrmcfMNWxoaI/FlNzytVgUhYnDjjxMVNg0q9+QvHafdfO
         YknEt+brQYWvH4frBgohhwP6xBJF4XoVnWm8JT5oBzU95awNTf3NlNeuEcObNn7zU9Fn
         mZAYY48219eQwm0abWgVGwbvSm4Fn7ZsT+bXeSpNsk8Y8G7iGGLiwL2eL5/ooZMTUbVq
         ptFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PCmFELiB2UxairimEc+I0Wc0I+KLmIO/8EUYypjUx2w=;
        b=uM9aL7hk0fyhNrZPJJY2drWIU8b2UIXE41X0IZAjPRkrUZbIzcwbiEGwjMkfaoPPCR
         6TZ+XmKtzTr3bVkK//VMqq8yjZkwFIpO/PC3Ge/zJhsdcDxm+mViHFJ38cfbg1NY7RLZ
         40wOYCKl75+WGrt46ToL3C71i+AwViHLs+AiN13mVUVPajS7okErjng9yOu9Exj2OUbP
         dvEbkNWXInA4AARWnmBhDxpb7/nhHZUwmgHhwUMeFvjO5jKrRIzGZqhoyUYqvgZEh8NA
         jy6ojm6WVAWAUXfTSC5Awa6jWBN8kTE6yu9UVWBKMTgISHQjn3/+TTioiUAbNzXmY8Ef
         2yqA==
X-Gm-Message-State: AHYfb5gNtVWKPOujC91Xijd4li8RE3QASKkcW4sYmWpWvScFa/jSDPzu
        oVHLZwnNPm+ioLtQdgagPQUBTjKCVAQF
X-Received: by 10.25.232.41 with SMTP id f41mr1991215lfh.90.1502214024993;
 Tue, 08 Aug 2017 10:40:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.1.130 with HTTP; Tue, 8 Aug 2017 10:40:24 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1.1708081404200.4271@virtualbox>
References: <20170808012554.186051-1-bmwill@google.com> <alpine.DEB.2.21.1.1708081404200.4271@virtualbox>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 8 Aug 2017 10:40:24 -0700
Message-ID: <CAGZ79kb2860nUs46bP=x-gAx9Ao6DxnvXQv3x387Wxw+kEyxJw@mail.gmail.com>
Subject: Re: [RFC] clang-format: outline the git project's coding style
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 8, 2017 at 5:05 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Brandon,
>
> On Mon, 7 Aug 2017, Brandon Williams wrote:
>
>> Add a '.clang-format' file which outlines the git project's coding
>> style.  This can be used with clang-format to auto-format .c and .h
>> files to conform with git's style.
>>
>> Signed-off-by: Brandon Williams <bmwill@google.com>
>> ---
>>
>> I'm sure this sort of thing comes up every so often on the list but back at
>> git-merge I mentioned how it would be nice to not have to worry about style
>> when reviewing patches as that is something mechanical and best left to a
>> machine (for the most part).
>
> Amen.
>
> If I never have to see a review mentioning an unwrapped line, I am quite
> certain I will be quite content.
>
> Ciao,
> Dscho

As a thought experiment I'd like to propose to take it one step further:

  If the code was formatted perfectly in one style such that a formatter for
  this style would not produce changes when rerun again on the code, then
  each individual could have a clean/smudge filter to work in their preferred
  style, and only the exchange and storage of code is in a mutual agreed
  style. If the mutually agreed style is close to what I prefer, I don't have to
  use clean/smudge filters.

Additionally to this patch, we'd want to either put a note into
SubmittingPatches or Documentation/gitworkflows.txt to hint at
how to use this formatting to just affect the patch that is currently
worked on or rather a pre-commit hook?
