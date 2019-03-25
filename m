Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4551820248
	for <e@80x24.org>; Mon, 25 Mar 2019 15:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbfCYPkx (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 11:40:53 -0400
Received: from mail-io1-f49.google.com ([209.85.166.49]:32791 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfCYPkw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 11:40:52 -0400
Received: by mail-io1-f49.google.com with SMTP id b6so8031831iog.0
        for <git@vger.kernel.org>; Mon, 25 Mar 2019 08:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2QsVvN7z4N3T0QvbE7w6s2r9ov/eIw1kZWijeq6QPGs=;
        b=h7uEks0EMZiAULd13I5TvR4zC7BZ99V7Ol7jzYcNMQknzNS2I/593YiXevqhBq7lI0
         gg8CSSlHzC8L638uNmowZSPedA5eVsM+hP5JBehsUGByei6xbxSwWcTYZdaq2Xtn/157
         swIJRSHE2+k8qAel3NvZpoV5d7PVGQ+42+mXJ8/txz3hxlG5MbD+Dx8eoSfdJdINMb61
         C4NrC1ewTFQvhdSWUz7hcUPO2RS6XbiViAzOdwLb1M8sgIfxB5rAv8wDZDaSgQtVdXLL
         Rpzn5+p5KwXxdUtXS5CR0kxlcFjx5sYD5dKD/8fHabciGZZplzoyLDZnGo21i6m0l2p9
         Q35g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2QsVvN7z4N3T0QvbE7w6s2r9ov/eIw1kZWijeq6QPGs=;
        b=bC8f9mSX9lrRl9xyAEGYV8UdIGKL77U9fLuzZ5UJGyUsZ7VpQIm8y6pQVUNHcm+fBx
         rzWs3Ax9hG2x9+sfKWnx7ZAk0p4CT8tCAIpaV+sgSBWfLC4Hsu0+hySbXu0L4BVIBbgp
         QoR2d1kCupWDkbnyD6vbsuZu1C6CWQCcrpZPAjuCeSU1o2MCnMYXhIJlaNuac4F/+NCs
         dk8vO+phSjvZm54a+ogOVpMBGtxQAIGaABtrIqDOGeQjN0WJdTUnJtWRKW+9o225I6aE
         iIQfe02j7K1yoZCStc/+wyBVE2407yqmfqEz9hk9jWjT4O3AR28H/w2tZ4DpmfXgUA/u
         pNhA==
X-Gm-Message-State: APjAAAV2zsGueVUCRQCJI/DHf/3xWu8x3psIVYC7jIo9lJ8mcIMlFVtO
        K5F2JY87ZAz/xrq4qadEOKo4eoH/cXOR+asG2VKT97ak
X-Google-Smtp-Source: APXvYqwP8s+L5ZB0Y3MjbS0eNMLAz0i0Jb8wBPqY9fLcGS5kM9bdZ7ahQNRKWEL4apGaeDKD0wvoZIv2wrtlQuOuhH0=
X-Received: by 2002:a6b:f704:: with SMTP id k4mr18850450iog.0.1553528451937;
 Mon, 25 Mar 2019 08:40:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAKcrOwe2ARK4J6YuiXUiVXic=q568VC8JtgWMNs6WEd4hhZs3A@mail.gmail.com>
 <nycvar.QRO.7.76.6.1903221343090.41@tvgsbejvaqbjf.bet> <f52ef736-9d58-a6cf-e3b0-501b065ae325@jeffhostetler.com>
In-Reply-To: <f52ef736-9d58-a6cf-e3b0-501b065ae325@jeffhostetler.com>
From:   balaji marisetti <balajimarisetti@gmail.com>
Date:   Mon, 25 Mar 2019 21:10:25 +0530
Message-ID: <CAKcrOwfz=W+HwAZUDCo9u=prH-orUph0f-H5bXZ14pcyjFTiFA@mail.gmail.com>
Subject: Re: git command history
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Johannes, and Jeff for your responses

> you probably meant the worktree, not the repository, I assume
You introduced me to a new feature :) I didn't know about this
"worktree" feature. Thanks.

> Trace2 will let you see all of the git commands,
> the alias expansions, and any shell commands launched
> by git. If those shell commands also run git commands,
> they will be listed too.
Currently, I'm going through the code and documentation of this
feature. I'll see how I can leverage this feature to work for my
usecase.


- Balaji M

On Fri, Mar 22, 2019 at 6:49 PM Jeff Hostetler <git@jeffhostetler.com> wrote:
>
>
>
> On 3/22/2019 8:46 AM, Johannes Schindelin wrote:
> > Hi Balaji,
> >
> > On Tue, 19 Mar 2019, balaji marisetti wrote:
> >
> >> Can anyone please tell me if there is way to see the command history
> >> of a local git repo?
> >
> > If you really are only interested in the *Git* commands, you will be able
> > to implement something on top of the Trace2 feature (which just made it
> > into `master` but not into any official Git version yet, so it will most
> > likely be available when Git v2.22.0 comes out).
> >
>
> Trace2 will let you see all of the git commands,
> the alias expansions, and any shell commands launched
> by git. If those shell commands also run git commands,
> they will be listed too.
>
> However, it can't tell you what was otherwise done within
> the shell script.
>
>
> > If you are instead interested in all shell commands in a local Git
> > worktree (you probably meant the worktree, not the repository, I assume),
> > then you might need to play some games with Bash aliases to override `cd`
> > and reroute the history by re-setting `HISTFILE` and then calling `history
> > -cr` or something similar.
> >
> >> If there isn't a way, why hasn't the command-history feature been
> >> implemented?
> >
> > Because Git is an open source project. This means that nobody is
> > responsible for fulfilling your wishes, except for you. And you can do it,
> > too, this project welcomes all high-quality contributions.
> >
> > Ciao,
> > Johannes
> >



-- 
:-)balaji
