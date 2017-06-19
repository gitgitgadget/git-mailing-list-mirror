Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CA831FA7B
	for <e@80x24.org>; Mon, 19 Jun 2017 14:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750846AbdFSOUY (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 10:20:24 -0400
Received: from mail-ua0-f182.google.com ([209.85.217.182]:34598 "EHLO
        mail-ua0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750761AbdFSOUX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 10:20:23 -0400
Received: by mail-ua0-f182.google.com with SMTP id d45so19925437uai.1
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 07:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=IDR7y+EkjNAiJNtndYlq2339gysM2TOOJ0/fZYcj80k=;
        b=E0/WSKv0F7kUw5SCkjKHWYQVugmfHKe6BKs6nZF4PrIE35H527Um6NuLSo+8mrixqg
         mERa4dwMHQcSEqCKNVSdaHH6xGBFR8vfNdGRKNYWYqDD0R6NYfU/V6LblQPtbbNMzMxy
         +EHdOjMOIP4Mt72yVgIZa6v2fZm1xCQ3GjcuNS1y1a1vqfAMHDEzFEi0hSAiGh7BquGx
         q1uM0Fs+NScTy+V+XfdCL7oCaZ7dlj+zPXo5BYbWzTRUaL23fJCSZufpi/7RJaERsa1M
         TfjPbgiva3Bb7L0bPHvYMEw0LQjCx95gKaRA2MZ54/mB0mlh8nCqNvjJQuC2wqV8Zzz3
         1xqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=IDR7y+EkjNAiJNtndYlq2339gysM2TOOJ0/fZYcj80k=;
        b=FJxRYPycNQ+vETKYHithqYqKITgKXupjsnpS+JxyLDCsmTv5XGHHfg/bEptsnVoN0L
         /J8Z1fknhI4mtDJ3PE+dqsaBJxbTGXIiF3gSb0gPdFQ4sTZALbH2vBuLZkpYjlhfyL7f
         JqpV7BH7EwWLqwl2l0NoLVoAlpHajwtrv2ejNmYgCQSdyPkxfSbvs/D+Jz5DKSyWKX++
         7WVMAqB40tQYsq+IJ2jXvSFAMaBDBOJH2GnoYd9VTo+fG36sdLEOjHmFmHZHzZ1/r0aS
         K+cHpq8pTf0HLXNuz0t5aJSivqSm3bCvYVCON/Cf3x0AIbQe80bfZsPd7aZuFxaTNbuY
         Jmcw==
X-Gm-Message-State: AKS2vOwiIbA70yhwyoAJ0IIThZA4PW8o8JVBMI9I35V+HluU69DRFTDU
        G6U62Qolp9K/CPVMTwqEuIuWYL1pBw==
X-Received: by 10.176.76.23 with SMTP id l23mr13081529uaf.63.1497882022463;
 Mon, 19 Jun 2017 07:20:22 -0700 (PDT)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.159.55.234 with HTTP; Mon, 19 Jun 2017 07:20:22 -0700 (PDT)
In-Reply-To: <xmqqpoec4nib.fsf@gitster.mtv.corp.google.com>
References: <CAHd499BBNsai4SScOe6kADsgbGRLyGnDKyUcm8LZL-w8c9Webw@mail.gmail.com>
 <xmqqpoec4nib.fsf@gitster.mtv.corp.google.com>
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Mon, 19 Jun 2017 09:20:22 -0500
X-Google-Sender-Auth: ZeHrbMSwwJFQF-EONxpI_-Mu_oQ
Message-ID: <CAHd499Aft6yE=8f8DGRVxMYNR5kg6AVs3tECVtz1VDdwFeL5fg@mail.gmail.com>
Subject: Re: How to git push mirror local refs only?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 9, 2017 at 8:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Robert Dailey <rcdailey.lists@gmail.com> writes:
>
>> So I want to update my remote fork with all my local branches.
>> Normally I'd do this:
>>
>> $ git push --mirror fork
>>
>> However this will also push everything under `refs/remotes` which I do
>> not want. And it fails if I specify a refspec parameter with --mirror.
>>
>> Is there a way to achieve this through one or more git commands? Note
>> I'm doing this on a non-bare clone and have to keep it that way since
>> I'm pushing branches I actively work on.
>>
>> An intrinsic benefit of what I'm trying to do is that the mirror
>> command will also batch delete branches on the remote that do not
>> exist locally, which is behavior I want since I do not need them
>> anymore.
>
> Something along this line in your .git/config:
>
>         [remote "fork"]
>                 url = ...
>                 push = refs/heads/*:refs/heads/*
>
> and then
>
>         $ git push --prune --follow-tags fork

Sorry for the late reply, I was out of town all last week. Thanks for
your help. Does this serve as a good general default? I can't imagine
a case where I'd ever want to push something inside refs/remotes.
