Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 723321F4DD
	for <e@80x24.org>; Wed,  6 Sep 2017 18:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751924AbdIFSfS (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Sep 2017 14:35:18 -0400
Received: from mail-yw0-f181.google.com ([209.85.161.181]:33930 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750807AbdIFSfS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2017 14:35:18 -0400
Received: by mail-yw0-f181.google.com with SMTP id r85so9099468ywg.1
        for <git@vger.kernel.org>; Wed, 06 Sep 2017 11:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JznPojs6SX3dnRsB6CSyFR6UggzXJqoYGnj/kkFwJr8=;
        b=mar3UYLch1Sqx5COheJ+ugKV1lYoGnX+Cj26sXFeXW+8G8SXGjbGbK1gs1sB/M1xd8
         zjYcpyQYt+n5pfWC0BU5n4dqtbkWsk0eVeAecASyygyCt7T94IgMTm/3oHHrfXPX6N2I
         Jdh/6dQXrexwZplu3st0o9bCwmD25949x50gSPm0CzRE0iHiLMr1zCMOv6WFieJbP7hq
         VlrFH/6X7tBYAvMCvpJ62uEgPcvpPndHBKeQbk4AABtZ9Qb2bAtH5CP/LmHj4tlwAbab
         g150mLdQsqMGXsJ6ETnu449vz3e0oJ6Se6OC/JnlQjUV7r1TgQ6pzzg3x7cMdr0X+TVK
         wclw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JznPojs6SX3dnRsB6CSyFR6UggzXJqoYGnj/kkFwJr8=;
        b=cRN3KwSxsS1GnvrOdmlUU4N7oUEficEqwHaE7jST9Cnng9cRQ1AEqWR7RlUbQPsfRb
         Z3CYoIwE3+zmJjJcLTX3o0xoNBcU591CBWNLnG/91TVeQTr2QD4ltyXYOiPs4hHydk9E
         rTcySax6qbZHxCLcI2tXJ5n7SisGPrQx5VHesjIW893QdC19AJhlY1hiKOSVSCIWTMl5
         1o7zwKNqrc+fQoG1z2oWpydDKUiEqw0MyRQdV6y24Wmvi6QJxumK98Bvxjuu6g9WacQY
         RTSJuTJqJXuT9lLg5/aG0KrdpINf5NLk5gUXyZGqr15Z8s/7PvHD3gdNGZWN/XJsngwk
         iWmA==
X-Gm-Message-State: AHPjjUhGlE5f+wiclLCInnTRqSCUFd6No//0izaJ+o/Zkr4zjY3XD5hh
        zc6ekfsR7UCZ7OfLIlZwuVAGMi6yPVxd
X-Google-Smtp-Source: ADKCNb5WlEfw2kL68VNYAB5ily5yXcU0vGkttv2cZ/1eTFpBqKONgWsLIqH8KiJyiX8LVp0NxLBh/7VrU8wT5hgIVww=
X-Received: by 10.37.160.66 with SMTP id x60mr36634ybh.305.1504722917130; Wed,
 06 Sep 2017 11:35:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.116.7 with HTTP; Wed, 6 Sep 2017 11:35:16 -0700 (PDT)
In-Reply-To: <CAHd499AuoZ-89mpnVkMhxaDT44SRNT2xWE7sykcaP8n5xTRd-g@mail.gmail.com>
References: <CAHd499AuoZ-89mpnVkMhxaDT44SRNT2xWE7sykcaP8n5xTRd-g@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 6 Sep 2017 11:35:16 -0700
Message-ID: <CAGZ79kaLdw0bX2gfw6AxQtQJZD9iiZGhYPJt9HwUh9T_+0T=fw@mail.gmail.com>
Subject: Re: gitmodules below root directory
To:     Robert Dailey <rcdailey.lists@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Cc:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 6, 2017 at 6:53 AM, Robert Dailey <rcdailey.lists@gmail.com> wrote:
> The gitmodules documentation[1] states that the .gitmodules file is at
> the root. However, it would be nice if this could be supported in any
> directory similar to how .gitignore works. Right now git-subrepo does
> not support submodules inside of a subrepo[2] (I suspect subtrees
> would have the same problem, but I did not verify). I think this is a
> limitation of git, rather than subrepo itself. Perhaps there are
> reasons why .gitmodules must be at the root, but I at least wanted to
> point it out and see if this could be supported.
>
> [1]: https://git-scm.com/docs/gitmodules
> [2]: https://github.com/ingydotnet/git-subrepo/issues/262

I agree that subtree likely suffers the same problem.
And at first it seems reasonable to want to have .gitmodules
at deeper trees supported, as that would fix subtree and subrepo
(and others) with ease.

Historically the need to store submodule URLs were the motivation
for having the .gitmodules file. An absolute URL for a submodule would
work fine no matter where the .gitmodules file would be located.
Relative URLs are currently defined as relative to the top level
of the project, which we would need to inspect if the anchor
is chosen well at the root or if we would want to allow anchoring
the relative URL within the tree. (This is no reason against
.gitmodules in deep trees, just pointing out the work required).

But does the URL still make sense? For absolute URLs this is likely
the case, for relative URLs my bets are off. Maybe?

It turned out that people want to e.g. move, delete and re-introduce
submodules, which is why the location of a submodule git directory
was moved to be either inside the tree (to keep supporting existing
git repos with submodules) as well as interned in the superproject.

In the example given in [2], the git dir of the submodule
("folder B") may be located at .git/modules/nameB as seen
from the root of RepoX:

    RepoX
    + folder A
    + folder B (submodule)
    + .gitmodules
    + .git # regular RepoX git dir
       + modules/<nameB>

An important mechanism of the .gitmodules file is
the resolution of the "name" and the "path" of the
submodule. (Given the path of a gitlink entry, where do
I find the git repository for the submodule? vice versa is slightly
less relevant: Given this git repository deep inside my own git
directory, where is the working tree)

So in the example we'd have

    RepoY
    + RepoX (subrepo)
      + folder A
      + folder B (submodule)
     +.gitmodules

The path entry in the .gitmodules file would not change via
subtree/subrepo merge, such that Git would need to know
that the actual path to the submodule is the
concatenation of 'path to tree in which the .gitmodules file is'
and the given path inside the .gitmodules file. Seems doable so far.

What about the name of a submodule? The .gitmodules file
follows the syntax of git config files, such that names cannot
occur twice as the names are stored as the section name:

  [submodule "nameB"]
    path = "folder B"

And I would think the property of having unique names
is important, such that each submodule has its unique
place to put its git dir inside the superprojects
"$GIT_DIR/modules/".

With multiple .gitmodules files, we would loose the
uniqueness property. (It may not be too bad, maybe
even a clever hack, haven't thought about it deeply,
but it seems ugly at first)

As said above, the name<->path resolution is
important, (and shall be unique, deterministic and simple),
so how do we do it? What about the case where we have

  .gitmodules "name" -> dir/path
  dir/.gitmodules "name" -> ./path

In this case we'd have the same mapping, but using this
mechanism we can map multiple names at the same path,
and we could choose to resolve a given path in different
.gitmodules files, which is cumbersome.

  anotherdir/.gitmodules "name" -> ../dir/path

seems crazy, too.

What about moving submodules?
Consider the example as in [2] again:

  $ git mv RepoX/folderB dir/sub
  $ git commit -m "move submodule"
  # ok fine, we can come up with a plan
  # where to put the submodule configuration,
  # maybe in dir/.gitmodules?

  $ git rm RepoX
  $ git commit -m "don't need the rest of RepoX"
  # observation: we would not want
  # RepoX/.gitmodules to still have impact on
  # the submodule.

  $ git revert HEAD^^ # undo the initial move
  # we'd move the .gitmodules file back to RepoX/.

tl;dr: I think this idea produces lots of interesting
corner cases in the data model, let's not go there
without having an idea how to solve them.

From an implementation stand point:
The submodule-config API could easily enhanced
to support reading multiple .gitmodules files (in case
their location is well defined, we would not want to
walk the whole tree recursively). This API is only
easily accessible from within C, such that current
implementing this idea in git-submodule.sh would
be a hassle to do. Prathamesh made good progress
in his GSoC project porting most of git-submodule.sh to
C, though, so once that is merged I'd claim that the
actual implementation of this idea is "rather easy".

Thanks,
Stefan
