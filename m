Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCE9C1F576
	for <e@80x24.org>; Thu, 15 Feb 2018 10:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755458AbeBOKUx (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 05:20:53 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34162 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755390AbeBOKUw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 05:20:52 -0500
Received: by mail-wm0-f65.google.com with SMTP id j21so469190wmh.1
        for <git@vger.kernel.org>; Thu, 15 Feb 2018 02:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=P1ClNCw7KuiRcVfdd5vEHuqovwuBDlim5n3Lvb5vwzY=;
        b=BGHDobQX93eM3vJyX8ygWhOYWreaS1D9akX96RYElDBBeNnVnXIoEE5kx8uJ20fNtN
         EC+wgJ2hES44oG6TzNLYJT9LU2T2DBdw/zaWq15hw7VYRzOT2jBxX29Z/kLRWUZv0kbw
         xpU0+Qtw5CjeCfj9X+573msTWmGRApmICxZZBPoGHd6xIUPULde32Fu0JU7TqVArrB06
         J4rq/UwIvgtiGjNPB+hMSYwMPocImVsHfGOr+dvyPfvHOs0Q/ru0bPJRROwIk21wiqqV
         g+Yf1oe/BtNox9//svKH0SJC6z8L7v66bbJD+u32YpDWl8LczKNokCH+loaEjVCiD35z
         uP0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=P1ClNCw7KuiRcVfdd5vEHuqovwuBDlim5n3Lvb5vwzY=;
        b=OWZp204ScbOsJfF2LQF6TtS9mWzt3G8IZmbJxS0jOmX8rbL6FRaJu2BBJ1+kWZj/R9
         27JRTCo6JW9kgLPB1iQIjPnuVB8r6MqaVPcInD3/Y5rVBa7YuJRy7kH5dcpke9uOB3xU
         Eb7KUbBX6ByrwSI9cTjMaetQ6vOqU1Yub0/lxqZ2I7fcSUpNEJV7/ZTnvYPz6qQjSGvh
         mAQF/HZJVeZlckC0bQNQ2zls6zZArCc5jvS1B8NFFSb712kXnm8UF7tev/5XI9NVypvi
         k5nwecL6taIfLQoBEzTQ2G9nu5zD67pFERE3gJdz9g7V8NbFXdsfMxg1XYpCGbzzXFB+
         EFug==
X-Gm-Message-State: APf1xPC8mLbLfgKeqF+X3CDoIJn0fkbbxx/w9ZeKlrceWMxdScldP/Du
        +5xlEpwvZDKuljmRhBOVBX16oB0XjzmHn4ShvOY=
X-Google-Smtp-Source: AH8x2279HMNRqv6uNL4HYbXMpspHKPmThP5WjYuezjhBeKZ8VnBzrdIWI5YTP9paFxn7xvyppm6kGCgjS3HC3ODUqAI=
X-Received: by 10.28.71.77 with SMTP id u74mr1518397wma.150.1518690051058;
 Thu, 15 Feb 2018 02:20:51 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.155.17 with HTTP; Thu, 15 Feb 2018 02:20:50 -0800 (PST)
In-Reply-To: <20180215054945.GL18780@sigill.intra.peff.net>
References: <01020161890f4236-47989eb4-c19f-4282-9084-9d4f90c2ebeb-000000@eu-west-1.amazonses.com>
 <01020161890f4357-05e636bc-8b44-425b-a252-ff2341f91cdd-000000@eu-west-1.amazonses.com>
 <20180215054945.GL18780@sigill.intra.peff.net>
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Thu, 15 Feb 2018 13:20:50 +0300
Message-ID: <CAL21Bm=7R2URkaRVCbM-T3Yxeq-S+E6Pq_ECSiBk_yJf9D1rag@mail.gmail.com>
Subject: Re: [PATCH v3 14/23] ref_filter: add is_atom_used function
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2018-02-15 8:49 GMT+03:00 Jeff King <peff@peff.net>:
> On Mon, Feb 12, 2018 at 08:08:54AM +0000, Olga Telezhnaya wrote:
>
>> Delete all items related to split_on_whitespace from ref-filter
>> and add new function for handling the logic.
>> Now cat-file could invoke that function to implementing its logic.
>
> OK, this is a good direction. I think in a more compact series we'd
> avoid moving the split-on-whitespace bits over to ref-filter in the
> first place, and have two commits:
>
>  - one early in the series adding is_atom_used()
>
>  - one late in the series switching cat-file over to is_atom_used() as
>    part of the conversion to ref-filter
>
>> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
>> index 6db57e3533806..3a49b55a1cc2e 100644
>> --- a/builtin/cat-file.c
>> +++ b/builtin/cat-file.c
>> @@ -382,8 +382,7 @@ static int batch_objects(struct batch_options *opt)
>>  {
>>       struct strbuf buf = STRBUF_INIT;
>>       struct expand_data data;
>> -     int save_warning;
>> -     int retval = 0;
>> +     int save_warning, is_rest, retval = 0;
>
> Try to avoid reformatting existing code that you're not otherwise
> touching, as it makes the diff noisier. Just adding "int is_rest" would
> make this easier to review.
>
> I also think the variable name should probably still be
> "split_on_whitespace". It's set based on whether we saw a "%(rest)"
> atom, but ultimately we'll use it to decide whether to split.

OK, I will fix that.

>
> -Peff
