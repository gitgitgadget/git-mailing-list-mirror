Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C4941F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 18:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbeJKCTe (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 22:19:34 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:43860 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbeJKCTe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 22:19:34 -0400
Received: by mail-ed1-f54.google.com with SMTP id y20-v6so5915498eds.10
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 11:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VpzKXJxnCinKU2AX6PKhfnHVgtyzj5OEihM692yRdKM=;
        b=T4g45+usQHTQpFImHOorUsHrnl4iM9KJNAxxjtoim68ZVgNMtdvHhpJVTnyibcAjrj
         99yDyIHpHmNkS3RmoEZUUflwpktWXHjLSFv5UQdib2GEJcVSQ/eU8kifqBX+ucghhuTL
         dCbTnAYLs5nZGBcIGddpiqX1wEjEFaLBRlu8z86URtOMLRFeAJlB0GHigwSK4bJ6XgRv
         hCP9mH+YYz6eruqAEgoM0QGSnbnP87pYemHjLrD1qsQGxPjZDVsS2/jecZ6VMResevNN
         nqYmlaosdqBwZfXsZOIn+3jLVvXdE1v+Fydo3SwoR0SukW/K7a5bYDuWh3Ld0I1fYraO
         Mogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VpzKXJxnCinKU2AX6PKhfnHVgtyzj5OEihM692yRdKM=;
        b=d7eEc9WWAI1b60WSUPhdjRPmfQ0P9p7zrHEDRXZUx6tmxNEmrMFg4sceQ58G3BaoQ4
         YznnAm7BVcGk0xNV2lN/7GllQTf1HAwVR3mvS/TdlUqpGHv6q4/ANgyqdmS5RP3+IA8W
         17kYFbVUR6On3fQVf5syiLBdI8Jy+1/DHZns7aYatHQJDdX6lu4Zudal2PDXv6Ga9i2+
         5cHxsKqk0qn+kbwIswiiUyG50oAJWtYGCXXRbnRIlrhyfshGE45eYAGP7L5FzI89XJqU
         pT6dVFSwjL1cHHUiXv8mVcvfXdad2irXhYi/8Lk30XJBzFVverbW6YrojblA2QHhPzGJ
         WEuQ==
X-Gm-Message-State: ABuFfojbOcjhElHauaqCe1sjNAIMvthuXaxQSztAgqEmLjcSBlaZkdeK
        G0UxUf2qrbpJIZvc7VEcaTuLfCyZjrpk4IJMowXkgg==
X-Google-Smtp-Source: ACcGV61EeRgNka5LLVzKKRJ7b/6XZrENLgtuzcD8lP8m/Fs6MbcDrDKt5mwyiOCRTzsAMnxH4NNtz+L5b6JgyjcJo0M=
X-Received: by 2002:a17:906:3557:: with SMTP id s23-v6mr34955531eja.128.1539197763115;
 Wed, 10 Oct 2018 11:56:03 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq8t36mk4t.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq8t36mk4t.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 10 Oct 2018 11:55:51 -0700
Message-ID: <CAGZ79kYJGMOtroLhPwOdhWewXf3X_b0QOgiUb65pyJ7xJ-whQw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Oct 2018, #01; Wed, 10)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> * pw/diff-color-moved-ws-fix (2018-10-04) 5 commits
>  - diff --color-moved: fix a memory leak
>  - diff --color-moved-ws: fix another memory leak
>  - diff --color-moved-ws: fix a memory leak
>  - diff --color-moved-ws: fix out of bounds string access
>  - diff --color-moved-ws: fix double free crash
>
>  Various fixes to "diff --color-moved-ws".
>
>  What's the status of this topic?

Per [1] ("The whole series is
Reviewed-by: Stefan Beller <sbeller@google.com>"),
I would suggest merging to 'next'.

[1] https://public-inbox.org/git/CAGZ79kbamUK=3Dd+-ejy9vopDiVZF7OVOngz1Zx9y=
04VR3HnmoXg@mail.gmail.com/

> * sb/strbuf-h-update (2018-09-29) 1 commit
>  - strbuf.h: format according to coding guidelines
>
>  Code clean-up to serve as a BCP example.
>
>  What's the status of this one after the discussion thread stopped here?
>  cf. <CAGZ79kbV6QjsFKcD2uG_P9j1AvzSNQSi-_jXGQ9w0YU9fjhEGg@mail.gmail.com>

I was waiting for more discussion and stricter guidelines,
which never happened.

The only controversial issue about this patch is whether we want
to name all parameters or only when we feel like it.

Peff did not seem to care about this particular detail
https://public-inbox.org/git/20180929073827.GD2174@sigill.intra.peff.net/

You suggested to embrace it further and use caps for the parameter
names in the docs comment.
https://public-inbox.org/git/xmqq8t3lb8uu.fsf@gitster-ct.c.googlers.com/

The patch as-is just adds names everywhere.
I'd be happy to resend with either
(a) not enforcing names everywhere, but only as needed or
(b) having names everywhere, capitalizing them NAMES in
    the doc comment.

I am tempted to ask for
(c) take as-is, defer the rewording of doc strings for a follow up patch.

> * sb/grep-submodule-cleanup (2018-10-10) 1 commit
>  - builtin/grep.c: remove superfluous submodule code
>
>  Code clean-up.
>
>  cf. <20181010001037.74709-1-jonathantanmy@google.com>

Will resend.


> * bw/submodule-name-to-dir (2018-08-10) 2 commits
>  - submodule: munge paths to submodule git directories
>  - submodule: create helper to build paths to submodule gitdirs
>
>  In modern repository layout, the real body of a cloned submodule
>  repository is held in .git/modules/ of the superproject, indexed by
>  the submodule name.  URLencode the submodule name before computing
>  the name of the directory to make sure they form a flat namespace.
>
>  Kicked back to 'pu', expecting further work on the topic.
>  cf. <CAGZ79kYnbjaPoWdda0SM_-_X77mVyYC7JO61OV8nm2yj3Q1OvQ@mail.gmail.com>

Thanks.

>
> * sb/submodule-move-head-with-corruption (2018-08-28) 2 commits
>  - submodule.c: warn about missing submodule git directories
>  - t2013: add test for missing but active submodule
>
>  Will discard and wait for a cleaned-up rewrite.
>  cf. <20180907195349.GA103699@aiede.svl.corp.google.com>

Yeah I think discarding this is the right move.

> * sb/submodule-recursive-fetch-gets-the-tip (2018-09-12) 9 commits
>  - builtin/fetch: check for submodule updates for non branch fetches
>  - fetch: retry fetching submodules if sha1 were not fetched
>  - submodule: fetch in submodules git directory instead of in worktree
>  - submodule.c: do not copy around submodule list
>  - submodule: move global changed_submodule_names into fetch submodule st=
ruct
>  - submodule.c: sort changed_submodule_names before searching it
>  - submodule.c: fix indentation
>  - sha1-array: provide oid_array_filter
>  - string-list: add string_list_{pop, last} functions
>
>  "git fetch --recurse-submodules" may not fetch the necessary commit
>  that is bound to the superproject, which is getting corrected.
>
>  Expecting a reroll.
>  cf. <b16af8c0-0435-0de4-ed6c-53888d6190af@ramsayjones.plus.com>

is fixed in
https://public-inbox.org/git/20180917213559.126404-7-sbeller@google.com/

>  cf. <CAGZ79kbavjVbTqXsmtjW6=3Djhkq47_p3mc6=3D92xOp4_mfhqDtvw@mail.gmail.=
com>

That is fixed locally

>  cf. <CAGZ79kZKKf9N8yx9EuCRZhrZS_mA2218PouEG7aHDhK2bJGEdA@mail.gmail.com>

That has been addressed via
https://public-inbox.org/git/20180925194755.105578-1-sbeller@google.com/

Will resend after a local review.

> * pk/rebase-in-c-6-final (2018-10-09) 1 commit
>  - rebase: default to using the builtin rebase
>  (this branch uses ag/rebase-i-in-c, js/rebase-in-c-5.5-work-with-rebase-=
i-in-c, pk/rebase-in-c, pk/rebase-in-c-2-basic, pk/rebase-in-c-3-acts, pk/r=
ebase-in-c-4-opts and pk/rebase-in-c-5-test; is tangled with ag/sequencer-r=
educe-rewriting-todo, jc/rebase-in-c-5-test-typofix and js/rebase-i-break.)
>
>  The final step of rewriting "rebase -i" in C.
>
>  Undecided.
>  I've been using this (i.e. the whole "rebase -i" and "rebase"
>  rewritten in C) in my personal build, and I also know users on
>  Windows port have been using it with the last feature release.  I
>  am tempted to merge the whole thing to 'next' soonish.
>
>  Opinions?  It's the last chance to remove any existing and avoid
>  any future "oops, that was wrong, and here is a fix-up"
>  embarrassment in these topics.

Yes, please merge to next.

Stefan
