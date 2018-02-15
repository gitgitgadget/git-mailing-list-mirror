Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 293361F404
	for <e@80x24.org>; Thu, 15 Feb 2018 01:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032430AbeBOBlF (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 20:41:05 -0500
Received: from mout.gmx.net ([212.227.15.18]:57695 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032245AbeBOBlD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 20:41:03 -0500
Received: from MININT-TB4PCE7.southpacific.corp.microsoft.com
 ([37.201.195.115]) by mail.gmx.com (mrgmx001 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 0MHH6Z-1f092A3zt5-00E5rf; Thu, 15 Feb 2018 02:40:58 +0100
Date:   Thu, 15 Feb 2018 02:40:56 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Sergey Organov <sorganov@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 5/8] rebase: introduce the --recreate-merges option
In-Reply-To: <87d1198k4e.fsf@javad.com>
Message-ID: <nycvar.QRO.7.76.6.1802150214500.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1516225925.git.johannes.schindelin@gmx.de> <71c42d6d3bb240d90071d5afdde81d1293fdf0ab.1516225925.git.johannes.schindelin@gmx.de> <874lmqirma.fsf@javad.com> <nycvar.QRO.7.76.6.1802102357510.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <87zi4edbp3.fsf@javad.com> <nycvar.QRO.7.76.6.1802122121230.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <87d1198k4e.fsf@javad.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:0JXH2AYP5/hV/vUMvY9aNq4bW3dXeaIgsCC+PwCFlIrF2CfZdFu
 0v2ZhW/aoUDUKy5KjG0GTJhccaSVsKXRbpN/qzOSRtWCPXjX2UC3di0MySkMovRiuweIy3A
 vFTLbtNRpqYhnjocwcP+jO6aetT6clxjaSDUaUoDlsjLDfdxkHFZIsrs6+qv9SIyKUHJDES
 4YAFVzQrmUIKfx/2S4M/g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PEsQ/AvRWrg=:XmSCWBHsBs3f++EC/oh+d1
 5yDDMBzaKLaINkmQyBh7ymGXppKYudRP/QcLmz0ktI1/ESpZWwcLYuNbE4TQCNV0xZKDj+iGH
 3d/Q7dSRYGp4ggFvhIm/C7LGmG10aDWbqd0YL9Xfb/XAWiFxvRfhZm4n2xR2q8m/IJI5+DQiS
 cDxrWVYfsYWQJTJmVx4WBFasQI/xNmMHTri0jnVF+aBVcJs/HgmPgBlF/wL+AlSirNz8HsiMC
 49+nuUPKaXoDsHI9ppFZ3SqxI+Om6kUwDDbov2BPbNZzyw5cKH5oAhRXyIqoUm6OR2mkw+nK9
 wJnUmf7Ry4ZJArJxEUoptX/7EejLmfhfF20222+fmKyQYNKMHXIvtVEvk4haa9315DMSio5up
 497JdGg5gKBqttr84Z4rGcMsvWaQyPmuuNeX9izWqz48JllAMJoVvr8Zpq31kciTXWmGJT6xw
 BSTMGojNIlPvSQv1/Yn0gvlzPa8Es/f278Pxjg9NOpt9YDRda+8bHc/o+dgmx/GLO5hMHB2GR
 FTnZZ3e+8zawzOIMojE+OaruvCgsjXKV5f63aMvnVU4Sy3wkDWvU17U47G6heVR/h+XvvMhCF
 vnd4UF5qpwBGlG8N+6qHRz485Xz1TC5daWB+jP54AubS39XPaOvIjEAvtEngsWN4j5EgG+ysL
 FKFeBkywe8T6imiehcqyCMpnTlGOJMH+4QMINLtjLte60K9F5grdO3WWDEKFMO0l2XVX/NMI6
 qClD29qPjfJbUeRnRnbGaElGkq4AWRWMZnFxDRhuGpMKm2U+YHF/SXCtH2d4oxt/7Ay/a9JrP
 E02XxdPseOVuQGuEoDvYD8w4LpL7J59XembFbWBmHslAoeOi7Y=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sergey,

On Tue, 13 Feb 2018, Sergey Organov wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >
> > On Mon, 12 Feb 2018, Sergey Organov wrote:
> >
> >> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >> >
> >> > On Fri, 9 Feb 2018, Sergey Organov wrote:
> >> >
> >> >> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> >> >> 
> >> >> [...]
> >> >> 
> >> >> > With this patch, the goodness of the Git garden shears comes to `git
> >> >> > rebase -i` itself. Passing the `--recreate-merges` option will generate
> >> >> > a todo list that can be understood readily, and where it is obvious
> >> >> > how to reorder commits. New branches can be introduced by inserting
> >> >> > `label` commands and calling `merge - <label> <oneline>`. And once this
> >> >> > mode has become stable and universally accepted, we can deprecate the
> >> >> > design mistake that was `--preserve-merges`.
> >> >> 
> >> >> This doesn't explain why you introduced this new --recreate-merges. Why
> >> >> didn't you rather fix --preserve-merges to generate and use new todo
> >> >> list format?
> >> >
> >> > Because that would of course break existing users of
> >> > --preserve-merges.
> >> 
> >> How exactly?
> >
> > Power users of interactive rebase use scripting to augment Git's
> > functionality. One particularly powerful trick is to override
> > GIT_SEQUENCER_EDITOR with an invocation of such a script, to perform
> > automated edits. Such a script breaks when we change the format of the
> > content to edit. If we change the format of the todo list generated in
> > --preserve-merges mode, that is exactly what happens. We break existing
> > users.
> 
> I didn't say a word against "--preserve-merges mode", whatever it is,
> only about re-using "--preserve-merges" command-line option to "git
> rebase", the git user interface.

*I* said something against --preserve-merges. You did not even need to. I
know fully well its limitations.

I also said something agains the suggestion to replace the functionality
of a previously well-defined (although misdesigned) feature.

I do not know how often I have to repeat that your suggestion would break
backwards-compatibility?

> I'm sure you see the difference?

Yes, of course I do, and you do not even have to suggest otherwise by
asking such a question.

I already demonstrated plenty of times that I do understand what you wish
for, and that I see serious problems with it.

> Unless there are out-of-git scripts that do use "git rebase
> --preserve-merges" and simultaneously do rely on the todo list format
> this exact command generates, there should be no breakage of existing
> users caused by changing todo list format generated by  "git rebase
> --preserve-merges".

So. Just because you cannot imagine that anybody uses rebase in such a
powerful way means you are willing to break their setups?

Git is used by millions of users. Many of them are power users. It would
be quite naive to assume that nobody uses rebase -p in a scripted manner
that modifies the todo list.

Changing the behavior of --preserve-merges would be simply irresponsible,
and that's why we won't do it.

Even if that was not so, there is yet another really good reason not to
reuse the name --preserve-merges: The name itself suggests that this mode
is about preserving all merges in the specified commit range. That was its
original intention, too, as I never designed it to be user with rebase -i.
If the todo list of rebase -p is not modified (preserving the entire
commit topology as well as possible), it works quite well.

The new mode is not so much about preserving, though. It is about
interactively modifying the todo list, to change the order of the commits,
even to change the branch topology. That means that we do not necessarily
preserve the merges. We recreate them. So you see, I did try to be careful
about the naming, too. I thought about this.

> Old broken "--preserve-merges mode" could be then kept in the
> implementation for ages, unused by the new fixed "git rebase
> --preserve-merge", for the sake of compatibility.

This sentence contradicts itself. Either you keep the code unused, or you
keep it used for backwards-compatibility.

> > BTW it seems that you did not really read my previous reply carefully
> > because I referenced such a use case: the Git garden shears.
> 
> I thought I did. You confirm below that this script doesn't use "git
> rebase --preserve-merges" in the first place, nor will it break if "git
> rebase --preserve-merges" starts to generate new todo format, yet you
> expected I'd readily see how it's relevant? No, I'm not that clever, nor
> am I a mind-reader.

You caught me. I am not a user of --preserve-merges. Not anymore.

Does that mean that by extension nobody is a user of that feature?

Certainly not.

And does my example of (ab-)using interactive rebase by scripting on top
of it maybe suggest that others do the same? Maybe even with
--preserve-merges? Most likely. Git is used by many, many users. It would
be foolish to make any assumption about how Git is used by others.

> > They do override the sequencer editor, and while they do not exactly
> > edit the todo list (they simply through the generated one away), they
> > generate a new todo list and would break if that format changes. Of
> > course, the shears do not use the --preserve-merges mode, but from
> > just reading about the way how the Git garden shears work, it is quite
> > obvious how similar users of --preserve-merges are likely to exist?
> 
> Maybe, I dunno. If even "garden shears" won't break, then what will? Do
> you know an example?

You are not seriously suggesting that we should assume that there is no
such Git user, just because neither you nor I personally know such a user?
Seriously?

> Anyway, as it seems it's too late already for such a change, let me stop
> this and assume there are indeed such scripts that will break and that
> it's indeed a good idea to introduce new option. Case closed. The manual
> should still be fixed though, I think.

Finally I got through. Yes, we cannot break backwards-compatibility.

> >> Doesn't "--recreate-merges" produce the same result as
> >> "--preserve-merges" if run non-interactively?
> >
> > The final result of a rebase where you do not edit the todo list? Should
> > be identical, indeed.
> 
> That's good to hear.
> 
> > But that is the most boring, most uninteresting, and least important use
> > case.
> 
> For you. Do you suddenly stop caring about compatibility?

What does "fun" and "interesting" have to do with compatibility?

Yes, to me, this case is boring. And yes, I took pains to make it work
(for compatibility).

And yes, I did not stop after that. After the boring case, I still wanted
to think things through, to come up with a design that would not be too
limited to be useful. With a design that is consistent.

If you find holes in the consistency or usability, please do call them
out.

But please stop suggesting to break backwards-compatibility, or to
introduce features that are inconsistent and/or can produce "surprising"
results (as --first-parent would, and multiple contributors had to argue
in concert, pointing out how it is not extensible to the general case, and
is hence consistent).

> > It is *all* scripts that use interactive rebase!
> 
> I'm really interested, and here I *do* ask for education. What are
> those? As I now only ask this out of curiosity, and don't argue
> --recreate-merges anymore, are you finally willing to reveal the
> information?

If you are interested, why don't you go about asking people for their
power scripts.

In the context of this patch series, I am not interested in such a
collection. What I had to do was to convince myself that they could not
exist, in which case I could just do away with backwards-compatibility. In
the alternative, the safe play is to go the deprecation route.

A mere "highly unlikely" made up from thin air does not convince me,
though. So deprecation route it is.

> > Don't you also care about not breaking existing users?
> 
> I do care. I just suspected they are very unlikely to exist, and I do
> want to be educated in this matter indeed, as they could be rather
> interesting.

Okay, "very unlikely". Not "highly unlikely". Still, it is an unconvincing
argument that suffers very seriously from lack of any robust evidence.

> [Please notice violation of your own standard of not using "Don't
> you...", not that I care myself.]

True. My apologies.

And as the rest of the mail seems to reiterate the idea that the
--recreate-merges code should override --preserve-merges (breaking
backwards-compatibility), despite my repeated efforts to educate you why
this would be a bad idea, I guess the best course of action to avoid
telling you "Don't you ..." is to just stop here.

Ciao,
Johannes
