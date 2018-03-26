Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E21121F404
	for <e@80x24.org>; Mon, 26 Mar 2018 22:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752219AbeCZWAU (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 18:00:20 -0400
Received: from mout.gmx.net ([212.227.17.20]:50267 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752180AbeCZWAS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 18:00:18 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lwnem-1eTcxy3W6S-016Rba; Tue, 27
 Mar 2018 00:00:14 +0200
Date:   Tue, 27 Mar 2018 00:00:14 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Jacob Keller <jacob.keller@gmail.com>
cc:     Wink Saville <wink@saville.com>, Git List <git@vger.kernel.org>
Subject: Re: Should I try to fix rebase interactive preserve-merges bug
In-Reply-To: <CA+P7+xqqLU-J5hv=yioMxMvp40hz_S9GfimjE7bp1Pj_TP-k3w@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1803262348080.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <CAKk8isqvfhiMPCdNBW5WNN4BfN1sLszekQscpy5M2Okh2YmbZg@mail.gmail.com> <CA+P7+xqqLU-J5hv=yioMxMvp40hz_S9GfimjE7bp1Pj_TP-k3w@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:qqePPRj4ChCEoNxjgNIz/iWSnySNwU2ZJ/FNMlAuiCeLsp/Z7nt
 MHBS5E7bcIASjrW3pK3GoBb3u97xtlZVOQeYqZUD739aKtDlUepptcwGr/QOF13wEMmiqzh
 U/Yhjyw8NFCq42e4HestILLX1xuPVTPNkTLiHUvDL2tpVNFBTTCWVFBdcutlI497KyFs5yF
 Bywmvv7P/owCD9by4gSGA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FoV6DUyr4AU=:Qo+S+yL03bB8Id8VX0SaZE
 U2rgsS0ixT13J+nHBjRJUB4oioXYoDRswSjPxwMA6wLIFSVsHdNgUlKWmfs6CwUTDJlu0VfcQ
 sHaf7R/ke0tJxlpT/U+oc7r/FylsiNT4e7ybkTKHk/iSHgQyOTFwdeOg5Du/EJ9eybKk3sAjc
 MCRkozUQ3J8uJFxvjfoC8wdpZv4BI44OLH7MlkRn5+UpLpJjSWktrBce0S+PmC/2dFzJGbOMv
 hMPN/i1cPsxBGtzz/Czv7eYw9tISit1exyJ0eI6+QwGJ/H4aS5U6DqjLLpgETDGLHZNuqgkq7
 hhTAxOS8EgMVnt37NGfonw+gGOwJ567dtYDIPcxNkT/lqdmNIrfYb7lpSdRRzmqRH1HiyNzC+
 d1A2tiDVR1yGwYw247tLE816U/GfvQ49nBvNW3Xc7uP3LzklB3JHVYQjJw2MOLKBEMMFE9Qsj
 rP8NjwG7ZnoiDOlBsmCJ1yCg9jOlKezRbkRPCftVJ+1cOH+npLAGnNj32/LHYgltdFJjNOh4z
 fQ52ex2vMUXEN85gi7Aw1ZNG2AAmd0972Pd4eWnlfVOru2X8CorzUUjHNo46+EXA+nc65PNMN
 U5Bbs9NoE1ZONru1So4Hm/yp0EN07LLVahhpvf/bpHeHpf1D/WsFmsUIWkfJ5YeprOZ5WrZfn
 XNXYuOwJF1l0jccrPbmsxog6AuT1wsFTpuHW4rLcA2kG9YFUBxobQvVFz67nG+d+Z4l5FpZ9c
 N8lyinQuvMGT0RlWeZLWF80+LyVFuI7aWfUWpUef4thpdRinxivwDs2wdhltPVV9kS1MMrpW5
 K4mGAASe/xviCfsAQRJrhGp4G3V/9vmX//y47SqTlZgKuaMUgHN/ME99UiwgH0CNxGUgU4B
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jake & Wink,

On Sun, 25 Mar 2018, Jacob Keller wrote:

> On Sun, Mar 25, 2018 at 10:32 AM, Wink Saville <wink@saville.com> wrote:
> > There is a "TODO known breakage" in t3404-rebase-interactve.sh:
> >
> >    not ok 24 - exchange two commits with -p # TODO known breakage
> >
> > I'm contemplating trying to fix it. But with --recreate-merges coming
> > maybe it's not worth the effort. Should I proceed with attempting a
> > fix or is --preserve-merges going to be a synonym for
> > --recreate-merges?
> 
> AFAIK this breakage of preserve-merges is a design flaw which isn't
> really fixable, which is why --recreate-merges is being added.
> 
> I believe the plan is to deprecate preserve-merges once
> recreate-merges has landed.

Indeed, my plan is to deprecate preserve-merges once recreate-merges
landed and proved robust.

The problem with the `pick` overloading in preserve-merges is many-fold:

- `pick` is used for merge commits, too. Therefore, the parents of the
  picked commits are *implicit*: a rebased commit will always have the
  rebased parents (or the original parents, for commits that were not
  (yet) rebased).

  The only way to fix this would be to break the current syntax, and
  thereby break existing users' scripts. (I know of a few users, and I
  know better than assuming that there are no power users out there
  scripting *everything* on top of Git, as I am such a power user
  myself).

- One might be tempted to special-case that implicit parent-keeping for
  the cases where merge commits are picked, and respect order for
  non-merge commits.

  However, *nothing* in the todo list (apart from the commit messages,
  which can easily be edited however) indicates whether a `pick` has a
  merge or a non-merge commit as parameter. That makes this "solution" a
  highly unintuive and inconsistent one.

- Even worse: if you ever found yourself editing long-ish todo lists in an
  alternative of preserve-merges (such as Git for Windows' garden shears
  [*1*]), you will know that it is *important* to know when you cross a
  merge commit line. Reordering within a linear list of non-merge commits
  is relatively safe. Moving a `pick` across a merge commit line is
  definitely causing a lot of grief, generally speaking.

  In short: my hard-won experience tells me that a todo list *needs* a
  visual cue that lets users tell apart the sequences of non-merge commits
  from the merge commit lines.

So there is more than just a technical problem with the design of the
preserve-merges feature. Its UI is fundamentally broken.

Which makes sense, as I intended preserve-merges to be non-interactive
only, and there was a single reason why it was piggy-backed on top of the
interactive rebase: this was the easiest way to implement that feature. I
was never a fan of enabling -p with -i, and I am fairly certain that I
warned against this. Turns out I was right. Strange, I know.

Ciao,
Johannes

Footnote *1*:
https://github.com/git-for-windows/build-extra/blob/master/shears.sh
