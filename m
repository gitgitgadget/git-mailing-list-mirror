Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A3141F404
	for <e@80x24.org>; Sun, 25 Mar 2018 14:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753230AbeCYOiZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 10:38:25 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:51911 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751094AbeCYOiY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 10:38:24 -0400
Received: by mail-wm0-f53.google.com with SMTP id v21so11011483wmc.1
        for <git@vger.kernel.org>; Sun, 25 Mar 2018 07:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=q+CJkiEOwKTOdoRv4StloItiVjBY7YaSLeYo/wX2fyw=;
        b=DoB4zH0EslYag1BqINBAOOTM79DHvJpfTK3qSM7llopX0aXgFYSgBfo8Jtuyazdwao
         2h3/oQiQg2TTOdZm1IpT/uk6aJbBCfr5hkWLHHFUz7WUipGEFLfWPg4S+EQ4UKNcsxED
         XN9PzRCvp0h/9uXhHw1JG6q8mTi9/b+9C7/XS0K0mkJkYtwiXdn/QaZgWcR1n4OeZSeH
         fOKikqzN2j73+Y4r4rGQGcGAHsmuOBhjczWHXSe8xSGgVVn9/EByyvTEPli1Wo1eIbyq
         eVSMUtc35vJPhYJazkuUV8Nzyp7P4SkNTfYzuZ9zmQF8KX9WksnPzMv+PY33jzXBaYRY
         mfEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q+CJkiEOwKTOdoRv4StloItiVjBY7YaSLeYo/wX2fyw=;
        b=sN0n/X8IwODcnVaHnM3+nggpvUn224pKoay/Wsmi1e/lNv11V5NoXBP5UgPyyFeNWE
         nmqttJgt/EDwDEN7I43pnhBRmzZwPZvmpLCwM5dx8QoIGZIMihRWrA8hGnYG80ZyB0nP
         Rq7XVjgJeJOveMaN3ajPufF2TS+ZqTxTJUFLanbMHeSnQ0ZwYPqEuUvx6W7bTweSY03q
         oZANkgzNXVw7ZrEtr+KfLnE+IILuCTOOcBoebU9y8jj7ZBnJBQIIJl6L9L6K5XYwlfMR
         vjQuKvfazt8pDf/UBQzIeJ1vm0Ec22vRKyJJvRlE8WP6gdj/5r1c9mJnfWNjVG/19aBs
         17pQ==
X-Gm-Message-State: AElRT7HT9MSvri9ygiIlborqQR/Er0ox1dOF4zqkjqBqughiWUAaAMZ1
        De4oCHD+Cprt/WL9/cfHdII=
X-Google-Smtp-Source: AG47ELupd5s9kU0NgRxTmNFvs1x4JlDFFb4e5KyfTviqYoZi9dfGltgBiSkg0ILLXSqWEkIUxHd/eQ==
X-Received: by 10.28.148.202 with SMTP id w193mr12123018wmd.62.1521988703296;
        Sun, 25 Mar 2018 07:38:23 -0700 (PDT)
Received: from [192.168.0.103] ([92.55.154.10])
        by smtp.gmail.com with ESMTPSA id k10sm8422367wmb.26.2018.03.25.07.38.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Mar 2018 07:38:22 -0700 (PDT)
Subject: =?UTF-8?Q?Re:_[GSoC]_Convert_=e2=80=9cgit_stash=e2=80=9d_to_builtin?=
 =?UTF-8?Q?_proposal?=
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <1521576562.2188.10.camel@gmail.com>
 <CAP8UFD3NKCSN8mVDiCUzvor5uZh4nFCAw4T0zgxpvHLf9AWmyA@mail.gmail.com>
 <1521760546.11809.20.camel@gmail.com>
 <CAP8UFD3bRaPke8MvubZ3+v6RrY7K7Peip1dpQ2LG9kxKoXcmbw@mail.gmail.com>
 <6603149f-776a-fde8-5d11-a7d9d6d37e96@gmail.com>
 <CAP8UFD2y605FQeiymO2JNxy7MXs=-vRcN-Z2ri1=ttDF8kccvQ@mail.gmail.com>
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Message-ID: <ad524ce4-8be2-4d14-44cc-2fbc9ff60b79@gmail.com>
Date:   Sun, 25 Mar 2018 17:38:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAP8UFD2y605FQeiymO2JNxy7MXs=-vRcN-Z2ri1=ttDF8kccvQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25.03.2018 12:46, Christian Couder wrote:
> On Sat, Mar 24, 2018 at 8:31 PM, Paul-Sebastian Ungureanu
> <ungureanupaulsebastian@gmail.com> wrote:
>> On 23.03.2018 19:11, Christian Couder wrote:
>>
>>>> * Ensure that no regression occurred: considering that there are plenty
>>>> of tests and that I have a good understanding of the function, this
>>>> should be a trivial task.
>>>
>>> There are a lot of things that the test suite doesn't test.
>>
>> Hopefully, by first adding new tests, any eventual bug will be spotted.
> 
> I was thinking about things like memory leaks that tests cannot easily spot.> 

I will do my best and follow best practices in order to avoid any memory 
leaks. However, to make sure that my code is really leak free, I will 
use Valgrind, which is already integrated with the testing framework.

> Ok. Feel free to resend another version of your proposal.
Sorry for not sending the whole proposal again. I decided to send only 
the changed parts because the proposal is quite big and I wanted to 
avoid sending the same thing over and over again.

One thing I did not mention in the previous reply was that I also added 
a new paragraph to "Benefits to community" about 'git stash' being slow 
on Windows for a lot of users. I consider this alone to be a very good 
justification for this project and doing this project will be very 
beneficial for the Windows users.

Best regards,
Paul Ungureanu
