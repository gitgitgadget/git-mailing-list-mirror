Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FC501F576
	for <e@80x24.org>; Thu, 15 Feb 2018 10:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755323AbeBOKd2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 05:33:28 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:52667 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755283AbeBOKd1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 05:33:27 -0500
Received: by mail-wm0-f46.google.com with SMTP id j199so15836643wmj.2
        for <git@vger.kernel.org>; Thu, 15 Feb 2018 02:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Mx5QIAUOaMDjyuWr1CJiQaqB814VvcRdK2dGjsmaqJc=;
        b=QPKze2r6qUxx0PPV+LQIPMD5C56I9bAOT8DVx3U48jeJWh2C6cnwTF9VUg4885Y/u0
         SbHLuBmkCCqMY8xATFamE/EkHL6COGCeCPZ8HH6wpOr+G6PbWny6Y2ckCpFFfJGM3Fn/
         pC9IaGL16+cEAvXAGVhxHUIsO8eBpKqiow7IF9cFZLMKXYamjxUSzTmzQ3PkXbvmug7V
         s32z/wJwYqbkXDgbX5zNPxBQeftC+9y5aTDioDSt1C2hqORtFi94sXaJWs8IGYyOYVjw
         s1RzJ0x+DJv8a4Wfe+vqQVGuljyDg8PfSqyR3+8bmAFYg2+lt+RqDmElRcj/s02HpjJx
         NcYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Mx5QIAUOaMDjyuWr1CJiQaqB814VvcRdK2dGjsmaqJc=;
        b=CNTRTJpi3sfO23rE8F0AagTsHDw0DxqqoVtPAHMr5p5cDV0RD9QnjIL5lUAU1wptDe
         tl96zFCrCFeuRaSzcSCQgFFFeKm9OHCmImV0wrE+p2diN73zw/E7dWBW76JGtJ69mVLE
         Ylz2mkbUhqlMPyCzNkfECMZeiBTCKhZPqELenIfYC300lEDyATRete+VfIqKDjvIkCTR
         TZOzS9hbzHyBshz6uwBZfYAR/D5hdsUA5JlsodMBwFuTbgjFq3OR/9fE6qaSfmixsrsV
         JH39vVqHFGN0memVyZ5tAlEm928L7z7w4IiQDexPkYSN+5A99nZa/gE+JGoGpzIi8VyK
         CHHA==
X-Gm-Message-State: APf1xPCO7tfGF8rpxTGJBbbRxuOqLb52Pd4GRAiG6NuDsn1nYT2lzEVC
        tpps7J+yV4+hgPFmtEueFQl6PCsVGRUGUXpSXJoANA==
X-Google-Smtp-Source: AH8x225BAmx5bteHDSX1a/fbpqmYffdpqdjnSgIk978+uEzFQEUZa7CJC1ZijXeQ/yEiB6WG8l8U3QTtooDvlzHTcm4=
X-Received: by 10.28.182.86 with SMTP id g83mr1581399wmf.75.1518690806055;
 Thu, 15 Feb 2018 02:33:26 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.155.17 with HTTP; Thu, 15 Feb 2018 02:33:25 -0800 (PST)
In-Reply-To: <20180215055334.GN18780@sigill.intra.peff.net>
References: <01020161890f4236-47989eb4-c19f-4282-9084-9d4f90c2ebeb-000000@eu-west-1.amazonses.com>
 <01020161890f4376-0d1c5615-ae9c-4320-bc2d-fd3bda19bce0-000000@eu-west-1.amazonses.com>
 <20180215055334.GN18780@sigill.intra.peff.net>
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Thu, 15 Feb 2018 13:33:25 +0300
Message-ID: <CAL21BmmFaDstAT3Jm6AWh95mfWLJqN1MQF+pBTa3erX5w9MWRQ@mail.gmail.com>
Subject: Re: [PATCH v3 16/23] ref-filter: make cat_file_info independent
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2018-02-15 8:53 GMT+03:00 Jeff King <peff@peff.net>:
> On Mon, Feb 12, 2018 at 08:08:54AM +0000, Olga Telezhnaya wrote:
>
>> Remove connection between expand_data variable
>> in cat-file and in ref-filter.
>> It will help further to get rid of using expand_data in cat-file.
>
> I have to admit I'm confused at this point about what is_cat_file is
> for, or even why we need cat_file_data. Shouldn't these items be handled
> by their matching ref-filter atoms at this point?

We discussed that earlier outside of mailing list, and I even tried to
implement that idea and spent a couple of days to prove that it's not
possible.
The problem is that the list of atoms is made dynamically, and we
can't store pointers to any values in each atom. That's why we need
separate cat_file_info variable that is outside of main atom list.
We also need is_cat_file because we still have some part of logic that
is different for cat-file and for all other commands, and sometimes we
need to know that information.

>
> -Peff
