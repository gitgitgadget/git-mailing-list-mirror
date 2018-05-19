Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 055DC1F51C
	for <e@80x24.org>; Sat, 19 May 2018 06:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751907AbeESGOB (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 May 2018 02:14:01 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:37009 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750769AbeESGN5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 May 2018 02:13:57 -0400
Received: by mail-pg0-f66.google.com with SMTP id a13-v6so4193802pgu.4
        for <git@vger.kernel.org>; Fri, 18 May 2018 23:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2eRa+blDgkGxfkBBhnAxAl9O1aqRa45dxbMVvNx2/Q4=;
        b=OZotl6hXIERqb8K1YMH7kNZAOiJllTRQcDTI0xQtqwuRQv8EAxir2ClR1vkHnF0NkR
         WcCN8PIXTLcxjXyubISduJ9VkhKwYRPgGh8+Thtuix6PmPG5JrIgzwqBLgdyyX5n3Ibj
         0zzE+5887HNHOfpiMPUUwBHVnLxHRC0iOUbCiqTqncLrEAPwSnNjHEtRku0SiIkL4zU2
         Y1y06EUrQl3r2x2uZffvvEvKh9EuhcIfwYNDK0e9qmaxhAWzpD+iAPLeQ2nSkkfFLg6r
         LteY7j75JUmcj/vz/w11UleAowmvm4HmfAyK7H7gifjgUrPBFfgBZWv3nmwCKqH0akP4
         acuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2eRa+blDgkGxfkBBhnAxAl9O1aqRa45dxbMVvNx2/Q4=;
        b=BBaNLVMuQarYd1aDIComLNSB5LQc9WGQrrZNLjeFJjfevi0dTEl4El/UKAGQEpbGrc
         LA1QelmCOgtQeW+/Pw1S9pOgtIPkJHbfU5Db7s1TNneaSsryRMy0rMqByfbvcl3FBTbR
         GAWOwLL8n7fiw8i6douf4J2GdykJPT3Wol+5r/JqYjXGgAJV4Qg8VUbxnn5fD52xgvs4
         xMEVoQQNO0GyooKZ98lPoZ4kGhTnxJF3wecHDsMlRqWSanjxdm1K8cxAj5b7Kl1j85c3
         rgFHBN4cS3OCQAa2zfQ+a6CA2glAkuJwRd07ekOaXV5PW1UhHBd9mAGkU03aKjPx+Xvf
         OiKw==
X-Gm-Message-State: ALKqPwd1YhBM/SqAz7Hw5UMUheEDSSokohQ2k3qT2qsIBtPRWUit6lcJ
        wQdu2MfOqaV4+RH4LYRJbcC6PHVphsF9iMvMli4=
X-Google-Smtp-Source: AB8JxZqVAvYIZF8HaFqOJ3rlQ7GxsEhQX9Tgoxwgfx6t9u5iAD2l4oHz1h4AiaSePDa6aLw3SudN336lmrjstCnOX0g=
X-Received: by 2002:a63:66c3:: with SMTP id a186-v6mr9575706pgc.408.1526710437124;
 Fri, 18 May 2018 23:13:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.187.139 with HTTP; Fri, 18 May 2018 23:13:56 -0700 (PDT)
In-Reply-To: <20180519010220.GA16071@sigill.intra.peff.net>
References: <CAN0heSo80SjjGtC2x9s-TmNY0=W=YWTYxyjeuAQ3utEAEynXeA@mail.gmail.com>
 <cover.1526677881.git.martin.agren@gmail.com> <f4e7822ebe8fcab8243ae3931084e10f3b199788.1526677881.git.martin.agren@gmail.com>
 <20180518213333.GB21797@sigill.intra.peff.net> <CABPp-BFdKFNLHxqt-rbSVPx_cXVG3iyad42qYFbWvP9_2fW2gQ@mail.gmail.com>
 <20180519010220.GA16071@sigill.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 19 May 2018 08:13:56 +0200
Message-ID: <CAN0heSp7DqxOy-UeLgj8t_T_4f-fNthMpGNS8oUbcs7+NvS-zw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] unpack_trees_options: free messages when done
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19 May 2018 at 03:02, Jeff King <peff@peff.net> wrote:
> On Fri, May 18, 2018 at 03:30:44PM -0700, Elijah Newren wrote:
>
>> > would become:
>> >
>> >   msgs[ERROR_WOULD_OVERWRITE] = msgs[ERROR_NOUPTODATE_FILE] =
>> >         string_list_appendf(&opts->msgs_to_free, msg, cmd, cmd)->string;
>> >
>> > I don't know if that's worth it or not (I suspect that there are other
>> > places where appendf would be handy, but I didn't poke around).

This does poke at the `string` member, but there is precedent for doing
that. That also feels much closer to the purpose of a string list than
the fiddling with `strdup_strings` that I do in my patch.

I'll look into this over the weekend. Thanks for the suggestion.

>> The strdup_strings=1 immediately before calling string_list_clear()
>> has been used in one other place in merge-recursive.c, and tripped up
>> the reviewer requiring a big code comment to explain it. (See the very
>> end of https://public-inbox.org/git/CABPp-BGh7QTTfu3kgH4KO5DrrXiQjtrNhx_uaQsB6fHXT+9hLQ@mail.gmail.com/
>> ).  So there's already one other place in merge-recursive.c that might
>> benefit from such a change.
>
> Thanks. I knew I had seen such hackery before, but it's nice to have a
> specific site that would benefit.
>
> IMHO the "nodup" variant of string_list is quite often a sign that
> things are more complicated than they need to be. Even in cases that are
> truly pointing to existing strings, is the complication really worth
> saving a few strdups? Perhaps sometimes, but I have a suspicion it's
> mostly premature optimization.
>
>> Maybe someone wants to tackle that as a separate patch series?  (Maybe
>> we make it a micro-project for future GSoC'ers?)
>
> Yeah, I'm fine with these patches if somebody wants to do it separately.
> It would be a good micro-project, but I'd also be just as happy if
> somebody did it before next year. :)

Obviously, I won't be tackling all of that now. I'll just look into
making this final patch better and leave any further cleaning up for
later.

Martin
