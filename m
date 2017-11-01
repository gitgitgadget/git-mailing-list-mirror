Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 681E4202A0
	for <e@80x24.org>; Wed,  1 Nov 2017 18:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751738AbdKAScu (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 14:32:50 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:47657 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751428AbdKASct (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 14:32:49 -0400
Received: by mail-qk0-f175.google.com with SMTP id m189so3852110qke.4
        for <git@vger.kernel.org>; Wed, 01 Nov 2017 11:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NyPgJ0d0XOu05cu8EBqOd/99Myk/G7RsCuTweJZurZI=;
        b=O2XkXUm+cIOU3skatZ4da2g9Ffl/QDmEaZjn6R/vbP5WsWf/jqUBumw/Kp+BYWuxId
         NzKtkUrjVpX7y3l1M40T6WSz0q3nCHQKOrCk3f+fzlNMSQzhE6Ctfgu3xe1CaKudZjmb
         duhoNOhdp7Z943772aR85WnQ/Ejyrx/l7DDnGskHzobyKvvyj5oyhn3MdizWUgZFlXCb
         2Wth8c/V4xK29wm7mjwzK0RaQn7I40mB7eJRZFlDTZfdapu3gKPEcC4kDiiA9BYvX3FD
         j7aBXVzMByHWXQ7EAxkVWq2/6zu6cd2jdTSPDiU3jz/IJA7BhhEY4HfavtdBdNL97AR9
         GifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NyPgJ0d0XOu05cu8EBqOd/99Myk/G7RsCuTweJZurZI=;
        b=Jx7iL7tTz7prGxsvepatre+zRRu6WftnHsu3lXbf0Xh2ppc4gAUO/uP2eUFx5TdVA7
         kwLPlKT3cR5KeBiYLWOsqkOkoCKYhkI1cxlNV1FYOBlcQvwHEdUZhjNdtBjtSM3174NX
         hVCeLu1g1hpsJ7KfdOji1EirYyGZUQdb/J6+TH8s4EJ7uZL8tSw8gANh5buUmg8I2eGq
         luMPytKfzQPDlg5uAZmb4I5izzWqozRgtWiPddNdDQLGUHnmboe5T5W+V5ORNoejaUUN
         ABNXE/yC2Pz8iV7cG87jFP1m6cTLGsPwk2CJXwHV5ITguNMLQNNn356VE9Q8j7IpT5eB
         O9vw==
X-Gm-Message-State: AMCzsaW/kYTbvurdjKBwKX7npmVksNNT9gm1hVAVjyfHjJo9cIWIbrXc
        EyHUkTL2kcWzi1dhinzMENPaFe9WQq7ax+oi/rd7Hg==
X-Google-Smtp-Source: ABhQp+T3XtysNq91v17cpWQE+YFT58AQek3it2i7yEoAcW2uN/ngg/YCNAJsCW+thprywE53461OsgABQl8k+F0nS+c=
X-Received: by 10.55.175.132 with SMTP id y126mr1251802qke.45.1509561168441;
 Wed, 01 Nov 2017 11:32:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Wed, 1 Nov 2017 11:32:47 -0700 (PDT)
In-Reply-To: <CABPp-BF5Aitu05X83Lbm+8rWKojOnNNec_4bf5PRy+hKZGPPHw@mail.gmail.com>
References: <CABPp-BF5Aitu05X83Lbm+8rWKojOnNNec_4bf5PRy+hKZGPPHw@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 1 Nov 2017 11:32:47 -0700
Message-ID: <CAGZ79kYM83May-S3jtXzaAucu_6U=ZJ+mGtqMT=GWqY3B66icg@mail.gmail.com>
Subject: Re: Contribution licensing question(s)
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 1, 2017 at 8:50 AM, Elijah Newren <newren@gmail.com> wrote:
> Hi,
>
> My employer has a new-ish open-source-contribution process, and is
> curious about some licensing question(s) before I submit a few patch
> series.

cool. :)

> Background: git's README.md file points out that some parts of git are
> under a license other than GPLv2 (while still GPLv2-compatible),

e.g. xdiff/* seems to have headers indicating it is LGPL.
otherwise I suspect contrib/ to be a fun place to look for different licenses.
IIUC, the files in builtin/ as well as the root of the git repo are all GPLv2,
though I am not your lawyer.

> though it doesn't state which one(s) or what a contributor might want
> to do if they want to grant permission under one of those more

I'd be surprised if we had anything more permissive than GPL,
e.g. BSD, APACHE in the tree outside of contrib/.

> permissive license(s). Also, I seem to recall that years ago there
> were requests to make code available under a slightly more permissive
> license to allow re-usage in jgit

JGit is in Java, so you have to rewrite the code anyway?

> and perhaps other projects, though I
> can't find any trace of this in the codebase.  git's COPYING file has
> wording suggesting how to make a license transition (to GPLv3) easier,
> but only considers completely new files as opposed to (significant)
> modifications to existing files.

I think going to GPLv3 is a pipe dream by now:

  git shortlog -sne | wc -l
  1589

It will be hard to identify all the contributors that had meaningful
contributions (more than a typofix?) and ask them if they agree
on a re-licensing of the code they submitted at the time.

These potential contributors may have changed their email address
(e.g. by switching jobs, whereas the copyright is with the employer
anyways, usually. :/)

> I'm not sure whether my specific git contributions would matter to
> jgit (which we also use internally, both directly and indirectly), but
> generally, is contributing under a more permissive GPLv2-compatible
> license to permit re-usage in other projects like jgit (or for easing
> future license switches) still relevant?

Contributions to git ask for your 'sign off', which ensures that
the conditions in https://developercertificate.org/ are met.
The first point points out "open source license indicated in the file".
However most files (e.g. git.c) have no license header and just
assume the license as in COPYING.

>  If so, which license(s) have
> folks gravitated towards for these contributions, and how would one
> mark their submitted patches?

That is an interesting question. When adding new files, maybe
by a file header? Existing files are more interesting though.

Stefan
