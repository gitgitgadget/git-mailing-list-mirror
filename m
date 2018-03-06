Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 284C41F404
	for <e@80x24.org>; Tue,  6 Mar 2018 18:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753065AbeCFSMV (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 13:12:21 -0500
Received: from mout.gmx.net ([212.227.17.21]:52357 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750817AbeCFSMT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 13:12:19 -0500
Received: from [10.59.3.43] ([77.210.250.197]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LnlmV-1eBwYu2ifH-00hsIt; Tue, 06
 Mar 2018 19:12:12 +0100
Date:   Tue, 6 Mar 2018 19:12:10 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     phillip.wood@dunelm.org.uk
cc:     Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution (Road
 Clear)
In-Reply-To: <1c912980-8ce8-6281-fa99-040a5e3e1103@talktalk.net>
Message-ID: <nycvar.QRO.7.76.6.1803061829460.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <87y3jtqdyg.fsf@javad.com> <bbe64321-4d3a-d3fe-8bb9-58b600fabf35@gmail.com> <nycvar.QRO.7.76.6.1802270051470.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <CA+P7+xq8UUcLWomUi=PS_hTKfJd3dMAxMmhioDS1bixwcmKAqw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com> <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com> <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com> <87606hoflx.fsf@javad.com>
 <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com> <87a7vss6ax.fsf@javad.com> <6c8749ca-ec5d-b4b7-f1a0-50d9ad2949a5@talktalk.net> <872944c4-ca97-9f55-a424-86d1e3299a22@gmail.com> <1c912980-8ce8-6281-fa99-040a5e3e1103@talktalk.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:6Nw6QruK5OsLrgaBRDOEFHw1uo433sRWGaBfyUmKpbzmy3sc9Q2
 PtJDBRxUdZWDJuOKewTvluDmheGNafmwHOWSk+CuofhXK28EKAxigoz68MfArnHzxhkIdzF
 cCLM42pdNJKx4IIyaj98rUDKlm01X3PCBzrTU0I3LOjdA8anVAuFXAKTPta0iateuOHTg/B
 nrjDEYuZTL5Sugi4CScCQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PRtyKdgNEXc=:uL+c9E+OAXLhX6TTap/zPm
 uRPlU9Ir01Ut+dkB9p3QExX0fAdvaPnDYzDwNAB6TzlAF5WeDZEySqV1l+091kR+7J4FCnHgo
 1bdnLEJgYVf6m2b4LfGQedxWlJldjDXMPZ1MDo+nPBlno9FQLinz5jYlHs+NaOO1j11yEVTuS
 QvBMGMRnIsrlsXCU66kwZ4HwFKLy1LoIDtt38wJPTcmjHMwbimouhjo+w6Yjyhz8MY8O1M89b
 Iw33qyFOx9UKjo/+djPx+KuX1lixoT11nRq46HsHTAgiFq5+IhduREvto+ABAvTeF9lgt/j5E
 2pcvejFg3UnJZGHag2O4REB7DsIgb3w1UEYV0IKLCm2vyrfO3rEzORyZIRugQJCAlI97zBmZL
 hSspXH3KCr+/KPS88IEZqlkhwRpf7V3ct4RzgKzW61yxCJFdp7kEizzB3SDbGmMFhn02M7/HJ
 am8mw6I3/Trv0Ozx6EiHzcoNcQLH/1dHU7VEqwG/E+8fTl4cOVVyucswAOh/e6RR6jYX3d6do
 J55H+rTxLomKUm3KcSa8tFiY7lzt6CUR6LYN1ynJcUEm2wcI+zW+G0JX6XXqvX0QjyHUxseTf
 E+UqRFOS7WQ51no0EKLkzdBjf3E1QyRAlLXq6cN8YW6Pvgh9QkZCnMNMmaE4VUM8SuriVAxBJ
 AO4yHTlkdjerf/dU+6c8CG/WzkubIRiIQHKGLdf/roHfAK1PPWf2D6jugVlXwYSEp6SAvuyvc
 +lo92VHZvyUgDhzbtDZnioDRYWFSHoj32xN3gifb3bJfWaIXxDLDyf8GhYJUBnn53Mngp70Gn
 +8QMaiE7D4Gv6Lf/tK8dzy0ZZjUxKPJd26vYjV46VbgG/X/Gak=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Tue, 6 Mar 2018, Phillip Wood wrote:

> On 03/03/18 00:29, Igor Djordjevic wrote:
> > 
> > On 02/03/2018 12:31, Phillip Wood wrote:
> >>
> >>> Thinking about it overnight, I now suspect that original proposal
> >>> had a mistake in the final merge step. I think that what you did is
> >>> a way to fix it, and I want to try to figure what exactly was wrong
> >>> in the original proposal and to find simpler way of doing it right.
> >>>
> >>> The likely solution is to use original UM as a merge-base for final
> >>> 3-way merge of U1' and U2', but I'm not sure yet. Sounds pretty
> >>> natural though, as that's exactly UM from which both U1' and U2'
> >>> have diverged due to rebasing and other history editing.
> >>
> >> Hi Sergey, I've been following this discussion from the sidelines,
> >> though I haven't had time to study all the posts in this thread in
> >> detail. I wonder if it would be helpful to think of rebasing a merge
> >> as merging the changes in the parents due to the rebase back into the
> >> original merge. So for a merge M with parents A B C that are rebased
> >> to A' B' C' the rebased merge M' would be constructed by (ignoring
> >> shell quoting issues)
> >>
> >> git checkout --detach M
> >> git merge-recursive A -- M A'
> >> tree=$(git write-tree)
> >> git merge-recursive B -- $tree B'
> >> tree=$(git write-tree)
> >> git merge-recursive C -- $tree C'
> >> tree=$(git write-tree)
> >> M'=$(git log --pretty=%B -1 M | git commit-tree -pA' -pB' -pC')
> >>
> >> This should pull in all the changes from the parents while preserving
> >> any evil conflict resolution in the original merge. It superficially
> >> reminds me of incremental merging [1] but it's so long since I looked at
> >> that I'm not sure if there are any significant similarities.
> >>
> >> [1] https://github.com/mhagger/git-imerge
> > 
> > Interesting, from quick test[3], this seems to produce the same 
> > result as that other test I previously provided[2], where temporary 
> > commits U1' and U2' are finally merged with original M as a base :)
> > 
> > Just that this looks like even more straight-forward approach...?
> > 
> > The only thing I wonder of here is how would we check if the 
> > "rebased" merge M' was "clean", or should we stop for user amendment? 
> > With that other approach Sergey described, we have U1'==U2' to test with.
> 
> I think (though I haven't rigorously proved to myself) that in the
> absence of conflicts this scheme has well defined semantics (the merges
> can be commuted), so the result should be predicable from the users
> point of view so maybe it could just offer an option to stop.

I am not so sure that the result is independent of the order of the
merges. In other words, I am not necessarily certain that it is impossible
to concoct A,A',B,B' commits where merging B'/B before A'/A has a
different result than merging A'/A before B'/B.

Remember, when constructing counter-examples to hypotheses, those
counter-examples do not really *have* to make sense on their own. For
example, A' could introduce *completely different* changes from A, and the
same is true for B' and B.

I could imagine, for example, that using a ton of consecutive empty lines,
and using patches that insert something into these empty lines (and are
thusly inherently ambiguous when said set of empty lines has changed),
could even introduce a merge conflict in one order, but no conflict in the
other.

Even so, I think that merging in the order of the parents makes the most
sense, and that using that strategy makes sense, too, because you really
have to try hard to make it fail.

Ciao,
Dscho
