Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EC261F404
	for <e@80x24.org>; Sat, 24 Mar 2018 19:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752715AbeCXTbT (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 15:31:19 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36687 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752633AbeCXTbR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 15:31:17 -0400
Received: by mail-wm0-f48.google.com with SMTP id x82so8869611wmg.1
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 12:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0P0K+oJdGZJ76GIlp7jsFDxg8xoCsBAHcF4H7CmUxSc=;
        b=knMO42x7msjw4jJGUW6qel668EpZk6yk7bknW0DrCs90Fv4uRYau4HwCuR0xWq1RKs
         fiI/5L+3O9C5xcZArVsZV16E17ubD8fDdqLj6BN1poii0OllMdUlz0a4wfOfQBIz25sh
         g/Sx6L8ZlOn/PARNqqA3eZsJiO951mAIw9XRKjazn65/3ZCYg7YfdhE+SABklzL5WomQ
         WmJkC1Zt6EvTsosTx4cepAHIgBJ0qiuuPjpoQxkHrHn2prMDTZyYnLjNM4GEA3M8fu+J
         NmsN+LsVzj1FDDAhusjXrVsIXdc74dx8TWBastRoHysYquCTiQr2mBgJwcB+Py23WIhB
         6IxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0P0K+oJdGZJ76GIlp7jsFDxg8xoCsBAHcF4H7CmUxSc=;
        b=XJ+76vFeqH0OscEibOlP89ji31qu3/unaOkx3isMJASKVRl1mqeHadLZ2LcBtuJ1C5
         7oykuRp6nPG51iqaPQtMnkFtQ6OjdZ6LSJ/wy+0JehFpHnBlF3mW7dV5TxpksqvZ2zSt
         9HALbe1ZD2SZyKost9qLRDZ5727jEsIo1+a0szXfGiYuhg4pkQo1tdyFG+NY0qFrsu3h
         NpJ2kH5VZY1BDby3l96CSg9s4p7h7n4/an7pG4oWA+mXH1QfM62Er6WhMIhIZyK9dgRq
         yW50yExLMQR2Wt5KTUwaWK13xOg90PygrJcp5/tRhbENPsDmyw1uUJET4HJPc1PtrhoL
         8c6A==
X-Gm-Message-State: AElRT7HVdUXWvEJjGvPX05e4u91aA63ec0A9L7hgIf2RGYO67ZcggOBQ
        2vzUTEENL7Ehlje/B6P1b5E=
X-Google-Smtp-Source: AG47ELteiEPbktQyyGR0JLtzmehBnEcv1i0IDfHeM+VLRD31mN+hJ3q31bheUZ8iIvdkGQAvLR1t/A==
X-Received: by 10.28.138.6 with SMTP id m6mr12459813wmd.146.1521919876358;
        Sat, 24 Mar 2018 12:31:16 -0700 (PDT)
Received: from [192.168.0.103] ([92.55.154.10])
        by smtp.gmail.com with ESMTPSA id x128sm10643159wmg.20.2018.03.24.12.31.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Mar 2018 12:31:15 -0700 (PDT)
Subject: =?UTF-8?Q?Re:_[GSoC]_Convert_=e2=80=9cgit_stash=e2=80=9d_to_builtin?=
 =?UTF-8?Q?_proposal?=
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <1521576562.2188.10.camel@gmail.com>
 <CAP8UFD3NKCSN8mVDiCUzvor5uZh4nFCAw4T0zgxpvHLf9AWmyA@mail.gmail.com>
 <1521760546.11809.20.camel@gmail.com>
 <CAP8UFD3bRaPke8MvubZ3+v6RrY7K7Peip1dpQ2LG9kxKoXcmbw@mail.gmail.com>
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Message-ID: <6603149f-776a-fde8-5d11-a7d9d6d37e96@gmail.com>
Date:   Sat, 24 Mar 2018 21:31:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAP8UFD3bRaPke8MvubZ3+v6RrY7K7Peip1dpQ2LG9kxKoXcmbw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23.03.2018 19:11, Christian Couder wrote:

>> * Ensure that no regression occurred: considering that there are plenty
>> of tests and that I have a good understanding of the function, this
>> should be a trivial task.
> 
> There are a lot of things that the test suite doesn't test.

Hopefully, by first adding new tests, any eventual bug will be spotted.

>> * In the end, an analysis based on performance can be made.
>> Benchmarking the script will be done by recording the running time
>> given a large set of diversified tests that cover all the
>> functionalities, before and after conversion. The new commands should
>> run faster just because they were written in C, but I expect to see
>> even more improvements.
> 
> If you want to do benchmarks, you might want to add performance tests
> into t/perf.

That is great. I will surely make use of the existent testing framework 
to do benchmarks.

>> ## Example of conversion (for “git stash list”)
>> ------------------------------------------
>> To test my capabilities and to be sure that I am able to work on a
>> project of this kind, I tried to convert “git stash list” into a built-
>> in. The result can be found below in text-only version or at the Github
>> link.
> 
> I think it would be better if it was sent as a patch (maybe an RFC
> patch) to the mailing list and add the link to the patch email in the
> maling list archive to your proposal.

I sent it as a [RFC] patch to the mailing list and included it in the 
proposal.

<https://public-inbox.org/git/20180324182313.13705-1-ungureanupaulsebastian@gmail.com>

> It could be useful if you described a bit more how you could (re)use
> the work that has already been made.
> 
> In the rest of your proposal it looks like you are starting from
> scratch, which is a bit strange if a lot of progress has already been
> made.

The patches about converting ‘git stash’ are a great starting point and 
I will definitely use them. Each time I start converting a new command I 
will first take a look at what other patches there are, evaluate them 
and if I consider the patch to be good enough I will continue my work on 
top of that patch. Otherwise, I will start from scratch and that patch 
will only serve for comparison.

One other resource that is of great importance is git itself. I can 
learn how a builtin is structured and how it is built by considering 
examples the other Git commands. Having a similar coding standard used, 
the codebase will be homogeneous and hopefully easier to maintain.

Another important resource are commands that are Google Summer of Code 
projects from previous years (2016 and 2017) which had as purpose to 
convert “git bisect” and “git submodule”. I can always take a look at 
the patches they submitted and read their code reviews to avoid making 
same mistakes they did.

> It is probably better especially for reviewers and more common to work
> in small batches, for example to send a patch series converting a few
> related commands, then to start working on the next small batch of
> commands in another patch series while improving the first patch
> series according to reviews.
> 
> Also we ask GSoC students to communicate publicly every week about
> their project for example by writing a blg post or sending a report to
> the mailing list.

Noted.

>> ## Git contributions
>> ------------------------------------------
>> My first contribution to Git was to help making “git tag --contains
>> <id>” les chatty if <id> is invalid. Looking over the list of available
>> microprojects, there were a couple of microprojects which got my
>> attention, but I picked this up because it seemed to be a long-standing
>> bug (I noticed it was approached by students in 2016, 2017 and now in
>> 2018). Thanks to the code reviews from the mailing list, after a few
>> iterations I succeeded in coming up with a patch that not only fixed
>> the mentioned problem, but also a few others that were having the same
>> cause.
>>
>> It got merged in the proposed updates branch.
> 
> What is its status in Junio's "What's cooking in Git" emails?

It is now in the ‘next’ branch of the Git repository.

I updated the proposal, in which I included these ideas and some 
additional examples. Thank you a lot!

Best regards,
Paul Ungureanu
