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
	by dcvr.yhbt.net (Postfix) with ESMTP id BC4151F461
	for <e@80x24.org>; Tue,  9 Jul 2019 23:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfGIXNM (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jul 2019 19:13:12 -0400
Received: from mail-vs1-f54.google.com ([209.85.217.54]:36457 "EHLO
        mail-vs1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfGIXNM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jul 2019 19:13:12 -0400
Received: by mail-vs1-f54.google.com with SMTP id y16so273687vsc.3
        for <git@vger.kernel.org>; Tue, 09 Jul 2019 16:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0GAR6cXCpRq7MrxBpOkqoI+NoQrcnXBmpWX4s0MJL38=;
        b=X1ux1zUXJPy3frebd2E2w0bPu9qGs1qMrT5tSrp8PD92SR2be7CBUVcXGgyCklHkAv
         OOpgZnEPrXazFR2aF3AaaDUksmeO7fSBqpEzslTljmbBSihpN8sAOH8y0FzXSptQJnpt
         sv+X8jsON0L2t3bLM5W6/jO+pjPg652qxfxYQhd0YldGP9MkmNCCbceOM66QLy0q357H
         cm8BcSH+XaLQzu/WJARytJSci4QBvmvxBXNMhmvCXbKt/ctleFZJCQHBjEZvYXm/uroL
         WnrEX3vtZzslTJkRuaIVWrnA6bedXhRlbaCyo6OJKYxoz9WwLCK69NuU2Zr+F2ftO1yb
         3CQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0GAR6cXCpRq7MrxBpOkqoI+NoQrcnXBmpWX4s0MJL38=;
        b=fCtOI6JDjpw2wrWSkIaMFMxAdOG8UBR6rmjC1cOtDPO00GYWPxGyVaKm2hXBqrXRrp
         X72vo0HHmNlGyt/tvUtagyXsoMmBqvuVWoaOH0kuyiCqSusaVP8rE/qcTqmdGAxxwph1
         ki3+7UIXKD8opdgKTWIQ7WbgKTRAEF1LdfOU3jBLdnRFMPzAzT7JkYJqsvx9qR4hx98T
         qSX9v1wYUo0kcTd3x8KIOc8dSifgO75IQLIccn2zpnLzIkcO8OPe4qJhtso4OpWup0Vj
         y8mGQ8WeTcj6bayJIosSVYlqHLzFwSDiFXOXTFM5KD4u3320xIMcfOh8w+Ubr2SjJvtd
         RV7g==
X-Gm-Message-State: APjAAAWgg+RhZWAnb0nAguESmTF9ERMPJ7yPMS4ffzqgn8xF1sMNw8s2
        DXYfGduw6/TIrf13wuwbGl3wu1IRb6V45yXT9Dw=
X-Google-Smtp-Source: APXvYqxhUSTXgDhhNxcukDXBY3cDsMP2ebgjuYgTywPAt+N05ZvxT4d94bJxHqEAglk7BUhCZG+eMswaZG0CPFsyUYk=
X-Received: by 2002:a67:300f:: with SMTP id w15mr16522136vsw.116.1562713991581;
 Tue, 09 Jul 2019 16:13:11 -0700 (PDT)
MIME-Version: 1.0
References: <1288734232ea45e0be655668ac60d98f@ASGEXCPWP07.ga.com>
In-Reply-To: <1288734232ea45e0be655668ac60d98f@ASGEXCPWP07.ga.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 9 Jul 2019 16:13:00 -0700
Message-ID: <CABPp-BE1fQs99ipi9Y8gfQO3QHkxzQhn1uriEbj6YjdYH839eQ@mail.gmail.com>
Subject: Re: Problem with git diff
To:     "McRoberts, John" <John.McRoberts@ga.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi John,

On Tue, Jul 9, 2019 at 3:57 PM McRoberts, John <John.McRoberts@ga.com> wrote:
>
> I am responsible for generating a list of all files changed between two
> successive releases of software. I was using 'git diff' but have run into a
> problem.
>
> Consider the following situation: A development branch comes off of commit A
> and files are changed three times.  A tag (REL1) is placed on the third
> commit.  Then the branch is merged back to master.  At this point, master's
> HEAD is at C (and it remains there).  Two development branches are created
> off of master, the first of which is not important here.  In the second one,
> there are files changed and a tag (REL2) applied.
>
>
> ---------------------[I]
>
> /      {dev branch}
>
> /
>
> /
>              {master branch}
> /
>  [A] ---------------------------------[B]------------------------------->[C]
> master <HEAD>
>    \                               filelist 6                           /  \
>     \                                                                  /
> \
>      \                                                                /
> \
>       \                                                              /
> \
>        \                {development branch}                        /
> \
>         \------->[D]----------------------->[E]-------------------[F]
> \------[G]--------[H]
>                                                                  REL1
> REL2
>                 fileset 1               fileset 2           fileset 3
> fileset 4    fileset 5
>
> At this point, I run
>     'git diff  -m --first-parent --pretty=fuller --decorate=short
> --name-only REL2..REL2'

Wow, we really, really need to throw errors and warnings when people
use crazy range operators with diff.[1][2]  What version of git are
you using that accepts --decorate=short as an argument to `git diff`?
And why in the world does git diff accept --first-parent or
--pretty=fuller?!?  That's insane for git-diff to swallow that.
(#leftoverbits?)  Also, I think you meant `REL1` one of the two times
you wrote `REL2`, which makes me suspect you may have done some
copy-edit-paste and didn't try this actual command.

> I expect to see only filesets 4 and 5 listed.  I also see filesets 1, 2 and
> 3 showing up.  This means that the git diff command is showing files that,in
> fact, did not change between the two tags.  By the way, I verified with a
> file by file comparison that under REL2 and REL1, the files represented by
> filesets 1, 2 and 3 had identical contents.

From your description, I assume you actually ran something like
  git diff --name-only REL1..REL2

which compares REL2 to the merge base of REL1 and REL2 (yes, this is
totally counter-intuitive to a large percentage of the git userbase,
but it is well documented and hard to change).  Also from your
description, what you seem to want is
  git diff --name-only REL1 REL2

since you want to compare the two endpoints.  Does that help get what you want?

Hope that helps,
Elijah

[1] https://public-inbox.org/git/CABPp-BECj___HneAYviE3SB=wU6OTcBi3S=+Un1sP6L4WJ7agA@mail.gmail.com/
[2] https://public-inbox.org/git/CABPp-BGg_iSx3QMc-J4Fov97v9NnAtfxZGMrm3WfrGugOThjmA@mail.gmail.com/
