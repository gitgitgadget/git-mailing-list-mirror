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
	by dcvr.yhbt.net (Postfix) with ESMTP id 62DDC1F462
	for <e@80x24.org>; Mon, 17 Jun 2019 02:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbfFQCCy (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Jun 2019 22:02:54 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:33723 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbfFQCCy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jun 2019 22:02:54 -0400
Received: by mail-vs1-f68.google.com with SMTP id m8so5174737vsj.0
        for <git@vger.kernel.org>; Sun, 16 Jun 2019 19:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qyOAH/gRnuNmmlOb5d1QJ2VdpI6/cx/XnQ8l6qzM2K8=;
        b=O87RDLFPMlbRKsRZ5TSmAydVd//YNkAhE8YD2Lh2oyz7vNjvXskRTjrY30LiXMpDfP
         ZlLHcQqqCZDXuUsLAhp66B2wjMbW89i12fm/GGcoGRq6qdq/jRmns+sJfvKMug3UIinI
         5gGQEWU8NcDgNqMF16rw512EQOIBLKOJCwxiJ9T2/vhFLe2c7+QLdz58OkZHEx2E2yvS
         88FfIl4KmE/QcfiErT/raBrZFxWPfSOLqodG3iqEimWLDH2F+pahoEWN9yTu0LI8zumw
         Oyk3YgMbhKDLTxfPYhknNGcyrXTglyz+fhT3AIV8/ZKaGjAhA/H1OmuFRlKsXgc2NXrE
         xBNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qyOAH/gRnuNmmlOb5d1QJ2VdpI6/cx/XnQ8l6qzM2K8=;
        b=t02gcxteSwJ2FlKKgs7QuHi04It5KanYErAsnz+hFR7HLbbkHWU/EqA3CqeoWOCW2K
         jJHIRcLNqCyfu1TIa26FQmxMAvUYnNHrr3w/rgcU6kDPLIoPjPcrfz9idWsZ/JgJ99VE
         TY/vmCJoTjjAsj1kIW8jo0ueqQh1JwlYs0tZUihwqThR+sNJUW+6fqaaOF784g8CTbMb
         0SvBhtTfKAiFfS9DQpu9HpNtgn8F0Ca8REyhoXqr8thP7BABB44R61C3Gm9PU1pDBhDf
         uTlF4IxSwNT3NjLU/AVGZJx5/VL0WVZtCmAnLk8EZMkYJ4oWVnb+UyoyubVwOhjdIxph
         X3qg==
X-Gm-Message-State: APjAAAXUBQ1H683P/grlKSLf+1lf1FVdJ/oe8vx4lnCO2YVD18YKlGAm
        srCZdK2RD/DtdFMbdXXU8djdHI0rdUw3eFGUNy45aQ==
X-Google-Smtp-Source: APXvYqyxFDkC847+mqRJk4y5Dui3S6Z4cQwzy2l3JyLg1DeqYwP+DJjEnyIESUEQhrXPgepn86Ai1Q3fFXCVnvCtRts=
X-Received: by 2002:a67:f5d0:: with SMTP id t16mr11516728vso.175.1560736973143;
 Sun, 16 Jun 2019 19:02:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190616132457.19413-1-phillip.wood123@gmail.com>
In-Reply-To: <20190616132457.19413-1-phillip.wood123@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sun, 16 Jun 2019 19:02:42 -0700
Message-ID: <CABPp-BFAJtY2Bzow6T6kYoFqYifKzMinmjF0_EJa-fepcWcppQ@mail.gmail.com>
Subject: Re: [PATCH] show --continue/skip etc. consistently in synopsis
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 16, 2019 at 6:29 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> The synopsis for am shows the command mode options as
>     (--continue | --skip | --abort | --quit)
> They are on a single line and in parenthesis as they are not
> optional. Fix the merge and rebase docs to match this style.

Thanks for working to make this more consistent.  One minor issue...

> ---
> This patch is based on top of nd/merge-quit.
> The docs for cherry-pick/revert are updated to this style by
> https://public-inbox.org/git/20190616082040.9440-1-rohit.ashiwal265@gmail.com/T/#u
>
> Documentation/git-merge.txt  | 3 +--
>  Documentation/git-rebase.txt | 2 +-
>  2 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
> index b7d581fc76..07ca9fb78c 100644
> --- a/Documentation/git-merge.txt
> +++ b/Documentation/git-merge.txt
> @@ -13,8 +13,7 @@ SYNOPSIS
>         [-s <strategy>] [-X <strategy-option>] [-S[<keyid>]]
>         [--[no-]allow-unrelated-histories]
>         [--[no-]rerere-autoupdate] [-m <msg>] [-F <file>] [<commit>...]
> -'git merge' --abort
> -'git merge' --continue
> +'git merge' (--continue | --skip | --abort | --quit)

merge --skip?  I think you meant to just add --quit here, but copied
from elsewhere and accidentally inserted --skip?
