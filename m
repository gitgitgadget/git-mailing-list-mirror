Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A1B61F406
	for <e@80x24.org>; Sat, 12 May 2018 18:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751312AbeELSuU (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 14:50:20 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:46051 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751096AbeELSuT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 May 2018 14:50:19 -0400
Received: by mail-wr0-f193.google.com with SMTP id p5-v6so8309943wre.12
        for <git@vger.kernel.org>; Sat, 12 May 2018 11:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=BeXWIcHTrrrwYD1R4Z/r0NFVDIbiZrCx92LohjqLOu8=;
        b=myHNsrvN63Sc3FKYkWJ8tFRjxQdawnoEyoPPC8QOrQPPF7rxOcEr0qXx4Pc21u94C5
         82JUifuFLqJox8zbaW3h6qvrkUL6TEa4EkD9WwxULPSNkA7h6LWxmHCT86B1nEAN8vtg
         auJTnzEgBEUQJNoOul/sRjpLkPOtl/9Mcq6ik6erJvrJSuty9LdRGmYXCKRs75KHTKh1
         AyGEsaMQlBXADtcUiud43u1Rt8KxtLQX+o0EiFJncoHvgRwFgOaxIfM1lb2U5t6SLyUc
         8f//gy5Sbyw7YCfcFn9rzR7gjU01p2LHjYRGs0ga9DqU9KyHqC37SVIws5tf2GjR1Gn4
         ijwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=BeXWIcHTrrrwYD1R4Z/r0NFVDIbiZrCx92LohjqLOu8=;
        b=p9iqlRlXePdecI/oFCueuVcnfeAX6FyvcbDYt+Um5jCfjMT9gw3uLm+qBJgWviS+Om
         fixz8MMPV7z1gWhHPiGD4IbSJig8PURx2zpUXg8GdOFgVDhWteLHvusTaleoDdae3Smr
         8iTcMPonrMlS8nG8GtKD/dkzigHJIvqglGYgZTjGJGXwRDK00uDrLLUOlLgGOqG7V8HF
         zbt+l7Zgv6zrGvci9hfrb2DbGsIxq+G+vds+LsZ93NkJy+k+FlIiIoBnt04rZQbyjUXP
         QrG5z0xZX7qTFtkLOg0qRsN+VGGYRVuWs1tj4/ByeKKaM6p/Y5V6n1wwx1jWU1ZqhvrF
         TRQw==
X-Gm-Message-State: ALKqPwc1UklMR5a2UvFldKKMMTYxxxvADuXJQwzXPWquWjZuCQzSyUCY
        PhGuh3JB8X5eWRP8v8WEYuTofPco
X-Google-Smtp-Source: AB8JxZqUll6WndhS1A8CPQwDf0o8T47uczbFC+9QBx3xx+qtKw76Qoq55jmDd84zyxQlYwzPneeqfQ==
X-Received: by 2002:adf:8b08:: with SMTP id n8-v6mr2416877wra.189.1526151017697;
        Sat, 12 May 2018 11:50:17 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (abrh212.neoplus.adsl.tpnet.pl. [83.8.101.212])
        by smtp.gmail.com with ESMTPSA id d8-v6sm7515048wrb.52.2018.05.12.11.50.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 12 May 2018 11:50:16 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 00/12] Die commit->util, die!
References: <20180512080028.29611-1-pclouds@gmail.com>
Date:   Sat, 12 May 2018 20:50:14 +0200
In-Reply-To: <20180512080028.29611-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Sat, 12 May 2018 10:00:16 +0200")
Message-ID: <86lgco3dzt.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> There's not much to write here. It's basically a copy from 12/12:
>
> This 'util' pointer can be used for many different purposes,
> controlled in different ways. Some are not even contained in a command
> code, but buried deep in common code with no clue who will use it and
> how. For example, if revs.show_source is set, then it's used for
> storing path name, but if you happen to call get_merge_parent() then
> some 'util' may end up storing another thing.
>
> The move to using commit-slab gives us a much better picture of how
> some piece of data is associated with a commit and what for. Since
> nobody uses 'util' pointer anymore, we can retire it so that nobody will
> abuse it again. commit-slab will be the way forward for associating
> data to a commit.
>
> As a side benefit, this shrinks struct commit by 8 bytes (on 64-bit
> architecture) which should help reduce memory usage for reachability
> test a bit. This is also what commit-slab is invented for [1].
>
> [1] 96c4f4a370 (commit: allow associating auxiliary info on-demand -
> 2013-04-09)

Good work.  This would reduce the amount of technical debt in Git.

I just wonder if most of those transformation could not be done with
Coccinelle, instead of doing it by hand.

> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (12):
>   blame: use commit-slab for blame suspects instead of commit->util
>   describe: use commit-slab for commit names instead of commit->util
>   shallow.c: use commit-slab for commit depth instead of commit->util
>   sequencer.c: use commit-slab to mark seen commits
>   sequencer.c: use commit-slab to associate todo items to commits
>   revision.c: use commit-slab for show_source
>   bisect.c: use commit-slab for commit weight instead of commit->util
>   name-rev: use commit-slab for rev-name instead of commit->util
>   show-branch: use commit-slab for commit-name instead of commit->util
>   log: use commit-slab in prepare_bases() instead of commit->util
>   merge: use commit-slab in merge remote desc instead of commit->util
>   commit.h: delete 'util' field in struct commit
>
>  bisect.c              | 12 +++++++++---
>  blame.c               | 42 +++++++++++++++++++++++++++++++-----------
>  blame.h               |  2 ++
>  builtin/blame.c       |  2 +-
>  builtin/describe.c    | 16 +++++++++++++---
>  builtin/fast-export.c | 14 +++++++++-----
>  builtin/log.c         | 17 +++++++++++++----
>  builtin/merge.c       | 25 +++++++++++++------------
>  builtin/name-rev.c    | 23 ++++++++++++++++++++---
>  builtin/show-branch.c | 39 +++++++++++++++++++++++++++------------
>  commit.c              | 12 ++++++++++--
>  commit.h              |  8 ++++++--
>  log-tree.c            |  8 ++++++--
>  merge-recursive.c     |  8 +++++---
>  revision.c            | 17 +++++++++++++----
>  revision.h            |  5 ++++-
>  sequencer.c           | 24 ++++++++++++++++++------
>  shallow.c             | 37 +++++++++++++++++++++++++------------
>  18 files changed, 225 insertions(+), 86 deletions(-)
