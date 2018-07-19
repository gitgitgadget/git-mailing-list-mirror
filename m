Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 276301F597
	for <e@80x24.org>; Thu, 19 Jul 2018 17:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732053AbeGSRyX (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 13:54:23 -0400
Received: from mail-ua0-f181.google.com ([209.85.217.181]:35489 "EHLO
        mail-ua0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731625AbeGSRyX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 13:54:23 -0400
Received: by mail-ua0-f181.google.com with SMTP id q12-v6so5682435ual.2
        for <git@vger.kernel.org>; Thu, 19 Jul 2018 10:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=H9mDgvnJpAWK1DnhBJkCx4j1Vnm4IMT1l9QWqIsHYmM=;
        b=al9yfLsqfx+ORB1xBQi63eZdbqomqhMRETOaoM9d2a1yGR3jlqZ0kqlrXyGY9610YX
         yL6UzjVZIGB4KOUePub5NSoZJHHfnsZCpOuRs2qRaj+ycxlwHWVQERaFi+WOnPQRo6Y4
         sBksS44uotxfhW0tvxkkfo9elpiYMl3WYNjhBZHyfDOmN9tZR5u68hcGaeQTWXcZCyIE
         RcR3D/QWHgIyadg7oiSHiXWaG29gPrpLtH6nUeurq1LkthdLsPR3PkW+dhVKmdVsXMfq
         gPnYE5eoNIXaE1TCM96QRB7BInJBzbmRsBmK+qHDFfpS3AYHza2G4RWFLikjK17cp07T
         PRww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=H9mDgvnJpAWK1DnhBJkCx4j1Vnm4IMT1l9QWqIsHYmM=;
        b=k8Z/7Mn4LR4aVt36qp4kh00q1Q5u16PrtvctKzCmIA8PDAr0Gxh4uGpy+erLmnvtET
         fDXSEAFltoYFsYK+64xc5sdihJZgIbll3sMG8xaNqf78ePw3VVfX44e2qCix5vcthXyM
         BKV3XWoQT3zehLFlwu9+mmIF2/RhUaiwvCU8GLGqFCzHfZRZMnweSxqZeuRi0Y/ywAse
         f1Cd8YIcfkqIfoC2lZVc+zwjAnCONHb4p21MDLKfYv7EgQmuemQHIQnt8UCJtg17G1A/
         I3P1Vf7EXgjelAlV97ZCtZzxubbcNPcE+FH/1AlrQHnKhtJp40nw7mzcgVX+FKgCWx2W
         JW4Q==
X-Gm-Message-State: AOUpUlGQIUEcudJAWwqk2MLWogqPITYhHWfsD30TrLnB84Uhw1uJsg0P
        +Nr+xhd23Wn9RES4dXLELzr0JVl9P97ct5xtJZsehA==
X-Google-Smtp-Source: AAOMgpfw9Vg+8UV61FOTTaI6Tkh5WkmmQue9NsgF1eYZwdCDwwQiuNoHyWrfk0FzGYfQ5MMCLOBm5o5XspZpdbW9mm4=
X-Received: by 2002:a9f:3666:: with SMTP id s35-v6mr7654926uad.94.1532020217385;
 Thu, 19 Jul 2018 10:10:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:21c7:0:0:0:0:0 with HTTP; Thu, 19 Jul 2018 10:10:16
 -0700 (PDT)
In-Reply-To: <xmqqtvowi4l3.fsf@gitster-ct.c.googlers.com>
References: <xmqqtvowi4l3.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 19 Jul 2018 10:10:16 -0700
Message-ID: <CABPp-BFSh2KYuBAWZcMUZ6NS0VYc4NNGTaTS3jUGiWm+BO4+Wg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jul 2018, #02; Wed, 18)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 18, 2018 at 3:03 PM, Junio C Hamano <gitster@pobox.com> wrote:

> * en/rebase-i-microfixes (2018-06-27) 3 commits
>   (merged to 'next' on 2018-07-11 at d913ca0f77)
>  + git-rebase--merge: modernize "git-$cmd" to "git $cmd"
>  + Fix use of strategy options with interactive rebases
>  + t3418: add testcase showing problems with rebase -i and strategy options
>
>  Will merge to 'master'.

This series showed up in the "Graduated to master" section of your
email and the series shows up on master; did you just forget to remove
this last line?

> * en/abort-df-conflict-fixes (2018-07-16) 2 commits
>  - read-cache: fix directory/file conflict handling in read_index_unmerged()
>  - t1015: demonstrate directory/file conflict recovery failures
>
>  "git merge --abort" etc. did not clean things up properly when
>  there were conflicted entries in certain order that are involved
>  in D/F conflicts.  This has been corrected.
>
>  This may have to be rebased on an older maintenance track before
>  moving forward.

Would you like me to rebase on maint and resubmit?  Alternatively,
  git cherry-pick -Xours master..en/abort-df-conflict-fixes
will backport the fixes to maint, with the only downside that it
leaves some unnecessary (but innocuous) double 'git reset --hard'
invocations in t6042.

Just let me know whatever is easiest for you.

> * en/t6042-insane-merge-rename-testcases (2018-07-03) 3 commits
>  - t6042: add testcase covering long chains of rename conflicts
>  - t6042: add testcase covering rename/rename(2to1)/delete/delete conflict
>  - t6042: add testcase covering rename/add/delete conflict type
>
>  Various glitches in the heuristics of merge-recursive strategy have
>  been documented in new tests.
>
>  Will merge to 'next'.
>
>  I am not sure if there is a single "correct" answer everybody can
>  agree on for each of these "insane" cases, though.

Yeah, I agree.  I was a little unsure about adding the expected
"correct" answer in these testcases for fear I would just end up
modifying it whenever I finally implement a fix.  However, it was
clear that current handling for these testcases is suboptimal, and
ultimately I decided it'd make sense to just take my best guess at
"correct" for now and deal with any modifications later.  *shrug*  I'm
not sure what, if any changes to make to this series because of this,
though; for now, I think it's fine as-is.
