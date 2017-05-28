Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65DF41FD09
	for <e@80x24.org>; Sun, 28 May 2017 23:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750891AbdE1XbI (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 May 2017 19:31:08 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:34618 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750844AbdE1XbH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 May 2017 19:31:07 -0400
Received: by mail-io0-f195.google.com with SMTP id 12so5698662iol.1
        for <git@vger.kernel.org>; Sun, 28 May 2017 16:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=A649jLXz6piofUTyAidmmuML77L+7VvN3+x0B4WCvwo=;
        b=W0jnme+znXpO9GMQMtn5sRVp/ko1w5yG7Jvyicv7iJ1KkBb4SSRy+KCT/6KC7DXzX9
         4m4Y7Zij74BAN4VhDbrQ9biqBOfJROQ1y6bMAhGK6t0AcyORx/c++XwJYhor6utsoeJB
         37kr+2e+0vejIFV2wjfDSFA9ZsT0fGhnStvQDCQjewVPvqrS9EqFJEdcgUAwhu9dAy59
         NuI46wpGDM4UoYkV5kKpS5WPQxPPybxzO0uuZDlmToyiNzdwTbBEyFfS5RMwGdtBT5uM
         a2BeZ6ntuAVG42ikoLSCPzsQI6grrmicj4iRC8hnfZkTLQ4m+ca5w4zadMKwu4qSxXLP
         k1Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=A649jLXz6piofUTyAidmmuML77L+7VvN3+x0B4WCvwo=;
        b=Glx4r1XKiI1vQ3sIRJCUgfVjzaT0HmZeW5iDXlfovT8Q3kGLB4vq+LG1q04hVBjN0D
         hfmJAV38Gp7wnHO/H04Gxolv9jhTOKuGbVhXVUjrv/5m/Kz4yUNyuQiwS4OoAagmbl5+
         DcEnHGm9JYOR6AJr8N4UjJpLgg7ilnpZGhmnMS5Ja31qj2LnxHKxZ5sye+YVlQ3n08IB
         wKJaBDZGrYTS5GVkAZj2bf6lSlDhyd4bNUBqVVy4TMHqqWph/GX5nKeVnqhuPEc6Y5EG
         L5+vKhLDxGnY2ask9nPbF9ffEm8jhsV4uFnkadPBy5nAULgx2IS0kBrgi2Xmtd/SyCjn
         J8Fg==
X-Gm-Message-State: AODbwcA4lCpARer0Mw3GcHlLWwhNhxxhNMTSbhQ73JCaeou4+qdwotKC
        zyXXmypiSlR2Q5JrJbMJS+3GysXWLw==
X-Received: by 10.107.201.131 with SMTP id z125mr10164395iof.160.1496014266897;
 Sun, 28 May 2017 16:31:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Sun, 28 May 2017 16:30:46 -0700 (PDT)
In-Reply-To: <0102015c5146c8ca-e5144538-326b-47b8-8c81-af31da4cdfe0-000000@eu-west-1.amazonses.com>
References: <0102015c5146c8ca-e5144538-326b-47b8-8c81-af31da4cdfe0-000000@eu-west-1.amazonses.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 29 May 2017 01:30:46 +0200
Message-ID: <CACBZZX4LpRK5q+cxToWqGeW2ZgN4ggo4h9SJpx0mZkZUR15jNw@mail.gmail.com>
Subject: Re: [PATCH/RFC] branch: add tests for new copy branch feature
To:     Sahil Dua <sahildua2305@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 29, 2017 at 12:56 AM, Sahil Dua <sahildua2305@gmail.com> wrote:
> New feature - copying a branch along with its config section.
>
> Aim is to have an option -c for copying a branch just like -m option for
> renaming a branch.
>
> This commit adds a few basic tests for getting any suggestions/feedback
> about expected behavior for this new feature.
>
> Signed-off-by: Sahil Dua <sahildua2305@gmail.com>
> ---
>  t/t3200-branch.sh | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>
> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index fe62e7c775da..2c95ed6ebf3c 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -341,6 +341,59 @@ test_expect_success 'config information was renamed, too' '
>         test_must_fail git config branch.s/s/dummy
>  '
>
> +test_expect_success 'git branch -c dumps usage' '
> +       test_expect_code 128 git branch -c 2>err &&
> +       test_i18ngrep "branch name required" err
> +'
> +
> +git config branch.d.dummy Hello
> +
> +test_expect_success 'git branch -c d e should work' '
> +       git branch -l d &&
> +       git reflog exists refs/heads/d &&
> +       git branch -c d e &&
> +       git reflog exists refs/heads/d &&
> +       git reflog exists refs/heads/e
> +'
> +
> +test_expect_success 'config information was copied, too' '
> +       test $(git config branch.e.dummy) = Hello &&
> +       test $(git config branch.d.dummy) = Hello
> +'
> +
> +git config branch.f/f.dummy Hello
> +
> +test_expect_success 'git branch -c f/f g/g should work' '
> +       git branch -l f/f &&
> +       git reflog exists refs/heads/f/f &&
> +       git branch -c f/f g/g &&
> +       git reflog exists refs/heads/f/f &&
> +       git reflog exists refs/heads/g/g
> +'
> +
> +test_expect_success 'config information was copied, too' '
> +       test $(git config branch.f/f.dummy) = Hello &&
> +       test $(git config branch.g/g.dummy) = Hello
> +'
> +
> +test_expect_success 'git branch -c m2 m2 should work' '
> +       git branch -l m2 &&
> +       git reflog exists refs/heads/m2 &&
> +       git branch -c m2 m2 &&
> +       git reflog exists refs/heads/m2
> +'
> +
> +test_expect_success 'git branch -c a a/a should fail' '
> +       git branch -l a &&
> +       git reflog exists refs/heads/a &&
> +       test_must_fail git branch -c a a/a
> +'
> +
> +test_expect_success 'git branch -c b/b b should fail' '
> +       git branch -l b/b &&
> +       test_must_fail git branch -c b/b b
> +'
> +
>  test_expect_success 'deleting a symref' '
>         git branch target &&
>         git symbolic-ref refs/heads/symref refs/heads/target &&
>

This looks good to me. Comments, in no particular order:

* There should be a test for `git branch -c <newbranch>`, i.e. that
should implicitly copy from HEAD just like `git branch -m <newbranch>`
does. However, when looking at this I can see there's actually no test
for one-argument `git branch -m`, i.e. if you apply this:

--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -699,8 +699,6 @@ int cmd_branch(int argc, const char **argv, const
char *prefix)
        } else if (rename) {
                if (!argc)
                        die(_("branch name required"));
-               else if (argc == 1)
-                       rename_branch(head, argv[0], rename > 1);
                else if (argc == 2)
                        rename_branch(argv[0], argv[1], rename > 1);
                else

The only test that fails is a `git branch -M master`, i.e.
one-argument -M is tested for, but not -m, same codepath though, but
while you're at it a patch/series like this could start by adding a
one-arg -m test, then follow-up by copying that for the new `-c`.

* We should have a -C to force -c just like -M forces -m, i.e. a test
where one-arg `git branch -C alreadyexists` clobbers alreadyexists,
and `git branch -C source alreadyexists` does the same for two-arg.

* I know this is just something you're copying, but this `git branch
-l <name>` use gets me every time "wait how does listing it help isn't
that always succeeding ... damnit it's --create-reflog not --list, got
me again" :)

Just noting it in case it confuses other reviewers who are skimming
this. Might be worth it to just use --create-reflog for new tests
instead of the non-obvious -l whatever the existing tests in the file
do, or maybe I'm the only one confused by this :)

* When you use `git branch -m` it adds a note to the reflog, your
patch should have a test like the existing "git branch -M baz bam
should add entries to .git/logs/HEAD" test in this file except
"Branch: copied ..." instead of "Branch: renamed...".

* Should there be tests for `git branch -c master master` like we have
for `git branch -m master master` (see 3f59481e33 ("branch: allow a
no-op "branch -M <current-branch> HEAD"", 2011-11-25)). Allowing this
for -m smells like a bend-over-backwards workaround for some script
Jonathan had, should we be doing this for -c too? I don't know.
