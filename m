Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96F231F406
	for <e@80x24.org>; Tue, 16 Jan 2018 06:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750827AbeAPGzY (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jan 2018 01:55:24 -0500
Received: from mail-qt0-f173.google.com ([209.85.216.173]:46083 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750740AbeAPGzX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jan 2018 01:55:23 -0500
Received: by mail-qt0-f173.google.com with SMTP id o35so6920140qtj.13
        for <git@vger.kernel.org>; Mon, 15 Jan 2018 22:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DATbZxVLMrWWuu2OXfGuOxG8zLbRHZsxLcL8gCeVC38=;
        b=VB1Y5ESBVGfepPMH9gZ0L7QODiHS8NMDAfUBif1+SXeGZ4y68tvL//IBH2YanRvroN
         cXA42OrLD0GX3vCr9o8IqdSd/ONlN6rNFj6zlbBFA6VoEarHYNVf5vdckfp3IcOFjCI4
         SpAZvU2kj1o9yJ6MW97Ks9UugH0hO9MVazNT8/JZj+LioPZN5SmSt1MhlIXZE3EfvkD+
         JJbw4dpzTrm5vCX3bYy3iQvP9JKFpQkwZ6mPNe68jNAQbnKYsj0ch17fxlYb2R0Si4Va
         i/WuY+QqyuiJ1qZb9aj6zOSJusAhIlhgtLY52XeqLcDbjnlzlw9Gsc/czMmWPKPatr1a
         RplQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DATbZxVLMrWWuu2OXfGuOxG8zLbRHZsxLcL8gCeVC38=;
        b=opu2XEkzZMb2S3qKlT6d9hY/Y4D/5hfmSf3MyY0oWaKms+TVD2reZ/J1aRjysBJFMg
         2beDRd4DxeNMdAMBS5bVJL+K2VEZvMBfPza5o8rsCeLv1kWpIVxMQVcU13xw77BgaUtw
         Hlxbt1OLkXKqGF0ihmfFWx+o3b8YOFD34xph9JE2+t4kAjyx6/Dcm+ZKX5T2ZE5LfV4S
         BVJm4spabeMoWm146Vv2a7EHOUwY3SNA4TgwJnZJOyy6s0ZibZ8jIvIzq7leflTP/Itm
         yC2VNjkeKGABdOzv2jbbIpmjpralJbRfLEaCsS5tUJIdHThGDT7RDMmF0Oq4SqtcaoLc
         hi/Q==
X-Gm-Message-State: AKwxytdYTtMnMfj9ztcPVAI/RfpywqUpWSWWm+/6wmDUhU7++b3hXnNm
        kxa76w85MTuFB7TgwPEke0pNdhdN6cg1vQPIGs3unA==
X-Google-Smtp-Source: ACJfBovgzAvSOelYbkL610sXcbdq6p+5CI8DsHT4UbHwclYw6misdvSpHEHZimKhGpSxG/RBIPS1IgBm7SePxKDPFcU=
X-Received: by 10.200.0.18 with SMTP id a18mr5027218qtg.162.1516085722893;
 Mon, 15 Jan 2018 22:55:22 -0800 (PST)
MIME-Version: 1.0
Received: by 10.200.16.154 with HTTP; Mon, 15 Jan 2018 22:55:22 -0800 (PST)
In-Reply-To: <20180115214208.GD4778@sigill.intra.peff.net>
References: <01020160df6dc499-0e6d11ec-1dcd-4a71-997b-ea231f33fae4-000000@eu-west-1.amazonses.com>
 <01020160df6dc529-fae54bd6-e595-44fa-9f9a-c44cb3a5a1a8-000000@eu-west-1.amazonses.com>
 <20180115214208.GD4778@sigill.intra.peff.net>
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Tue, 16 Jan 2018 09:55:22 +0300
Message-ID: <CAL21Bm=+uPrKECcCq2_rfJRuCpsOjZ41NfiyY3d1UA0b8YKj1w@mail.gmail.com>
Subject: Re: [PATCH v2 03/18] ref-filter: make valid_atom as function parameter
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2018-01-16 0:42 GMT+03:00 Jeff King <peff@peff.net>:
> On Wed, Jan 10, 2018 at 09:36:41AM +0000, Olga Telezhnaya wrote:
>
>> Make valid_atom as a function parameter,
>> there could be another variable further.
>> Need that for further reusing of formatting logic in cat-file.c.
>>
>> We do not need to allow users to pass their own valid_atom variable in
>> global functions like verify_ref_format because in the end we want to
>> have same set of valid atoms for all commands. But, as a first step
>> of migrating, I create further another version of valid_atom
>> for cat-file.
>
> I agree in the end we'd want a single valid_atom list. It doesn't look
> like we hit that end state in this series, though.
>
> I guess I'm not quite clear on why we're not adding these new atoms to
> ref-filter (and for-each-ref) right away, though. We already have the
> first three (name, type, and size), and we'd just need to support
> %(rest) and %(deltabase).
>
> I think %(rest) doesn't really make sense for for-each-ref (we're not
> reading any input), but it could expand to the empty string by default
> (or even throw an error if the caller asks us not to support it).
>
> IOW, the progression I'd expect in a series like this is:
>
>   1. Teach ref-filter.c to support everything that cat-file can do.
>
>   2. Convert cat-file to use ref-filter.c.
>
> -Peff

I agree, I even made this and it's working fine:
https://github.com/git/git/pull/450/commits/1b74f1047f07434dccb207534d1ad45a143e3f2b
But I decided not to add that to patch because I expand the
functionality of several commands (not only cat-file and
for-each-ref), and I need to support all new functionality in a proper
way, make these error messages, test everything and - the hardest one
- support many new commands for cat-file. As I understand, it is not
possible unless we finally move to ref-filter and print results also
there. Oh, and I also need to rewrite docs in that case. And I decided
to apply this in another patch. But, please, say your opinion, maybe
we could do that here in some way.

Olga
