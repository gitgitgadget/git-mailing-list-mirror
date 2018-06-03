Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 198CC1F403
	for <e@80x24.org>; Sun,  3 Jun 2018 21:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751232AbeFCVu0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 17:50:26 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37270 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751159AbeFCVuZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 17:50:25 -0400
Received: by mail-wm0-f68.google.com with SMTP id l1-v6so11235543wmb.2
        for <git@vger.kernel.org>; Sun, 03 Jun 2018 14:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:openpgp:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=RF5f7mQII3bMpGYqd/tiS1bgMnoEf6JSdAqxWrW1ntk=;
        b=de3Ji+V0Ax7K5tDTDBE1ZLAyZwHu3ZEAp0zJ2e+K7JRy1B1/27/INTGQBBVS8LP3Ya
         F6mPU4EF4YJk9KACzNAeht8sumZFjbHQQlsoOaxSR4yBrAB7+bDzQOo6FZuyb5dxjNMP
         N4wCG11EHibXhseHp4i6Y3neUofCeWDFuDO+xZWizzr0uqEZRuR+rgW6DmVsO9g6P2QL
         aUZuSeknxu9z5Aix60ENqqXgpdUj0r1nMkCz0dOK1fC8UgTEZjdyCGdCJMKOj6/fpzk0
         /vAxXLghp/ezKI07qxoJuB3IxoGqAiNVVQx0DAHj8mtUscBfKQD5FO2sB+73u12QNTp6
         iK6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:openpgp:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=RF5f7mQII3bMpGYqd/tiS1bgMnoEf6JSdAqxWrW1ntk=;
        b=dV8KJtsXWoD/2QYtytFA/74czsINWOUHrI9ucUL1dIjVFuXhbxky7ncI321Fvb03gP
         jqZ8BdmV+3OZcdnAPQB/FknRlSnxDy7PEnwUM7udqwCPU1aacthG3CZZkdqPoD2jjXQZ
         qh+G4AiF7SD+3B/zooGJbMWLkkOj3ArK/CV0jWLd4HHLXvSULXhUajqUJ+hE/oXHPx/D
         BNI87pbVOQiN4cJhPqr3y5VL+rV+ijPWdvU0YuB9vrMnrS22G3R2OELfO2EfrucYFGpU
         dpQJvT1X7ZhkXdgJNoRDX9k6yyxndBd9Igi1zKFWTjQMaEfDWsPmgk9M5IbbtRd8UcHm
         lKHw==
X-Gm-Message-State: ALKqPwcGvx8s3m+Ud0KR1cYa/GpYvpKchnMFmjdEIyoJ1vQjrmlsVjiF
        4dB81VTCcAPI8zi0UyxkWZM=
X-Google-Smtp-Source: ADUXVKK2usXguhL2UeMPOQ8KZVyxjxUFnYHjk5FGeoDsaEjyFedIxIgPH3G84LozzP/nn4gZLMxCZg==
X-Received: by 2002:aa7:c309:: with SMTP id l9-v6mr21381178edq.304.1528062623998;
        Sun, 03 Jun 2018 14:50:23 -0700 (PDT)
Received: from [192.168.0.104] (AToulouse-658-1-184-117.w86-199.abo.wanadoo.fr. [86.199.39.117])
        by smtp.gmail.com with ESMTPSA id l9-v6sm13993732edb.17.2018.06.03.14.50.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Jun 2018 14:50:22 -0700 (PDT)
To:     Git List <git@vger.kernel.org>
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Pratik Karki <predatoramigo@gmail.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC] GSoC with git, week 5
Openpgp: preference=signencrypt
Message-ID: <7aa242ed-0d19-669b-574f-9d0847e2169e@gmail.com>
Date:   Sun, 3 Jun 2018 23:50:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I wrote a post about this week. Unfortunately, I have a technical issue
with my website, so you can find it right in this email instead. I’m
sorry about that. I will publish it on my blog as soon as it comes back
online.

Feel free to give me your feedback!

Cheers,
Alban


--

As you may know, I made no less than three attempts to upstream my
changes about ``preserve-merges`` last week.

This week began by a fourth one[1].

4th attempt
-----------

Johannes pointed out some problems with my commit messages on that
series:

 - some lines are too long
 - they do not describe what I wanted to do well.

On the first point, commits messages should wrap at 72 characters, but
I configured Emacs to wrap pretty much anything at 80 characters.

He also wanted to keep the original name of
``git_rebase__interactive__preserve_merges()`` (which I renamed
``git_rebase__preserve_merges()``), but I decided not to, as this
function is now part of ``git-rebase--preserve-merges.sh``.

Also, Friday, Junio Hamano announced[2] that my changes (among many
others) have been merged into the ``pu`` (proposed updates) branch of
git.git. This does not mean that it will necessarily hit ``master``,
but it’s a start.

TODO: help
----------

When you start an interactive rebase, you’re greeted with your
``$EDITOR``, containing a list of commits to edit, and an help text
explaining you how this works.

So, this week, I rewrote the code writing this message from shell
to C. You can find the branch here[3], and the discussion on the list
here[4].

The conversion itself is quite trivial, but strings are a rather
curious case here: some of them begins with one or two newlines. As
this becomes useless in C, Stefan advised me to remove them, as this
would probably cause less confusion for the translators, but it
implies changing the translations, as pointed out by Johannes and
Phillip Wood. Right now, no clear opinion has emerged from the
discussion.

Some additionnal work and refactoring could be made once more code has
been converted. For instance, the todo-list file is opened, modified,
and closed several times. Instead, we could create a ``strbuf``, build
it progressively, then write it once to the todo file.

What’s next?
------------

I’ve started to work on converting the ``edit-todo`` functionnality of
interactive rebase. This is also a straightforward change, but it
would also require some future work once the conversion is completed.

[1]
https://public-inbox.org/git/20180528123422.6718-1-alban.gruin@gmail.com/
[2] https://public-inbox.org/git/xmqqa7sf7yzs.fsf@gitster-ct.c.googlers.com/
[3] https://github.com/agrn/git/tree/ag/append-todo-help-c
[4]
https://public-inbox.org/git/20180531110130.18839-1-alban.gruin@gmail.com/
