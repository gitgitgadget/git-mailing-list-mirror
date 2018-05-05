Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24A28200B9
	for <e@80x24.org>; Sat,  5 May 2018 13:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751267AbeEENnd (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 May 2018 09:43:33 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:34900 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751118AbeEENnc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 May 2018 09:43:32 -0400
Received: by mail-io0-f173.google.com with SMTP id g1-v6so19408093iob.2
        for <git@vger.kernel.org>; Sat, 05 May 2018 06:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+8iSyZjS1TCzz4mpx6XOOwcu0M2SHa9LwELvVRpPIPw=;
        b=LQCXmvIJULPZmv+gjAklQFKxO2od8MmqeLEa2+nClfhKuXJbcLoDNDPaQuF9mynu6/
         o/u+qYMcDpTlWB+cM5GHrLYfxj/a3C+1UcbH5UgRP26Wy7fh4STnaGaJ0Ur9xeTB1XjF
         LwMl6vbe/Nxmt0QrkZoo8V8fXqMHKbNNYVDbsxxWX9QNlJoiDaAF2MKZOVUbitmPMemn
         poKnY2GJZMoHn6vAQc9WC8mjCUiumft5STfrS3AGhyiUkDXIiwD9YElN+r5FbMZgFNNf
         kqZ7SzoFM8hMMEVwJ7mLfvGqBj5uvILqhJI2QD0JP36oq9Sw5a7TlTNFKyV5NcV4KmDm
         JJyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+8iSyZjS1TCzz4mpx6XOOwcu0M2SHa9LwELvVRpPIPw=;
        b=oRC1NTU8cGzHzmZa89RvTrEIacBdDoFLBMqG23gBEh5ybjdAEiozxcg+Nfs0wgvY8O
         jp0ABTP/+FGW0aWiuQhoMRtlusNNPbFBrKdlYZNwtlvZpEfytNqPu/q5UmNPcoNPfrv+
         96R4Qna5qVdR9gokjPsO5q581SxK7WlQRIdjNv6J7prSPJpDgklwZV6VvSqITASvOYu/
         G4vrefxutHKfB317IuoLEtaTVs36lKTgIO8OgJ0ct6zav4wpMfS0XoOMWSQLx/gLxHN3
         hG3HBwgCAeVxVJ4Gn+oY10pOIhNncoORDKVF/wSzxBKkfpvHuP55C24kW7YKxlLNxH+g
         4TWw==
X-Gm-Message-State: ALQs6tAD8Spxn9Mn2hsDWUc0W4mpVx6oNNjux9EIq1V8ZzNbR7H+M3j6
        SfqNME9V6raLqJjYWWxzqKbgxvm3cGRRLr9OyWI=
X-Google-Smtp-Source: AB8JxZr2g0hhnc3/B8CGseC0xzjN2BsIJQC1+MxgxTuIKyYTS8FPYiRTPH8K3/aifzhXwhzGW80BM/8CsILsaRD2S1U=
X-Received: by 2002:a6b:1604:: with SMTP id 4-v6mr29959428iow.147.1525527811549;
 Sat, 05 May 2018 06:43:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:22db:0:0:0:0:0 with HTTP; Sat, 5 May 2018 06:43:31 -0700 (PDT)
In-Reply-To: <CAOZc8M9sESwyMQvCq5RpfD=-RYAxQRZ-UxoRBdESriD92xxZwA@mail.gmail.com>
References: <917621a4-b46a-95aa-dccc-905c0cd32b1d@gmail.com> <CAOZc8M9sESwyMQvCq5RpfD=-RYAxQRZ-UxoRBdESriD92xxZwA@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 5 May 2018 15:43:31 +0200
Message-ID: <CAP8UFD0P1zwKD+hz-Z96J15wZUmLKUubqWT7iPHGs8D_sk8dZg@mail.gmail.com>
Subject: Re: [GSoC] Yet another blog series about the GSoC
To:     Pratik Karki <predatoramigo@gmail.com>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Git List <git@vger.kernel.org>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pratik and Alban,

On Sat, May 5, 2018 at 2:24 PM, Pratik Karki <predatoramigo@gmail.com> wrote:
> On Sat, May 5, 2018 at 5:11 PM, Alban Gruin <alban.gruin@gmail.com> wrote:
>>
>> as my fellow students, I started a blog series about my GSoC project[1].
>> First, I wanted to post them directly on the mailing list, but a blog
>> allows me to edit the content easily if needed.
>>
>> Any feedback is welcome!
>>
>> [1] https://blog.pa1ch.fr/posts/2018/05/05/en/gsoc2018-week-1.html
>
> Nice post. Great job, Alban.
> Just a little typo I found out there: hazardous -> hasardous.

Thanks both for setting up nice blogs for your GSoC!

Best,
Christian.
