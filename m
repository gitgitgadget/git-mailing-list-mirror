Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8670B1FC96
	for <e@80x24.org>; Tue, 29 Nov 2016 19:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755391AbcK2TVn (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Nov 2016 14:21:43 -0500
Received: from mail-qk0-f171.google.com ([209.85.220.171]:35307 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752169AbcK2TVl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2016 14:21:41 -0500
Received: by mail-qk0-f171.google.com with SMTP id n204so185537020qke.2
        for <git@vger.kernel.org>; Tue, 29 Nov 2016 11:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3ELE6ldY7J7uSfB4+1zZCRy0ho0xwE2jrSM3Ps9gzFo=;
        b=EG7RlermHYB/hs14CbFpHMOZbFLTruACUft8JTV7Y9vU00SlDq3zowQuaaBIqRSV/m
         e4ENKQtGFd+hD3bF2sNZ8uWblRQAER4sFTX2yKEVzPMdSDnvZqi4OvefMhSdF3YnQB5+
         9s2FL80hgOI/dv2mO/df1a1q5Wj6kZVNbCd5efrdmn0F4R3NkgjW3qhQNKFw0U+1Z8RL
         29zZhaI0z+gfEL9fH0MwKQdUmydISE7juosru4O4j+w9gVyW17gL1XzVUmmybGqXa7hu
         gYw6zBg9JtgODnsAX8LI+AURE+zltDkE3kIriBUBIhEp0jwodevBOJCL61MxEnfXcGjr
         wW7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3ELE6ldY7J7uSfB4+1zZCRy0ho0xwE2jrSM3Ps9gzFo=;
        b=KEUCmWcSjHVz8nvC64eO1aS+U/guaugB5VGd/xWmJlTBVNDtXcQtyDbg4eDjkn1pff
         nxREIiJubiyEWGIlqSsTGlYYIb213lywINiky34yIaxRwpH9qJ+tJ08HqBIZvgJw1gZy
         8w6upHeZ3ylTZhGMfLMPXXkNBdy3jpQMSo2b2FrfWblU5Qi4UzdGeuXPsNDOeytirw71
         Vy9WlrKKjrfX6VKcdzj8KN6DtvkYbTZi9Za2W4lSCqWbuyljUQ9DlsWeh9IaiByFCjsX
         kEOGGRvn1wGVfCVqOnb95GtNmbMACZZBgbYlKLi9Jl5cV2A5epviOKO4ov7XjqJhmzRb
         tM0A==
X-Gm-Message-State: AKaTC036/S2Cx41UkJvPLFp+3bC1pD9by/ixV05WHaUwg5LpalbTw5NOlSwVhD99OiTkaM+B1x5fdFMAaYLsN6uW
X-Received: by 10.55.186.3 with SMTP id k3mr28106957qkf.47.1480447299678; Tue,
 29 Nov 2016 11:21:39 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Tue, 29 Nov 2016 11:21:39 -0800 (PST)
In-Reply-To: <xmqqk2bngn03.fsf@gitster.mtv.corp.google.com>
References: <xmqqk2bngn03.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 29 Nov 2016 11:21:39 -0800
Message-ID: <CAGZ79kZbBufaKoJyTQa_DseE5GofMAwb=ujtEYn35r9VEwdJ2g@mail.gmail.com>
Subject: Re: What's cooking in git.git (Nov 2016, #06; Mon, 28)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 28, 2016 at 4:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> * sb/push-make-submodule-check-the-default (2016-10-10) 2 commits
>  - push: change submodule default to check when submodules exist
>  - submodule add: extend force flag to add existing repos
>
>  Turn the default of "push.recurseSubmodules" to "check" when
>  submodules seem to be in use.
>
>  Need to rebase on hv/submodule-not-yet-pushed-fix and then consider
>  merging to 'next'.

The rebase is without merge conflicts, so I assume there is no
work needed by me here.

> * sb/submodule-intern-gitdir (2016-11-22) 5 commits
>  - SQUASH
>  - submodule: add embed-git-dir function
>  - test-lib-functions.sh: teach test_commit -C <dir>
>  - submodule helper: support super prefix
>  - submodule: use absolute path for computing relative path connecting
>
>  A new submodule helper "git submodule embedgitdirs" to make it
>  easier to move embedded .git/ directory for submodules in a
>  superproject to .git/modules/ (and point the latter with the former
>  that is turned into a "gitdir:" file) has been added.
>
>  Need to read it over again, deal with SQUASH, and may ask for a
>  reroll.

Ok, I looked over it again and I may see some issues:
* it is applicable to all submodules recursive by default, i.e. really
  "all submodules reachable from this superproject". I anticipate
  this to be the most relevant use case (i.e. as a preparatory step
  for having e.g. git-checkout work), but there are no other commands
  yet that are recursing into submodules recursively by default. So
  a discussion/disagreement on the default may come up.
  (We also may want to see a --[no-]recursive flag)

* The output is okay-ish, but could be better as it is a mix of
  relative and absolute path:

    Migrating git directory of plugins/cookbook from
    '/absolute/path/here/gerrit/plugins/cookbook/.git' to
    '/absolute/path/here/gerrit/.git/modules/plugins/cookbook/'

  On the other hand this seems like what the user may need,
  as it is the maximum for trouble shooting

* As this is a subcommand we do not need to add it to command-list.txt
  However we may want to discuss if some submodule commands are
  porcelain (all except for the new embedgitdirs?) and if this new command
  is plumbing. We could also argue the submodule--helper (which needs
  listing in command-list.txt as a plumbing command?) is the plumbing
  equivalent and the "submodule embedgitdirs" is the porcelain.

* any other part where we need to add documentation for a new command?

FYI: I have a series cooking internally that adds a new page in
Documentation/submodules that introduces the concept of submodules,
which then allows Documentation/git-submodule.txt to be focused on the
actual command and its options.

>
> * dt/empty-submodule-in-merge (2016-11-17) 1 commit
>  - submodules: allow empty working-tree dirs in merge/cherry-pick
>
>  Waiting for review

That slipped by me. Will review.

> * sb/attr (2016-11-11) 35 commits
>  - completion: clone can initialize specific submodules
>  - clone: add --init-submodule=<pathspec> switch
>  - submodule update: add `--init-default-path` switch

I may end up rerolling these top three patches as its own series
again without the underlying pathspec support.

I will investigate if we need the mutex at all for the attribute
code or if we can initialize all attrs (in the pathspecs) before the
threaded preload_index takes place. That sounds cleaner to me,
but I do not prioritize it as high.

>  Waiting for review.

There was some review by Duy and Brandon, I may reroll with just their
issues addressed.

Thanks,
Stefan
