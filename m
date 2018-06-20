Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85F321F403
	for <e@80x24.org>; Wed, 20 Jun 2018 09:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932341AbeFTJT6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Jun 2018 05:19:58 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53081 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754342AbeFTJTw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jun 2018 05:19:52 -0400
Received: by mail-wm0-f67.google.com with SMTP id p126-v6so4816334wmb.2
        for <git@vger.kernel.org>; Wed, 20 Jun 2018 02:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5P4A4g7hCXT40gL0fp+uSz31MD2vVTplglPqH3xJWGU=;
        b=C0z8cynQHWPWvQCxq3DE2dk58BMHV9r+fUHQHqxxggCaTmtJnxMnB/f/5GmslLbiuV
         yKFtwtEiMmAnykzs0R8qsOBCh13czr2Z0WgJdMzigBS/hs+BPRs/tNVYV6TeLK45wYLW
         69fvfGbBGAHM8DrH/aO17oNBtNXQHj9zArPFHIoSo6eZYX6oIEUbMUFi5ZiiQRw+HjGg
         SV04orQKEi1+d+UOpjkrCI3axw4OcfqW7k27WkCAd5MZiVlr/2FVZTKNuBP6YiEzeNuS
         vRi6XYiCrKgUj+eDnfp1Tlj7NXlTg1l3y0upQMCbEfGdp0kBg4H2SsOkUOXYlp58yEgT
         idkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5P4A4g7hCXT40gL0fp+uSz31MD2vVTplglPqH3xJWGU=;
        b=iXn9MWQGNpPj4nAD6Xb27/sJO9v6f+9Pjw7XqCh+7ByzEk4U56Sbxu5j7Um9nrw/c/
         strBpLkMFr1aM2VUgtnK0RTBsYHy6lc6r8LtHziZTAQ6KsbMrKu7MkzB8lq+Uwri2clY
         LG/o4FoCQatqDB4ebXy0pj3rrsqBwTQNOUABe0iRqR79Pm3HydlYdS2WMpZWQyuS8JQ7
         8wGck/DZLGC9mxepdI8ygcxQVA5e06qkNOhQ15YOyl6SD4M4PSwLRkKHTr8r6w1Zrau1
         kOa4v8eZIR5rwDZTSB3OcohJc0mOe2hM6jfBoK0OspjivgXUxLxQErWdk1jHJ5bKfUNA
         7NrA==
X-Gm-Message-State: APt69E1HbfuHGGqKHfdsvkIbP7pOQvvpGlS+A3MohdmxkF6L5kamet/2
        ifuR51zTOFuj0tmzFPlzMRicdLoPyO+heXdfXtvfs795
X-Google-Smtp-Source: ADUXVKK1OV9WgpFLolM/FtCpy7FSfEvJCxaPChCfnzIEnfYttkbyh1S2o8ZEk14F5YtqfL20nCTsjzrfwtqv3Jfgc9I=
X-Received: by 2002:a1c:3bc4:: with SMTP id i187-v6mr747542wma.57.1529479025155;
 Wed, 20 Jun 2018 00:17:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:42d2:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 00:17:04
 -0700 (PDT)
In-Reply-To: <c3025418-e98f-6860-c55c-1d6b2d27dddd@gmail.com>
References: <f7cd9f11-c239-15f0-87b8-b1503b1d54fc@gmail.com> <c3025418-e98f-6860-c55c-1d6b2d27dddd@gmail.com>
From:   Pratik Karki <predatoramigo@gmail.com>
Date:   Wed, 20 Jun 2018 13:02:04 +0545
Message-ID: <CAOZc8M9_tcpvjft4x1Ds-vdss=ExiRpJSyAy1r0YHPCYL4UABQ@mail.gmail.com>
Subject: Re: [GSoC] GSoC with git, week 7
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 19, 2018 at 12:33 AM, Paul-Sebastian Ungureanu
<ungureanupaulsebastian@gmail.com> wrote:
> Hello!
>
>
> On 18.06.2018 20:34, Alban Gruin wrote:
>>
>> Hi,
>>
>> I published a new blog post here:
>>
>>    https://blog.pa1ch.fr/posts/2018/06/18/en/gsoc2018-week-7.html
>>
>> It=E2=80=99s shorter than the last one, but feel free to tell me what yo=
u think
>> about it!  :)
>>
>> Cheers,
>> Alban
>>
>
> Good job! My blog is also up:
>
> https://ungps.github.io/
>

Awesome!
My blog post is also up:

https://prertik.github.io/post/week-07

Cheers,
Pratik
