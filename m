Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D02851F463
	for <e@80x24.org>; Wed, 11 Sep 2019 18:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729903AbfIKSPO (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Sep 2019 14:15:14 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:38351 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729699AbfIKSPO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Sep 2019 14:15:14 -0400
Received: by mail-ua1-f67.google.com with SMTP id 107so7116391uau.5
        for <git@vger.kernel.org>; Wed, 11 Sep 2019 11:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iAtgSLKnpodmnWBPUGYM0bzIozrKSxqYFyMI+sNM8m8=;
        b=EORBBgTXy9OeM0AmnAJa0uh1A4clekYnumIjNGwcMjG9CP15GRv6BvwbaLvRNIHfHi
         T/PSWupzMBP1Ud7zZaNhVRnTZd1PA+gpgClwtn12XOkP3OimiTB6g6WTN8Rrs+xsRUkz
         qSQvfOb1PVeXEsQowgXSlZcSTPn3qoQ9RYIsphoD+yBZQBiNSlmLIRLEPuYmg1w6zt69
         UL/NoV9XV7Xd8RW1eEW/Ll4LB+PCupCBzGzrR0w/w2I+27iqonJV/+GMqykyX9sm4E8n
         +7VdBy1E5TFe21W7xz3AmVo/QIHDSLNiyEBqbxuFC0D6sj1lzrXzCkOR9JIcJ4U6OyDR
         pEtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iAtgSLKnpodmnWBPUGYM0bzIozrKSxqYFyMI+sNM8m8=;
        b=lAH06oXP2yKnZpkGvbeTKIw+03MleevgqzaarlUlYk+eTevKihs59EvTB518FrrTij
         7XkKF9QNWnoZNkZj+c0YXxu+RpM2WVzPzaMPD4XWw+58w56fXJ3T8j8/Pnnmw8bjUiaj
         oyHLtKdrKfb2eAsQBZR6qFH5GGavm5zCds07p+mEL3i7HU+ER4ENQ3VwV+GBjv3SMOWt
         3f6LzQ1IxDQ7UXfrjRBN9/p81Ce53avzbZ70viu1QdyAIUMpCyDd1O+Bm0gTIMIXHR+K
         EElYkqLHiWH3NvbzUqTrE80w3TaXF31WnqJdZn69lyRvWJEn2I+hrIAt6fMN4XtLgtdx
         0AfA==
X-Gm-Message-State: APjAAAXBcD58/PdiQjQ/WMIEg6Wr9VJJcVYYyA98ALtgs4gBTjEVFRPw
        kyhRww0hHVPYpcetldw8jdC+8ECb0NgzddrjKAxNUvzm
X-Google-Smtp-Source: APXvYqz4VHLUwdy8/yHXUSI9meE72dC14RFBcD90Qn2DlLxUskW8eDrV00kbQZz1Qn5kgmbucfn72JaEYf7UDAVk15E=
X-Received: by 2002:ab0:7785:: with SMTP id x5mr5215787uar.97.1568225713117;
 Wed, 11 Sep 2019 11:15:13 -0700 (PDT)
MIME-Version: 1.0
References: <0102015f985d387e-f50183c4-4b49-4a9f-b365-2a86ba24bbed-000000@eu-west-1.amazonses.com>
 <0102016bb065bf5e-005b0752-2594-45d5-a01a-12d0c5e24b70-000000@eu-west-1.amazonses.com>
 <CAFA_24J8Ry5LhRX5O82eJDtrqjEodDFTEniZNw06fKEWvwvYMA@mail.gmail.com>
In-Reply-To: <CAFA_24J8Ry5LhRX5O82eJDtrqjEodDFTEniZNw06fKEWvwvYMA@mail.gmail.com>
From:   Max Rothman <max.r.rothman@gmail.com>
Date:   Wed, 11 Sep 2019 14:15:02 -0400
Message-ID: <CAFA_24JW_oRXB+40M2wKtEDQeC5VYjTC0D9GLEm5oa5E_dGtSg@mail.gmail.com>
Subject: Re: [PATCH] completion: add missing completions for log, diff, show
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just pinging again, I'd love to move this forward!


On Thu, Aug 1, 2019 at 8:54 PM Max Rothman <max.r.rothman@gmail.com> wrote:
>
> Ping :)
>
>
> On Thu, Aug 1, 2019 at 8:50 PM Max Rothman <max.r.rothman@gmail.com> wrote:
> >
> > The bash completion script knows some options to "git log" and
> > "git show" only in the positive form, (e.g. "--abbrev-commit"), but not
> > in their negative form (e.g. "--no-abbrev-commit"). Add them.
> >
> > Also, the bash completion script is missing some other options to
> > "git diff", and "git show" (and thus, all other commands that take
> > "git diff"'s options). Add them. Of note, since "--indent-heuristic" is
> > no longer experimental, add that too.
> >
> > Signed-off-by: Max Rothman <max.r.rothman@gmail.com>
> > ---
> >  contrib/completion/git-completion.bash | 18 ++++++++++++++----
> >  1 file changed, 14 insertions(+), 4 deletions(-)
> >
> > diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> > index 9f71bcde967bc..b6d18710135ec 100644
> > --- a/contrib/completion/git-completion.bash
> > +++ b/contrib/completion/git-completion.bash
> > @@ -1474,6 +1474,8 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
> >                         --dirstat-by-file= --cumulative
> >                         --diff-algorithm=
> >                         --submodule --submodule= --ignore-submodules
> > +                       --indent-heuristic --no-indent-heuristic
> > +                       --textconv --no-textconv
> >  "
> >
> >  _git_diff ()
> > @@ -1782,6 +1784,10 @@ _git_log ()
> >                 __gitcomp "$__git_diff_submodule_formats" "" "${cur##--submodule=}"
> >                 return
> >                 ;;
> > +       --no-walk=*)
> > +               __gitcomp "sorted unsorted" "" "${cur##--no-walk=}"
> > +               return
> > +               ;;
> >         --*)
> >                 __gitcomp "
> >                         $__git_log_common_options
> > @@ -1789,16 +1795,19 @@ _git_log ()
> >                         $__git_log_gitk_options
> >                         --root --topo-order --date-order --reverse
> >                         --follow --full-diff
> > -                       --abbrev-commit --abbrev=
> > +                       --abbrev-commit --no-abbrev-commit --abbrev=
> >                         --relative-date --date=
> >                         --pretty= --format= --oneline
> >                         --show-signature
> >                         --cherry-mark
> >                         --cherry-pick
> >                         --graph
> > -                       --decorate --decorate=
> > +                       --decorate --decorate= --no-decorate
> >                         --walk-reflogs
> > +                       --no-walk --no-walk= --do-walk
> >                         --parents --children
> > +                       --expand-tabs --expand-tabs= --no-expand-tabs
> > +                       --patch
> >                         $merge
> >                         $__git_diff_common_options
> >                         --pickaxe-all --pickaxe-regex
> > @@ -2525,8 +2534,9 @@ _git_show ()
> >                 return
> >                 ;;
> >         --*)
> > -               __gitcomp "--pretty= --format= --abbrev-commit --oneline
> > -                       --show-signature
> > +               __gitcomp "--pretty= --format= --abbrev-commit --no-abbrev-commit
> > +                       --oneline --show-signature --patch
> > +                       --expand-tabs --expand-tabs= --no-expand-tabs
> >                         $__git_diff_common_options
> >                         "
> >                 return
> >
> > --
> > https://github.com/git/git/pull/426
> >
