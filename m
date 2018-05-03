Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5AFF200B9
	for <e@80x24.org>; Thu,  3 May 2018 01:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752006AbeECBtq (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 May 2018 21:49:46 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:46194 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751862AbeECBtq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 May 2018 21:49:46 -0400
Received: by mail-wr0-f176.google.com with SMTP id o2-v6so12944620wrj.13
        for <git@vger.kernel.org>; Wed, 02 May 2018 18:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=teqDmhPU66wyoC87mQK5t5eFjEtNYUwb7QsmhfX99hU=;
        b=b61zWfrn9XhOkHCdZgbJrgnSKB/zQ2fDsHQr3YAfhLvw5VKqxPHvtdxTS0gJO2g6hS
         L8tiVMHUWLHhx1gRPAlkdReXYXXl/M+3cBdaGIb7FeDTD5j+VQ6tjep3IYR9fYAwT9BB
         jEJIsm26WmRLFAd/TH3LmVcc4+M4FEUVhyBSOi/pqmveyDBOMiOfbXCacu6js5Wul8Vo
         P5c86zhXaMRR5NiSyELYFBSVfWKLnreiFPa7pHeMMQAQDjUZQPtCg4M0tmAR8+MlodVF
         QXENfOLCdnMu9ZM+B5CfacnZpKCH+RYdPawoTasFesUWInLlbT86gtw6xTn2X9aO4QFe
         pZqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=teqDmhPU66wyoC87mQK5t5eFjEtNYUwb7QsmhfX99hU=;
        b=VnPQbRtiRVo6N3iKXbP6KRq5u+DzOUKaR2od4i4qeENVm1Jwr2N6fmnLHBovYjb4Q9
         Vl1E6n7bCUGFJfDYWIBNlY1v6oXUrzvA/7DohsWe5/fCDM1OsUYH7JHx2Vydz1+quaHw
         z+ejlUamoP8BfTAbUPNSE1jAnhQ/0U/fun7E2YiL43tHXtIv4Rq5NKtsKkIziw2DOdh6
         OAtHuqBDhkx7xO+OF1E1Hlp/9nLcKgQYyyAOKeWJsKg76N61BhopB5wWuBFypCM+YJdI
         Q0x2yg1omsivVMhxpPVY+/AzC9CXECxNmA8C4ghIX6aY7emIkDvS/OBqew2KgkkRaWcn
         A7Qw==
X-Gm-Message-State: ALQs6tA+mumT9Is5PpTrheGs8QF/LVlCAzzgQz2D4f0uFYHbzbkm9jOW
        UK9U5vyLBDWHplxWzc7EcU5QiEGm6BQdfGtxS5Q=
X-Google-Smtp-Source: AB8JxZqoBUjBZr203zK9DRGDXCWG0UCJGclc+ebGdw/oDmu1po758l5QjCsJBlmDFQtn8qsrnCj4ajlcCmtU3CNj0Oo=
X-Received: by 2002:adf:b88f:: with SMTP id i15-v6mr15568682wrf.163.1525312185005;
 Wed, 02 May 2018 18:49:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.142.82 with HTTP; Wed, 2 May 2018 18:49:44 -0700 (PDT)
In-Reply-To: <CAH5451mJO3Bgg9DST57fqcGGU-SPrcSECjXi0qOqeKsW0uaRzg@mail.gmail.com>
References: <20180502033925.6744-1-predatoramigo@gmail.com>
 <nycvar.QRO.7.76.6.1805020912210.73@tvgsbejvaqbjf.bet> <CAH5451mJO3Bgg9DST57fqcGGU-SPrcSECjXi0qOqeKsW0uaRzg@mail.gmail.com>
From:   Pratik Karki <predatoramigo@gmail.com>
Date:   Thu, 3 May 2018 07:34:44 +0545
Message-ID: <CAOZc8M86gbBy99=+oWaYGhsmJFE+W-koNFQAYDT_CoVQBhm2Zw@mail.gmail.com>
Subject: Re: [GSoC] Info: new blog series of my work on Git GSoC '18
To:     Andrew Ardill <andrew.ardill@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 3, 2018 at 6:31 AM, Andrew Ardill <andrew.ardill@gmail.com> wrote:
> On 2 May 2018 at 17:12, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>> Hi Pratik,
>>
>> On Wed, 2 May 2018, Pratik Karki wrote:
>>
>>> As promised in my proposal, I've started
>>> to write a blog series of GSoC '18 with Git. The initial blog is up.
>>> You can find it here[1]. The initial one is just to get started and
>>> from next iterations, I'll start detailing of my work towards converting
>>> rebase to builtin.
>>>
>>> [1]: https://prertik.github.io/categories/git/
>>
>> This is awesome! Thanks for doing this,
>> Dscho
>
> Agreed, was fun to read.
>
> I'd encourage you to post to the list when you blog, or perhaps
> include a link to the blog as part of any regular updates you give on
> your project progress.
>
> Would also make for an interesting addition to the newsletter.
>
> I know it can be difficult to sit down and write about what you're
> doing, especially when it feels like you could be focusing on 'real
> work'. Hopefully you will find the process rewarding; I'm looking
> forward to reading about what you find easy and hard, how you learn
> the git developer processes, and the challenges you find in converting
> shell scripts to a built-in. I'm sure other people are too, and I'll
> bet the ones who have been there before will have feedback for you as
> well.
>
> I'd find it interesting even if it was a 5-line bullet list of what's
> going through your mind with respect to the project! Looking forward
> to following along.
>
> Regards,
>
> Andrew Ardill

Thank you. Feedbacks mean a lot to me.
I will be writing a weekly blog of the progress
I made during the week. I will try my best to detail
things I did and intend to do. I will surely notify
everyone as soon as I publish a post.

Cheers,
Pratik Karki
