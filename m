Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72699207EC
	for <e@80x24.org>; Tue,  4 Oct 2016 05:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751702AbcJDFrx (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 01:47:53 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:35930 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751032AbcJDFrw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 01:47:52 -0400
Received: by mail-yw0-f196.google.com with SMTP id r132so3730547ywg.3
        for <git@vger.kernel.org>; Mon, 03 Oct 2016 22:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5ubkziFHmTmJ+8SDsMmgktDghtbPSKCOOhu2v7gceuA=;
        b=CgAIjU3F7msm2y18AD9u2Lpdodbk8let5Q6OXHNPOsFDoQxqOY3kufLXii4nEs4C6v
         bCsC+RRmAPkTSEvbpLT5Djh0EvVzKe7+0Z0+D4A9ce2kw+9WWbnx7ZrPvMr+pQs4e1BW
         n+79YPaMdbXwT67LStaAmuatolbfGbOqq4eHHrJ+/Leoqfe5NtcWSHoqXm2v5tHM3n/B
         PWYgOF8FIY58VzCE1Nda3TNKQGmFhVbFCuBwkIc07p6DDkDVEJX8DN56l08K2e6Tv6+B
         pxbFHEL8beZE5ijlUI62vP0CYgMKBofijjcQvgTIl+jDLCKNwG4vT6Bt+O6h4W6ap7F/
         Zwnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5ubkziFHmTmJ+8SDsMmgktDghtbPSKCOOhu2v7gceuA=;
        b=GdBPRhNspZvqGKl7WCIASrEz1SnnjdJ/GtkFBl/3z2B4/jeR/AshHi7iKX3F5SFTBb
         2tYEVCZyWkeS4vT61jzsWt1hRM02p7pb/N9Tk0OYclQAXBXvyT/O0VJQteWY+qe7Jn/N
         42MsQRm5s3ruP2kJiLnnOu51bDkQjINofJOqmXW5GtjTX1jjQIs6Xdq1BQ96Kch9c8TB
         FklJaBTsMDr3Gx61SVwZogM8ib1YP+vZ2Y7AfW15dTw8HmPsIh0nl/dF3zBqhqZDtVmK
         gRCUWUYD7GEEvQcCId7fQxTP70FljufkcZs7xT0OU/PP6gw+OVxsiTX5c7sCPKMWb+2I
         8p5w==
X-Gm-Message-State: AA6/9RmwVa+QkjNHq76zgllWDTEoE0mi6hxi/i4hWIpjj3XiWTsFEj5E4Y/Vud9h54L1WMBAiYRxiY0BP3oTBg==
X-Received: by 10.129.102.85 with SMTP id a82mr1304346ywc.160.1475560071627;
 Mon, 03 Oct 2016 22:47:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.96.195 with HTTP; Mon, 3 Oct 2016 22:47:31 -0700 (PDT)
In-Reply-To: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 3 Oct 2016 22:47:31 -0700
Message-ID: <CA+P7+xob7ohj1MxuLGGLwwJyi4RfqUTeLkbw86u+VvbU=uEyAw@mail.gmail.com>
Subject: Re: [PATCH 0/18] alternate object database cleanups
To:     Jeff King <peff@peff.net>
Cc:     Git mailing list <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 3, 2016 at 1:33 PM, Jeff King <peff@peff.net> wrote:
> This series is the result of Ren=C3=A9 nerd-sniping me with the claim tha=
t we
> could "easily" teach count-objects to print out the list of alternates
> in:
>
>   http://public-inbox.org/git/c27dc1a4-3c7a-2866-d9d8-f5d3eb161650@web.de=
/
>

Hah. Nerd snipes are fun.

> My real goal is just patch 17, which is needed for the quarantine series
> in that thread. But along the way there were quite a few opportunities
> for cleanups along with a few minor bugfixes (in patches 7 and 18), and
> I think the count-objects change in patch 16 is a nice general debugging
> tool.

Yea there are a *lot* of cleanups here.

>
> The rest of it is "just" cleanup, but I'll note that it clears up some
> hairy allocation code. These were bits that I noticed in my big
> allocation-cleanup series last year, but were too nasty to fit any of
> the more general fixes. I think the end result is much better.
>

Definitely agreed. I read through all the patches, and each one seemed
reasonable.

> The number of patches is a little intimidating, but I tried hard to
> break the refactoring down into a sequence of obviously-correct steps.
> You can be the judge of my success.
>

I read through them once. I'm going to re-read through them again and
leave any comments I had.

Regards,
Jake

>   [01/18]: t5613: drop reachable_via function
>   [02/18]: t5613: drop test_valid_repo function
>   [03/18]: t5613: use test_must_fail
>   [04/18]: t5613: whitespace/style cleanups
>   [05/18]: t5613: do not chdir in main process
>   [06/18]: t5613: clarify "too deep" recursion tests
>   [07/18]: link_alt_odb_entry: handle normalize_path errors
>   [08/18]: link_alt_odb_entry: refactor string handling
>   [09/18]: alternates: provide helper for adding to alternates list
>   [10/18]: alternates: provide helper for allocating alternate
>   [11/18]: alternates: encapsulate alt->base munging
>   [12/18]: alternates: use a separate scratch space
>   [13/18]: fill_sha1_file: write "boring" characters
>   [14/18]: alternates: store scratch buffer as strbuf
>   [15/18]: fill_sha1_file: write into a strbuf
>   [16/18]: count-objects: report alternates via verbose mode
>   [17/18]: sha1_file: always allow relative paths to alternates
>   [18/18]: alternates: use fspathcmp to detect duplicates
>
>  Documentation/git-count-objects.txt |   5 +
>  builtin/count-objects.c             |  12 +++
>  builtin/fsck.c                      |  10 +-
>  builtin/submodule--helper.c         |  11 +-
>  cache.h                             |  36 ++++++-
>  sha1_file.c                         | 179 ++++++++++++++++++------------=
--
>  sha1_name.c                         |  17 +--
>  strbuf.c                            |  20 ++++
>  strbuf.h                            |   8 ++
>  submodule.c                         |  23 +---
>  t/t5613-info-alternate.sh           | 202 ++++++++++++++++++++----------=
------
>  transport.c                         |   4 +-
>  12 files changed, 305 insertions(+), 222 deletions(-)
>
