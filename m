Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E82CC2B9F4
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 05:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F26160FE9
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 05:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233592AbhFSFla (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Jun 2021 01:41:30 -0400
Received: from mail-ej1-f42.google.com ([209.85.218.42]:38837 "EHLO
        mail-ej1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233574AbhFSFl3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Jun 2021 01:41:29 -0400
Received: by mail-ej1-f42.google.com with SMTP id og14so19261649ejc.5
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 22:39:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=02D6TCWJHi+6dmdPThrlHSreq6cQbY84+N8/LGPSMp8=;
        b=AoNlNfb9AdKlVhtiVmSF0H62b6A+PztA0dM8lHJ/c56Pqh+C/cn1wCfrx6KRSQt30K
         WXxJoPTogjgFj48zFItcEKKpK0pxWiAxBktL8gw4WTzQp2NpM73SSiK3Pn6tBGNlpGsJ
         dJtMTDeFQ092IKiP7u+7lezs/bwJYWxRdn48s0VpzmuBtQpcTeW1mubcU/2VqSHa6Hz3
         Bf4JiQHk2ckOmHJnVQHbuzfZIaNfUK6A13U9PiyCPQJ54pJiSBAS5mdPqbXM5+8BuhmY
         MskDqs+onTZRtyjOzxV2gt8p/AGlfqdA+XE27qDBv7QlbBrjNoLagqhSLTinNX0ihKdk
         EtWA==
X-Gm-Message-State: AOAM531Sugy8/mnCcAOZm6mYwryB+1q0BdcEsLRFUJ/QZb4hevvyP75B
        HOG8NmtbUNSHyCYeznhlcwx2X8hIMdtZhbHG5OaPQNotlg4=
X-Google-Smtp-Source: ABdhPJzBw8jc3PN0QHSnjo0dob5iEz2O61xYeSZU5peEOuyslsd2H0VxVOoKfXMkfGF0KYZ3s6zwVKEewWPYOt1dD6A=
X-Received: by 2002:a17:907:207c:: with SMTP id qp28mr13899210ejb.311.1624081157370;
 Fri, 18 Jun 2021 22:39:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210619023310.1342809-1-mail@smlavine.com>
In-Reply-To: <20210619023310.1342809-1-mail@smlavine.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 19 Jun 2021 01:39:06 -0400
Message-ID: <CAPig+cRwsByvAtB0WgVVGH_a45zA718suFW1oUc0A6rfNThcAg@mail.gmail.com>
Subject: Re: [PATCH] myfirstcontrib: update links to IRC channels
To:     Sebastian LaVine <mail@smlavine.com>
Cc:     Git List <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 18, 2021 at 10:41 PM Sebastian LaVine <mail@smlavine.com> wrote:
> The Git project now uses Libera Chat, not Freenode. A similar change was
> made in git-scm.com commit b1f3d65 (community: update links to IRC
> server, 2021-05-26).
>
> Signed-off-by: Sebastian LaVine <mail@smlavine.com>

Makes sense. Thanks. However, it looks like an equivalent patch has
already been submitted[1].

[1]: https://lore.kernel.org/git/20210608190612.72807-1-raykar.ath@gmail.com/

> diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
> index af0a9da62e..015cf24631 100644
> --- a/Documentation/MyFirstContribution.txt
> +++ b/Documentation/MyFirstContribution.txt
> @@ -47,7 +47,7 @@ Veteran contributors who are especially interested in helping mentor newcomers
>  are present on the list. In order to avoid search indexers, group membership is
>  required to view messages; anyone can join and no approval is required.
>
> -==== https://webchat.freenode.net/#git-devel[#git-devel] on Freenode
> +==== https://web.libera.chat/#git-devel[#git-devel] on Libera Chat
>
>  This IRC channel is for conversations between Git contributors. If someone is
>  currently online and knows the answer to your question, you can receive help
> @@ -827,7 +827,7 @@ either examining recent pull requests where someone has been granted `/allow`
>  (https://github.com/gitgitgadget/git/pulls?utf8=%E2%9C%93&q=is%3Apr+is%3Aopen+%22%2Fallow%22[Search:
>  is:pr is:open "/allow"]), in which case both the author and the person who
>  granted the `/allow` can now `/allow` you, or by inquiring on the
> -https://webchat.freenode.net/#git-devel[#git-devel] IRC channel on Freenode
> +https://web.libera.chat/#git-devel[#git-devel] IRC channel on Libera Chat
>  linking your pull request and asking for someone to `/allow` you.
>
>  If the CI fails, you can update your changes with `git rebase -i` and push your
> --
> 2.32.0
