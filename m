Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 158BF20986
	for <e@80x24.org>; Sun,  9 Oct 2016 10:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751219AbcJIKwo (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Oct 2016 06:52:44 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:36214 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750850AbcJIKwm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Oct 2016 06:52:42 -0400
Received: by mail-io0-f171.google.com with SMTP id j37so86206313ioo.3
        for <git@vger.kernel.org>; Sun, 09 Oct 2016 03:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=F3bwp+eALn0Xrpnbh/D9w4QOamerRadxIZl5aLPnT+c=;
        b=A1u9Yl+YFOpfUkpltj3AKQeL1ghcr7Ih1QkNYYWS3cwciNB14KILK8e/xE4tNWxJzq
         Q06tlqAAoPVc//Y5RKx5OBYrUwiii3aF/9FGU5mNkOQgZV/x8V4koomEQlcgI9QwlZ4f
         n6xychqj+t4yeN2CdnkPCd2rv7egkLrdBmx3SzC/uBpQ4RFHqkwe8jHBhAKBlyakb9xd
         e8Y38pe9JERO11BY/WGP7Kz3uCqTcVpSS3cjz6/3Qt2vDPKXGWEptywwqe5ZAD5aX7HN
         9YQK+IbT4bJDroL+Bgs/SjHjVq2PsCeiYoPKEAKLhuq02cjN5qfCqjyq8H4nRiznDOeV
         3TOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=F3bwp+eALn0Xrpnbh/D9w4QOamerRadxIZl5aLPnT+c=;
        b=JJ9Ni5zTGocx8idLmCznPTXFG7hdJ10Yui5qigI5sucmVFDLuJr7WUVYTpXfPMITht
         S7LpQvqC/YWBLSAt6nRwAb51HZhEY63Z264lPU0ToouE+sblODsmEtpkirz5xsRDHdhp
         dpSMmvznQiAabgdVFOLywkmh4WYyHepsV6N1+DrTMwBcC8y1oaxXgaHIaUsPjTq1TZGv
         8pH4uETz4O4m7JiLzszCYtKqPZRYJCPLGgDhDGxs18FdWFWjS+027OlgTojiaP1Fr2NR
         zqCeeA909jzRKPEStKNvTYw7HTXow969tHclJ8zHS9cII4FGik7M0y/vPwTju2Jwbgst
         Fq/g==
X-Gm-Message-State: AA6/9RkKO2gGwLdqTo6xMLIYiwoCE9SrLW78XooZCnyFjZik6SVaFWmAd/cmzDJwtkCj6BCglkzd0ESJMtfV0Q==
X-Received: by 10.107.44.17 with SMTP id s17mr27124175ios.212.1476010362057;
 Sun, 09 Oct 2016 03:52:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.230.206 with HTTP; Sun, 9 Oct 2016 03:52:11 -0700 (PDT)
In-Reply-To: <1475999513.7410.8.camel@kaarsemaker.net>
References: <CAOi_75+2SG2WYHBMQhfGj96eKsZ66niJzOevVGM5eJv-qqrVNg@mail.gmail.com>
 <1475999513.7410.8.camel@kaarsemaker.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 9 Oct 2016 17:52:11 +0700
Message-ID: <CACsJy8CmgmGLEi0xQUY9Eo-4FkA4eDNk9WJ2LtEDVFQBjbFdCA@mail.gmail.com>
Subject: Re: Bug? git worktree fails with master on bare repo
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
Cc:     Michael Tutty <mtutty@gforgegroup.com>,
        Git Mailing List <git@vger.kernel.org>,
        Michael Rappazzo <rappazzo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 9, 2016 at 2:51 PM, Dennis Kaarsemaker
<dennis@kaarsemaker.net> wrote:
> On Sat, 2016-10-08 at 19:30 -0500, Michael Tutty wrote:
>> Hey all,
>> I'm working on some server-side software to do a merge. By using git
>> worktree it's possible to check out a given branch for a bare repo and
>> merge another branch into it. It's very fast, even with large
>> repositories.
>>
>> The only exception seems to be merging to master. When I do git
>> worktree add /tmp/path/to/worktree master I get an error:
>>
>> [fatal: 'master' is already checked out at '/path/to/bare/repo']
>>
>> But this is clearly not true, git worktree list gives:
>>
>> [/path/to/bare/repo (bare)]
>>
>> ...and of course, there is no work tree at that path, just the bare
>> repo files you'd expect.
>
> The worktree code treats the base repo as a worktree, even if it's
> bare. For the purpose of being able to do a checkout of the main branch
> of a bare repo, this patch should do:
>
> diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
> index 4bcc335..b618d6b 100755
> --- a/t/t2025-worktree-add.sh
> +++ b/t/t2025-worktree-add.sh
> @@ -138,6 +138,14 @@ test_expect_success 'checkout from a bare repo without "add"' '
>         )
>  '
>
> +test_expect_success '"add" default branch of a bare repo' '
> +       (
> +               git clone --bare . bare2 &&
> +               cd bare2 &&
> +               git worktree add ../there3 master
> +       )
> +'
> +
>  test_expect_success 'checkout with grafts' '
>         test_when_finished rm .git/info/grafts &&
>         test_commit abc &&
> diff --git a/worktree.c b/worktree.c
> index 5acfe4c..35e95b7 100644
> --- a/worktree.c
> +++ b/worktree.c
> @@ -345,6 +345,8 @@ const struct worktree *find_shared_symref(const char *symref,
>
>         for (i = 0; worktrees[i]; i++) {
>                 struct worktree *wt = worktrees[i];
> +               if(wt->is_bare)
> +                       continue;
>
>                 if (wt->is_detached && !strcmp(symref, "HEAD")) {
>                         if (is_worktree_being_rebased(wt, target)) {
>
>

You're fast :) I'm still studying  8d9fdd7 (worktree.c: check whether
branch is rebased in another worktree - 2016-04-22). But yeah that
should fix it.

> But I'm wondering why the worktree code does this. A bare repo isn't a
> worktree and I think it shouldn't treat it as one. A patch that rips
> out this feature and updates the tests to match would look like this:
>
>
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 5c4854d..3600530 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -382,15 +382,11 @@ static int add(int ac, const char **av, const char *prefix)
>  static void show_worktree_porcelain(struct worktree *wt)
>  {
>         printf("worktree %s\n", wt->path);
> -       if (wt->is_bare)
> -               printf("bare\n");
> -       else {
> -               printf("HEAD %s\n", sha1_to_hex(wt->head_sha1));
> -               if (wt->is_detached)
> -                       printf("detached\n");
> -               else
> -                       printf("branch %s\n", wt->head_ref);
> -       }
> +       printf("HEAD %s\n", sha1_to_hex(wt->head_sha1));
> +       if (wt->is_detached)
> +               printf("detached\n");
> +       else
> +               printf("branch %s\n", wt->head_ref);
>         printf("\n");
>  }

This goes back to the first very first commit of "git worktree list":
bb9c03b (worktree: add 'list' command - 2015-10-08) and was sort of
pointed out during review [1] but nobody answered it.

A bare repo does not have an associated worktree. However only main
worktree can be bare. If we take this out, "git worktree list"'s first
line will no longer be about the main worktree (because it does not
exist). That may cause trouble since we promised in "git-worktree.txt"
that the main worktree is listed first. I don't think we have any way
else to determine if the main worktree exists. Showing "bare" may be
the way to see if we have a main worktree or not. So we probably want
to keep this function unchanged.

[1] https://public-inbox.org/git/%3CCANoM8SWeqxD2vWLQmEfxxxn8Dz4yPfjGOoOH=Azn1A3So+wz2Q@mail.gmail.com%3E/
-- 
Duy
