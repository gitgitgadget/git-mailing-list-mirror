Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B903F200B9
	for <e@80x24.org>; Mon,  7 May 2018 02:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751891AbeEGCEv (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 22:04:51 -0400
Received: from mout.gmx.net ([212.227.15.18]:52771 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751781AbeEGCEu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 May 2018 22:04:50 -0400
Received: from [10.40.94.26] ([209.226.201.248]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MHoC5-1fBwDO09nB-003d64; Mon, 07
 May 2018 04:04:35 +0200
Date:   Sun, 6 May 2018 22:04:31 -0400 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Git List <git@vger.kernel.org>, Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v2 02/18] Add a new builtin: branch-diff
In-Reply-To: <CAPig+cS0pvdg78fGUu8m2xspDDMHxi=uAMCkbLuthy7R4p3fQw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1805062155120.77@tvgsbejvaqbjf.bet>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <cover.1525448066.git.johannes.schindelin@gmx.de> <a1ea0320b64527ee6ce9856dcf359513d13052b7.1525448066.git.johannes.schindelin@gmx.de> <20180505182631.GC17700@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1805052355190.77@tvgsbejvaqbjf.bet> <xmqqk1shsecd.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1805061419530.77@tvgsbejvaqbjf.bet> <CAPig+cS0pvdg78fGUu8m2xspDDMHxi=uAMCkbLuthy7R4p3fQw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:j0nS1UN15yZISvDH7pNLLFf8zHtbUr4Z+AXEL/DbkvP0zOkPXew
 CBy80YOgCXSV7xtnwK0TveMw9vRpXiwhz81B+gXcKs01+AOYmWozwLFEtdZQfJZu2Aufa+J
 47H8JQrP3MZ3ra/EssVXjpDyNiGGb33HBXfAou3bCD3PqZ5SlHvCOqq1qYR5AZd6y5LRUmg
 r8dzn7f627Y6uaIKDdXrw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0pCKu6xSPh4=:z6wi6TBi4IihTqfEri+S0Q
 m9FCEECJWNuxi4NlEO6BtAijR2ZACGlb67eFuaOmBL/+sULftsnmY5v94MyOrfglLU1iVyVf7
 XEJPwQwkuG1Nt3PrddDsg2A51tOc8tS+XyVk+OqVBIg1Dfe4a9VJ0QxlXr0sAf5Wbisfanh8w
 x/2usdQIAN6AAIaAMA1BZoX+01/ohfRgsvtzuqjrgLdFj5sFk1OEH+bgjN0BQmcuy4AA/gVBY
 jLO9poxXRbHWTR5sBPEZK89WWJbX5dUmKmJi9fQ+hNvPzmbXcr3Os2Mymc4PQfuJ0kAMAxGsC
 7dvPVL9SvGhoN6ZMcgYuz/+OQIF/wkj3dA21ixMVMNVC/9h10pDxpq2Xrv8Jt/gV9vHsoqWDo
 GotBHeuKdHeEchZLjmxHw0LOyWPM4AhaOZu1oLE/kN6hMQrktIRTsL1RjtUqL7PSIEfl5WloL
 +CWIdzTtGEOTkUxwID24jzTHtT7KTIiShOewexOTn7b3iQ6ep2TTcloM3Qt2u4aAJnooMrObj
 SQRm0vBXZsiO7Abj5dlixBOaKaSYw/8Lxai8bWV2jsFk6+JwX7z+qLEZbxuRJBjSaXCaA9Pzq
 KSfOTjR+/TirF7bco0TKaPnA9mBE5aqQCHmSZ7Dlm6M3O9z9GJh5JPZw+uEgI1yEu2sAUgrF5
 PLhYEvJzSM4evrtOaASKQXQ3Nb4kOJGeG227+Ynay70xTJIHzySavdKQ3+P8EaxU4pfqMVDXi
 GiGaDzq6EZQAfOteAwYxzTODjA2ZmGqnvSmofALJAikIHsfzyzskGFT+Yf+y2S8yygUdB5bIB
 f6qPpAl
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Sun, 6 May 2018, Eric Sunshine wrote:

> On Sun, May 6, 2018 at 8:21 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > On Sun, 6 May 2018, Junio C Hamano wrote:
> >> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >> > On Sat, 5 May 2018, Jeff King wrote:
> >> >> One minor point about the name: will it become annoying as a tab
> >> >> completion conflict with git-branch?
> >>
> >> If tbdiff were "Thomas's branch diff", I would call this jbdiff ;-)
> >> but I think the 't' in there stands for "topic", not "Thomas's".
> >> How about "git topic-diff"?
> >
> > Or `git topic-branch-diff`?
> >
> > But then, we do not really use the term `topic branch` a lot in Git, *and*
> > the operation in question is not really about showing differences between
> > topic branches, but between revisions of topic branches.
> >
> > So far, the solution I like best is to use `git branch --diff <...>`,
> > which also neatly side-steps the problem of cluttering the top-level
> > command list (because tab completion).
> 
> Let's, please, not fall into the trap of polluting git-branch with
> utterly unrelated functionality, as has happened a few times with
> other Git commands. Let's especially not do so merely for the sake of
> tab-completion. git-branch is for branch management; it's not for
> diff'ing.

I totally disagree. `git branch` is *the* command to work with branches.
Yes, you can manage branches. But you can also list them. And now you can
also compare them.

> Of the suggestions thus far, Junio's git-topic-diff seems the least
> worse, and doesn't suffer from tab-completion problems.

Except that this is too limited a view.

Have you seen one of the more important tidbits in the cover letter, the
one about Git for Windows' *branch thicket*? In this case, it is not *one*
topic branch that we are talking about.

And even worse: what this patch series introduces is not at all a feature
to compare topic branches!

Instead, it is a way to compare iterations of patch series, versions of
topic branches, changes introduced into a topic branch by rebasing it,
etc. And `git topic-diff` simply does not say this. It says something
different, something that my patches cannot fulfill.

> Building on Duy's suggestion: git-interdiff could be a superset of the
> current git-branch-diff:
> 
>     # standard interdiff
>     git interdiff womp-v1 womp-v2
>     # 'tbdiff'-like output
>     git interdiff --topic womp-v1 womp-v2

No, no, and no. An interdiff is an interdiff is an interdiff. See e.g.
https://www.tutorialspoint.com/unix_commands/interdiff.htm for details.

The operation introduced by this patch series, or for that matter tbdiff,
*never ever* produced an interdiff. Get this "interdiff" label out of your
mind immediately when you think about this here operation.

One of my commit messages even talks about this, and says *why* we do not
generate interdiffs: they are in general not even well-defined.

Take my --rebase-merges patch series, for example. It is so long-running
that at some stages, all I did was to resolve merge conflicts incurred
from rebasing to `master`. That was literally all. Now, if you tried to
produce an interdiff, you would *already fail in the first step*, as the
previous overall diff does not apply in reverse on current `master`.

Out of all the options so far, the one that I liked was `git branch
--diff`. Seriously. I do not understand why you think that this is abusing
the `git branch` command. It is no less abusing it than `git branch
--edit-description`! And that is a *very good* command, and it is *very
good* that it is an option to `git branch`. It makes a total lot of sense,
I have never had to think "wait, in which Git command is this implemented
already?" And I would expect the exact same thing to happen with `git
branch --diff`.

Ciao,
Johannes
