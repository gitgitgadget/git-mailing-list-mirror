Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57AB01F404
	for <e@80x24.org>; Thu, 16 Aug 2018 04:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbeHPHgp (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 03:36:45 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:41821 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbeHPHgp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 03:36:45 -0400
Received: by mail-pl0-f65.google.com with SMTP id w19-v6so1448633ply.8
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 21:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VWa1KeM1aGHfqzBYZ/TOWvmYW7bTvdgX+Wrsl7ibRps=;
        b=ht3IdYfEvpGA5wNexOMMI0Hj+4xnejdVg4HLNPUW5mwCV72Jluh5AZuU53gxEUtwk1
         d1/6Up34C5d45HsiK6Nw1k3HLQ1m94Ojt8MwAVrjn4SyZfVYVwSPjiqfIjg+Sil4lXC/
         riqfG/7iG8QObKJdnL1gmt8QklPgtoeya453RJ6d37iOThfWDk4UFErJExU6+KV9FhVb
         qyY3VD8Dw5GA0OwjF2QK/Efw5ElOeDzDSOvNT1r0eBHfJtKx4L06o7FzQR6TuRZ5TflN
         B4gdpZd9uTHMpe8zb4Rz8xv2QA515aovBaEZ9+fqqV1KO9gF3RwR5vv6OLfqDPBwSgSd
         M8aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VWa1KeM1aGHfqzBYZ/TOWvmYW7bTvdgX+Wrsl7ibRps=;
        b=rlwsZZPoteD2gl1pALvGueAReUcVsWqnaKhVpUjHSl5+LdjH0aIC9gOWlg8gT27IzO
         Cm5zfA4vG7ZXfG1MgpzBqsS6si6VgUB6ZMxgZ5wpemrx4G/ctFY6SJU0XlUQW1pL5VUN
         S2H4D0mf3vw8w8wSKdTFXAp+pMcaFo0G8lGcvL+BF2ZflyRee4Djng7F0o553D4Zguaa
         3AgtRHpPRm9fwaqQlQgAic47s82z4KemIWBZtKxHYv37vHOCDqUiLWqHPBc6ynzVPbkA
         5xtI4ZboYNiHMtQ/+zN/GuugXYymLoS7w5HYj65Kh7jlDC0ioAWlp1KzkW1eH/kuP+Bu
         ywPA==
X-Gm-Message-State: AOUpUlFwxk9bt1gs2M/gTUIIhCmz+/diHebI86LxNLPwj5kvxwmGB1Wv
        JXKtleEYDfvstrMFrxo5ISx1hC0E44ENtf3Mm74=
X-Google-Smtp-Source: AA+uWPwjejz63DasTyV8TDdLUpThtpYoUquDbEEqRcPhHkzVAqIv760UkMbVNQ0E3QFU0qg+aWXGVKKAV/lpN2M9DmQ=
X-Received: by 2002:a17:902:1a2:: with SMTP id b31-v6mr26665674plb.279.1534394466190;
 Wed, 15 Aug 2018 21:41:06 -0700 (PDT)
MIME-Version: 1.0
References: <20180815205630.32876-1-gitter.spiros@gmail.com>
In-Reply-To: <20180815205630.32876-1-gitter.spiros@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 16 Aug 2018 06:40:51 +0200
Message-ID: <CAN0heSrZXjaQ0H1J1Mmqhv9qhiNbRn4fOJ4oO1XrZFEGO4YFug@mail.gmail.com>
Subject: Re: [PATCH v2] worktree: add --quiet option
To:     Elia Pinto <gitter.spiros@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        karen@codesynthesis.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 15 Aug 2018 at 22:56, Elia Pinto <gitter.spiros@gmail.com> wrote:
> Add the '--quiet' option to git worktree,
> as for the other git commands. 'add' is the
> only command affected by it since all other
> commands, except 'list', are currently
> silent by default.

Thanks for a follow-up.

The word "currently" means I can't shake the feeling that Eric has a
very good point in [1]:

  It might make sense to say instead that this is adding a --quiet
  option _in general_, rather than doing so specifically for 'add'.

As an example, if `git worktree move` ever learns to produce some sort
of output, then Eric's approach would mean that such a hypothetical
`move` is buggy until it learns to respect `--quiet`. With your
approach, it would mean that we would get feature requests that `move`
should also respect `--quiet` (which we would then need to redefine in
the documentation) or that it should learn of a `--quiet-move` (which I
do not think is a particularly good UI).

Doing such a patch instead would mean tweaking the commit message
slightly...

  Add the '--quiet' option to git worktree, as for the other git
  commands. Currently, 'add' is the only command affected by it since
  all other commands, except 'list' obviously, are already silent by
  default.

... and the documentation slightly ...

  Suppress feedback messages.

It might make sense adding a comment to the documentation about how this
currently only affects `add`, but such comments do risk going stale. I
am on the fence about whether the documentation needs to say something
about `list` -- who in their right mind would expect `list --quiet` to
actually suppress the list? And if `list` ever learns to give some
feedback messages in addition to the list itself, then we would want
`--quiet` to suppress *those*, I guess.

Others might disagree violently with this, but I wonder whether it makes
sense to add a test to verify that, e.g., `git worktree move --quiet` is
quiet. Such a test would demonstrate that this is your intention, i.e.,
anyone digging into a report on "why does git worktree foo not respect
--quiet?" would be 100% convinced that your intention back in 2018 really
was to respect it everywhere. It seems wasteful to add such a test for
all other modes, but maybe you can identify one which you think has a
higher risk of learning to output some feedback in the future.

To be clear, it is fine for you to disagree with the above! :-)

>         }
> -
> -       print_preparing_worktree_line(opts.detach, branch, new_branch, !!new_branch_force);
> +       if (!opts.quiet)
> +               print_preparing_worktree_line(opts.detach, branch, new_branch, !!new_branch_force);

I think that empty line should be kept. Probably not worth a reroll.

Good work!

[1] https://public-inbox.org/git/CAPig+cS-b2yL2FeLRzS+jW-O5fRd1g8Kqak7j1QX5PRP0ojQEQ@mail.gmail.com/

Martin
