Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 195C1200B9
	for <e@80x24.org>; Tue,  8 May 2018 02:29:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753878AbeEHC3U (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 22:29:20 -0400
Received: from mail-wr0-f182.google.com ([209.85.128.182]:36459 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753809AbeEHC3T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 22:29:19 -0400
Received: by mail-wr0-f182.google.com with SMTP id p4-v6so333656wrh.3
        for <git@vger.kernel.org>; Mon, 07 May 2018 19:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jw0jcJObK61srj04r+EpbnKx1YpOLwQogdTBjXa9ETw=;
        b=EKIj7B2CJByTfvfvjd3rQdqaUEVKzF66dn5kTdB833HF2DI/omufj9NLHfnyGU3rkU
         ZQnOkodfXKJhrPfdVSb+T8+rg0eVyapG6wP1GvcgR1iAxv580t/YjoeYAj64PNZGHTjs
         DOQa+d8k8y/k8lI83jryuUkjQ8Fb8jemcYA2B4C4b3QgtdQalxV3Jo5/RssEAZ3H0rwE
         S/YjhPk08XybB1GamYrnMiXto3RHOAoHl9G23tr9UuGsg4SzRTGrvgG6Cddi5a5DLGxo
         h8zd72SaAeIa1L62yr67XrmpwH4pBoIFHK3XPnbGwqCCvAKbsHKqOi6fRcld6QNlAVeq
         +ICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jw0jcJObK61srj04r+EpbnKx1YpOLwQogdTBjXa9ETw=;
        b=BlCITjLShFdNT4l1xYrAnYVI+AGtgv45EhAccwUYpGzSFFhxKeJPWz0BH5qgMULr6M
         yi4WKUaqgzMq1TVHmirVJElaETqHxnNZps3LIeqFUg9bN+Z17/fs0Sttv14jYa/fUHs7
         gmD6hn9GEjJCUPxZpP4s3nw0wENhFzeo3jUKwIPmKjELBmfX9Y0oCjNVJ0AWBmt9DFa3
         msfDyVzRV4wgjOpa4N7m7TM3akj3IALwI1YYiG1DtqbzV2LJi0FSkZnps37sKjd3bvd0
         o3X2lQuKYNoQ58P8UGjdW6xDq9YnkO4OeHL/X5CAbZA7jM+LjLbnB9vyJyI9P4JXqFTa
         P3fw==
X-Gm-Message-State: ALQs6tAF9GaPIL8SXeOhM/PAUyYygSdFmvqwTF0v9R4BoQQYPEr84Kb1
        C6vbOriHpyYtBPMzFml5fp2VnrPIcWHv5S00y2c=
X-Google-Smtp-Source: AB8JxZqtArY3kE59v+u/Y/tPc132AFuR66C2Us5qWwp0Ybzr+TJmYkq+byvN8/URynUoRCntJuwWkwa2m2IQAnhH/po=
X-Received: by 2002:adf:8df7:: with SMTP id o110-v6mr33303586wrb.251.1525746558213;
 Mon, 07 May 2018 19:29:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.142.82 with HTTP; Mon, 7 May 2018 19:29:17 -0700 (PDT)
In-Reply-To: <CAGZ79kZU-LsQqYxUeFzxk+6wpmUY0rKpWBa4Us+n9c60JE-frg@mail.gmail.com>
References: <917621a4-b46a-95aa-dccc-905c0cd32b1d@gmail.com>
 <CAOZc8M9sESwyMQvCq5RpfD=-RYAxQRZ-UxoRBdESriD92xxZwA@mail.gmail.com> <CAGZ79kZU-LsQqYxUeFzxk+6wpmUY0rKpWBa4Us+n9c60JE-frg@mail.gmail.com>
From:   Pratik Karki <predatoramigo@gmail.com>
Date:   Tue, 8 May 2018 08:14:17 +0545
Message-ID: <CAOZc8M934x8HWiPVmv7OkaApjNkQ-t5jw51Fv9Zg7pwCyLt_HA@mail.gmail.com>
Subject: Re: [GSoC] Yet another blog series about the GSoC
To:     Stefan Beller <sbeller@google.com>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Git List <git@vger.kernel.org>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 8, 2018 at 12:20 AM, Stefan Beller <sbeller@google.com> wrote:
> Hi Pratik,
Hi Stefan,

> On Sat, May 5, 2018 at 5:24 AM, Pratik Karki <predatoramigo@gmail.com> wrote:
>> On Sat, May 5, 2018 at 5:11 PM, Alban Gruin <alban.gruin@gmail.com> wrote:
>>> Hi everybody,
>>>
>>> as my fellow students, I started a blog series about my GSoC project[1].
>>> First, I wanted to post them directly on the mailing list, but a blog
>>> allows me to edit the content easily if needed.
>>>
>>> Any feedback is welcome!
>>>
>>> [1] https://blog.pa1ch.fr/posts/2018/05/05/en/gsoc2018-week-1.html
>>>
>>> Cheers,
>>> Alban Gruin
>
> Thanks for blogging about GSoC!
>
>> Nice post. Great job, Alban.
>> Just a little typo I found out there: hazardous -> hasardous.
>
> I would think hazardous is correct, both in British as well as
> American English, I cannot speak for more.

I believe I kept the notation wrong in the mail I sent earlier.
Actually, Alban had hasardous typo. I corrected him.
I guess the notation should have been: hasardous -> hazardous.
Sorry. :-)

Cheers,
Pratik Karki
