Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36D0A1FAE2
	for <e@80x24.org>; Sun, 11 Mar 2018 11:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932200AbeCKL4L (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Mar 2018 07:56:11 -0400
Received: from mout.gmx.net ([212.227.17.20]:55295 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932126AbeCKL4K (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Mar 2018 07:56:10 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LaJWs-1eEocI3EMw-00m3Ec; Sun, 11
 Mar 2018 12:56:00 +0100
Date:   Sun, 11 Mar 2018 12:56:04 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Junio C Hamano <gitster@pobox.com>
cc:     Phillip Wood <phillip.wood@talktalk.net>,
        Sergey Organov <sorganov@gmail.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        phillip.wood@dunelm.org.uk, Git mailing list <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution (Road
 Clear)
In-Reply-To: <xmqqbmfzx9n0.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1803111248200.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <87y3jtqdyg.fsf@javad.com> <bbe64321-4d3a-d3fe-8bb9-58b600fabf35@gmail.com> <nycvar.QRO.7.76.6.1802270051470.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <CA+P7+xq8UUcLWomUi=PS_hTKfJd3dMAxMmhioDS1bixwcmKAqw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com> <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com> <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com> <87606hoflx.fsf@javad.com>
 <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com> <87a7vss6ax.fsf@javad.com> <6c8749ca-ec5d-b4b7-f1a0-50d9ad2949a5@talktalk.net> <872944c4-ca97-9f55-a424-86d1e3299a22@gmail.com> <87h8pvm7zz.fsf@javad.com> <ebc73962-8dff-520c-e19d-8fcc1ef63ab0@talktalk.net>
 <xmqqwoyp5eig.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1803080804420.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <xmqqbmfzx9n0.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:9LAXLylpXtZX46Zh6YrDgLu4WB9RJfAD+HueGwVhs4wS+hD/c+g
 i5hbPH425wpC3nKGtfjdBf9BMZEq811FxcBrdJjtVhJn9hZ5Wt3doOk4l5iSwxeH/HdRXkC
 WUGweBMgUBYs8/Zd+8RdLbZT/7cxsQAWXCJL2JctPv2+ikqz6KdssE/iYe50iYgR4PPA/Qe
 jGAkzEEH0YWCbQs4ZBKvw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Lg6oBXsYfLc=:QuEMaD8lUUJVLE8NsjJo1H
 GgiKozu2AXY1KlWkI4kg/UxLJFiyb23kibUyLfac6APdjWknGuRdNrfKbpJzVN17bTD0syfCS
 AVXDsSX0bzZpht5pMhEkKZpXU0BUN8cEVmzUXRomjqpBQ7GCDfCkpCF0ww8vDlzj925GH459y
 u0AaFyXnsvg+4PRuNT9/rdFgJXp3/crgByDFdnzHYRLjTnuNDZ7XR40d0dXUIsL3CfiE6y/kF
 sapyztUG1h+rSSMOCWVFmkK9+wYyp86LfkAVp8pc5A/0cSNyQZ3pSsfTJjNq1Sf82iIpDXYoE
 cUXJUwDwrZVh5FFEdF602LxejJGGhDW3owIcXaCejRfFDuif5lsp8kCFtlnlvyAr8+hHpH7gb
 YqERo3j/bh+3g45vNjKOuxplqvCTk+gtfHAWrlVDY8FQ6a9XETP+mFXahFU9eIRWB7wlMgcLM
 LWU1mIcJBYCRZek6N711AeeDsVosE/Qn0XR8LAMFyJDI2MAUlDwtY/yfu+iwkIMJJXHKUPrt4
 ekJxCRVZ2Z/cX4kUyj5vcx+1EzFSmzufpDGDYrAosr/5aXUWpqL3nKY1avmB9gX/E5kugC/Jx
 gj3tuHHDdt/ORCB+b/kb09jHZlhH9Vw1f1JBarW4/IjCa+dKkkboRBOQPyaVHgQmF9naLnXWu
 vsQ6qvZHQ+9FPTubKPXHRdMhvoPjSaYxnM19PF+f5iyM1Ke1WzWMGQJMa63ExZ40XWak1oGDz
 CrUWBep20EeggD+WkiLyVIh9yvixQo8GLnvlF1Xku7bJ4a3VtcWHLqmHvbhtXtZAmrZZ8Hl5m
 zFKJi0LMkKBZOlMW+uFMfq7YU/CPKP1tqjuGkaKFSqODvDw4cgd2c+phxHT6+2/w2e/ZPRk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 8 Mar 2018, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> Non-textual semantic conflicts are made (in the best case just once)
> >> as a separate commit on top of mechanical auto-merge whose focus is
> >> predictability (rather than cleverness) done by Git, and then that
> >> separate commit is kept outside the history.  When replaying these
> >> merges to rebuild the 'pu' branch, after resetting the tip to
> >> 'master', each topic is merged mechanically, and if such a fix-up
> >> commit is present, "cherry-pick --no-commit" applies it and then
> >> "commit --amend --no-edit" to adjust the merge.  I find it quite
> >> valuable to have a separate record of what "evil" non-mechanical
> >> adjustment was done, which I know won't be lost in the noise when
> >> these merges need to be redone daily or more often.
> >
> > So essentially, you have something that `git rerere` would have learned,
> > but as a commit?
> 
> You probably wouldn't be asking that if you read what you cut out
> when you quoted above ;-) 

Sorry to be so stupid, and no, the part I cut did not clarify it for me,
hence my question.

> There are a collection of cherry-pickable commits in hierarchy under
> refs/merge-fix.  They are indexed by the branch that will cause
> semantic conflicts that do not involve textual conflicts at all (the
> important implication of which is that 'rerere' fundamentally will
> not trigger to help resolving them) [*1*], and are used to create
> evil merge when a corresponding branch is merged to 'pu' (and down).

I see. My question was unclear, I agree. Please let me re-try:

So essentially, what your cherry-pick'able commits are is a way to store
what rerere would have stored (i.e. the set of merge conflicts together
with their resolution)?

If so, what tooling do you have to identify quickly what to cherry-pick,
given merge conflicts?

(I know I could spend some half hour to scour your `todo` branch and the
documentation you wrote about how you maintain Git, but you already know
the answer to this question, and it would probably be interesting to
others who are as eager to have better tools for handling merge conflicts
as I am, too, so it would save time overall to discuss this single
question here.)

> *1* One topic adds an extra parameter to read_index_from() that has
> been and still is defined in a file and merged to 'pu' first, while
> another topic adds a new callsite for the same function in a file
> that the former topic does not touch, hence a merge of the latter
> topic has no textual conflict to the file with a new callsite, but
> still needs adjusting.  That sort of think.

Okay, so it is even more intricate than `rerere`: it does not only store
the merge conflicts (by grace of using the "patch ID" of the merge
conflicts) together with their resolution, but instead it has some sort of
idea of what context needs to be met to require the resolution?

Color me intrigued.

If you really found a way to automate describing, say, that a function
signature changed in one branch, and a caller was introduced in another,
and that merging those requires adjusting the caller in a specific way, I
now *really* think that this should be made available more broadly.

Ciao,
Dscho
