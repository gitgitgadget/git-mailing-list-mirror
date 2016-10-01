Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00C9120986
	for <e@80x24.org>; Sat,  1 Oct 2016 21:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751055AbcJAVj2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Oct 2016 17:39:28 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34541 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750947AbcJAVj0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Oct 2016 17:39:26 -0400
Received: by mail-wm0-f67.google.com with SMTP id b201so3411500wmb.1
        for <git@vger.kernel.org>; Sat, 01 Oct 2016 14:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=824kJ+sWfimqraGJsXl1zDw2m5zWLp1wppir7Uu5Gwg=;
        b=04ubb3MBck5TV1FbhmBfGsxz6pGJA7ZP6hmaREnA9qMS8JMWb+AxmIRrXRd85tC7vx
         +kvMn4a3Gti95JdlgjSNn8d44lsk0xTX7wZDdTkidw20ly6njcE0FkCUqKr4DDg1ZQ0D
         +/Bxbkz9yA32MIPU+N3qbinQVtjt+iNYnlBwkGASj8/oIdJeeFJ51XQhDkdiilW7gzQu
         TTfmM5bxulKPeTwOUJFJb8OVqK9NZG2L4Z/dCCl/Ye3c4aHiR09iinvDofq5F/n+6syI
         1W5wZJjq9VzF9e6NKajFs6WZnKQURzf4yqKv819XKHoGqkkp/aJR9idS+/9kDF8NJoYw
         5aIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=824kJ+sWfimqraGJsXl1zDw2m5zWLp1wppir7Uu5Gwg=;
        b=FGLdaYd+VlGDi6t7IquYcB8o7WbrV/uJchQqoh1T3OpA6oprEHJQJXFWgo6dXsUvv/
         6hNYtGVVHCTz8Xnx1MQHFF3NN8XNESZLoVfd1m/xUKjKCfq8+n2fHt6A6aVkL/xxgrwf
         gtTbET/N+jrkBQe4RIWES11U0ijv2KGKVdoOh2wJPu6XsEb1IsliifEop8EU5XhW1vLx
         ay3/jSDn+98HsbZm3w0Yykgdm/S2ou7myQV0t2I8h/mZfOZyDRv4uBY/ydaQHTLzvyuc
         5On9ZPrRynSSOA258/SuUXYOBdpQ3ZCvo8eAHauXOXTNoNIevbt23p+HAj6WZVlnS95g
         qSwQ==
X-Gm-Message-State: AA6/9RmvxTQplj3KcilUSWeyEWyagl1G7/Iz9+bBGtnYHMRcCE6CKy4rKX5TGiiFk1oR0w==
X-Received: by 10.28.46.82 with SMTP id u79mr3682939wmu.57.1475357965177;
        Sat, 01 Oct 2016 14:39:25 -0700 (PDT)
Received: from [192.168.1.26] (abrc125.neoplus.adsl.tpnet.pl. [83.8.96.125])
        by smtp.googlemail.com with ESMTPSA id n7sm10918940wmf.18.2016.10.01.14.39.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Oct 2016 14:39:23 -0700 (PDT)
Subject: Re: "Purposes, Concepts,Misfits, and a Redesign of Git" (a research
 paper)
To:     Kevin Daudt <me@ikke.info>
References: <20160930191413.002049b94b3908b15881b77f@domain007.com>
 <481910fd-5a5f-ffc6-b98c-61d48b4a2e49@gmail.com>
 <20161001201325.GA29588@ikke.info>
Cc:     Konstantin Khomoutov <kostix+git@007spb.ru>, git@vger.kernel.org,
        Santiago Perez De Rosso <sperezde@csail.mit.edu>,
        Daniel Jackson <dnj@csail.mit.edu>,
        Greg Wilson <gvwilson@third-bit.com>,
        =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@mat.umk.pl>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <ce42f934-4a94-fa29-cff0-5ebb0f004eb5@gmail.com>
Date:   Sat, 1 Oct 2016 23:39:13 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20161001201325.GA29588@ikke.info>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 01.10.2016 o 22:13, Kevin Daudt pisze:
> On Sat, Oct 01, 2016 at 12:24:57AM +0200, Jakub Narębski wrote:
>>
>> | 7.2.1 Discussion
>> [...]
>> | There could be other use cases for the
>> | staging area that Gitless doesn’t handle well but we expect
>> | these to be fairly infrequent.

I'd like to point to the word "other" in the above sentence...

>>
>> Like handling merge conflict...??? Infrequent doesn't mean
>> unimportant.
> 
> For me the most important thing is that the lack of staging area leads
> on commits that have no clear goal, people just commit everything they
> have changed at some point, as a sort of checkpoint.
> 
> Although lots of people still do this with git currently, they don't
> even have the possibility[1] to improve on this.
> 
> This makes history and features like git bisect less useful.
> 
> 
> [1] At most they can specify the files they want to commit, but this is
> still a very crude way to group together changes.

... If you had read the original discussed research paper 
http://people.csail.mit.edu/sperezde/pre-print-oopsla16.pdf
you would notice that this use case is covered by Gitless,
though imperfectly.

  Common use cases for the staging area in Git are to select
  files to commit, split up a large change into multiple commits,
  and review the changes selected to be committed. We address
  the first by providing a more flexible `commit` command that
  lets the user easily customize the set of files to commit (with
  `only`, `include` and `exclude` flags). For the second use case
  we have a `partial` flag in `commit` that allows the user to
  interactively select segments of files to commit (like Git’s
  `commit --patch`).

First imperfection is that only equivalent of `git commit --patch`,
that is additive selection of changes during commit.  There are,
from what I understand, no equivalents of `git add --interactive`
(crafting additively and subtractively part by part, not all at
once), `git reset --patch` (crafting additively from any commit,
defaults to HEAD), `git checkout --patch` (crafting subtractively).
It is a good thing to have those possibilities when disentangling
working area, or splitting commit during interactive rebase.

Though all of those could be added (if they are not present
already) to the interactive interface of `partial` flag in
`gl commit`.


Second imperfection is that you cannot test the crafted state
without creating a commit.  In Git you have `git stash --keep-index`
for this; go to the state crafted in the staging area (the index),
and you can test it.

Though you can always create a [temporary] commit, run tests, and
then if necessary amend this commit.


On the other hand the index / the staging area is important and
useful thing in helping to resolve merge conflicts, for example
the one where one side changed file and other deleted it, or
where one side renamed file and other changed it, etc.

-- 
Jakub Narębski

mailto:jnareb@gmail.com
mailto:jnareb@mat.umk.pl

