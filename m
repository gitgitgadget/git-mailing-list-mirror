Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35CFB1F42D
	for <e@80x24.org>; Sun, 27 May 2018 05:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755162AbeE0FCh (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 May 2018 01:02:37 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:43353 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755118AbeE0FCg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 May 2018 01:02:36 -0400
Received: by mail-oi0-f68.google.com with SMTP id t133-v6so4225773oif.10
        for <git@vger.kernel.org>; Sat, 26 May 2018 22:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=c9Ly7Xsutv7lREplwy8Q4/OQWU+s/pis4zjY8NYoGso=;
        b=g3f93vMVgwwGgOF1NRy0q2lpP20afqkiKHzRF2ATYs/K7pbdcEgt81F0pC04wGQXoQ
         3wo2/GIbNdVEicYJI3OoZEcNGi8tDQ8cRycJDRdL7Dl9d5Z8vLhxgWTWYkYvRH2Tzyz/
         FxzIxj33cZ5N7pITFxE2Ce4D5CVgbJwWLGZgFqhiLqwdoxT5gK6Rknm4s7cxIF+iPFWd
         nBEmGbO4NmHhKjXQC78jj2HScpaNSOTf7yWTlx9frxmqZ1KKiBCxbAQOijr4ErSKYMqR
         HY+19oHyGS2bPsWDgVteU4QjoSUfPlfmN4m//9uM3e5ADAGwjDoJCuwiTUfNtqSeEwEB
         oYUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=c9Ly7Xsutv7lREplwy8Q4/OQWU+s/pis4zjY8NYoGso=;
        b=e1bM/F1eHcGwQuwiDEFTOOTmH0+Gr/YkUHSGYaoKqnQZW5fX2qdUOmgSqOF5nadwXC
         yTWGJ1yrNZ3lAVeZEXfvefcwy1jNkD/Thx8bMJgSZEcRACZvgUSOIpsl+uREfZdYnnYu
         pJBttVaAVxfNLE8/VXYghqXBaSC8lRBK4hEWGv3TIqbeofRBTFup+848Eb6d6uRQX3oJ
         egY3Z7bHv3EHdrJB5XuHZc58fCAxEWsl2BtIjO408Pt/+xnzA4RDcmtPg4nIgFYAZ7Tk
         X5KcNAo6/lV+OMXJyvUqlUca5qr5lDT4I9GqCkqIcTx5Vv8GGcoAs6qVWNnF5Un/rnXF
         v0Xw==
X-Gm-Message-State: ALKqPwd4sOttBYJxAFUK33PgpFTq28fO6G6dXD7b8HdNaQmUiV2GT+gc
        xO3V9XdlB2+CFMeZr+93DXvLI9MFI5tCMDU3Nig=
X-Google-Smtp-Source: ADUXVKKBz616KckPPMDhO5g1I5AnjS7UgA4+nJxLqmmiSO4MgxUscUmlcQ1j5vjlnZRF+PSdHAQTuPytvWjtF0m5l8k=
X-Received: by 2002:aca:aad3:: with SMTP id t202-v6mr4895458oie.30.1527397355758;
 Sat, 26 May 2018 22:02:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:b285:0:0:0:0:0 with HTTP; Sat, 26 May 2018 22:02:05
 -0700 (PDT)
In-Reply-To: <xmqq8t86m0m3.fsf@gitster-ct.c.googlers.com>
References: <20180525225601.22575-1-lintonrjeremy@gmail.com>
 <CACsJy8C4zNZAe6Vw-mz8r8HueYdQKs4ZhMOQYX0v7ypfHdmShg@mail.gmail.com> <xmqq8t86m0m3.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 27 May 2018 07:02:05 +0200
Message-ID: <CACsJy8CNmDkxzhkdfwjVHjGF4JeUzzPHGnp1x647NxU-GxkxvA@mail.gmail.com>
Subject: Re: [PATCH] packfile: Correct zlib buffer handling
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeremy Linton <lintonrjeremy@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 27, 2018 at 1:57 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Sat, May 26, 2018 at 12:56 AM, Jeremy Linton <lintonrjeremy@gmail.com> wrote:
>>> @@ -1416,7 +1416,7 @@ static void *unpack_compressed_entry(struct packed_git *p,
>>>                 return NULL;
>>>         memset(&stream, 0, sizeof(stream));
>>>         stream.next_out = buffer;
>>> -       stream.avail_out = size + 1;
>>> +       stream.avail_out = size;
>>
>> You may want to include in your commit message a reference to
>> 39eea7bdd9 (Fix incorrect error check while reading deflated pack data
>> - 2009-10-21) which adds this plus one with a fascinating story
>> behind.
>
> A bit puzzled---are you saying that this recent patch breaks the old
> fix and must be done in some other way?

No. I actually wanted to answer that question when I tried to track
down the commit that adds " + 1" but I did not spend enough time to
understand the old problem. I guess your puzzle means you didn't think
it would break anything, which is good.
-- 
Duy
