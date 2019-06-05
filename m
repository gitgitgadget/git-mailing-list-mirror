Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBAF11F462
	for <e@80x24.org>; Wed,  5 Jun 2019 18:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfFESir (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jun 2019 14:38:47 -0400
Received: from mail-qt1-f180.google.com ([209.85.160.180]:39733 "EHLO
        mail-qt1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbfFESir (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jun 2019 14:38:47 -0400
Received: by mail-qt1-f180.google.com with SMTP id i34so5787966qta.6
        for <git@vger.kernel.org>; Wed, 05 Jun 2019 11:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IqBQInhvOv7PGK/AqhydZ6hVao/H0nzXikd+AzyNCTo=;
        b=XeXFkgBW46GeQDJAFV659sRQPt9rmOvJBKU/ExWt2XiD9bVUVlE5UhNR+UwtYHmtlU
         uybCqyJgC8sz7Xt1SSHX6yunsFm3yXClPcx9Hd8XbUvw75DUWRY12+evL3MhFwRSSiOx
         gwf1pbAaO3jc4LsDKaXUvNE3Ezdi53xSsWG4Pcm82wwMQ9Xg0nIBt0M4w2RRkyCo2YSx
         Gy4HNQyZ6oZPT4p0uXH5/DI0aERYXjQRaSG8Eo2RDVfV+9sKyfDbTC2mhdPA7s6EJqVJ
         IZQsmkPV1mh0UzGbz0fXIovYcGlGl3ErD4NXzXAbhP1xQBWYNDEaFNp4W/jvU9fz44V9
         kAgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IqBQInhvOv7PGK/AqhydZ6hVao/H0nzXikd+AzyNCTo=;
        b=njawKLiX23EaAjF4ZobCxhuIrfxiI46mqlPKpm2zRgseDuWZ8K2ZFnrvsdupjpeTaW
         XXkaETmRsTY6/jJal1q3GrXWNIdwJsqo/EdYBQb8Vl93ye3LS60ZpzXGfJYDE6Um5kTD
         vojd66vc4/q5KnBCxdz4GhFMiMHddNHModEcQxjvTut5jvhKuiRzsgQbq3zOJesL8dJl
         fXzmyan/xr5i3mqTcmS4Uj+XO/1e3tx8NoNcgz4HdVmoKWpmT+VEZgESrLs6cq3chraV
         7k9n6EWmbgBVuRwf3RbfafaT6vt31Hvt8Wv/HIDwbDsr02Dh3aED6xpl+rLY5WN6bEBH
         HAwg==
X-Gm-Message-State: APjAAAUU/yryaPg2gEEL/QcV24l+Y7HXfcfrEOxvZwGz9MX+5aoQ3EDS
        HaYIUI8I7QnjCbdR71tl57REaVrqIpEjVGcZV8U=
X-Google-Smtp-Source: APXvYqxXp+SrHkap1NGYiqePI4BVSVXOz9hq/UrToXXCaoOw8PBSL1EV/ryamAgkEWHIQsB76Qem5jDOrMsriOJBnxc=
X-Received: by 2002:a0c:ee49:: with SMTP id m9mr26860801qvs.217.1559759926319;
 Wed, 05 Jun 2019 11:38:46 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqwoi7ws9z.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqwoi7ws9z.fsf@gitster-ct.c.googlers.com>
From:   Nickolai Belakovski <nbelakovski@gmail.com>
Date:   Wed, 5 Jun 2019 11:38:20 -0700
Message-ID: <CAC05385iALWsN_fRS-Mzt1Q-3kV+562KfkV+Gz_XtEw40_ddLQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (May 2019, #05; Thu, 30)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 30, 2019 at 5:20 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> * nb/branch-show-other-worktrees-head (2019-05-07) 3 commits
>  - branch: add worktree info on verbose output
>  - branch: update output to include worktree info
>  - ref-filter: add worktreepath atom
>
>  "git branch --list" learned to show branches that are checked out
>  in other worktrees connected to the same repository prefixed with
>  '+', similar to the way the currently checked out branch is shown
>  with '*' in front.
>

I see that this has been in 'pu' for some time now. Is there something
holding it up from going into 'next'?
