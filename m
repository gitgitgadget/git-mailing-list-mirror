Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54DF71F424
	for <e@80x24.org>; Thu, 12 Apr 2018 09:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751832AbeDLJa6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Apr 2018 05:30:58 -0400
Received: from mout.gmx.net ([212.227.15.15]:58727 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750780AbeDLJa5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Apr 2018 05:30:57 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LwaQZ-1eP1bc0GVz-018GUa; Thu, 12
 Apr 2018 11:30:47 +0200
Date:   Thu, 12 Apr 2018 11:30:29 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>
Subject: Re: [PATCH v6 15/15] rebase -i --rebase-merges: add a section to
 the man page
In-Reply-To: <26c21a44-92b3-80f4-5211-034c64f7568c@talktalk.net>
Message-ID: <nycvar.QRO.7.76.6.1804121102260.65@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1519680483.git.johannes.schindelin@gmx.de> <cover.1523362469.git.johannes.schindelin@gmx.de> <a162afa761e3000eb60169fce7a50938888f80b4.1523362469.git.johannes.schindelin@gmx.de> <26c21a44-92b3-80f4-5211-034c64f7568c@talktalk.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:f0laDDKL0Yo/MRKZZWO/9yZ8sPpgzH+stGteXv5v4bs/CMplzH+
 B1gKYBqejvX6UwPiTfFEFiRKCwZi4nSbNH0RvyZPwJOeiin/pgcitv+o61h0nNfWS2ScLVR
 35/zWiT+20gnieZ53UMBetxb2f7R/wPF1oRxHnu5xEV9aBWw5h4vuiUu8SY6QqjDbVuqN7l
 QCj8eSsjRUmthIDGx917A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QRSOYXND9BA=:1vofO5Qc8Fx+plPmIxuVVH
 UiJp2vFir0XJpxc/zAZLD4UfS375tMIjr1Mp4kSiFdL8tkQzy+5H3HgstS6tAkRE+wGDxf/ea
 nyl4kcKDUqWLjZa0V9H0NdsfR/7dGzPRCSllY+86yr+qzpyWfNlv6Mie6lxbGMmjwCKUzlohM
 sDcho+sTT2m67xvWz0fhXLNgDTakP3hI2mPzTa54TYFTYmmglK08MKr7++rqICP2gGypRAs+A
 lC0TIBmD1yWxcHwuvzPzGK1Cnxke/MNH0HhGYnKyQ78g1yLJtBVJp5NV6wCgvgUWaxKXa4Nnx
 Q097iVmiIqrtdzhkBegcq67SAkSkBHaJEjfog5aBgukxXGK87WTrjZpduuO2BL0z0M2BAs9qw
 iFuw2CIqfU9GRaBPb/kOKSkjIDgfO6VQWYN3UlmHxmAA7RqiJi0aoaScg/r5bQN4FkqPo1/h1
 0iCKa+yZh6XYPzJL+cthz+Q0gMHhHTBdyEiG07OIIWgVd7gs0LYQPDl7LwWvSMv4JrvEY95eG
 +mdjyGiTUXPb/+F2ZL+j3Q+Zvjp1LQQspjaVnvH1DpW8bFXzWTq46fNgEOtN0qOFeU3ek/Dxq
 5tXAmH0ElNjdpbT8Sn562/FH5JMwGp/Lw2Hoe7nzhUFQ6rahisxJTOUUz58iijceaVNBkOWYY
 SUhuGi+4OdW4N6UwPCffiYL4zbogBIDjPwBInO9ut+/iW4eUsle46miB3lNU2iFRwMc9X+OVd
 g08Xp7pKT07wd40yD2tyGy5sQ6nPB1bnVb/jkmXo5JGWQZqxEDlDE5EPBB+kCdkgGkQMMo+1K
 +Sp8qBLwnUKlYoGCxHQi4XK8V/wBXKMJ/AzF9Zt0vrP7y2FnEc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Wed, 11 Apr 2018, Phillip Wood wrote:

> On 10/04/18 13:30, Johannes Schindelin wrote:
> 
> Firstly let me say that I think expanding the documentation and having an
> example is an excellent idea.

Thanks! At first, I meant to leave this for others to contribute, but I
think it makes sense for me to describe it, as I do have a little bit of
experience with rebasing merges.

> > +
> > +------------
> > +label onto
> > +
> > +# Branch: refactor-button
> > +reset onto
> > +pick 123456 Extract a generic Button class from the DownloadButton one
> > +pick 654321 Use the Button class for all buttons
> > +label refactor-button
> > +
> > +# Branch: report-a-bug
> > +reset refactor-button # Use the Button class for all buttons
> > +pick abcdef Add the feedback button
> > +label report-a-bug
> > +
> > +reset onto
> > +merge -C a1b2c3 refactor-button # Merge 'refactor-button'
> > +merge -C 6f5e4d report-a-bug # Merge 'report-a-bug'
> > +------------
> > +
> > +In contrast to a regular interactive rebase, there are `label`, `reset` and
> > +`merge` commands in addition to `pick` ones.
> > +
> > +The `label` command puts a label to whatever will be the current
> 
> s/puts a label to/associates a label with/ would be clearer I think. Maybe
> s/whatever will be the current revision/the current HEAD/ an well?

Thanks, I incorporated both changes here.

> > +revision when that command is executed. Internally, these labels are
> > +worktree-local refs that will be deleted when the rebase finishes or
> > +when it is aborted.
> 
> I agree they should be deleted when the rebase is aborted but I cannot see any
> changes to git-rebase.sh to make that happen. I think they should also be
> deleted by 'rebase --quit'.

Oh right! For some reason I thought I already hooked up rebase--helper
--abort when rebase was called with --abort or quit, but I had not managed
yet. I think I will leave this for later, or for GSoC, or something.

In the meantime, I'll just drop the "or when it is aborted.".

> > That way, rebase operations in multiple worktrees
> > +linked to the same repository do not interfere with one another.
> > +
> > +The `reset` command is essentially a `git reset --hard` to the specified
> > +revision (typically a previously-labeled one).
> 
> s/labeled/labelled/

As Eric pointed out, I am using 'murricane spelling here (or is it
speling? Ya never know these days).

> I think it would be worthwhile to point out that unlike the other commands
> this will not preserve untracked files. Maybe something like
> "Note that unlike the `pick` or `merge` commands or initial checkout when the
> rebase starts the `reset` command will overwrite any untracked files."

You know what? You just pointed out a bug in my thinking. Previously, I
thought that this is impossible, that you cannot overwrite untracked files
because we labeled this revision previously, so the only new files to
write by `reset` were tracked files previous. But that forgets `exec` and
`reset` with unlabeled revisions (e.g. for cousins).

So I changed the `reset` command to refuse overwriting untracked files...

Thank you for improving this patch series!
Dscho
