Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0213E1F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 09:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbeKLTOl (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 14:14:41 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]:50944 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbeKLTOl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 14:14:41 -0500
Received: by mail-wm1-f51.google.com with SMTP id 124-v6so7742347wmw.0
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 01:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=R/NOsNhkUWGph1e2BhI9hcEYmbfw109KMRX3M8a49Fk=;
        b=GV6ABq6oU2RMsuqkGzy3t9vhoK0mVpTeWZn7+FyBobAlBoGWPpyTfgx5re8vtuIXNj
         6UVBdPcyNkZlGE6TN40kcrCeMgvAmIS6WdnkIFDGNLlDbouGrfy4vwYzFv+jLsTxN3QE
         iG0VR86cCz8M20dlEXPxj9+s6S9Qch1aMr0LYhWbsZEMt17MR5w0TmORfuBBuRER8113
         aTWnyvKwWwPyVkcex+Ag1q/phHeA4sA70lgabvcjaG58jQ6YtahpPglU/pX3TnCzQPkl
         7M+doTxhhjz7PSiE1n7P8j58jxQoY+M1WNGIizODagKep9SvJHBKT/ch0sLrQ2N4ONcg
         hk6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=R/NOsNhkUWGph1e2BhI9hcEYmbfw109KMRX3M8a49Fk=;
        b=JSbklC1GHm+BN8c5c+y+FR8TwHJw12iZvn+5SuJa+5YCk0LOKzP5WvLBIGovDE3/B0
         pwE7K5TzA843ya+ciigi6FLqR7rFF6z/KmMkDPXpzf5NIJF8+IEY9k9xxkv717havwLL
         8dXKWjGC7JTltCpQsMA9pO8bLFPv+wgHvXwUrvgcxKYGt45CFvBMU4vDC1mFFQdW21Q0
         uhBewfKcwKAyiMHGy6vPVMppsrzoHjTnsS49gyB9aIMPO0lRGfL7xeG7i4HqNcV8g1uc
         fcaOU5pgUwwdYwhoaesQi6jdxrJMUsvs2dObqvwj1tfntnJt25FMM7pH4EcQLDJX7EW+
         zjSg==
X-Gm-Message-State: AGRZ1gIYar4JiVH1aXflP5woNOnT6FIXvrjlV5sseByQLcC9hhVpch9j
        iHCcAJql07IPvQ3BgBS7BXX6c5rq
X-Google-Smtp-Source: AJdET5dryXzEHEy0WJeAtG2LDGB+dCpn9WTcLsj15wjttw1yN40lEQG8FziPVP4l4+LloI+GVKDL0A==
X-Received: by 2002:a1c:4b1a:: with SMTP id y26-v6mr7209231wma.82.1542014539527;
        Mon, 12 Nov 2018 01:22:19 -0800 (PST)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id 64-v6sm7488742wml.22.2018.11.12.01.22.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 01:22:18 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Konstantin Khomoutov <kostix@bswap.ru>
Cc:     yan ke <yanke131415@gmail.com>, martin.delille@gmail.com,
        git@vger.kernel.org
Subject: Re: Add issue management within git
References: <881C01A7-82BB-4A4D-9CDC-6ECDA451B12B@gmail.com> <CAJosSJ4_PXrXUxn0WfFcR90SbDL0UWRRGPpxEjVwc=3NwWP+Jg@mail.gmail.com> <20181112085335.r5mk6b3l4faloayn@tigra>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181112085335.r5mk6b3l4faloayn@tigra>
Date:   Mon, 12 Nov 2018 10:22:17 +0100
Message-ID: <87pnva3b1y.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 12 2018, Konstantin Khomoutov wrote:

> On Mon, Nov 12, 2018 at 09:35:31AM +0800, yan ke wrote:
>
>> > This would be awesome to handle issue directly with git:
>> > Having an offline version of the issues synced to the gitlab/github issues.
>> > A lot of work is done on the issues and it is lost when migrating
>> > from one service to the other.
>> > Beside we don’t always have a good internet connection.
>> > There is already a kind of integration between commit message fixing
>> > issue automatically when merged in the master branch (with “fix
>> > #143’).
>>    Very very agree, now it is very difficult to find a solution when
>> has some problem such build problem an so on! The mail-list is good to
>> send patch es, but is it not suitable for problem track or problem
>> solution search!
>>    Now the Github or Gitlab is good to track issues, suggest to open
>> the git issue track!
>
> Please don't hijack the discussion: the original poster did not question
> the workflow adopted by the Git project itself but rather asked about
> what is colloquially called "distributed bug tracker", and wanted to
> have one integrated with (or into) Git. That is completely orthogonal
> story.

Correct, but let's assume good faith here and presume yan ke just
misread the original E-mail. Many of us (and perhaps yourself) are
participating in our second, third, fourth etc. language on this list :)

> As to searching for Git issues / problem solutions - I'd recommend using
> the search on the main Git mailing list archive [1] and the issue
> tracker of the Git for Windows project [2].
>
> The communities around Git also include the "Git Users" low-volume
> mailing list [3] (also perfectly searcheable), and the "git" tag at
> StackOverflow [4].
>
> 1. https://public-inbox.org/git/
> 2. https://github.com/git-for-windows/git/issues
> 3. https://groups.google.com/forum/#!forum/git-users
> 4. https://stackoverflow.com/questions/tagged/git

Yeah. I'll add to that that this specific thing has been discussed here
really recently:

https://public-inbox.org/git/CACSZ0Pwzs2e7E5RUEPDcEUsa=inzCyBAptU7YaCUw+5=MutSsA@mail.gmail.com/
https://github.com/MichaelMure/git-bug/

So Martin, there's already a nascent tool that does this. It looks like
the main thing it needs now is users & testers.
