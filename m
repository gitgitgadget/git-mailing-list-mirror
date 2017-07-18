Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7114720356
	for <e@80x24.org>; Tue, 18 Jul 2017 18:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751436AbdGRSGo (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jul 2017 14:06:44 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:35340 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751392AbdGRSGn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2017 14:06:43 -0400
Received: by mail-pf0-f170.google.com with SMTP id e199so14944111pfh.2
        for <git@vger.kernel.org>; Tue, 18 Jul 2017 11:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VP41wFbnA78/OvlA2iaz7QilE/whbAGHfdEYzS3Pfyc=;
        b=E7FF5FgkdYH8JTgI7DFMaOHEadtZyINKzOLsyoPoOG8H99Klqs35KWlUQPX3rGIw4h
         W2Pw1uRoJw56Y3ot1hbfzw9MbuYToFM+mRWaxIz+7WVQKXJdOD2CyhBDkATfQ1DH4DTP
         I7nozusMuNfhk2VQkYxXhfX05kXybAE43GvBX15AYwwAXI5j7TK63ZVe7gz6vZYLgir6
         twS9u1TvP3IZGvPx9sGlssLQ8zg46FQHBSASoZ7nmzCbd4buMywLL3QQ3rhjGHg/6kEX
         sUo6nFU1sjG3Sn+qSj3sUyI3N3v1dzVlR8FJqmVPP91f2KyjBPLJU5RPw1yxzh+XNFxt
         by5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VP41wFbnA78/OvlA2iaz7QilE/whbAGHfdEYzS3Pfyc=;
        b=GDE5hZLJgxsyMY9JmM4BEAtTxABhszkhilDQz7fr57KGBUDOmsPiIXNk6Qk3fNTbgC
         bsfVmHDQqgytTZw+fVL/y1yix1bP/4nCh/0jGgy/zqNGVaauqerE0NCRBI0vl1PHcYDy
         LtW98CjgiVNqsgWi1N6hB5zDpOcNRmjDXSUxy+GT1d1D3/F5urE28XwgwS0jvyv7whIv
         vZxARya69R29ZTYXR/kXZXjOzjsL97/W32S+gdp6oPP0kJm4rZD84SkYeB4Uy0JV3mAc
         Lyxptpba5y+lCXwciGalvjg7Y19CtKS3NAtn4omJjNXv+JDLmdtp1oFIsd+HyqkS0uyU
         YuZA==
X-Gm-Message-State: AIVw113oRB1rL8THUnQS08qSWLwmaWyXftV/g3hWkS8wp9W5mTgA2cWg
        rmnvlTNPg7GnIk/GIQZneojU2RSPqK4ShQE=
X-Received: by 10.101.76.206 with SMTP id n14mr3006682pgt.154.1500401202397;
 Tue, 18 Jul 2017 11:06:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.167.81 with HTTP; Tue, 18 Jul 2017 11:06:41 -0700 (PDT)
In-Reply-To: <20170718180057.GA22656@google.com>
References: <596ddaa620821_77f83e7330107c4@ss1435.mail> <CAGZ79kaPFDMn2K0f529-Crzv+vhU3XUMsSM6w3QV4RXKBv5s_g@mail.gmail.com>
 <xmqqa841fylf.fsf@gitster.mtv.corp.google.com> <CAGZ79kYohev8BdBEL9qnfmZ6quMwZPDRqZ44qCKV_wMwR=Etiw@mail.gmail.com>
 <xmqqy3rleijv.fsf@gitster.mtv.corp.google.com> <20170718180057.GA22656@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 18 Jul 2017 11:06:41 -0700
Message-ID: <CAGZ79kZrybXdUXosb=2qoS9jaSYvrkhiBOb6ka=nPZMO3Xt2WA@mail.gmail.com>
Subject: Re: Fwd: New Defects reported by Coverity Scan for git
To:     Brandon Williams <bmwill@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 18, 2017 at 11:00 AM, Brandon Williams <bmwill@google.com> wrote:
> On 07/18, Junio C Hamano wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>> >> I'd be more worried about segfault we seem to be getting only on
>> >> Windows from this:
>> >>
>> >>     git -C parent grep -e "(1|2)d(3|4)" --recurse-submodules HEAD^ > actual
>> >>
>> >> in https://travis-ci.org/git/git/jobs/254654195 by the way.
>> >
>> > Thanks for bringing that to my attention, (I do not follow the travis builds
>> > as closely, as there is no yelling email in my inbox).
>> >
>> > Windows builds on travis seem to be flaky.
>> > (sometimes they do not start), but there are also
>> > successful builds, including the -rc0, which may indicate
>> > bw/grep-recurse-submodules may be faulty on Windows.
>>
>> I can get valgrind complaints locally from
>>
>>     $ cd t && sh t7814-grep*.sh --valgrind -i -v
>>
>> so this may not be Windows only.  Can repo_worktree_path() return a NULL
>> in repo_read_gitmodules() to cause git_config_from_file() barf on a NULL
>> gitmodule_path?
>
> Yep that's most likely the cause.  The issue is if a repository doesn't
> have a worktree then what should a worktree path look like?
> repo_read_gitmodules() should check if there is a worktree before trying
> to load the gitmodules file.  I actually noticed this and have it fixed locally in
> another series I'm working on right now.  Looks like I may have to get
> that change in first though.  Thanks for finding this.

If there is no worktree, we could fallback to read it from the tree
HEAD:.gitmodules, if that doesn't exist, then there are no submodules.

Thanks,
Stefan
