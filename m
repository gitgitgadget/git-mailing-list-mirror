Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 433AE1F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 18:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388959AbfJOSXL (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 14:23:11 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:45334 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388941AbfJOSXL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 14:23:11 -0400
Received: by mail-vs1-f66.google.com with SMTP id e19so837361vsb.12
        for <git@vger.kernel.org>; Tue, 15 Oct 2019 11:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZpNEKMkA9wHFgolk0Qcmk+q6J+GipdYAcsHnUczgNik=;
        b=Q8SWg2XlWRS/gqWdLgsiEoiLwwkvIwkjy7byMaRilmKvcDRjUyPJh/niS7xQMyF2g2
         lFKB2tn7mTIdWmwfxHAtszzBf79At3YcMM58wh0k/pYq7+EAVMtC8/9RodLpGdErYil7
         3NPdGDE/qIawPwBsQ5YFKmvdlwA/vLb8pprDJWAhV17yqq2ko3TFrBLdhWnrRj7TCkqo
         QVZgldvpxclH00A3bK7cEWBJFq4sOEZEsxxAkjVwUuqmLxHsEp6OhqsTc1gsTxzvFP/8
         5yI/xXa1SPc3OgJJT02bczTMVGp/QGkIRahgZKOYW7wcXCyxrrePCadpVaKC0/pTKe/G
         d92w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZpNEKMkA9wHFgolk0Qcmk+q6J+GipdYAcsHnUczgNik=;
        b=XPic8+031YaC5/eiXmuhhfw2wkDaiL9ojgAj00uKN3imjj95AH/P7kjw/hSGCvOg58
         lPf9Cs8erTaUgjmMQKkZGdju7/KxbhuwR3qCUwkZ6dpZMsNVL1avytq4mTWemc0ov/jH
         M+ZYzq223Sre1UFG2AUjdUDkcDPf6Rosls9Gljl6Kcg0wKb2fwCrEwJrurjC2pFx+tSe
         duOPGiHkTzGFiz1z+TKIRizjYOFzk61lSlzS5r0ekbze5nGxpHs5QIuNsweZE9ZaMSyg
         mmooU3ObZNyXmZIU3v4FA+cCi8mOI126HPk2Bopc7TSun6nFSN3s+koP30q/5JyXchfV
         /0Cw==
X-Gm-Message-State: APjAAAXhSKOdCfxQAiIvK3fwz9aIIwXUsOMYdMaajwUMy8/oJJgCU21N
        TSyoEpyQcoKDKvCu+K6Gw17UNugxOXsYKUv8Acc=
X-Google-Smtp-Source: APXvYqxdeNdZYHpe+BnHuALX/XtpbARU6Cm+8XVG49qyGoPyHnti4cqLnnRCJkx9XTSqmINgmIhB0XtPbIMkP7Dw/As=
X-Received: by 2002:a67:b30c:: with SMTP id a12mr21227644vsm.175.1571163789819;
 Tue, 15 Oct 2019 11:23:09 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqh84abmjm.fsf@gitster-ct.c.googlers.com> <CABPp-BHnSG+PtnU=jKHW2_hfLtBK1Sib_W+nqY08gGj8yHGCgw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1910151938280.46@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1910151938280.46@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 15 Oct 2019 11:22:57 -0700
Message-ID: <CABPp-BG_NjU6PgPVpZisF_UbWQhQLDNtHo5uPGaHKwQYtce+Gg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Oct 2019, #04; Tue, 15)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 15, 2019 at 10:39 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Elijah,
>
> On Tue, 15 Oct 2019, Elijah Newren wrote:
>
> > On Tue, Oct 15, 2019 at 2:04 AM Junio C Hamano <gitster@pobox.com> wrote:
> > > * en/fast-imexport-nested-tags (2019-10-04) 8 commits
> > >   (merged to 'next' on 2019-10-07 at 3e75779e10)
> > >  + fast-export: handle nested tags
> > >  + t9350: add tests for tags of things other than a commit
> > >  + fast-export: allow user to request tags be marked with --mark-tags
> > >  + fast-export: add support for --import-marks-if-exists
> > >  + fast-import: add support for new 'alias' command
> > >  + fast-import: allow tags to be identified by mark labels
> > >  + fast-import: fix handling of deleted tags
> > >  + fast-export: fix exporting a tag and nothing else
> > >
> > >  Updates to fast-import/export.
> >
> > Thanks!
> >
> > > * en/merge-recursive-directory-rename-fixes (2019-10-12) 2 commits
> > >   (merged to 'next' on 2019-10-15 at ebfdc3ff7b)
> > >  + merge-recursive: fix merging a subdirectory into the root directory
> > >  + merge-recursive: clean up get_renamed_dir_portion()
> > >
> > >  A few glitches in the heuristic in merge-recursive to infer file
> > >  movements based on movements of other files in the same directory
> > >  have been corrected.
> > >
> > >  Will merge to 'master'.
> >
> > I'm surprised this one was merged straight down to next; perhaps I
> > should have highlighted my plans a bit clearer in the thread?  I did
> > mention (at the end of an email) at [1], that
> >
> > "Oh, and I think there's another place in the code that needs to be
> > tweaked to make sure we handle renaming subdirectories into the root
> > directory that I missed (and just wasn't tested by this testcase), so
> > I'll check into it and if so fix the code and add another testcase,
> > and include the fixups I agreed to above and send out a v2.  Probably
> > won't get to it until the middle of next week, though."
> >
> > So, I guess I'll submit a fixup patch on top instead, either later
> > today or tomorrow.
> >
> > Also, a very minor point but "glitches" may be misleading; it suggests
> > (to me at least) a malfunction rather than a failure to trigger, and
> > it's really only the special case of renaming/merging of a directory
> > into the root directory that the previous heuristics failed to detect.
> > The rest of the fixes were make-the-code-clearer (there were a couple
> > places in the code that were technically correct but quite misleading
> > and hard to reason about).
>
> I also offered several comments that the regression tests could be
> condensed into easier-to-understand ones.

Part of that was (obliquely) referenced in my above quote ("the fixups
I agreed to above"), and I was also going to respond to your follow up
and add a few more changes based on it.

I thought I'd be doing that while this series was still in pu, and
that this series would probably not make it into 2.24.0, but since
Junio quickly merged this down to next and says he plans to merge
down, I'm thinking right now it may make more sense to make a minimal
change to what he has merged down to get the functionality right, and
then start a new topic that addresses testcase restructuring overhauls
of t6042, t6043, and t6046 -- restructurings that we'll probably
continue to argue about but may be able to find some common ground on.

I'll respond in more detail on the testcase restructuring stuff in a
few days after I get a few other things out of the way.

> Ciao,
> Dscho
>
> > [1] https://public-inbox.org/git/CABPp-BFNCLJnt4NgFKVxURBGD1Z00gastc5q4ZPjcHmwS=kuFw@mail.gmail.com/
> >
