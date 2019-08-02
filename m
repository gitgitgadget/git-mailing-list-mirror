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
	by dcvr.yhbt.net (Postfix) with ESMTP id AAB901F731
	for <e@80x24.org>; Fri,  2 Aug 2019 19:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392200AbfHBTVk (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Aug 2019 15:21:40 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41014 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392153AbfHBTVk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Aug 2019 15:21:40 -0400
Received: by mail-qk1-f195.google.com with SMTP id t187so2981006qke.8
        for <git@vger.kernel.org>; Fri, 02 Aug 2019 12:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cV5xBYDwj0jibG+OHnvdXbkYhPTQro+No3cY3QzUnT4=;
        b=ON0SMfafmkscht54ejJ3wq00JgOtEj2NKm+9xNg3x8dWE9VUnb15c0MbjsAdC0EJUN
         V/djmArRNpB47kLoTiGQFjeJb2hx1M8MNUXBaSS2olARV5SMEzjns5vmbxSYlpooVRLs
         8TeYDzsZHNhWGV+tlL4tPB9Uq3gAme4u6/IsC1dmnWLTaHmothxCsEyZzg7V75bXYZaG
         2gHbsa96wPyneIZNY+75atffaXGVlFk3qVvDql1uAlncY01GIsppV40+r9atf2JfSJp6
         Xp2X3zjkL4wPHDgrxzA4LTBlEr/FtKoRjv+TYiTCTXeSJZlxOUS748wyDnu7m3pvtZas
         06wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cV5xBYDwj0jibG+OHnvdXbkYhPTQro+No3cY3QzUnT4=;
        b=C+OJNkuREN3SY0leE01910YPdmb5VAUiTpNymisBFeVuC/4n7yFVhEBpXp/oe/Nb0T
         2rPUjDmwSsVnMso+t+6RRU2w/qy4y+4O/g/Im7SE9sIXjHYX44UHTvzUFnDlcWWw7LyD
         Xt30XytJnzYCbwGwL3vX7onf/2Onh4jQuU6EzuO4F/pLMdxu0nAqMy0YaTo0ebcu4zcd
         wgDi7vysWByTLzzH84F2WO36dQ6bx/iESDaB4zoTsTCylWNS3wvQAc5/4ej/rIgUlNII
         Yod1/fPUBwoUl9pY/lD12BarK/sSaJ+uxSrDA9fMzO1e7nly/mP6K9VpuckKKfCLHRXk
         lqzw==
X-Gm-Message-State: APjAAAXL5hBOQ+mW/youIdyT42oMNM6tAjdu+U/FqBfrT/2AuaozvhVt
        2bm2pFu/d14P3ppK9ZV8mcMJFaUSTct4RTTGWYY=
X-Google-Smtp-Source: APXvYqy90S1xNandJVxCt7o0rWSLOxKbHZMzycTNaBqZmcPBr9sK6E8O+BAYOnc6fsEHC5xgMyCOJUHQInBvZ5LM3AM=
X-Received: by 2002:a05:620a:1116:: with SMTP id o22mr93609947qkk.82.1564773699558;
 Fri, 02 Aug 2019 12:21:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAA01Csp=g08N4+S1HKAjV2a12VJNSJU0UYdAU6LW1jGWLD9SLQ@mail.gmail.com>
 <05c77291-48d1-a592-6296-d8a8bdb16b02@gmail.com>
In-Reply-To: <05c77291-48d1-a592-6296-d8a8bdb16b02@gmail.com>
From:   Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Date:   Fri, 2 Aug 2019 21:21:28 +0200
Message-ID: <CAA01CspHCKA3itmTxFO1NeNB6DpdFx3CTbXKtO=TvtznLn_zAg@mail.gmail.com>
Subject: Re: git-log on a file, and merges
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 2, 2019 at 4:22 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 8/2/2019 5:38 AM, Piotr Krukowiecki wrote:
> > Hi,
> >
> > I have merged a branch into master.
> >
> > When on master I do "git log -- some/file", it does not show commits
> > from merged branch (which I know they changed the file).
> > I have to add "--full-history" to see the commits.
> > When I run "git log" (without "-- some/file") I can see the commits
> > without using "--full-history".
> >
> > This seems not logical, and contrary to user expectations. Harmful even ;)
> >
> > Am I missing something?
>
> Hi Piotr,
>
> You are falling victim to an issue related to file history simplification [1]
> and a (probably) bad merge. You can read more about how this can happen at [2].
>
> When git log reaches a merge commit and one of the parents matches that path
> exactly, only that parent is walked. The other is ignored. In some sense, the
> other commit did not contribute changes to that file (because we only took
> changes from the other parent). This makes the history look good and enables
> some performance boosts.
>
> Basically, someone must have gotten a merge conflict and used "-S ours" to
> wipe away the changes from the other branch on that file. You can find that
> merge by running
>
>         git log --full-history --simplify-merges -- some/file
>
> You will see the merge commit that un-did the change somewhere above the
> commit you are expecting to see in the history.
>
> Thanks,
> -Stolee
>
>
> [1] https://git-scm.com/docs/git-log#_history_simplification
> [2] https://docs.microsoft.com/en-us/azure/devops/repos/git/git-log-history-simplification?view=azure-devops

Thanks for explaining.

There was no "bad" merge. The file was modified only on the branch
(and previously in common history).

There were two commits to this file on the branch, older one did some
changes, later one reverted the changes (among other things).

So my understanding is that git looked at the merge commit, saw that
this file was the same as it was before the merge, and assumed that
there were no commits which modified this file in the branches being
merged, so it didn't bother looking at the branch history.

At this moment I'm not sure myself if I consider this a bug or not.
Maybe if I look at merge commits as a special entity - not a diverging
history, but rather a single commit which introduces some changes -
then maybe I could accept it.
But on the other hand I feel this generates wrong results. Falsifies
history. If I was asking about "diff", I would understand if it showed
nothing, as there was no difference. But I'm asking for "log".
Especially that I remembered/checked that there were some changes to
this file, and wanted to see them.


Anyway, is there a way to disable this behavior (enable
"--full-history"?) by default?
I suspect that this behavior will bite me in future, and I guess the
"performance gains" are not big enough to validate it...



-- 
Piotr Krukowiecki
