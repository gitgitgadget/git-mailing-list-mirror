Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 459E71FA65
	for <e@80x24.org>; Mon, 21 Nov 2016 22:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754863AbcKUW5y (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Nov 2016 17:57:54 -0500
Received: from mail-qk0-f177.google.com ([209.85.220.177]:34042 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754583AbcKUW5x (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2016 17:57:53 -0500
Received: by mail-qk0-f177.google.com with SMTP id q130so667556qke.1
        for <git@vger.kernel.org>; Mon, 21 Nov 2016 14:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yvB0HmRYoJ82jZOvgVsUpp5wfkDqoGwldypIbkjQW6A=;
        b=Z9D+WlLIGEQOFUX9E+n8BTPtSKhuDH1/L8UmVU0Nenw9fx2IPaPD0r1C1TVEHxGDW9
         T206SguGm+7rDFPq44KUWO8/cCYn8ADQ9uH+ifn16UraaRLCZxEgqeiLadK9F+zWFYVC
         YuDkIDD+5iFazWE1sj8B4yKoByqQ5fD3W8LdDWRjLfEl2ZCFGIugffIWS7zR8FlE2Q3B
         +Mz6E79kYvF0+RGfha6HquCbLqAbkA9+OB2aYCgGkjpunTPOrU+T5HgeaXTEhB6SIaBM
         b4Q0zCNbRCwIkzIwpFfHGQm/2DDA6H/5WxyjaHXVKEqlho0ezOsTti16dmYQ+nFH1sFt
         x3Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yvB0HmRYoJ82jZOvgVsUpp5wfkDqoGwldypIbkjQW6A=;
        b=FbEmWGPqnNEzQ9vrgzowmwPZj1STQW6lJkRy5TkNkWwUk4Fsjj62RoO2GBnVCv8nw5
         +LtuJzNaINoong9olaTAdIJ3ZafJwhMVdQpMdthNbR0qUMRpz2XAJ5bOtP9Q2pCzrj0l
         P0iRqHgSaGh/OCk/rKb5pDFXuUsDHQ/u6hHQJ5RtXeN/q1zlLZlaAs+iXhDHUWXfL04L
         yJ4K7iISNz/5aJjRvvtzVU63ts7WyM8hNRyKq99J+QOqT3CszY708bZ/LJo53WSp678B
         qNaSLu7JCCHR3/6ZUaGavaWATfX9i3TYXsoN1KPuM5vGO1fAXOOjo4+MmpX3on5WLg12
         INmQ==
X-Gm-Message-State: AKaTC02Z7kUBZ06VhzqQCkYOz1sAISUvPDH5j5eRBo93SQIsHiMVR2YUzegvxpPgYD0w8dFc23bdb0AXoWfGv3Yh
X-Received: by 10.55.191.134 with SMTP id p128mr17962456qkf.58.1479769063520;
 Mon, 21 Nov 2016 14:57:43 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.134.65 with HTTP; Mon, 21 Nov 2016 14:57:43 -0800 (PST)
In-Reply-To: <xmqqpoloh3xa.fsf@gitster.mtv.corp.google.com>
References: <xmqqpoloh3xa.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 21 Nov 2016 14:57:43 -0800
Message-ID: <CAGZ79kbCebHojPDUdHn2mmjUwRe-FOcnJqtoa828PJwC6P5mNw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Nov 2016, #04; Mon, 21)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> * sb/push-make-submodule-check-the-default (2016-10-10) 2 commits
>  - push: change submodule default to check when submodules exist
>  - submodule add: extend force flag to add existing repos
>
>  Turn the default of "push.recurseSubmodules" to "check" when
>  submodules seem to be in use.
>
>  Will hold to wait for hv/submodule-not-yet-pushed-fix

Which is cooking in next, so we'd want to include this into next as well?

When including this series, we get 2 benefits:
* the cooking of hv/submodule-not-yet-pushed-fix is greatly enhanced as
  more submodule users will make use of it (as it would be the default).
* for non submodule users we would see if the approximated estimation
  if the user cares about submodules produces false positives:

        if (has_submodules_configured || file_exists(git_path("modules")) ||
           (!is_bare_repository() && file_exists(".gitmodules")))
                recurse_submodules = RECURSE_SUBMODULES_CHECK;
        else
                recurse_submodules = RECURSE_SUBMODULES_OFF;

This heuristic was introduced after we got burned and called out by Linus,
so I would expect this series to not stress non submodule users any more.

>
> * dt/empty-submodule-in-merge (2016-11-17) 1 commit
>  - submodules: allow empty working-tree dirs in merge/cherry-pick
>
>  An empty directory in a working tree that can simply be nuked used
>  to interfere while merging or cherry-picking a change to create a
>  submodule directory there, which has been fixed..
>
>  Waiting for review.

I thought I had reviewed it, will do again and comment.

> * bw/grep-recurse-submodules (2016-11-18) 6 commits
>  - grep: search history of moved submodules
>  - grep: enable recurse-submodules to work on <tree> objects
>  - grep: optionally recurse into submodules
>  - grep: add submodules as a grep source type
>  - submodules: load gitmodules file from commit sha1
>  - submodules: add helper functions to determine presence of submodules
>
>  "git grep" learns to optionally recurse into submodules
>
>  Waiting for review.

I did review both off and on list and I think the latest version is good.


> * hv/submodule-not-yet-pushed-fix (2016-11-16) 4 commits
>   (merged to 'next' on 2016-11-21 at 1a599af962)
>  + submodule_needs_pushing(): explain the behaviour when we cannot answer
>  + batch check whether submodule needs pushing into one call
>  + serialize collection of refs that contain submodule changes
>  + serialize collection of changed submodules
>
>  The code in "git push" to compute if any commit being pushed in the
>  superproject binds a commit in a submodule that hasn't been pushed
>  out was overly inefficient, making it unusable even for a small
>  project that does not have any submodule but have a reasonable
>  number of refs.
>
>  Will cook in 'next'.

Thanks!

>
> * jt/use-trailer-api-in-commands (2016-11-02) 6 commits
>  - sequencer: use trailer's trailer layout
>  - trailer: have function to describe trailer layout
>  - trailer: avoid unnecessary splitting on lines
>  - commit: make ignore_non_trailer take buf/len
>  - SQUASH???
>  - trailer: be stricter in parsing separators
>
>  Commands that operate on a log message and add lines to the trailer
>  blocks, such as "format-patch -s", "cherry-pick (-x|-s)", and
>  "commit -s", have been taught to use the logic of and share the
>  code with "git interpret-trailer".
>
>  What's the doneness of this topic?

From a cursory read (with the SQUASH applied)
this seems to be done to me.

> * sb/submodule-config-cleanup (2016-11-02) 3 commits
> - submodule-config: clarify parsing of null_sha1 element
> - submodule-config: rename commit_sha1 to commit_or_tree
> - submodule config: inline config_from_{name, path}
>
>  What's the doneness of this topic?

Jake Keller reviewed this and it turns out I was not careful in patch 2/3.

Will resend.

Thanks,
Stefan
