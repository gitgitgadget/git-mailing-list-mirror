Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EE5B1F404
	for <e@80x24.org>; Mon, 12 Feb 2018 20:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752447AbeBLUjW (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 15:39:22 -0500
Received: from mout.gmx.net ([212.227.17.22]:45543 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751073AbeBLUjV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 15:39:21 -0500
Received: from MININT-TB4PCE7.southpacific.corp.microsoft.com
 ([37.201.195.115]) by mail.gmx.com (mrgmx102 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 0LyB6P-1ehVSw4Aar-015aT2; Mon, 12 Feb 2018 21:39:16 +0100
Date:   Mon, 12 Feb 2018 21:39:15 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Sergey Organov <sorganov@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 5/8] rebase: introduce the --recreate-merges option
In-Reply-To: <87zi4edbp3.fsf@javad.com>
Message-ID: <nycvar.QRO.7.76.6.1802122121230.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1516225925.git.johannes.schindelin@gmx.de> <71c42d6d3bb240d90071d5afdde81d1293fdf0ab.1516225925.git.johannes.schindelin@gmx.de> <874lmqirma.fsf@javad.com> <nycvar.QRO.7.76.6.1802102357510.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <87zi4edbp3.fsf@javad.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:GtJfIPDX8ucc2rxwjFLqyQ66ipQfu9sMITNZ5pCL0FA4ylwDoJi
 qw8ti9t8mnR/MH5ga6ZDkj0qgdkTnoydoJcXG1wzfA/4jLi1h+F0G21B2WDENzLaqaGxt0q
 NsM9iprOmMf+yOY24mp2F9pWpI2sP9O9FXgT7/isKYZuMTkhFa9VeU8YGzy8hBCrP/SyPtd
 rELderol9qrPYFNsXmHvA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Jf6BgEEqQ10=:vgt7EGtu8ueXgAnk/fHKw5
 bwSG8wXf/th5/hIRzahpAZ7W4FRFlOa+IQI/lpxc9jXB2oQzEBwanM5HnqoA/pZsw1avyAJvI
 G0304ne1zAtUabGHKiapKUOKx7fmjfsPlITSpqZng5ir15KiUJHOEPNlL0qlG/lLjPNAX3gix
 JqoNKrdFlqWiQCdB52zQNJ9trF0gMO4jHtULoqK8TzK78Ayr0CI/8Mm345hHNlcY+cTCbo39q
 JxypL1Rft4pBIddokf3qN5D6xB7MCII3yWXnZWwQY+xzB5G/fa6+JkpBPvYWAUtqJSO2iRJaw
 re1zlL9ifjLErr5Qtemr164uDjnBrXpI2GeilMMXmwaUDHeZbEi3pgvthUVRtHbjYJqLSMIdq
 x+tJQAcO+EmmGcbi2ARBcorRfAfgEsz6sLsODgNbIpIU04MORrQR9x7G1gOwXIIHFqFeirkJZ
 FHWCjH1OlxQNXYNqko1K7/5kry0+tiMZeBaieurvRb9mQIUJ4gvdco5gGrLVrJhH60J7YC/eQ
 lMGjq7+7f12JoTO7KDi2rek0UvQ119xDSBWlVm6pNIiZpR3Od13b4TRgZsyRQoWckMTqr1Ik7
 a5LXHC32kFa6FvFM0dAhMls0TAYiF+QUDApb81v+Lqkm+6p36yNEE8++doxv76NJVhUArYiTy
 e/QGavFRb+Pi7CfUJyj/7zCA35ya5dQAhRHgBARyM9CTOOOxtv0AGKSEX6VDEndrjIb31aosF
 Wc+pWJYL8qdiMq9yExfj5aRPZe22wH73J1+VQ7gaPggp3sPC+/GX5tDmbLztLsD4keTPZ2Z++
 iSuDMUfdio83mQL3LQ1uQ2VJoJABKjSYHLx6fgvW5sNAuKciG4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sergey,

On Mon, 12 Feb 2018, Sergey Organov wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >
> > On Fri, 9 Feb 2018, Sergey Organov wrote:
> >
> >> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> >> 
> >> [...]
> >> 
> >> > With this patch, the goodness of the Git garden shears comes to `git
> >> > rebase -i` itself. Passing the `--recreate-merges` option will generate
> >> > a todo list that can be understood readily, and where it is obvious
> >> > how to reorder commits. New branches can be introduced by inserting
> >> > `label` commands and calling `merge - <label> <oneline>`. And once this
> >> > mode has become stable and universally accepted, we can deprecate the
> >> > design mistake that was `--preserve-merges`.
> >> 
> >> This doesn't explain why you introduced this new --recreate-merges. Why
> >> didn't you rather fix --preserve-merges to generate and use new todo
> >> list format?
> >
> > Because that would of course break existing users of
> > --preserve-merges.
> 
> How exactly?

Power users of interactive rebase use scripting to augment Git's
functionality. One particularly powerful trick is to override
GIT_SEQUENCER_EDITOR with an invocation of such a script, to perform
automated edits. Such a script breaks when we change the format of the
content to edit. If we change the format of the todo list generated in
--preserve-merges mode, that is exactly what happens. We break existing
users.

BTW it seems that you did not really read my previous reply carefully
because I referenced such a use case: the Git garden shears. They do
override the sequencer editor, and while they do not exactly edit the todo
list (they simply through the generated one away), they generate a new
todo list and would break if that format changes. Of course, the shears do
not use the --preserve-merges mode, but from just reading about the way
how the Git garden shears work, it is quite obvious how similar users of
--preserve-merges are likely to exist?

> Doesn't "--recreate-merges" produce the same result as
> "--preserve-merges" if run non-interactively?

The final result of a rebase where you do not edit the todo list? Should
be identical, indeed.

But that is the most boring, most uninteresting, and least important use
case. So we might just as well forget about it when we focus on keeping
Git's usage stable.

> > So why not --preserve-merges=v2? Because that would force me to
> > maintain --preserve-merges forever. And I don't want to.
> >
> >> It doesn't seem likely that todo list created by one Git version is
> >> to be ever used by another, right?
> >
> > No. But by scripts based on `git rebase -p`.
> >
> >> Is there some hidden reason here? Some tools outside of Git that use
> >> old todo list format, maybe?
> >
> > Exactly.
> >
> > I did mention such a tool: the Git garden shears:
> >
> > 	https://github.com/git-for-windows/build-extra/blob/master/shears.sh
> >
> > Have a look at it. It will inform the discussion.
> 
> I've searched for "-p" in the script, but didn't find positives for
> either "-p" or "--preserve-merges". How it would break if it doesn't use
> them? What am I missing?

*This* particular script does not use -p.

But it is not *this* particular script that I do not want to break! It is
*all* scripts that use interactive rebase! Don't you also care about not
breaking existing users?

> >> Then, if new option indeed required, please look at the resulting manual:
> >> 
> >> --recreate-merges::
> >> 	Recreate merge commits instead of flattening the history by replaying
> >> 	merges. Merge conflict resolutions or manual amendments to merge
> >> 	commits are not preserved.
> >> 
> >> -p::
> >> --preserve-merges::
> >> 	Recreate merge commits instead of flattening the history by replaying
> >> 	commits a merge commit introduces. Merge conflict resolutions or manual
> >> 	amendments to merge commits are not preserved.
> >
> > As I stated in the cover letter, there are more patches lined up after
> > this patch series.
> 
> Good, but I thought this one should better be self-consistent anyway.
> What if those that come later aren't included?

Right, let's just rip apart the partial progress because the latter
patches might not make it in?

I cannot work on that basis, and I also do not want to work on that basis.

If you do not like how the documentation is worded, fine, suggest a better
alternative.

> > Have a look at https://github.com/git/git/pull/447, especially the
> > latest commit in there which is an early version of the deprecation I
> > intend to bring about.
> 
> You shouldn't want a deprecation at all should you have re-used
> --preserve-merges in the first place, and I still don't see why you
> haven't. 

Keep repeating it, and it won't become truer.

If you break formats, you break scripts. Git has *so* many users, there
are very likely some who script *every* part of it.

We simply cannot do that.

What we can is deprecate designs which we learned on the way were not only
incomplete from the get-go, but bad overall and hard (or impossible) to
fix. Like --preserve-merges.

Or for that matter like the design you proposed, to use --first-parent for
--recreate-merges. Or to use --first-parent for some --recreate-merges,
surprising users in very bad ways when it is not used (or when it is
used). I get the impression that you still think it would be a good idea,
even if it should be obvious that it is not.

> > Also, please refrain from saying things like... "Don't you think ..."
> >
> > If you don't like the wording, I wold much more appreciate it if a better
> > alternative was suggested.
> 
> Sorry, but how can I suggest one if I don't understand what you are
> doing here in the first place? That's why I ask you.

There are ways to put the person you ask on trial. And there are ways to
genuinely show interest and seek education.

I am a really poor example how to communicate properly, of course, so
don't try to learn from me. I am trying myself to learn better ways to
express what I mean clearly, and to express it in a direct yet kind
manner.

> >> Don't you think more explanations are needed there in the manual on
> >> why do we have 2 separate options with almost the same yet subtly
> >> different description? Is this subtle difference even important? How?
> >> 
> >> I also have trouble making sense of "Recreate merge commits instead of
> >> flattening the history by replaying merges." Is it "<Recreate merge
> >> commits by replaying merges> instead of <flattening the history>" or is it
> >> rather "<Recreate merge commits> instead of <flattening the history by
> >> replaying merges>?
> >
> > The documentation of the --recreate-merges option is not meant to explain
> > the difference to --preserve-merges. It is meant to explain the difference
> > to regular `git rebase -i`, which flattens the commit history into a
> > single branch without merge commits (in fact, all merge commits are simply
> > ignored).
> 
> Yeah, that's obvious, but the point is that resulting manual is ended
> up being confusing.

Again, just saying something is bad, is bad. Saying something leaves room
for improvement and then suggesting how to improve it, is good.

> > And I would rather not start to describe the difference between
> > --recreate-merges and --preserve-merges because I want to deprecate the
> > latter, and describing the difference as I get the sense is your wish
> > would simply mean more work because it would have to be added and then
> > removed again.
> 
> I suspect you actually didn't need those new option in the first place,
> and that's the core reason of these troubles.

Are you suspecting that I, myself, do not use --recreate-merges?

If so, please read the cover letter again, in particular the part where I
describe how this entire series of patch series arose from the Git garden
shears, which I invented myself to help with maintaining Git for Windows,
and which I use for five years now. This should help disperse that
suspicion rather quickly: the intent of --recreate-merges is to allow me
to simplify the shears by quite a bit, and maybe eventually even get rid
of the script altogether (if I ever manage to convince myself that the
concept of a merging-rebase should be official enough to enter core Git).

I am a heavy user of --recreate-merges, even if it does not really exist
yet. I have five years of experience with it, which is the reason why I am
so confident about its design, and why I can tell you a lot about typical
use cases and common pitfalls, and where the original design had to be
adjusted.

Ciao,
Johannes
