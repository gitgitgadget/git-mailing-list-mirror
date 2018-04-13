Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED90F1F404
	for <e@80x24.org>; Fri, 13 Apr 2018 12:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754246AbeDMMJe (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Apr 2018 08:09:34 -0400
Received: from mout.gmx.net ([212.227.15.15]:50209 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754086AbeDMMJd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Apr 2018 08:09:33 -0400
Received: from [192.168.0.129] ([37.201.203.18]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lj1jy-1ebSij2QLW-00dJM3; Fri, 13
 Apr 2018 14:09:23 +0200
Date:   Fri, 13 Apr 2018 14:08:26 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Jacob Keller <jacob.keller@gmail.com>
cc:     Sergey Organov <sorganov@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v6 00/15] rebase -i: offer to recreate commit topology
In-Reply-To: <CA+P7+xrGMtbtquHohnWbfq1Fy6Smj=LAXnqM=_wXOLvHMU+F2A@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1804131243010.65@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1519680483.git.johannes.schindelin@gmx.de> <cover.1523362469.git.johannes.schindelin@gmx.de> <87tvsj6rn2.fsf@javad.com> <nycvar.QRO.7.76.6.1804110009080.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <871sfm737e.fsf@javad.com>
 <nycvar.QRO.7.76.6.1804111324350.65@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <87h8oh51jm.fsf@javad.com> <CA+P7+xq8KJKJ0d1unW3btUhKVjOZM3EdTSKdDs96pn5J3WwSKA@mail.gmail.com> <87sh810ym4.fsf@javad.com> <CA+P7+xq8LOUZxVd832cOQFi4V=2YvydxtT6_y4NLKvFkki4QdA@mail.gmail.com>
 <nycvar.QRO.7.76.6.1804130002090.65@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <CA+P7+xrGMtbtquHohnWbfq1Fy6Smj=LAXnqM=_wXOLvHMU+F2A@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:wIyJxR32Nx6Fhapqbz937O0LF5KSUchq+Lno94RFhpDtZPcy+bb
 8w2OtzpoVT2f6vFaZHOdfjEQrrdmkVdSfPtsa+OyUsy/kX1v5OxuWdtwNBaLnzrci6qfgTh
 rLWMVSd6WJiB3WOLcOX+vbHS3ZsNOg/NrA/fPv8Oos5YCnKFi0RpYt2pLEdeky6AeqXmBCT
 1PzFwKD/HK3b37ni0IZgQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:y75LnkxOUpc=:SS40rV6ZfuhH1yNwki8FcH
 7bA2TMH8kuHGA58BUvlfSG9DkPDUtYYu3IFp3fQqm6DclLzI7M3kKyeKL3zODVunALxV+tlsz
 ceAFnMx7DTQb6mksDQZMMOCu1jtbja1wULHyc/LPa7o818RdXjBpZ+S8vzw8+x67cMyjUiV95
 n3W1pp5AP4nIMGk+JvGOCHfWQfy45pdvgRCv7pi1srstR+4UMywjXMTtaD8VO7q1HQc32oMYo
 yhf+C4HElCA3v1sIQSF8X68Xtvw/LMopQUTsIuSsVoUKY7CgKnQvWfjzBWfGsB19aKro4fdQJ
 ljEhrWk2/OdMY4XYGKi2j46VuiqIUf8PL75zc/b9cyzkl0TUPShIMIrymyEkanXdtDeDQG9ph
 qDEZyDuPXf2Cy8XQR2Z+S9G6w2/pwWlq17U2pYn5ICDt8HSMkcl6fWjEXBtLwPxkHMPZcBVTO
 4wuOxgMYFho3mf+UYGL/gPNzR5kbP5bEnDGT7+x2X2D1qfX2M3IDyiYMPaoCF84MSJoUFu9A1
 LhCNHepEVkpMZHrShsmPEyps0viWMrJyXFp28sUr7cUbJyyCGP3E4V0OigTgsajLZLyhpDFOg
 6ht6bsgTgKL6i5n6kNHLHTLjgsrI8Eu9sB+GikyVDlR6JKFGXicmvxRZhVFIDNG9G9k0mbB0x
 DZ52yYxpx69dW/Q0Oj5gnhF0jPvM33KGmJHSlK2cofMzQa30eNxv7r2qk7PaozZT5+qPeeac9
 Axl1y2tvNkvx9UlxaZfLnUrVH0zDC1qKiL4A4uwOTarDBG0zp7PmpkW27HeEQDUme/WguYmHQ
 AnpIHxMC5721L1r81Dqypz7M4FB6NrNPRrM1VxuU8DMSyx51NU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jake,

On Thu, 12 Apr 2018, Jacob Keller wrote:

> On Thu, Apr 12, 2018 at 3:02 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> 
> > [... talking about nested merge conflicts ...]
> >
> > The only way out I can see is to implement some sort of "W merge" or
> > "chandelier merge" that can perform an N-way merge between one revision
> > and N-1 other revisions (each of the N-1 bringing its own merge base). I
> > call them "W" or "chandelier" because such a merge can be visualized by
> > the original merge commit being the center of a chandelier, and each arm
> > representing one of the N-1 merge heads with their own merge bases.
> >
> 
> I think this approach sounds reasonable.

... and it would incidentally also offer a saner way to do octopus merges
(so far, an octopus merge that causes merge conflicts causes... huge
pains, as it usually stops in the middle of everything, without a UI to
help with concluding the merge).

> > Similar to the 3-way merge we have implemented in xdiff/xmerge.c, this
> > "chandelier merge" would then generate the two diffs between merge base
> > and both merge heads, except not only one time, but N-1 times. It would
> > then iterate through all hunks ordered by file name and line range. Any
> > hunk without conflicting changes would be applied as-is, and the remaining
> > ones be turned into conflicts (handling those chandelier arms first where
> > both diffs' hunks look identical).
> >
> > Have I missed any simpler alternative?
> 
> I *think* this would work well if I understand it, but it's difficult
> to process without examples.

Well, I am fairly certain about the implementation details (it's been a
while since I contributed xdiff/xmerge.c, and if you ever want to hear the
horrible story how I wrote the initial version in a stopped train in the
middle of the night, just buy me a beer or three, my memory is fresh on
the "simultaneous walking" of the diff hunks).

So it goes somewhat like this. You have two diffs, and for the matter of
the discussion, let's just look at the hunk headers (with 0 context lines,
i.e. -U0):

diff base..HEAD
@@ -10,1 +10,2 @@
@@ -40,2 +41,0 @@

diff base..branch
@@ -8,4 +8,3 @@

So on one side of the merge, we changed line 10 (e.g. wrapping a long
line), and we removed lines 40 and 41.

In the branch we want to merge, lines 8--11 were edited (removing one
line).

The 3-way merge as implemented in xdiff/xmerge.c handles only one file,
and first uses the diff machinery to figure out the hunk headers of both
diffs, then iterates through both diffs. This is the `while (xscr1 &&
xscr2)` loop in `xdl_do_merge()`, and the "scr" stands for "script" as in
"edit script". In other words, `xscr1` refers to the current hunk in the
first diff, and `xscr2` to the one in the second diff.

Inside the loop, we look whether they overlap. If not, the one with the
smaller line numbers is "applied" and we iterate to the next hunk after
that.

If the hunks overlap, we have a look at the respective post images to see
whether both sides of the merge modified that part identically; if they
don't, we create a conflict (and later, we will try to reduce the conflict
by trimming identially-changed lines at both ends of the line range).

Lather, rinse & repeat.

Now, what I have in mind is that we will have not only two diffs' hunks to
look through, but (N-1)*2 (note that if N == 2, it is the exact same thing
as before).

Again, at each iteration, we look for the next hunk among all available
ones, then determine whether it overlaps with any other hunk. If it does
not, we apply it. If it does, we first look whether all overlapping hunks
agree on the post image and if they do: apply the change, otherwise create
a conflict.

How to present such conflicts to the user, though?

The worst case, I think, would be N diverging changes with N-1 agreeing on
a large part of the post image and the remaining post image being
completely different. Imagine, for example, that the original merge
contains a long function hi() that was renamed to greeting() in HEAD, but
replaced by a completely different implementation in the rebased
branch-to-merge. In such a case, this nested conflict would be most
intuitive, methinks:

	<<< intermediate merge
	<<<< HEAD
	greeting()
	====
	hi()
	>>>> original merge
	... /* original function body */
	===
	hi()
	... /* complete rewrite */
	>>> branch

But now that I look at it, it is still hard to parse. *Is* there any good
way to present this conflict?

And then there is the problem that our index really is only prepared for
*three* stages, but we would need N*2-1.

So maybe I am overthinking this and we should stick with the
implementation I have right now (try to merge HEAD and the original merge
first, then merge the rebased 2nd parent if there are no conflicts,
otherwise try the other way round), and simply come up with a *very good*
message to the unfortunate user who encounters this situation?

I am thinking about something along these lines:

	There were conflicts merging the original merge
		deadbee (Merge 'side-branch')
	with its rebased first parent
		b1ab1ab (Rename 'core()' to 'hi()')
	and its rebased second parent
		ceeceec (Call core() in the event loop)

	The intermediate merge(s) are available as
		abcdef6 (intermediate merge)

Maybe that is good enough? Then the user could always try to glean which
amendments in the original merge (if any) were responsible for the
conflicts, and maybe even try to recreate the merge and then apply the
amendments manually... or something else...

I could even imagine that we could come up with more clever fall-back
strategies, such as recreating the original merge with a regular
merge_trees() to see whether it resulted in the same tree, i.e. find out
whether there *were* amendments, and in that case simply recreate a new
merge from scratch.

At some point, though, I should stop spending so much time on something
that may not even happen all that much in practice, I guess... ;-)

Ciao,
Dscho
