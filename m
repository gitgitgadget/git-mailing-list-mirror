Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3525E202A5
	for <e@80x24.org>; Thu, 21 Sep 2017 17:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752258AbdIUR3G (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 13:29:06 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:52976 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751922AbdIUR3F (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2017 13:29:05 -0400
Received: by mail-qk0-f177.google.com with SMTP id o77so6475754qke.9
        for <git@vger.kernel.org>; Thu, 21 Sep 2017 10:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=l0h845zs7rjwEo6wjJSsST9WuT77+ADe4Bog28M35+s=;
        b=Lo2mH3JBmPhumJfV0b3aa1G4eFucSDj69wBNrZRQLmk0R4L2BvSzZW9bUEhYGTTSoJ
         Nm/t0vVJpwgP052ffKA7lEDYR18p5Mr1b3YntgR8082fajzeBovv/IhubdNnwlnEzhV0
         8Jgx8uIRt+urawLHwlXCCM34j7D6VZTGkSmaa6zCaFw/8fCSKrkmFoMVdjQwMmdct7oT
         KdNVguPawbHGwrzzrT3uH82MJvMMwZPlBw1aho/aYOQoIC63C+uqnshCK8ENmelmFeaF
         WkZrzSqAyEj+wQlLh2cjH5I3A3LyHbp9ynuzravvX0fpThynpQGg0/ow60/j+SincvBR
         Sb6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=l0h845zs7rjwEo6wjJSsST9WuT77+ADe4Bog28M35+s=;
        b=LlTPAQV+t3BjTAiSgQxt1ue7bIGX3iRcJXaB7EXLFb4fAae9u01vOP4aesjnuJzrtC
         z0oYH/yTceAbQRnxj3ozy49TGJqn3/ZCFNlJtmVJ007EVK6SVv+c5kib4ExrF5UYj0sd
         Qrc8NUTYYRspY9bGrE4wLSfgoVCQ3tajMsRhnQtyAPY7nnGJJJZ9LqvT8rfLpoC6gB6v
         pOOE9cpp5LuQVf6IwOZUY8NFCmIgpUwJbpmrkQoQg2T1AwYGvksyo6Dj+JszzQIuuXau
         48kfWhbiAtWUNyad1DwiQBnXpVJDneBALweGVoZD92kXXAW/U7ilNEDJdimxX/nDgHln
         CPqQ==
X-Gm-Message-State: AHPjjUjvit7Wg0kPSVWb/XZ5A4R741zpzQKzPjgi11Rua8yOJy7IXURG
        nAe5rfPA0lRE1hD5x3TTH4yoDfeVe751eQlsXKsJXw==
X-Google-Smtp-Source: AOwi7QD5eAyYAVNyvh2aXvDQHsXosAz2Q1z/X8IDZd6c0lzQ15wiYkvDIhQz0jRajGqljc7MdL/WykFMQ+B5eOXXu+U=
X-Received: by 10.55.52.135 with SMTP id b129mr4278924qka.308.1506014944046;
 Thu, 21 Sep 2017 10:29:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.51 with HTTP; Thu, 21 Sep 2017 10:29:03 -0700 (PDT)
In-Reply-To: <20170921045932.b5y33fm7gao27ium@sigill.intra.peff.net>
References: <cover.1505799700.git.mhagger@alum.mit.edu> <2bb2e8ccb57eef8acbea5004167751a007a1bd2f.1505799700.git.mhagger@alum.mit.edu>
 <CAGZ79kbwCAidGR3cgukdjckZVYwj+qbOikqN-e934uP1yk9Cuw@mail.gmail.com> <20170921045932.b5y33fm7gao27ium@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 21 Sep 2017 10:29:03 -0700
Message-ID: <CAGZ79kZ5xcw3hw_aEp2ggLbC8AQm8DwpqK3+i5UO7s+aGzgXjQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/21] prefix_ref_iterator: break when we leave the prefix
To:     Jeff King <peff@peff.net>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 20, 2017 at 9:59 PM, Jeff King <peff@peff.net> wrote:

>> But this compare function is not to order by the natural encoding order,
>> but it's used to detect the '0' at the end of prefix, which orders
>> before *any* unsigned char.
>
> It's not just detecting the "0". We care about the ordering overall (so
> that "refs/foo" comes after "refs/bar", and we know that "refs/bar/baz"
> cannot come after "refs/foo", and we can stop iterating).

refs/{foo,bar,bar/baz} is all ASCII, such that the ordering by byte value
and byte position (2nd order) orders 'correctly'. correct in the sense as
Git expects. But if you use other encodings, the natural encoding
may differ from the arbitrary order that we have here. (Example
utf-8 with BOM and smileys)

However these different orders do not matter (according to my initial
conclusion), because we need (a) find out about '\0' and (b) only need
only 'arbitrary' order (which is referred to by the " ordered" trait).

>> Essentially compare_prefix wants to provide the same return
>> value as `strncmp(refname, prefix, min(strlen(refname), strlen(prefix)));`
>> except that it is optimized as we do not have to walk over a string
>> multiple times (to determine length and then pass it to compare).
>
> Hmm, yeah, I think that would be an equivalent. I didn't think of that,
> but as you say it would be less efficient.

I was just too lazy to check if we had the results of strlen around already,
such that the comparison would be equally cheap, but more readable.
Also IIRC later patches enhance this function, so we shall not make use
of the strncmp function here.

> The patch is credited to me, but I actually screwed up the ordering by
> failing to do the unsigned cast. Michael fixed that part before posting
> it. :)

Thanks,
Stefan
