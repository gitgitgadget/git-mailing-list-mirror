Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 909FD1F403
	for <e@80x24.org>; Sun, 17 Jun 2018 21:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752659AbeFQVoQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Jun 2018 17:44:16 -0400
Received: from mout.gmx.net ([212.227.17.22]:39687 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752100AbeFQVoP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jun 2018 17:44:15 -0400
Received: from [192.168.0.129] ([37.201.195.106]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MY75A-1fhod709ke-00UpA8; Sun, 17
 Jun 2018 23:44:09 +0200
Date:   Sun, 17 Jun 2018 23:44:16 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: Re: [RFC PATCH 3/3] git-rebase.sh: make git-rebase--interactive the
 default
In-Reply-To: <CABPp-BHa+sxuFBa3EmSyio28ytF_ORn950Keh1P=L-VxXtOwMw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1806172337340.77@tvgsbejvaqbjf.bet>
References: <CABPp-BGxaroePB6aKWAkZeADLB7VE3y1CPy2RyNwpn=+C01g3A@mail.gmail.com> <20180607171344.23331-1-newren@gmail.com> <20180607171344.23331-4-newren@gmail.com> <nycvar.QRO.7.76.6.1806100006000.77@tvgsbejvaqbjf.bet>
 <CABPp-BHa+sxuFBa3EmSyio28ytF_ORn950Keh1P=L-VxXtOwMw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:mYNRrxG/9r7WQTgyBqvJnFwFUDzELEn9vqj0shRX2VZDVRz/Hzk
 Ii4pykvorAWtEVZKsfBc2lWVfobAnUMteQx0OkPB20ZOKTyN7M5aVSz5xCvJP8v46TOC77b
 9UO3/quNhKVMr06Ya5ZZH/9U0LUpI6f0v/XaILP8lh/HF0b/KFGr9L/CSfBJlK5nk49tMuo
 TZsv5aoTgaSjKin997kbQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:67FALdMJcXg=:6XsrCYXML3W1lRNXO6+yke
 hqcSZmjhBJlmIy9cNkAlXP1BmkTqoW6zvNlZR3Uqt2EY2aSyMj9Gt8W9MikZg9+X19jvzkbCh
 H5irLFIrd361yR6MgfxKZOLBXNCxdKtwZn2T4xxqBwVEQYb2tN86K5WhjrTu5i4Y+WY8KX2fX
 2MOtYrqeH/xt+kkXnsZe/8xZ4WClrjuXXrm53rLrqAAsWHsXxU9n1LhKTbKTZefedoRRByEQ4
 ijIoZpT0NHVGfKAcTM79ji05yECQKcfSW+gZ9te9G/2w1zDVWJyKpDM1UkzdXTBhiDq02VwCF
 482xYuSrKk9qp9qVRngeKSIgcQqQu7aH1mO2O3uzJE67iCwRTOxqc4Ns2DuOTPSoo6B3IepmS
 /pFhL0csNdQ4eNuFs3JAMjk2uMb5wszjDu+AVP/eRdBuhw7n10zjpaS/O9Sn2L0aTTLe5GpYX
 mX9V2j49mvCuPiGGBLurbdBqtOlWggTfA+v9vPJLbpycG+RkHru4gw4YbBO4nVJgpCWY7e7Xs
 QUTV0+bddQepWkb4SF0YHKaVdz1lUC4cYMlP1N58MgP0ZSG8+clkOq3PFRLDtDpK5tbf/J/u0
 p4HsN7xLSTWIUJ/k8P4Sq5UbizqZ8fx5bM0fKMk7LgAliCgS91qGR0rfhS9Ftakt2NqRE9b23
 ceCOQ0KSUbkNpnWcM8PZwhowcYMrolkuJOUwA3DLVNROtXCVVLjSZwKWe5DQNgetS7yZgUPqa
 SqbshalpxLsLWSskKdvFQl7/hXkpGmwEmm86KHyOB6sWuvLOeK425zo39aftONFHnJr7JMqUw
 +xVCL2C
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Sat, 9 Jun 2018, Elijah Newren wrote:

> On Sat, Jun 9, 2018 at 3:11 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > On Thu, 7 Jun 2018, Elijah Newren wrote:
> >
> >> am-based rebases suffer from an reduced ability to detect directory
> >> renames upstream, which is fundamental to the fact that it throws
> >> away information about the history: in particular, it dispenses with
> >> the original commits involved by turning them into patches, and
> >> without the knowledge of the original commits we cannot determine a
> >> proper merge base.
> >>
> >> The am-based rebase will proceed by first trying git-apply, and, only
> >> if it fails, will try to reconstruct a provisional merge base using
> >> build_fake_ancestor().  This fake ancestor will ONLY contain the
> >> files modified in the patch; without the full list of files in the
> >> real merge base, renames of any missing files cannot be detected.
> >> Directory rename detection works by looking at individual file
> >> renames and deducing when a full directory has been renamed.
> >>
> >> Trying to modify build_fake_ancestor() to instead create a merge base
> >> that includes common file information by looking for a commit that
> >> contained all the same blobs as the pre-image of the patch would
> >> require a very expensive search through history, may find the wrong
> >> commit, and outside of rebase may not find any commit that matches.
> >>
> >> But we had all the relevant information to start.  So, instead of
> >> attempting to fix am which just doesn't have the relevant
> >> information, instead note its strength and weaknesses, and change the
> >> default rebase machinery to interactive since it does not suffer from
> >> the same problems.
> >
> > I'll let Eric comment on the grammar, and I'll comment on the idea
> > behind this commit instead.
> 
> Going to dump the hard job on Eric, eh?  ;-)

Just trying to learn how to delegate.

:0)

> > IMHO `git rebase -i` is still too slow to be a true replacement for
> > `git rebase --am` for the cases where it serves the user well. Maybe
> > we should work on making `rebase -i` faster, first?
> 
> That sounds fair.
> 
> > I imagine, for example, that it might make *tons* of sense to avoid
> > writing out the index and worktree files all the time. That was
> > necessary in the shell script version because if the ridiculous
> > limitations we subjected ourselves to, such as: no object-oriented
> > state worth mentioning, only string-based processing, etc. But we
> > could now start to do everything in memory (*maybe* write out the new
> > blob/tree/commit objects immediately, but maybe not) until the time
> > when we either have succeeded in the rebase, or when there was a
> > problem and we have to exit with an error. And only then write the
> > files and the index.
> 
> Hmm...are you still planning on using cherry-pick (internally rather
> than forking, of course)?

The sequencer side-steps the cherry-pick command by calling
merge_recursive() directly. But yes, this is what the interactive rebase
will always use.

>  Because cherry-pick uses the merge-recursive machinery, and the
>  merge-recursive machinery doesn't have a nice way of avoiding writing
>  to the working tree or index.

Exactly. I think it could be taught to perform its magic in memory. I am
not saying that it is necessarily easy to teach merge-recursive.c this
trick, but it should be possible.

> Fixing that is on my radar; see the first block of
> https://public-inbox.org/git/CABPp-BG2fZHm3s-yrzxyGj3Eh+O7_LHLz5pgstHhG2drigSyRA@mail.gmail.com/

Great!

> (reading up until "At this point, I'd rather just fix the design flaw
> rather than complicate the code further.")
> 
> However, also covered in my plans is a few things to speed up the
> merge-recursive machinery, which should provide some other performance
> benefits for interactive rebases.

I am looking forward to see this materialize.

> > In any case, I think that the rather noticeable change of the default
> > would probably necessitate a deprecation phase.
> 
> Why is it a "rather noticable change of the default"?

I was really referring to speed. But I have to admit that I do not have
any current numbers.

Another issue just hit me, though: rebase --am does not need to look at as
many Git objects as rebase --merge or rebase -i. Therefore, GVFS users
will still want to use --am wherever possible, to avoid "hydrating"
many objects during their rebase.

> If we popped up the editor and asked the user to edit the list of
> options, I'd agree, or if folks thought that it was significantly slower
> by a big enough margin (though you already suggested waiting and making
> sure we don't do that).  What else remains that qualifies?
> 
> (Okay, the default behavior to just skip empty patches rather than halt
> the rebase and ask the user to advise is different, but we could fix
> that up too.  Is there anything else?)

That is indeed a change in behavior that is rather easy to address.

As to speed: that might be harder. But then, the performance might already
be good enough. I do not have numbers (nor the time to generate them) to
back up my hunch that --am is substantially faster than --merge.

Ciao,
Dscho
