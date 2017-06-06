Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDF1820D0C
	for <e@80x24.org>; Tue,  6 Jun 2017 01:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751235AbdFFBke (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Jun 2017 21:40:34 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:38691 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751107AbdFFBke (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2017 21:40:34 -0400
Received: by mail-it0-f50.google.com with SMTP id r63so95988937itc.1
        for <git@vger.kernel.org>; Mon, 05 Jun 2017 18:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=KoYpnkAe+cEI8KqyT9a1LY/3DNK4xS/hGkoP8Jwpc38=;
        b=HYTe//QBTI6/G6hZo7IW1Q8AN0hh61X6YJeOfp/lNByXHPR0e+4uVoBgyXLlydfl+G
         NtfXI9w0ZU5NCCK2249z0sq1wKmmFq28nh7Xz7ex3IR5vwqD2MmKRHBAlKG9ehtrrr2b
         O6tvdlgB8BYrEQA1nFnVy9D31WU0SYaHJ8+9nOSPZTqJ47z0W9IGIN1wN/UyPcBXQE7F
         mzl1PWvJD7IhQYrdMChzjR2Fv7RRshaoAhjb4T1cM08+jB9X+6xUUKVcaza8dvzCKLpN
         SIv6fqjyKeSXzKGP9oUoYHqu7p+NH8Sd0ZoG8oNapQkt7gzU3E4zRwDNVkcliSxyyhd3
         TIww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=KoYpnkAe+cEI8KqyT9a1LY/3DNK4xS/hGkoP8Jwpc38=;
        b=KF8ZqW2o2UjP0YGB/jORfTywcDHJGw44Cl8wWYeAYgFlcAubgL8O4ASlM0tJfjeGgV
         3KE8uWNmND36Ni4W9H0FvaosWZpjBNugfSomEJ44JanIP0G08WtrT8zowDVuIyk+QvsG
         Hz2Njg8K5BPdSAJCUxhKnZUO7MBtRSvmpypy+lfgFBINYztx+g5RShLPPeXor/h76bep
         kPuHt/obQbg1T8v96HaFzhGlnPbvO1O2tby8TFVh16GhcjAKbYGsh8fY6xHB+JbIbNnv
         hNHgVvA8g2Ubk39rQjdbzhuYoLZjEp0DUaiam4zRDbWwcG+qcVQRkTT1gPldYGywZF/u
         oJng==
X-Gm-Message-State: AODbwcDs5w4etaU0cnFn61raqRvXgM0hgepzEuJgj1XzRWXMP1qHXwY/
        ZwlmsVKzpEwpnmby7O5A9AYERCPdOQ==
X-Received: by 10.36.70.211 with SMTP id j202mr14492975itb.22.1496713233146;
 Mon, 05 Jun 2017 18:40:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.72.66 with HTTP; Mon, 5 Jun 2017 18:39:52 -0700 (PDT)
In-Reply-To: <20170606011151.qe5ycih77vqlqgme@genre.crustytoothpaste.net>
References: <1496671452.4809.2.camel@gmail.com> <20170605231058.pgb4fgfb4z45bzmk@genre.crustytoothpaste.net>
 <CAGZ79kYp6GepJxZjaXhosX=vCh0vwa57+zFHK2gHFociiyTnDg@mail.gmail.com>
 <xmqqd1ai9bhf.fsf@gitster.mtv.corp.google.com> <20170606011151.qe5ycih77vqlqgme@genre.crustytoothpaste.net>
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Mon, 5 Jun 2017 21:39:52 -0400
Message-ID: <CAJZjrdWoK__rZVCG3vRSSEOPgxK7b_wWjpJ3YUQcLxw+J8KfGQ@mail.gmail.com>
Subject: Re: What does this output of git supposed to mean ?
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 5, 2017 at 9:11 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Tue, Jun 06, 2017 at 10:00:12AM +0900, Junio C Hamano wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>> > On the subject: maybe we want to rename initial commit
>> > to root commit? (evil-me also thinks we could name it
>> > "parent-less commit", to reinforce what the lovely git man
>> > page generator tries to point at.)
>>
>> Is "initial" harder to understand than "root" or "parent-less"?
>
> I personally think that "Initial commit" is very straightforward.  If we
> get more inquiries about it, we could consider changing it, but seeing
> as this is the first question I've ever seen about it, I think most
> people understand it pretty well.

For what it's worth, I've never quite understood the "Initial commit"
message, because the repository is in a state where there are no
commits yet, not when HEAD is pointing to a root commit.
