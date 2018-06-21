Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F26F1F516
	for <e@80x24.org>; Thu, 21 Jun 2018 10:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754538AbeFUK53 (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 06:57:29 -0400
Received: from mout.gmx.net ([212.227.17.22]:51575 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754501AbeFUK5Z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 06:57:25 -0400
Received: from [192.168.0.129] ([37.201.195.106]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MSuYT-1ffgCp0K4T-00RmkJ; Thu, 21
 Jun 2018 12:57:18 +0200
Date:   Thu, 21 Jun 2018 12:57:28 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: Re: [RFC PATCH 3/3] git-rebase.sh: make git-rebase--interactive the
 default
In-Reply-To: <CABPp-BEnJ4q9WGi4BgikpLJ9Aty5-3MR4VozjBk7ie4rGMc-ng@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1806211242440.11870@tvgsbejvaqbjf.bet>
References: <CABPp-BGxaroePB6aKWAkZeADLB7VE3y1CPy2RyNwpn=+C01g3A@mail.gmail.com> <20180607171344.23331-1-newren@gmail.com> <20180607171344.23331-4-newren@gmail.com> <nycvar.QRO.7.76.6.1806100006000.77@tvgsbejvaqbjf.bet> <CABPp-BHa+sxuFBa3EmSyio28ytF_ORn950Keh1P=L-VxXtOwMw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1806172337340.77@tvgsbejvaqbjf.bet> <CABPp-BEnJ4q9WGi4BgikpLJ9Aty5-3MR4VozjBk7ie4rGMc-ng@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Gh7eD7/lwd3+DjQClQxoVrsOHghw9UaIPEU4k5b5+JvoaFcOu8T
 qkPcdPalPprsJ1FNz2JmxwTxor2onytJWWX9WOTUCdyJceqcsDvg36IEf7SMgT4AWW45Q4f
 9T8Z5f28QxPJ0HUgiuvn//OV+zJvGRnuJBUbKmsW/vYuFXR2yEDv7fqxFJo0exfhsXl9AoG
 1IZQ7bLQiuuVFgKuUA6Uw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3qNIoVkiXJA=:+icII8RHyOoIBTBG9Ghrh8
 cvlnco4OZwDKDRhHa1Qwo7NqOQg8dUgxT8BnJ1AZwCgd9+YuTyDZmLdsWK7WKkJ53x/fdoBC3
 DGy1GA70OxI4d8ENDaxgKN1ZlpQmzaTmdvlLXHK+O9L89fqWNecxYOBTn1zFDq9Kfq9P2XLbh
 D02SC87aB6Z2zCOVj2hVPXtMTxMzOFqodPWnYCWE23DvROwAS+LktaWOMNcLEmYPDa2K1/OFY
 mufn70t1ySTpm5KaWf35MaEh5vj3Ca+GpeSQ2bCt40J+u3gr6xof6wdGzPv645UnsR8HE8qzg
 EynR0V4RQwt2N88r597N36kIFyO0UGp4oG64bSqBEYxXJ6aH1K/Rxh6dJnDqE42iYfjRm0HZ+
 +2jsjh84wyC8+PVC62n1bkLQ/8sLfliNou+YwaPzy3Y9U78mwK9Pm+ag+YZEwEWq6kiXMY0o5
 GOFbRcXihEWLzIMhbsndiggpMWa57VDEg2gcjC/Zt1gVYJHw4ThjQG7iwpYZqn81EiO+Dd5FE
 R0OsDEdnZ7q5zbApgJx+iqQm23sUGmh3Df6ZQsQkfQSWHtioz53TuR/5ZFT6nhq1EVYT8yoE9
 JoDKYWBALEDyF88RKMB8/sW3MZn3e4jrGBPCO5zEHmtb90rW+92XZgDJUGPUPWfCjiO87wZpR
 pMEis2jap8TuAUV6yfTH/NiJ2Fp5jpXw9VPeQ0iEuNdX4kfk5D1OFa9Ey0mztQSafMPvAuoOO
 7iMugoJpLejxmSUOD3wQYQ8jpzwMWh6ym8Y3M+0VTWJXIyxnIZEPIgCTKT3ZYeVIrUZLf1l9C
 F/jw/jL
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Wed, 20 Jun 2018, Elijah Newren wrote:

> On Sun, Jun 17, 2018 at 2:44 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> 
> > I was really referring to speed. But I have to admit that I do not have
> > any current numbers.
> >
> > Another issue just hit me, though: rebase --am does not need to look at as
> > many Git objects as rebase --merge or rebase -i. Therefore, GVFS users
> > will still want to use --am wherever possible, to avoid "hydrating"
> > many objects during their rebase.
> 
> What is it that makes rebase --am need fewer Git objects than rebase
> --merge or rebase -i?

Multiple things. The most obvious thing: --cherry-pick. When you call `git
rebase --am`, it does not try to exclude the patches by looking at
`rev-list --cherry-pick --right-only <upstream>..<head>`

This really bit us in GVFS Git because we have several thousand developers
working on the same code base, and you probably read the numbers elsewhere
how many commits are introduced while a developer goes on so much as a
week-long vacation.

Next, rename detection.

I think that bit us even harder because it tries to look at all the files
that have been changed in upstream in the meantime, which can be *a lot*.
And if you know that moving files outside of your cozy little sparse
checkout is unlikely (or moving from the outside into your checkout), then
all this hydration is pretty wasteful. That's why we had to switch off
rename detection in GVFS Git.

> My guess at what objects are needed by each type:
> 
> At a high level, rebase --am for each commit will need to compare the
> commit to its parent to generate a diff (which thus involves walking
> over the objects in both the commit and its parent, though it should
> be able to skip over subtrees that are equal), and then will need to
> look at all the objects in the target commit on which it needs to
> apply the patch (in order to properly fill the index for a starting
> point, and used later when creating a new commit).

No, in --am mode, it does not even need to look at all the objects in the
target commits. Only those objects that correspond to the files that are
touched by the diff.

In a massive code base, such as Windows', this makes a huge difference.
Even comparing the number of files touched by the patches that are to be
rebased to the number of files that were touched in upstream since you
rebased last is ridiculous. And a three-way merge needs to consider that
latter set of files.

> If the application of the diff fails, it falls back to a three-way
> merge, though the three-way merge shouldn't need any additional objects.

The three-way merge needs to reconcile the diff between branch point and
your changes to the diff between branch point and upstream's changes. The
latter can be a lot bigger than the former, in which case --am's
complexity (O(former)) is much nicer than --merge's (O(former u latter)).

> So, to summarize, rebase--am needs objects from the commit being
> rebased, its parent, and the target commit onto which it is applying,
> though it can short circuit some objects when the commit and its parent
> have matching subtree(s).
> 
> rebase -i, if I understand correctly, does a three-way merge between
> the commit, its parent, and the target commit.  Thus, we again walk
> over objects in those three commits; I think unpack_trees() does not
> take advantage of matching trees to avoid descending into subtrees,
> but if so that's an optimization that we may be able to implement
> (though it would require diving into unpack_trees() code, which is
> never easy...).
> 
> (Side notes: (1) rebase --merge is basically the same as rebase -i
> here; it's path to reaching the recursive merge machinery is a bit
> different but the resulting arguments are the same; (2) a real merge
> between branches would require more objects because it would have to
> do some revision walking to find a merge base, and a real merge base
> is likely to differ more than just the parent commit.  But finding
> merge bases isn't relevant to rebase -m or rebase -i)
> 
> Is there something else I'm missing that fundamentally makes rebase -i
> need more objects?
> 
> > As to speed: that might be harder. But then, the performance might already
> > be good enough. I do not have numbers (nor the time to generate them) to
> > back up my hunch that --am is substantially faster than --merge.
> 
> I too have a hunch that --am is faster than --merge, on big enough
> repos or repos with enough renames.  I can partially back it up with
> an indirect number: at [1], it was reported that cherry-picks could be
> sped up by a factor of 20-30 on some repos with lots of renames.  I
> believe there are other performance improvements possible too, for the
> --merge or -i cases.
> 
> I'm also curious now whether your comment on hydrating objects might
> uncover additional areas where performance improvements could be made
> for non-am-based rebases of large-enough repos.
> 
> Elijah
> 
> [1] https://public-inbox.org/git/CABPp-BH4LLzeJjE5cvwWQJ8xTj3m9oC-41Tu8BM8c7R0gQTjWw@mail.gmail.com/
> (see also Peter's last reply in that thread, and compare to his first
> post)

I am too unfamiliar with the rename detection to understand the details,
but you are familiar with it, so I trust your judgement!

Ciao,
Dscho
