Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6FC71FAE3
	for <e@80x24.org>; Wed, 14 Mar 2018 07:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753306AbeCNHaO (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 03:30:14 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:36401 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751470AbeCNHaN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 03:30:13 -0400
Received: by mail-qk0-f180.google.com with SMTP id d206so2460364qkb.3
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 00:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=xN9B3ic7rwJtE3AjCDa/GA4iSWEadKcLg/L/sTXEEqU=;
        b=feKFi4LCQOS6mLloC5UjdCaDncsQURzSSTTktE02WY7uqfFyX14PMx7DAhoK+Sk/+A
         qlF9GFXYCdOPmxYD37ONmDzz0gghhqdbkuUUaP2e5/dMTd0PhYefO66+reyxMFtQ8N3v
         CYsPpLq2SPin+PnRyWbbqTHnB77CKz9kHJFeQD7cf/tySEf6zpm46U1q5julXiELyBQy
         K3684HWbVTgkMOPLY0sYlUEQdAwTNDp8jrQxDG7/KLOKFUPTPdVnrgxABvyH97biiMXs
         nB2DYCJXDfeCGIpBiNynR0lYYrTeNlDOT6SShzaPmNA3q5hLNcXM2e/7Ie0hMvbL7rlB
         vT9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=xN9B3ic7rwJtE3AjCDa/GA4iSWEadKcLg/L/sTXEEqU=;
        b=V3oV68o3E2PRuuP0l+MeU9DCn7L1UnWezNEIbTHQYWwnpzge+zAY9PaxnP5iEqEw6u
         d4aGfMOT2yVEcFs5z4F0cHwGpSrWeNyo7eDcoBF9IiBtCWgLPo877Dj/bnVTqL4Km+q9
         lYrRlBZKHeKV3pER/t3/XILrzF8DnhmBoZPxZeaLiXZT4AOXZoN/G7ykLZ+Huxp6S+SE
         uBrqfwxW6GlE+ey3HpV2c5voh/M7vhCl4TrWZLsoFlAg66MLc+rxtHWj8rN+JqFxSLJD
         nocRVYgAiXs+q1CRaX38Xn2eMiigNswR/frEFxCqt7kjdT90c1MetMQmovV6xrKaN8n+
         V+8g==
X-Gm-Message-State: AElRT7FmgoVbWItMfXSUF6ZF9cwxQUGL5NrMUoiyFcnWCkzdJe2xXnVD
        2hNbC2PZgDugHQs4XBZcZ4eii9ksq36ac6nj/xI=
X-Google-Smtp-Source: AG47ELsdRCaLI3km7P1J3w8O6tXAgGLvCDuFW4LP2Bvtzy93PjUrKz0STVgH7MOzXBQxd9HCx7//NY7UmZjSJMzCsjs=
X-Received: by 10.55.54.199 with SMTP id d190mr5193462qka.220.1521012612354;
 Wed, 14 Mar 2018 00:30:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.190.196 with HTTP; Wed, 14 Mar 2018 00:30:11 -0700 (PDT)
In-Reply-To: <20180313201945.8409-1-predatoramigo@gmail.com>
References: <20180313201945.8409-1-predatoramigo@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 14 Mar 2018 03:30:11 -0400
X-Google-Sender-Auth: EhRTITL_yULqCtCu0dbxA8cAjME
Message-ID: <CAPig+cRPzyw525ODC4=-E7w=zbpbhVN2eqxSYDSLij5wfW8S_A@mail.gmail.com>
Subject: Re: [GSoC] [PATCH] test: avoid pipes in git related commands for test suite
To:     Pratik Karki <predatoramigo@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the patch. See comments below...

On Tue, Mar 13, 2018 at 4:19 PM, Pratik Karki <predatoramigo@gmail.com> wrote:
> This patch removes the necessity of pipes in git related commands for test suite.
>
> Exit code of the upstream in a pipe is ignored so, it's use should be avoided. The fix for this is to write the output of the git command to a file and test the exit codes of both the commands being linked by pipe.

Please wrap commit messages to fit in about 72 columns; this one is
far too wide.

On the Git project, commit messages are written in imperative mood, as
if telling the codebase to "do something". So, instead of writing
"This patch removes...", you could word it "Remove..." or "Avoid...".

It's misleading to say that the patch "removes the _necessity_ of
pipes" since pipes were not used out of necessity; they were probably
just a convenience and seemed reasonable at the time, but later
experience has shown that they can be problematic for the reason you
give in the second paragraph.

Taking these observations into consideration, perhaps you could
rewrite the commit message something like this:

    Avoid using pipes downstream of Git commands since the exit codes
    of commands upstream of pipes get swallowed, thus potentially
    hiding failure of those commands. Instead, capture Git command
    output to a file apply the downstream command(s) to that file.

More comments below...

> Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
> ---
> diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
> @@ -116,10 +116,10 @@ test_expect_success \
>  test_expect_success \
>      'checking the commit' \
> -    'git diff-tree -r -M --name-status  HEAD^ HEAD | \
> -     grep "^R100..*path0/COPYING..*path2/COPYING" &&
> -     git diff-tree -r -M --name-status  HEAD^ HEAD | \
> -     grep "^R100..*path0/README..*path2/README"'
> +    'git diff-tree -r -M --name-status  HEAD^ HEAD >actual &&
> +     grep "^R100..*path0/COPYING..*path2/COPYING" actual &&
> +     git diff-tree -r -M --name-status  HEAD^ HEAD >actual &&
> +     grep "^R100..*path0/README..*path2/README" actual'

Although this "mechanical" transformation is technically correct, it
is nevertheless wasteful. The exact same "git diff-tree ..." command
is run twice, and both times output is captured to file 'actual',
which makes the second invocation superfluous. Instead, a better
transformation would be:

    git diff-tree ... >actual &&
    grep ... actual &&
    grep ... actual

The same observation applies to other transformations in this patch.

> diff --git a/t/t9104-git-svn-follow-parent.sh b/t/t9104-git-svn-follow-parent.sh
> @@ -204,8 +204,8 @@ test_expect_success "follow-parent is atomic" '
>  test_expect_success "track multi-parent paths" '
>         svn_cmd cp -m "resurrect /glob" "$svnrepo"/r9270 "$svnrepo"/glob &&
>         git svn multi-fetch &&
> -       test $(git cat-file commit refs/remotes/glob | \
> -              grep "^parent " | wc -l) -eq 2
> +       test $(git cat-file commit refs/remotes/glob >actual &&
> +              grep "^parent " actual | wc -l) -eq 2
>         '

This is not a great transformation. If "git cat-file" fails, then
neither 'grep' nor 'wc' will run, and the result will be as if 'test'
was called without an argument before "-eq". For example:

    % test $(false >actual && grep "^parent " actual | wc -l) -eq 2
    test: -eq: unary operator expected

It would be better to run "git cat-file" outside of "test $(...)". For instance:

    git cat-file ... >actual &&
    test $(grep ... actual | wc -l) -eq 2

Alternately, you could take advantage of the test_line_count() helper function:

    git cat-file ... >actual &&
    grep ... actual >actual2 &&
    test_line_count = 2 actual2

> diff --git a/t/t9110-git-svn-use-svm-props.sh b/t/t9110-git-svn-use-svm-props.sh
> @@ -21,32 +21,32 @@ uuid=161ce429-a9dd-4828-af4a-52023f968c89
>  test_expect_success 'verify metadata for /bar' "
> -       git cat-file commit refs/remotes/bar | \
> -          grep '^git-svn-id: $bar_url@12 $uuid$' &&
> -       git cat-file commit refs/remotes/bar~1 | \
> -          grep '^git-svn-id: $bar_url@11 $uuid$' &&
> -       git cat-file commit refs/remotes/bar~2 | \
> -          grep '^git-svn-id: $bar_url@10 $uuid$' &&
> -       git cat-file commit refs/remotes/bar~3 | \
> -          grep '^git-svn-id: $bar_url@9 $uuid$' &&
> -       git cat-file commit refs/remotes/bar~4 | \
> -          grep '^git-svn-id: $bar_url@6 $uuid$' &&
> -       git cat-file commit refs/remotes/bar~5 | \
> -          grep '^git-svn-id: $bar_url@1 $uuid$'
> +       git cat-file commit refs/remotes/bar >actual &&
> +          grep '^git-svn-id: $bar_url@12 $uuid$' actual &&
> +       git cat-file commit refs/remotes/bar~1 >actual &&
> +          grep '^git-svn-id: $bar_url@11 $uuid$' actual &&
> +       git cat-file commit refs/remotes/bar~2 >actual &&
> +          grep '^git-svn-id: $bar_url@10 $uuid$' actual &&
> +       git cat-file commit refs/remotes/bar~3 >actual &&
> +          grep '^git-svn-id: $bar_url@9 $uuid$' actual &&
> +       git cat-file commit refs/remotes/bar~4 >actual &&
> +          grep '^git-svn-id: $bar_url@6 $uuid$' actual &&
> +       git cat-file commit refs/remotes/bar~5 >actual &&
> +          grep '^git-svn-id: $bar_url@1 $uuid$' actual
>         "

An indented line in the original shows that it is a continuation of
the preceding line. However, in the revised code, that is not so, thus
it probably makes sense to drop the indentation.

The same comment applies to several additional cases snipped from this reply.

> diff --git a/t/t9114-git-svn-dcommit-merge.sh b/t/t9114-git-svn-dcommit-merge.sh
> index 50bca62de..c945c3758 100755
> --- a/t/t9114-git-svn-dcommit-merge.sh
> +++ b/t/t9114-git-svn-dcommit-merge.sh
> @@ -68,7 +68,7 @@ test_debug 'gitk --all & sleep 1'
>  test_expect_success 'verify pre-merge ancestry' "
>         test x\$(git rev-parse --verify refs/heads/svn^2) = \
>              x\$(git rev-parse --verify refs/heads/merge) &&
> -       git cat-file commit refs/heads/svn^ | grep '^friend$'
> +       git cat-file commit refs/heads/svn^ >actual && grep '^friend$' actual
>         "

Style: split the line at the '&&'...

    git cat-file ... >actual &&
    grep ... actual

The same comment applies to another test snipped from this reply.

Aside: The current patch wants to solve the problem of exit code being
swallowed down pipes, however, this and other tests are afflicted by a
similar problem with $(...) also swallowing the exit code. A failure
of "git rev-parse" could potentially go unnoticed inside "test
x$(...)". Fixing that is outside the scope of the current patch,
however, a follow-on patch to fix that problem (if you feel so
inclined) might transform it something like this:

    git rev-parse ... >rev1 &&
    git rev-parse ... >rev2 &&
    test_cmp rev1 rev2 &&
