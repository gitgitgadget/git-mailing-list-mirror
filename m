Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7C601F4C0
	for <e@80x24.org>; Wed, 30 Oct 2019 14:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfJ3Obs (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Oct 2019 10:31:48 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36903 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfJ3Obr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Oct 2019 10:31:47 -0400
Received: by mail-wm1-f67.google.com with SMTP id q130so2426136wme.2
        for <git@vger.kernel.org>; Wed, 30 Oct 2019 07:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fImxXu/T7jQUj3R2ZMY3RTKqar/SKnDZE5P9R146Rbo=;
        b=jO3Ihu8kG4IYIJLbdq2Uyoo+Gmh88sqjtdIDTYXWfPK+4qdZlq8FKqHpMX/ar0TMmL
         erII0PQ6Djnd2QUOA5y9fE0wZ8CKdy7oAqqkpxx6be6fTtDt3ov9IjgO7xFPfgMbG2xZ
         fAthvZKw4tbe46Ae81UJWGK0/bOQDnJGlKapwvFAdM+NyikyC5gTs91A4d3YZBTzCT3B
         yZJ/qzsKI1qncNtsDWn1ozjspGILMdgMSygFxTkoSK9fxwkKR/pmN1Xwn776ud4Bl8si
         ifZRib+1e7M0077dWLdfoFCRxm4s9aTZi/F8yzfNfKrA2ohpKuBcxbFZC+fM8nFcFgKc
         anRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fImxXu/T7jQUj3R2ZMY3RTKqar/SKnDZE5P9R146Rbo=;
        b=DfrFlBHiE4176WP0y0vr+bJFqOX69qQCfreGRxn4VOZ95n1COFhGsrA9shEviu/Oam
         mHjJ9zfiwm0KCW+VbjqqE6spfWcVc25tNPBwdRTjUfsoyImVqi6lgcuFRX1pdOi+9KEK
         qSZth7ao0+Jk+uVYAh7wlO23w8955XriRvwh/EWBjkX/r2p7UgmaCRDN2yGvHidWZBgi
         sP9X5lE1vbYM2VcNSxdHBE1ADV3wJCNu9wxunYf+fEt8UXDEd79mUx73T4OYAj8rrLas
         m6jj43k8kVyL8YSNhtTryDDLQOF10nTuZ3xxTW35LbhO+oJUTeD8FDJUDjMonmohsLzY
         7opQ==
X-Gm-Message-State: APjAAAXo52Qo7HTWny6rF3tCLMU8G4oxh7mxlga4UPkU56KbFI+rZYrc
        xdmwQWBKuNcSxhjVZs8qd2w=
X-Google-Smtp-Source: APXvYqwOE1uCVvOxTKC1ashokdCHLJxTUxAf+4f+oVQXH8VwHPg7yo7yArC/zEhjpg9wIWwTLq2GQw==
X-Received: by 2002:a1c:ab0a:: with SMTP id u10mr9831479wme.0.1572445905497;
        Wed, 30 Oct 2019 07:31:45 -0700 (PDT)
Received: from szeder.dev (x4db90119.dyn.telefonica.de. [77.185.1.25])
        by smtp.gmail.com with ESMTPSA id a7sm406276wrr.89.2019.10.30.07.31.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Oct 2019 07:31:44 -0700 (PDT)
Date:   Wed, 30 Oct 2019 15:31:42 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, johannes.schindelin@gmx.de, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] commit-graph: fix writing first commit-graph
 during fetch
Message-ID: <20191030143142.GW4348@szeder.dev>
References: <pull.415.git.1571765335.gitgitgadget@gmail.com>
 <pull.415.v2.git.1571835695.gitgitgadget@gmail.com>
 <ca59b118f1fa4176214f55b8993145b5e1db39a0.1571835695.git.gitgitgadget@gmail.com>
 <20191023150402.GB26017@szeder.dev>
 <e2eb7b76-a29b-04c4-e698-f3a67ae56ecc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e2eb7b76-a29b-04c4-e698-f3a67ae56ecc@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 24, 2019 at 06:39:51AM -0400, Derrick Stolee wrote:
> >> Instead, I finally arrived on the conclusion that I should use a flag
> >> that is not used in any other part of the code. In commit-reach.c, a
> >> number of flags were defined for commit walk algorithms. The REACHABLE
> >> flag seemed like it made the most sense, and it seems it was not
> >> actually used in the file. The REACHABLE flag was used in early versions
> >> of commit-reach.c, but was removed by 4fbcca4 (commit-reach: make
> >> can_all_from_reach... linear, 2018-07-20).
> >>
> >> Add the REACHABLE flag to commit-graph.c and use it instead of
> >> UNINTERESTING in close_reachable(). This fixes the bug in manual
> >> testing.
> > 
> > I'm inclined to agree that using a flag that is not used anywhere else
> > is the safest thing to do, and at -rcX time safest is good.  I'm not
> > sure whether it's the right thing to do in the long term, though.
> > 
> > Furthermore, calling this flag REACHABLE is misleading, because the
> > code actually means SEEN.
> > Consider the following sequence of commands:
> > 
> >   # Create a pack with two commits
> >   $ git commit --allow-empty -m one &&
> >   $ git commit --allow-empty -m two &&
> >   $ git repack -ad &&
> >   # Make one of those commits unreachable
> >   $ git reset --hard HEAD^ &&
> >   # Not even from reflogs!
> >   $ git reflog expire --expire-unreachable=now --all
> >   # Now write a commit-graph from that pack file
> >   $ git commit-graph write
> >   Computing commit graph generation numbers: 100% (2/2), done.
> > 
> > It added two commits to the commit-graph, although one of them is
> > clearly not reachable anymore, so marking it as REACHABLE while
> > enumerating all commits feels wrong.
> 
> Since you are using "git commit-graph write", the command is scanning
> all pack-files for commits to include. Even in this case, the
> close_reachable() method needs to walk to see if any commits are missing.
> (It could be that the root commit is loose for some strange reason.)
> 
> In this case, we are marking REACHABLE the commits that can be reached
> from our "starting" commits. In your example we start with every commit.

That's exactly my point.  fsck already uses the REACHABLE flag to mark
objects that are reachable not only from all refs (including the HEADs
of all worktrees), but their reflogs and the index as well.

However, in close_unreachable() we start with a bunch of commits and
then go into a loop adding their parents to an array, while marking
each parent to prevent them from being added multiple times in a mergy
history.  We have a good couple of similar traversals in our code
base, and in revision.c, builtin/describe.c, walker.c,
negotiator/default.c (and at this point I stopped looking) we mark
those parents as SEEN.

On a somewhat related note: 'git commit-graph write --reachable'
doesn't include HEAD; should it?

> If you had used `git commit-graph write --stdin-packs` and provided a
> small pack name over stdin, the concept would be similar and even more
> pronounced: the pack (perhaps downloaded via 'fetch') is not likely to
> contain every commit, so we need to walk all reachable commits from
> those included.
> 
> I'll have a v3 today with the requested fixes.
> 
> Thanks,
> -Stolee
