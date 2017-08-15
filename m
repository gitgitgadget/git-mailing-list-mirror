Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B899F208B8
	for <e@80x24.org>; Tue, 15 Aug 2017 17:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753527AbdHORl7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 13:41:59 -0400
Received: from mail-yw0-f169.google.com ([209.85.161.169]:36835 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752629AbdHORl6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 13:41:58 -0400
Received: by mail-yw0-f169.google.com with SMTP id u207so8879216ywc.3
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 10:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=e4iGtl6/i8j563U0p10oYKqMI6yQJL7Ixx1y7AK7pcg=;
        b=uLrZ2kpHhFmpVIUlDq1bq13xD5BWCUO4x39ctQVbSmunI/XIVLEEWcBM2c7Lu/1uDh
         MDWpusNX6GJqHST/EjA20LUpCep9mxmKi7DhkkOhDAQMTq2x+M5Mz0kMMEyZaTcM79M+
         jFpr6WbOOOJ+OPuJJrxk3xJrcS+zdpiiAng43K/xfeKJiHq5TrmhbuZJiX/DCMReBq2a
         kEjaCvhHEeskGJ7RdyE80LGG2rELx95x5UFlaxOhbF97cZWLrnp4gllNE5BaE81K3rXU
         A44WBmno41JjGvsRVtVUQkC8gu9zQSxGUN9uaJw43AeemxDf3/o8PXICbqXQ+a4rwS7P
         fupQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=e4iGtl6/i8j563U0p10oYKqMI6yQJL7Ixx1y7AK7pcg=;
        b=GHqT5ryRl37K6QUBw1/6B7s8xtSqydgV9GnqmZDa90khfGUQYLe7BbV2BmDsNapOJd
         Eb+sRvEie4nPLJYBIFDq5Q79jM3YqmkjnJRJySSDXY0fUQJoeTp8s3NMNIDs92208fSZ
         BBjMZ+g3Cq+56dZhATFQ2i2sB/rx8LmahRhE81/hhWHfIRR8hjC6t+292VOSm4h8FqmC
         DjIcdneV/yK6U/tkucD7mWUhKqn8soSxkEvAzT8ErbPZKEaztFRd7JzESVhv4QmqJ0wF
         8fzyctgZnTQ/e9OTv7RF3tnJz2Nd0U4v6tT6NyMSVK28OIoypep5ZqKr5rX6TPsrF9Em
         /dBA==
X-Gm-Message-State: AHYfb5gnDzAi+uoKMlA9F1Qy2mM5id59Kblq98308MVImFuZBCOMVyjC
        ILO7EUpA9y2mv0B0utD+bPb7dtoCfs08zCI=
X-Received: by 10.13.229.3 with SMTP id o3mr23183829ywe.137.1502818918103;
 Tue, 15 Aug 2017 10:41:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.56.142 with HTTP; Tue, 15 Aug 2017 10:41:57 -0700 (PDT)
In-Reply-To: <20170815173445.GA21874@google.com>
References: <20170808012554.186051-1-bmwill@google.com> <20170814213046.107576-1-bmwill@google.com>
 <20170814213046.107576-2-bmwill@google.com> <9c9a9b98-9308-95d6-a912-85a49bd3e21d@gmail.com>
 <20170815173445.GA21874@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 15 Aug 2017 10:41:57 -0700
Message-ID: <CAGZ79kZc_Mh8i7kMmP_BNGWBAp8rGiiVdCYgTHtfHhsJ6YfGSA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] clang-format: outline the git project's coding style
To:     Brandon Williams <bmwill@google.com>
Cc:     Ben Peart <peartben@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 15, 2017 at 10:34 AM, Brandon Williams <bmwill@google.com> wrote:
> On 08/15, Ben Peart wrote:
>>
>>
>> On 8/14/2017 5:30 PM, Brandon Williams wrote:
>> >Add a '.clang-format' file which outlines the git project's coding
>> >style.  This can be used with clang-format to auto-format .c and .h
>> >files to conform with git's style.
>> >
>> >Signed-off-by: Brandon Williams <bmwill@google.com>
>> >---
>> >  .clang-format | 165 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>> >  1 file changed, 165 insertions(+)
>> >  create mode 100644 .clang-format
>> >
>>
>> I applied this and then ran:
>>     clang-format -i -style file *.c *.h builtin/*.c
>>
>> The modified files generate lots of line ending warnings.
>> Apparently clang-format isn't respecting the git settings for line
>> endings as it converted CRLF to LF in all the files it edited.
>>
>> $ git add .
>> warning: LF will be replaced by CRLF in alloc.c.
>> The file will have its original line endings in your working directory.
>> warning: LF will be replaced by CRLF in base85.c.
>> The file will have its original line endings in your working directory.
>> warning: LF will be replaced by CRLF in bisect.h.
>> [...]
>>

This sounds as if core.safecrlf is set to "warn" (by default?),
you could set it to false to not have these warnings. However
that is side stepping the problem of clang-format producing
non-crlf line endings.

Maybe the workflow can be setup such that this side stepping
is ok, and no harm is done by the LF line endings by the formatting
(If the formatting was a pre-commit hook, then Git would convert
LF/CRLF and there would be no impact to your workflow I'd imagine).
