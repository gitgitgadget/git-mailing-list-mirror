Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE94620A1E
	for <e@80x24.org>; Fri, 14 Dec 2018 06:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbeLNGuO (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 01:50:14 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45618 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbeLNGuO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 01:50:14 -0500
Received: by mail-ed1-f67.google.com with SMTP id d39so4042317edb.12
        for <git@vger.kernel.org>; Thu, 13 Dec 2018 22:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ub5U7XP1MT/AuuyG5RsVcxEZTNl4kri/w7d81vhb3fE=;
        b=TGrkYVZ71FvpYHEy/7vL0b57LrospRGq1E0VnKhBMmtR0sliOHYAhK1hIkFLxY4FqV
         Acn0MW9CzJx9ulb+y2c+wGtvkkSxNjGkbM304tInPBZLwF0NJrmq31E2d9RaQgd4u4CR
         ppvERx4Bct57z0xAb3QPWcLLcjDrV9E66VxhD2BMl8qNj1SQ2R7k9xDbcCQCZvjjUZQp
         cP7vZCn1tO1D5/jmVlUhEr2y6FYmS3XjZhlbceTdM+oWY/MH/FlXxQ7nl/SanxfdSyIC
         nEhgtM+tsCoK4uAd43PEU0m7wluiOrwfu4qHQGAz4/ndcrb0QS++9HCher+pTWv1xl+u
         KFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ub5U7XP1MT/AuuyG5RsVcxEZTNl4kri/w7d81vhb3fE=;
        b=S7+0/qnDGadQWWjlmV8DxefhqJLIQxzWgUTpCQY8EW1ILG+ADU3CtEJ+Huzw78tzzj
         iN9vZuaGGqymXyK0lNcDnEJd7k6JOiQIuKvbMv1Ei+nTEg6aoA9kWQ2FzWJbl/5rwqfx
         P3C+ZAabfbratFlY5e3fqfh2hDRSEYgcBiGsfqaAL20zp0jepk+JY6D3M+ucNG24cbtL
         EdhejoQxN+YrN70HvZNRF1zcmPqgGbthIVPrznMh7xmkgU1fx1WYAvJuZ/YEFn0P2Uyc
         sviDyYE4CqzFEwtKVSsRjibowJlTMUwTDqaZvLLb5CiZ8qGXZtbNZto3S1HuM6HGGfBs
         0QOg==
X-Gm-Message-State: AA+aEWZmP1OwVtvuGzam+bZxkR1WGlZoE35jdgvgiB0oqhV5Kw4XMNX4
        1SOnDJwqjABQf1kTn8EQ4ERmFDN2DbtAWsr6U/Q=
X-Google-Smtp-Source: AFSGD/VK7NnGkRJvcuty+GqVahhU5+8Doah3XEI+n+r5mfcrlgXpE6zrrYEgB3+i6p5aABgqdJE8PYCG2RebNbkoONY=
X-Received: by 2002:a50:a8c3:: with SMTP id k61mr1980090edc.296.1544770212509;
 Thu, 13 Dec 2018 22:50:12 -0800 (PST)
MIME-Version: 1.0
References: <pull.100.git.gitgitgadget@gmail.com> <13ee60e44f91ca06d182ff50fa4c69e137650fd2.1544730848.git.gitgitgadget@gmail.com>
 <CACsJy8AsRT+k4kdwC3gGjDOPiDn-L0GJs7-SQHb88Ra_gt4OcA@mail.gmail.com>
 <CANoM8SVMYBRg-nL4r=JJDFU_qZ=grzSmRs-B2nLYUnv5kFc00Q@mail.gmail.com>
 <CACsJy8Bj=8xHp3JA8dLbyM=RwJey7utMK6DTVe_0AjBNVHxJyg@mail.gmail.com>
 <CAGZ79kYnQPhGMStmKSFb5_4Ku-nv54nHwta==jE82ZR4NOPETA@mail.gmail.com> <CANoM8SWQTAEYGiUC9PnWi8u9oAJYPcyiE5+5usoRvR7Vw2z0JA@mail.gmail.com>
In-Reply-To: <CANoM8SWQTAEYGiUC9PnWi8u9oAJYPcyiE5+5usoRvR7Vw2z0JA@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 13 Dec 2018 22:49:58 -0800
Message-ID: <CA+P7+xonxvfuhw4W+FUL87We8CaOwxsndFkN5bcgBhdsnZ5QAg@mail.gmail.com>
Subject: Re: [PATCH 1/1] worktree refs: fix case sensitivity for 'head'
To:     Mike Rappazzo <rappazzo@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        gitgitgadget@gmail.com, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 13, 2018 at 1:16 PM Mike Rappazzo <rappazzo@gmail.com> wrote:
>
> On Thu, Dec 13, 2018 at 3:48 PM Stefan Beller <sbeller@google.com> wrote:
> >
> > > > The current situation is definitely a problem.  If I am in a worktree,
> > > > using "head" should be the same as "HEAD".
> >
> > By any chance, is your file system case insensitive?
> > That is usually the source of confusion for these discussions.
>
> This behavior is the same for MacOS (High Sierra) and Windows 7.  I
> assume other derivatives of those act the same.
>
> On CentOS "head" is an ambiguous ref.  If Windows and Mac resulted in
> an ambiguous ref, that would also be OK, but as it is now, they return
> the result of "HEAD" on the primary worktree.
>

Because refs are *not* case sensitive, and we know that "HEAD" should
be per-worktree, it gets checked in the per-worktree refs section. But
lowercase head is known to not be a per-worktree ref, so we then ask
the main worktree about head. Since you happen to be on a case
insensitive file system, it then finds refs/HEAD in the main refs
worktree, and returns that.

I don't understand why the CentOS shows it as ambiguous, unless you
actually happen to have a ref named head. (possibly a branch?)

I suspect we could improve things by attempting to figure out if our
file system is case insensitive and warn users. However, I recall
patches which tried this, and no suitable method was found. Partly
because it's not just "case" that is the only problem. There might be
things like unicode characters which don't get properly encoded, etc.

The best solution would be to get a non-filesystem backed ref storage
working that could be used in place of the filesystem.

Thanks,
Jake

> >
> > Maybe in worktree code we have a spillover between path
> > resolution and ref namespace?
