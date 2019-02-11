Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48E2B1F453
	for <e@80x24.org>; Mon, 11 Feb 2019 22:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbfBKWSb (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 17:18:31 -0500
Received: from mail-wr1-f46.google.com ([209.85.221.46]:38425 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbfBKWSb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 17:18:31 -0500
Received: by mail-wr1-f46.google.com with SMTP id v13so532198wrw.5
        for <git@vger.kernel.org>; Mon, 11 Feb 2019 14:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PhiX5ujnMFuvGZgac7bqPtY7FuTF11gue9tYs9llr0Q=;
        b=bTqIH/jRyABhi+1TB7czVMK+/G0D/kuCRG/yokwhZ6OHKSABj14EmnOE0Mr0PR1p/p
         kYK+pF3yEpNxu4jQDmktOdDqIn0axWEYSHo8C0Oe0TiRfL8LMcLXwFx5+o/pvAtsAcdR
         d8xln/79nocbRPRZDwP2fPAffeGFjdWM4fUVwMlXsSt+gIulwsBUbHlDRl0MniTt6pbz
         rompRzgvhECy0+9lmnhroWcaI7QFfVsiGtd4BYwl/opKhzws5EGcVIYrNnrE6+TMcFoz
         G4Seom1FpNqcuLWUvCoaHp31r9puPb3jAKR9v1RQVNRyQMrMnwNRhN+qrWHzqhZPBTD1
         x57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PhiX5ujnMFuvGZgac7bqPtY7FuTF11gue9tYs9llr0Q=;
        b=rSZX6UBTasV+3DYKzTUtztCOXJdZXsbuN34Dec/MjHyyzSESw/VVXiaFV0jcGL7LE5
         ItcQHT6MtCR0ezSyRtvaEydZc6C9lgi0nn3jahTnBHvJutkPzxgVnV5KeNR/hrOH6sUx
         yBNdzGyN5XhCfVtS+6VE8hT3dg+YGTyGyWvmoE4pegzG+CKRnNIHq794ug3KTCaM+0pn
         +pgpvOMqANQidP4dAim0fZPK5opSgjEegiZ5c88cKSoSLoidAqB7nLqn8rcpXMxcC5a2
         1yVMMFMHmB84nOBds4PuZQQBZwiHsuwOJGErcxeMjMLVt+L0d3oG7mXZ1olN1Q+rIrZY
         SRCg==
X-Gm-Message-State: AHQUAuaau66KzcYNEeWnpsNQ/8ioRVFI7qBhLi9mYWJ6rEWYezdfxv2O
        +LlDEPOCofDrj9WDD2U7zr8=
X-Google-Smtp-Source: AHgI3IZaqTTy/FP9cwQkhWtBqmZRzNga4qaHOdUxF4jNttnhW0ysGYg0dbOQpWA9Uzp83gjsaDoR8A==
X-Received: by 2002:a5d:4349:: with SMTP id u9mr313529wrr.223.1549923509286;
        Mon, 11 Feb 2019 14:18:29 -0800 (PST)
Received: from localhost ([95.149.189.205])
        by smtp.gmail.com with ESMTPSA id r22sm892657wmh.2.2019.02.11.14.18.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 14:18:28 -0800 (PST)
Date:   Mon, 11 Feb 2019 22:18:27 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Matthieu Moy <Matthieu.Moy@gmail.com>
Subject: Re: GSoC 2019: Git's application submitted
Message-ID: <20190211221827.GG6085@hank.intra.tgummerer.com>
References: <CAP8UFD2kt=Rv4pC67q0s+CKjgmBON_KkK09igfwe-0709Di2RQ@mail.gmail.com>
 <20190204215251.GB6085@hank.intra.tgummerer.com>
 <20190205211736.GD6085@hank.intra.tgummerer.com>
 <CAP8UFD0bFWvXyQYb=EQ7QCPD_Va7CXEueEEtrETuEVO3n2X35g@mail.gmail.com>
 <20190206220942.GE6085@hank.intra.tgummerer.com>
 <nycvar.QRO.7.76.6.1902072023250.41@tvgsbejvaqbjf.bet>
 <20190207213326.GF6085@hank.intra.tgummerer.com>
 <CAP8UFD1Rv+nFqDYf33rRw-kWnfqokSG6=tG8XPFyBoVCU6Te=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP8UFD1Rv+nFqDYf33rRw-kWnfqokSG6=tG8XPFyBoVCU6Te=w@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/11, Christian Couder wrote:
> On Thu, Feb 7, 2019 at 10:33 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
> >
> > On 02/07, Johannes Schindelin wrote:
> > > On Wed, 6 Feb 2019, Thomas Gummerer wrote:
> > > >  - implement pushing/poping conflicted state
> > > >
> > > >    This would obviously be the end goal.
> > >
> > > On second thought, this might actually be super trivial. Right now, we
> > > support two modes (not counting the `--untracked` stuff): --keep-index and
> > > --no-keep-index. In both cases, we seem to create a merge commit whose
> > > tree reflects the working directory and whose first parent is HEAD and
> > > whose second parent is a single commit on top of HEAD (which contains
> > > either no changes in the case of --no-keep-index, or whose tree reflects
> > > the index in case of --keep-index).
> > >
> > > To extend that to the conflict case, we could introduce a new flag
> > > --with-conflicts, and have the commit structure
> > >
> > >       Worktree
> > >        |    \
> > >        |    index stage 0
> > >        |      /     |     \
> > >        | stage 1  stage 2  stage 3
> > >        |    /     /       /
> > >       HEAD ---------------
> > >
> > > The only tricky thing I can see is to maintain backwards compatibility if
> > > possible, so that old `git stash` will do something at least semi-sensible
> > > with those commit structures.
> > >
> > > It might be too small a project, after all.
> >
> > Yeah, looking at this I think you're right.  Thanks for helping work
> > through this.
> 
> I am not sure it will be too small a project, especially because it is
> a new feature. On top of the coding part, the student will also have
> to come up with good documentation and test cases, and there will
> probably be naming and workflow discussions and possibly refactoring
> opportunities and bug fixes along the way.

I still think it's on the smaller side, but also as you mention below
we have usually been rather optimistic about project sizes.  So maybe
this is the right size for a GSoC after all.

> Yeah, the naming and workflow discussions should actually happen when
> discussing the student's proposal, in which case an important part of
> the work will (hopefully) be done before the GSoC actually starts.
> 
> Historically though we have always been very optimistic in what we
> thought a student could accomplish in a GSoC. And we are very likely
> to find more ideas for improvements during the GSoC, in case
> everything is "finished" before the end. I actually think that it has
> never happened that a student both "finished" the project before the
> end, and that no idea for improvement on top of the work was found.

Fair enough.  I think there's still a number of things that could do
with some refactoring in 'builtin/stash.c', e.g. use more of the
libgit.a API, instead of using the run_command API, or potentially
other improvements that could be made.

Another thing that may be useful to do is to write down some actual
technical documentation on the format of what a stash commit looks
like.

> I have added a "Note about refactoring projects versus projects that
> implement new features" at the end of the idea list:
> 
> https://github.com/git/git.github.io/blob/master/SoC-2019-Ideas.md#note-about-refactoring-projects-versus-projects-that-implement-new-features
> 
> and I think that with that note students working on such projects will
> be warned enough, and therefore hopefully have a better chance of
> success.
>
> So after all if you are willing to co-mentor such a project, I would
> be ok to co-mentor it with you, and we should add it to the list.

Ok, I'll submit a PR to add it to the list.

> Thanks,
> Christian.
> 
> And yeah it would help improve our idea list as requested by Google.
