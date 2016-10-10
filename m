Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C29220989
	for <e@80x24.org>; Mon, 10 Oct 2016 16:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752909AbcJJQMz (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 12:12:55 -0400
Received: from mail-qt0-f179.google.com ([209.85.216.179]:34406 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752286AbcJJQMx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 12:12:53 -0400
Received: by mail-qt0-f179.google.com with SMTP id q7so59548333qtq.1
        for <git@vger.kernel.org>; Mon, 10 Oct 2016 09:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZS5122JZYkikd636/r+FsmSryfbRnMDc8fTZASsHoYw=;
        b=P2i3m6n03uelYb3HpY4/FiK3J00cYqbfrQsKjZ9Hn89McFfgfQkcXzJi8yMVUiZ/7/
         P79khvRE9beNVrnpZVxq1MmfjRUCwZ5jiE5kDm/UQb2RnIr/0mcTrRw8Mbs7QW34XY+b
         dI59h4GMReKwp71kXkw1aYDUI5A3F7WaHg2cFQOOmQZw3j4hOsHjXQE7cXt2EVsh3WmD
         IQll6mBw6bo/20SqGmziG5ga01PjchC2N2ROa8wsLaJk0ANtDMms1QOvmZFlLw7vslhv
         r844XyN8MgN66D+4rUjnMeriLv/yUwxz4oS8o1ur5XJCOV7y5YFWPMBBIj/80VHr90V3
         QooQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZS5122JZYkikd636/r+FsmSryfbRnMDc8fTZASsHoYw=;
        b=LZKAEP4Jp5LWB3BkjRIImDsvh5RqUjfoaw0Bj8WlwwxuK83Ot6rKRbZRLMEqkjPvX+
         Th2c+zGTiaWoOY0kuZ5Mz+geNdlxe1t6ojjCc6Rnt+o6hVm7iSVSOvdnAJhVpUraEst3
         waiAUMBoCkj5N9ZuGVlcCnhVhWBhmZYy60qXmsiQDZpOV7ho4BG1fLUMFFNHYLp7Kp/Q
         nb5hDf+7LmQdmDaj4QsI8VefAhmOLauyUY4Mi4ZKjHM9EjOeoTJlfKk3gqWq9aesbKJi
         h3Jo8xfnvJ2vqTRyCVaON8Wy4UB2sNA7q9+9UZDj8QCpG9+NJ7YGHHqoLCvdePvYHKxW
         529A==
X-Gm-Message-State: AA6/9RlTCEyAGuwKJIj1Pkw8DnsG92xcZz+SWHKJQ2yUL14f6+SXrLJ4Z9sPqxGnmNJlsIrR9poqiTcOehOYcg==
X-Received: by 10.194.200.162 with SMTP id jt2mr30140328wjc.172.1476115946393;
 Mon, 10 Oct 2016 09:12:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.236.135 with HTTP; Mon, 10 Oct 2016 09:12:25 -0700 (PDT)
In-Reply-To: <20161010153032.v2x773cbs4ifvzec@sigill.intra.peff.net>
References: <CAN40BKqPdPP2+K4FBzgDDfYiGkzk1gYcOeP==_t+pr5w0rj0EQ@mail.gmail.com>
 <20161010153032.v2x773cbs4ifvzec@sigill.intra.peff.net>
From:   Seaders Oloinsigh <seaders69@gmail.com>
Date:   Mon, 10 Oct 2016 17:12:25 +0100
Message-ID: <CAN40BKoWroM4ZJHHdMvO8YvvCho0FnWzV9BG9E5xnCZbYOO2pg@mail.gmail.com>
Subject: Re: git filter-branch --subdirectory-filter not working as expected,
 history of other folders is preserved
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the reply, Jeff.

Clearing the backups of the branches, those starting with
"refs/original" has gotten me closer, but I also needed to do that
with "refs/tags" as well, or change my filter-branch command to,

  git filter-branch -f --prune-empty --tag-name-filter cat
--subdirectory-filter android -- --all

I still have remnants of that other history, though.

Due to the structure of this repo, it looks like there are some
branches that never had anything to do with the android/ subdirectory,
so they're not getting wiped out.  My branch is in a better state to
how I want it, but still, if I run your suggestion,

  git log --all --source -- unity/

I get output like

> commit 4853c... refs/heads/unity-sdk-3_1_3
> Author: serg... <serg...@...ve.com>
> Date:   Thu Sep 11 16:30:01 2014 +0100
>
>    Started 3.1.3

Which is basically logs of branches which contain only edits within
the unity/ subdirectory of the original root.  There are other
branches like that for the other platforms / subdirectories of the
original root, which if that is the case, I would consider
filter-branch with the subdirectory-filter isn't acting as expected,
and doesn't get rid of all the history you want it to get rid of.


On Mon, Oct 10, 2016 at 4:30 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Oct 10, 2016 at 02:42:36PM +0100, Seaders Oloinsigh wrote:
>
>> We have a git repository that looks like
>>
>> sdk/
>> android/
>> ios/
>> unity/
>> windows/
>>
>> Which we'd like to split into 4 repositories, 1 for each platform.  To
>> start this process (for splitting android out), I ran,
>>
>> git filter-branch -f --prune-empty --subdirectory-filter android -- --all
>
> OK, so that should rewrite each ref to have only the contents of the
> "android" directory at the top-level.
>
> Note that filter-branch saves a copy of the old refs in refs/original.
>
>> Which rewrote a ton of history and commits, and looked like it worked, but
>> on closer inspection had left a ton of history behind.
>>
>> If I run
>>
>> git log --all -- unity/
>>
>> It returns a list of commits that happened in the unity/ subfolder of the
>> original root.
>
> Here you asked for "--all", which includes refs/original. So you are
> seeing the original, unwritten commits (and none of your new ones, of
> course, because they do not have a unity/ directory!).
>
> Try:
>
>   git log --all --source -- unity
>
> to see which ref each commit is coming from.
>
> Or try:
>
>   git log --branches --tags -- unity
>
> to confirm that your branches and tags do not include that path.
>
> Or just:
>
>   git for-each-ref --format='delete %(refname)' refs/original |
>   git update-ref --stdin
>
> to get rid of the backup refs entirely.
>
> -Peff
