Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54CC61F4BD
	for <e@80x24.org>; Wed,  9 Oct 2019 14:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731298AbfJIO3v (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Oct 2019 10:29:51 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43587 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730708AbfJIO3v (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Oct 2019 10:29:51 -0400
Received: by mail-io1-f66.google.com with SMTP id v2so5365797iob.10
        for <git@vger.kernel.org>; Wed, 09 Oct 2019 07:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i3TJMd424UNJZEV9dfQ4LERbBFTWO4ffcmnXnLjTzfU=;
        b=A9a0lLQvQAxro/xu/Zt0iHxBqrPwV9I8b6stJHXZ/fmlJj7FrLx72wVFE2O3DcoiP9
         5C3Y0xZe7zXNmKVC1rAwVaZH23TtmA8wjurycfp45LwxmSN0vmXX8cLyBX1uE0nic47c
         hr8wHuiemvLTt5F7djj4bdwRDQzQaVh+v7xziYQrsJH7GRvS4JLDZzmUiOTWnYSOero/
         AiApF1vb5jAKL6iTr8dE2K+bbsGYRApI3/qkBj5gpJ8sdreuR2zd6sr/2NrpgNsDGz/f
         O73NtAhG8sXISPAxgWvIxruJmXiFErbYdA+HA/TK+6PRmetfdsBdRNmfq/bYbFswhusI
         h0dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i3TJMd424UNJZEV9dfQ4LERbBFTWO4ffcmnXnLjTzfU=;
        b=H9+Egh18WqJCoDZID+D98WnPxHBMdcVoZFjv6LhQqE3/gWDFgPFosaRu0PH+eY7GQe
         qYYJn9FLT8ylGETcykOqKYEc6391hTKB1RdOx9APJWzBj5cwLfH6tO8pji85dA6zN3Mj
         QXFwpjwDGBCowbwJRWHsUaRFq/GppFr9Fc1OzGdqppK2zV43RyQF2R2VIqQR6GQpQdOB
         4hi2TfhyKmnxqVLCXa9hsmWN70qFKDWMIDA54xUEHRWB0PoMmzG4cJIVeS6xIhwNNCqZ
         mT+H7Qk0P++VOa4I+xYYRSHcsMpRptOrjQm25icjwOI0OlVx49aI2Wvi2eKUn2O7lBG1
         tDjw==
X-Gm-Message-State: APjAAAVy2HrJJFxG5M9oaJ+7KJyXczFL9VzXbGih+481gkNOHeKmqoO/
        8mtv5IHH1rJp1cAlH8A6XJKVOB1KVvzDhG5h2tvb2g==
X-Google-Smtp-Source: APXvYqxol8rFH2351gugn0J1eWdP0W+Le4nKZGkLkpwWYgsM7i9uHTLmyjLIupCwrPp/+ZGT5UFjNEoUubZ71Rokb2M=
X-Received: by 2002:a02:e48:: with SMTP id 69mr3427945jae.17.1570631389720;
 Wed, 09 Oct 2019 07:29:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAEXP2g8-reK+u2FaO=mMP-nsvuDDWGpwV_tyKG5L5XpU=1LQeg@mail.gmail.com>
 <20191009022457.GB73710@google.com>
In-Reply-To: <20191009022457.GB73710@google.com>
From:   Dominik Salvet <dominik.salvet@gmail.com>
Date:   Wed, 9 Oct 2019 16:29:33 +0200
Message-ID: <CAEXP2g93XtaeEZi-5+A+PEDT7FJgJERdsrsAG7OFqWpShD7mqw@mail.gmail.com>
Subject: Re: Fetch origin/HEAD during git fetch
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,
Thank you for your time. I would be for something like `git fetch
--head` or `git fetch --remote-head` as the name. It also matches `git
fetch --tags` - fetch tags from remote, in addition to whatever else.
Aside from that, there are no further comments from my side. I would
be really happy to see the option in newer versions of Git (though, I
would be more happier being able to implement it in current ones...).
However, I won't be able to implement it myself for two reasons; a)
not enough skill in C and b) unfortunately, I do not have enough time.
Nevertheless, I can assist during the development of this feature if
approved and if there is someone who actually writes the code.

Another solution, on the other hand, could be the one from the
provided link [1] - use ~ for symrefs. That would also solve my
problem and since it would be equivalent to `git remote set-head
origin -a`, I am perfectly fine with that. Just run `git config --add
remote.origin.fetch ~HEAD:refs/remotes/origin/HEAD` after setting up
the origin remote and then just use `git fetch`.

About the `git checkout --orphan`: it also modifies the work tree in
my case (files in local repository), which I don't want to. Still, if
I want to create a branch to delete another branch (default clone
local branch), that itself is counterproductive - I don't want any
local branches. There is another problem, though. What name to choose
for `git checkout --orphan <name>` not to conflict with a default
branch (that could be anything) of the repository? Yep, there is a
solution for that but I don't want to make things over-complicated. I
would rather not use the `git clone` solution as long as there is no
`git clone --no-checkout-and-no-local-branches`-like option/s.

However, it looks like I have found an optimal workaround for my case.
Use git init, setup git remote and also run `git config --add
remote.origin.fetch HEAD:refs/remotes/origin/HEAD`. Now, using a plain
`git fetch` for fetching updates also fetches the current default
remote commit in origin/HEAD each time used, so no symbolic reference
to a branch might not be required as origin/HEAD points to the latest
commit of the default branch in both cases. Symbolic reference may be
beneficient in case when not fetching origin/HEAD while fetching the
branch pointed by origin/HEAD reference, which may fail in case the
remote updates its origin/HEAD anyways (e.g., on GitHub - repository
Settings -> Branches -> Default branch).

Due to my workaround, I guess now it's up to you, developers, whether
developing a `git fetch --head` option or ~ for symrefs worth it for
you. Anyway, if you find any pitfalls in my workaround, please let me
know. If you are rather interested in the actual implementation, take
a look at GitPack hosted on github.com/dominiksalvet/gitpack, the
affected file is src/gitpack (search for 'git config').

Have a nice day,

On Wed, 9 Oct 2019 at 04:25, Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> Hi!
>
> Dominik Salvet wrote:
>
> > 1) `git fetch origin && git remote set-head origin -a`
> > 2) `git fetch origin +refs/heads/*:refs/remotes/origin/*
> > HEAD:refs/remotes/origin/HEAD`
> > 3) instead of git init and remote, use directly `git clone --no-checkout`
> >
> > The first solution is not suitable due its delay caused by remote
> > access (2 separate invocations). For smaller repositories, delays of
> > these individual commands are almost comparable. However, this
> > solution is semantically exactly what I want.
>
> Interesting.
>
> For the specific case, it sounds like some kind of "git fetch
> --also-set-head" would do the trick for you.  As you can see, I'm awful
> at naming command line options --- aside from the need to give it a
> better name, any others thoughts on that?  Would you be interested in
> taking a stab at implementing it?
>
> For the more general case, there's been some discussion of fetching
> and pushing symrefs on-list before.  [1] discusses one possible UI.
>
> [...]
> > The third solution has several problems. The first one is the created
> > default local branch. So delete it.
>
> Hm, I don't follow.  Does "git checkout --orphan" do what you're
> looking for?
>
> Thanks and hope that helps,
> Jonathan
>
> [1] https://public-inbox.org/git/20180814214723.GA667@sigill.intra.peff.net/



--
Dominik Salvet
