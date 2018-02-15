Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 724D91F576
	for <e@80x24.org>; Thu, 15 Feb 2018 10:03:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755308AbeBOKDI (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 05:03:08 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:52067 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755240AbeBOKDG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 05:03:06 -0500
Received: by mail-wm0-f45.google.com with SMTP id r71so27855541wmd.1
        for <git@vger.kernel.org>; Thu, 15 Feb 2018 02:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Zp8cRjw3VGzZpQG0TbBofSs/1BljCtZglK7kdDpnHFA=;
        b=RqkvltRsNAtE2Kn9MSUSgw7Isnirpst7jxG6eQooK/no25qpEWaD8O19y1LszAmz7S
         hYuVR+pPI68b+qb/ZxVR3TGFYoFUQekDXnE37SbUa8ktKwTa6yMSzU46aRWV39GUI/76
         V2heL3PHo/wvmkyLDhngiw7diQp1sap86mtup1AxW1ahUI5Pf1Gq+lnx6PspA3NJ0rGf
         4XCl08e+FrLjuIHb3DcNfLPp3iJDt3m80sGn2/pMLT0VVaQT4PY2DZZu3jaRV5gItsf6
         1XX+UJy719OOT6NXf28yaUhON5/Brl9Bxg431dynv+8ZNqGtCPA6JMWxWW1PFrAspGxn
         8kng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Zp8cRjw3VGzZpQG0TbBofSs/1BljCtZglK7kdDpnHFA=;
        b=TC/s/SMO9a/qlXBaXr59SkhGv9A9nVa/vS5hFvobeInEfGODyanGmiuvef1GDSwJtm
         g6kY6lvXcwW3ludFDk1pw1YsfKC6FzhX2n49baW/Ft2Bf6UjjX/hPAR8+SISUUh3y1Rb
         +SbqsSrlBOzPelCMg0c32Kzn1C6RM+YIOZE6FEkJkFZjGYPgTef3FfyYTFB2rD8VQHKY
         Ovz201/AQULrx2STVgQIvSVI6G3H4Xlz7f/djf7sy8wlU1kIuw26E9/hMQtMZusiu7lK
         3GZrBoO1aRUZoVHOpyKGTh4/2WihSzfkFUJevKQ4A73visPwQOotYf1LddloSuSqJGrl
         nRug==
X-Gm-Message-State: APf1xPDCn3mIgMCkrrXSotDjonH75HHyeQgzEoRACfE/qhH6PBpAbIwt
        MR+3gRn6ypQJNkaGjru/wjkUWijtzyCHwm3NsIE=
X-Google-Smtp-Source: AH8x2267+FG+zlpOH1HaLz56wnrJYH1C6jM1ImCrsS/0oOBKz6zKnDFXPmNF5pWV+GFhTno5zk7g8UpBQAM1GWgvMf0=
X-Received: by 10.28.85.194 with SMTP id j185mr1449974wmb.31.1518688985572;
 Thu, 15 Feb 2018 02:03:05 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.155.17 with HTTP; Thu, 15 Feb 2018 02:03:05 -0800 (PST)
In-Reply-To: <20180215052312.GD18780@sigill.intra.peff.net>
References: <01020161890f4236-47989eb4-c19f-4282-9084-9d4f90c2ebeb-000000@eu-west-1.amazonses.com>
 <01020161890f4324-be5dda9b-9ad7-402f-9196-30f982fd20c2-000000@eu-west-1.amazonses.com>
 <20180215052312.GD18780@sigill.intra.peff.net>
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Thu, 15 Feb 2018 13:03:05 +0300
Message-ID: <CAL21BmmyjgzYEHm_VHJkU4KEH+uhCo4G3Au=KM54YAU3n2n_4w@mail.gmail.com>
Subject: Re: [PATCH v3 04/23] ref-filter: make valid_atom as function parameter
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2018-02-15 8:23 GMT+03:00 Jeff King <peff@peff.net>:
> On Mon, Feb 12, 2018 at 08:08:54AM +0000, Olga Telezhnaya wrote:
>
>> Make valid_atom as a function parameter,
>> there could be another variable further.
>> Need that for further reusing of formatting logic in cat-file.c.
>>
>> We do not need to allow users to pass their own valid_atom variable in
>> global functions like verify_ref_format() because in the end we want to
>> have same set of valid atoms for all commands. But, as a first step
>> of migrating, I create further another version of valid_atom
>> for cat-file.
>
> Hmm. So I see where you're going here, but I think in the end we'd want
> to have a single valid_atom list again, and we wouldn't need this.
>
> And indeed, it looks like this goes away in patch 17. Can we
> reorganize/rebase the series so that we avoid dead-end directions like
> this?

I tried to do that, but in my opinion it's easier to understand
everything in current version. I need to squash too many items so that
commits do not look atomic, and it's really hard to understand what is
going on. Now we have that helper commit that will be cancelled later,
and other logic is more clear for readers.

>
> -Peff
