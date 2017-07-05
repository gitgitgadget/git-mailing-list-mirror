Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CD65202AE
	for <e@80x24.org>; Wed,  5 Jul 2017 23:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752086AbdGEXGe (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jul 2017 19:06:34 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:35622 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751941AbdGEXGd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2017 19:06:33 -0400
Received: by mail-pf0-f170.google.com with SMTP id c73so1652967pfk.2
        for <git@vger.kernel.org>; Wed, 05 Jul 2017 16:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ktd7reCSO3IEgZwYo9+4RomqyJnggq8/vSSEeIMWv0M=;
        b=kpGLDL7THIwNgzLdbQQJDqENt9Cbm5PN944ZlSIptdV81kpkqnf6TLHyiRZyLdUzGe
         wv6x4Wm2WZBegzfk/3lr7nos1bIVYNTJi0/iNu/AWQ/yQY2O1HELql541znu0Utf7yo2
         2RDf20R9ztGGwuZ0gzwP4m6+DlP78FxhCBEdn/KptjaKtyEo5MifrmIw5f/nKa7Otjw2
         npFbUiWYKmYEQthBJeh9Iz1odTVwu1OOegKeYRbhpzueE0Wmr4BsawETg1+Y/F+BtmYR
         QGCvnnEuB75tPkVn/SFVY9ntkTYRZLi7QDfsWPGZdwJlXe2fG6LxZHTZyMwRC8YK3LlK
         cHrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ktd7reCSO3IEgZwYo9+4RomqyJnggq8/vSSEeIMWv0M=;
        b=DRJrLb7BMo0M1VMxJ1ECGu84JvDVylq5IAGnAID2/qRCfkYIxl6nInrh882WbPSsY6
         12ziuU+etzDLp2YsbWBqvb/FRteEtmSXOqUI+N3qpoaA8iNV65IB1+DY05T86ZccpOBa
         8KulcC5jBtJyLZD52zXnqm4u70H/AF68SQaXc1Plf0iwX+tQPML2lri/XAlwRbYhdFah
         FUfqiboNoSy5uu6mhdQtD4DWfODnVAnN/wle8LPxikFG9+0qjM/SQ2/0TtbJB3A3UQya
         1u62BQDszvICqakwRnJ5Tf2SjKXryRNe6/YdcsvipPH3JySzV09zVqKuNDrvV0FxnIff
         Pp1g==
X-Gm-Message-State: AIVw112jD0rPqhQD5LfF+4Ika8PAG+BTxH3XgG69NVr9hsV71z//xaoB
        rJyepPU2fTvvsrr6o1N5Bv4ChASNAMGF287LiQ==
X-Received: by 10.84.224.74 with SMTP id a10mr24498758plt.210.1499295986898;
 Wed, 05 Jul 2017 16:06:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.183.170 with HTTP; Wed, 5 Jul 2017 16:06:26 -0700 (PDT)
In-Reply-To: <xmqqeftuh5q7.fsf@gitster.mtv.corp.google.com>
References: <xmqqeftuh5q7.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 5 Jul 2017 16:06:26 -0700
Message-ID: <CAGZ79kamhPAQrE3GBC=fG=PNNtdHj7iStsqjOojkVMpNy_VEWw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jul 2017, #01; Wed, 5)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> [Graduated to "master"]
>
> * bw/repo-object (2017-06-23) 21 commits
...
>
>  Introduce a "repository" object to eventually make it easier to
>  work in multiple repositories (the primary focus is to work with
>  the superproject and its submodules) in a single process.

It's pretty rad to see this advancing to master.
FYI: I started working on teaching the object store how to work
with repository objects. This would allow us to get rid of hacks in
submodule.c: namely add_submodule_odb, which adds submodule
objects to the (main) object store for processing. Ideally we want
to free the objects of a submodule once we are done with a submodule.
(or integrate it into our try_to_free_routine)

> * sb/hashmap-cleanup (2017-07-05) 10 commits
...
>  Will wait for feedback, then merge to and cook in 'next'.

Thanks.

> * sb/pull-rebase-submodule (2017-06-27) 4 commits
>  - builtin/fetch cleanup: always set default value for submodule recursing
>  - pull: optionally rebase submodules (remote submodule changes only)
>  - builtin/fetch: parse recurse-submodules-default at default options parsing
>  - builtin/fetch: factor submodule recurse parsing out to submodule config
>
>  "git pull --rebase --recurse-submodules" learns to rebase the
>  branch in the submodules to an updated base.

Speaking of submodules, It's not just features, but I also send bug fixes. ;)
https://public-inbox.org/git/20170630003851.17288-1-sbeller@google.com/
(That patch is not related to this series, except for working in the submodule
area, but I consider that patch more important than e.g. this series.)

> * sb/submodule-doc (2017-06-22) 1 commit
>  - submodules: overhaul documentation
>
>  Doc update.
>
>  What's the status of this thing?

There was some review on the list (mostly from Brandon and Jonathan T.),
but I felt like it was bikeshedding, as there is no black/white correctness
with words. (Same for code, but for code it is easier to come to a
consensus at least.)

So I had a couple of internal rounds with them on a Google doc, hence
I assume they agree on this patch being ok as-is.  But it has been a while
I can reread it myself to check. But I guess most valuable input
would come from others.

> * sb/diff-color-move (2017-06-30) 26 commits
...
>  Will merge to 'next'.

cool. Let's see how a larger audience reacts to this one. Maybe there
is more input for a good heuristic.

Thanks,
Stefan
