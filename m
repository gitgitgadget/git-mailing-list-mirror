Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29EB91F461
	for <e@80x24.org>; Thu, 29 Aug 2019 04:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfH2EY5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Aug 2019 00:24:57 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44799 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfH2EY5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Aug 2019 00:24:57 -0400
Received: by mail-io1-f65.google.com with SMTP id j4so4106674iog.11
        for <git@vger.kernel.org>; Wed, 28 Aug 2019 21:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=msRHWSFhLhsme4wr6AggRFuOygAWF4jE2l4Bjft22DA=;
        b=ZebE/k/tfNDy/tQgR9RaTSDySg2/pITd3dWs0MkEaJvFORAxR4EfyCSvRKZG1gi+wV
         O6Ug4K7FU7lSfMJy9DRHSZcU13OcSdVlFQplRr0O4qpg13zykv6Ka0WtVrRjmSFLWR0o
         jFCvX3B5Z6gQ0ihxz8/ABZ4VwM28If4XdBWx9AGQeitCeqdCLMuJg6MTUt2lu0PIwXKD
         vsagRpz1SAYGMhkro3nxmBTkn3PmjLD1ThiFVSDys/jjnD4ZhnXY/7SiNGSvuFJwj9zc
         0bmNtr3RJP/8tuadOoWg927e4NxL5UFbEupPTfoHARCM6EfjHGgfa/K3l697TNuIPFIi
         5pcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=msRHWSFhLhsme4wr6AggRFuOygAWF4jE2l4Bjft22DA=;
        b=XIJdWlDLLzoVlrsTLGroeP8Oa5r0afEQBxeCLhLaG9FMokY15yAo8nRzy5nhkxebEZ
         NoJFkCOmWKk4MZ9F4aDOMPe9kVfVfVRDCEjc/LbirWxC2VVM1a0Mezff75RljK8kfSsD
         qyPJgSfU6TYBp/wwmh5B44CygmQkpByVuJWd4xhj98tVAYewLdgrsPL4EzZjghcoUhIg
         TNyOuHR2XvpcyigLxDiwiFphyX8iEgrcrHlVKaepuOMZ0Z6GAbE4xJIJn0BixaeVo5aQ
         uX96UC0UJHDTtH7+sdV2DMBsOn7X6xbuHs/PePEp1mb+fWkWrabecImUkSpQn6bLjJyq
         BIDw==
X-Gm-Message-State: APjAAAWH6ACw8DEjV9L3ddgSYFTusQ7bGpZ1zIrXZp6QiKl95+oJz9aP
        QWfAfctLJGXFt0ccTq8dWDZXkKxUp0PGLtjsH0w7TQ==
X-Google-Smtp-Source: APXvYqwuz35FTPFF4UoxXsXNuJXTAKpLlouu+I6in9uyvWym7h/smFTt7AJkY/UK4eBMxebuC9leUoKNUWdiQjnBa5E=
X-Received: by 2002:a02:bb98:: with SMTP id g24mr3162675jan.142.1567052695916;
 Wed, 28 Aug 2019 21:24:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1566863604.git.matheus.bernardino@usp.br>
 <4920d3c474375abb39ed163c5ed6138a5e5dccc6.1566863604.git.matheus.bernardino@usp.br>
 <CACsJy8Dry7MfKBi5EKw4Ka9r63QVmDjPv9nAozS0mC6Z7-sG=w@mail.gmail.com> <CAHd-oW4h80xrp6y65dqZbq_a67ncArC9rrNq7F7rAhBbrALOkA@mail.gmail.com>
In-Reply-To: <CAHd-oW4h80xrp6y65dqZbq_a67ncArC9rrNq7F7rAhBbrALOkA@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Thu, 29 Aug 2019 01:24:44 -0300
Message-ID: <CAHd-oW6doh=06nxUkMLWZOwNMyUOogLRbLstD0bJVQxLauR_Aw@mail.gmail.com>
Subject: Re: [PATCH 1/2] config: allow config_with_options() to handle any repo
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 27, 2019 at 8:46 PM Matheus Tavares Bernardino
<matheus.bernardino@usp.br> wrote:
>
> Hi, Duy
>
> On Tue, Aug 27, 2019 at 6:26 AM Duy Nguyen <pclouds@gmail.com> wrote:
> >
> > On Tue, Aug 27, 2019 at 6:57 AM Matheus Tavares
> > <matheus.bernardino@usp.br> wrote:
> > >
> > > Currently, config_with_options() relies on the global the_repository
> > > when it has to configure from a blob.
> >
> > Not really reading the patch, but my last experience with moving
> > config.c away from the_repo [1] shows that there are more hidden
> > dependencies, in git_path() and particularly the git_config_clear()
> > call in git_config_set_multivar_... Not really sure if those deps
> > really affect your goals or not. Have a look at that branch, filtering
> > on config.c for more info (and if you want to pick up some patches
> > from that, you have my sign-off).
>
> Thanks for the advice. Indeed, I see now that do_git_config_sequence()
> may call git_pathdup(), which relies on the_repo. For my use in patch
> 2/2, repo_config_with_options() won't ever get to call
> do_git_config_sequence(), so that's fine. But in other use cases it
> may have to, so I'll need to check that.

While working on this, I think I may have found a bug: The
repo_read_config() function takes a repository R as parameter and
calls this chain of functions:

repo_read_config(struct repository *R) > config_with_options() >
do_git_config_sequence() > git_pathdup("config.worktree")

Shouldn't, however, the last call consider R instead of using
the_repository? i.e., use repo_git_path(R, "config.worktree"),
instead?

If so, how could we get R there? I mean, we could pass it through this
chain, but the chain already passes a "struct config_options", which
carries the "commondir" and "git_dir" fields. So it would probably be
confusing to have them and an extra repository parameter (which also
has "commondir" and "git_dir"), right? Any ideas on how to better
approach this?

> > [1] https://gitlab.com/pclouds/git/commits/submodules-in-worktrees
> >
> > --
> > Duy
