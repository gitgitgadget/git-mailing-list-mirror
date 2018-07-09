Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 385C91F85A
	for <e@80x24.org>; Mon,  9 Jul 2018 18:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932798AbeGISUv (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 14:20:51 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:38130 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932633AbeGISUu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 14:20:50 -0400
Received: by mail-yw0-f193.google.com with SMTP id r3-v6so6878388ywc.5
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 11:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cGvpVIh5rVuSHIp6Vdsk/R9r17kQ602t7Tro8s0kDlQ=;
        b=a8QDFfDfJaBN46s6xTxAIf6Uu9XXzw0nxPzmLCESLWRKPmazMmnw5NofdquTYuzahG
         U1Vrw3RKthmeJBnsuEEE2eV8Yk2zubw2CZt0yiBycj+PilLOSZgS6H5x3Px69l1DPSIM
         pZLrau08Agb783jFEWpMRWxq67rbxUMlNkn50vXUi7BaEVna94VTl65p4DwLmBYT7DJj
         cReiV78ctCKJ01pAHwylWA2EsI5uHee9Ud0Oi4r9Hs3Dls+QayLi4F8dAC6VaIcsP0HQ
         2k4pGXXk03dXvpp0ATo+NEoNDXctXr2GXJR7cDZ4/UDRw7zdKn13C7YNmPED1siI5DZ/
         ZLpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cGvpVIh5rVuSHIp6Vdsk/R9r17kQ602t7Tro8s0kDlQ=;
        b=KTQkbfyB6Bi+pW4kE3jymd8ku62cotF0fe1DqlIeO5K9D/LbyYzDvR9hQp+ApzM3Et
         YzRedI16+qBYzFCGo4BGaqrh1o6ZlROZurixBRoDzJSMh5U2Eu/t0wvqLBZYbz2nTza2
         Y5TL5radAef11Go564pkTy0rtdIq3hSB9nN2kFjyzNt1G/SN2La+v7iOe8hCzjoAoQMX
         NC98ImvyevFa7WPX2Sn/jlD0p/SwgIOptHqM3/25RZj8thHNL+1A0zFO19bqreNdFbGx
         GA8JBgAQsFTcM62gPu1ayWYaleFf7Re6py/TdPZWtq7qRSfrVqM2aVsNcxWwHe3SFTYq
         Ch9g==
X-Gm-Message-State: APt69E1a9t8CJIfmQiznwsfEB0uk4MozGLfDnyPlBEiT28k5xPc9ChFm
        SZClRsY3GAZaOH+KxWSJIyCHsQxJ0l/mxI+iuacLHA==
X-Google-Smtp-Source: AAOMgpfagsjUdyChVMCW/Ivyj7UW3W3jriPJ3clPaElmY9rUVCm1ZbGNlJv+n2lPwoTIiYcuOou/gKVcMYgQiyinIuw=
X-Received: by 2002:a81:ae41:: with SMTP id g1-v6mr10283641ywk.345.1531160449279;
 Mon, 09 Jul 2018 11:20:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1525448066.git.johannes.schindelin@gmx.de>
 <pull.1.v3.git.gitgitgadget@gmail.com> <799da25ef35d2b23dc0df1e6af0772e634f39f19.1530617166.git.gitgitgadget@gmail.com>
In-Reply-To: <799da25ef35d2b23dc0df1e6af0772e634f39f19.1530617166.git.gitgitgadget@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 9 Jul 2018 11:20:38 -0700
Message-ID: <CAGZ79ka9kjnu=taVBnkTicZBGZo-EbPOkzRxXihH8Y=Fcn5+-g@mail.gmail.com>
Subject: Re: [PATCH v3 17/20] range-diff: add a man page
To:     gitgitgadget@gmail.com
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 3, 2018 at 4:26 AM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:

> +'git range-diff' [--color=[<when>]] [--no-color] [<diff-options>]
> +       [--dual-color] [--creation-factor=<factor>]
> +       ( <range1> <range2> | <rev1>...<rev2> | <base> <rev1> <rev2> )
> +
> +DESCRIPTION
> +-----------
> +
> +This command shows the differences between two versions of a patch
> +series, or more generally, two commit ranges (ignoring merges).

Does it completely ignore merges or does it die("not supported"), how is the
user expected to cope with the accidental merge in the given range?

> +To that end, it first finds pairs of commits from both commit ranges
> +that correspond with each other. Two commits are said to correspond when
> +the diff between their patches (i.e. the author information, the commit
> +message and the commit diff) is reasonably small compared to the
> +patches' size. See ``Algorithm` below for details.
> +
> +Finally, the list of matching commits is shown in the order of the
> +second commit range, with unmatched commits being inserted just after
> +all of their ancestors have been shown.
> +
> +
> +OPTIONS
> +-------
> +--dual-color::
> +       When the commit diffs differ, recreate the original diffs'
> +       coloring, and add outer -/+ diff markers with the *background*
> +       being red/green to make it easier to see e.g. when there was a
> +       change in what exact lines were added.

I presume this is a boolean option, and can be turned off with
--no-dual-color, but not with --dual-color=no. Would it be worth to
give the --no-option here as well.
The more pressing question I had when reading this, is whether this
is the default.

> +--creation-factor=<percent>::
> +       Set the creation/deletion cost fudge factor to `<percent>`.
> +       Defaults to 60. Try a larger value if `git range-diff` erroneously
> +       considers a large change a total rewrite (deletion of one commit
> +       and addition of another), and a smaller one in the reverse case.
> +       See the ``Algorithm`` section below for an explanation why this is
> +       needed.
> +
> +<range1> <range2>::
> +       Compare the commits specified by the two ranges, where
> +       `<range1>` is considered an older version of `<range2>`.

Is it really older? How does that help the user?
I think this comes from the notion of e.g. patch 4 ("range-diff: improve the
order of the shown commits "), that assume the user wants the range-diff
to be expressed with range2 as its "base range".

> +<rev1>...<rev2>::
> +       Equivalent to passing `<rev2>..<rev1>` and `<rev1>..<rev2>`.

That is cool.

> +Algorithm
> +---------
> +
> +The general idea is this: we generate a cost matrix between the commits
> +in both commit ranges, then solve the least-cost assignment.

Can you say more about the generation of the cost matrix?
I assume that it counts the number of lines added/deleted to make
one patch into the other patch.

If that assumption was correct, an edit of a commit message adding one
line is just as costly as adding one line in the diff.

Further I would assume that the context lines are ignored?

I think this is worth spelling out.

Another spot to look at is further metadata, such as author and author-date,
which are kept the same in a rebase workflow.

Maybe worth noting that this algorithm doesn't pay special attention to these,
but a change in them would be strong signal that the two patches compared are
not the same?

I like the example below, thanks!
Stefan
