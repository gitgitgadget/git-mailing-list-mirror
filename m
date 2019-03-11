Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFDE020248
	for <e@80x24.org>; Mon, 11 Mar 2019 16:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbfCKQZr (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 12:25:47 -0400
Received: from mout.gmx.net ([212.227.15.19]:59337 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbfCKQZr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 12:25:47 -0400
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MYwVv-1hY1rR1ZKN-00VjgF; Mon, 11
 Mar 2019 17:25:42 +0100
Date:   Mon, 11 Mar 2019 17:25:26 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/2] stash: handle pathspec magic again
In-Reply-To: <xmqqva0rmtrg.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1903111714430.41@tvgsbejvaqbjf.bet>
References: <pull.159.git.gitgitgadget@gmail.com> <xmqq5zsukuyj.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1903081709220.41@tvgsbejvaqbjf.bet> <xmqqva0rmtrg.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:KAShBuVeegx2IbM6UWI1yMoqG3Ci/i4kkVUS+LWWF4vGk1KMchY
 MUIkkN+BJ/sM2j114HmWyE1/b4ub9mrMzdG2XA767N8sn2C7nh73nn8UXcH7CfFKniIdvi6
 CiyoNXTls/rbbxgxSudh1VJtsviPblIgqZw7Od0uW3HVw9WCJRqsm9e0VZXKdMRqbwfp6uF
 o1HgRxRhK3iH372VxddDQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ncY2HerZyxA=:GHdoTnS7/RKLZ5bietUeY6
 wVJzAtuIS2KXsnMv8yG6sN+AZfytd+FEPD7aqOrI8zC2kDSay12Xct2zNot5OWkgFCN2SZL9Z
 oQNOjPQwKVk/CpKNcJB0R0onpoY5nvdqm6EIPQn3mELlXTjMlYljAlExR71Xdakiw+hqzyQ+Y
 6/Z2YjUBpKuMaZqyaKOmuGUvQ9sqAH+joRzyRJpTjamTaXqHYy1TBwVTKQ10V3R4TCpc19JGu
 YMlYaK33uFlyHU1TY85AFqbUA6oUPKgqJZKxNam2KXR2Wg14v2n/TL26vSTuhTX3HcHk8KUhF
 KIPA3eSA7S8iiBRQeAsdYSJ2uDT5NlgX5CNXlezu6ns+KmbxjFAG//hnhtp0fSB/5mnl2Jrj6
 qQ8k93Q2xKMimJt60rpPLkkgLpaHtxTP9Nwt5X5a7yZZD5oYh534lCbQOwVvRksCM6FOraZ9f
 XGY+CMMvmnAnpWek0gBAgqrDKpJUZ+8xzl6d35m45usUgxSJLtRZlkwbqkfACsep/lCBxK+1/
 VsHy9ifuynMJ9SKuH4iiUAaSng8UeGbLQ/mMFVSNfxj+Gml8EJCjDyPGC+zho/QBE5VsCFZ9n
 wi5qEEV7iVjEQ/xQvWRSJ0JH69TLhXwh0N3xS7K8CiCPcGAc6uMolQc+8XwF+FxOsTbnGE26Q
 qz9AAhggtytN8YLghFTbyhPo44dPACxxAZlDIF0INLQ6x8yqXT8YtDIiYRlZGrjEp3IGkeZpr
 6egzbwzaH2E8dT89nChfyf1LgSnqcJ6bFEsWQh3YlTkAqmJMkzKkTYf4kosuupNI8uSQL1pAD
 e2zm+PbLNXbTxb7or19XD7upTjMTmlvvV6IcQq3QYx8Vk0salbAe6cZ+GkQNGolYjIwCEJfEC
 7jRLAMn4v2jIA0+VHJIKiDqIqugdnQvFQSJZSPPMRCu3VjPnrkFMBxKNmqmFX0GDI8xGXwORn
 epDsYo+F/Hw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sun, 10 Mar 2019, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > If you care deeply about the commit history, I hereby offer to you to
> > clean up the built-in stash patches when you say you're ready to advance
> > them to `master`.
> 
> What's the goal of such a rebase?

To appease you enough that you stop complaining about the current, or
previous, state of `ps/stash-in-c`.

I am genuinely interested in making this all more pleasant for you, even
if my efforts to that end show no fruit.

> To rebuild the topic as a sensible sequence of commits that logically
> builds on top of previous steps to ease later bisection and
> understanding?
> 
> Thanks for an offer out of good intentions,, but let's move on and
> polish the tree shape at the tip of this topic.

I would be prepared to do that, but I am constantly reminded of the
unfortunate way we handled `ps/stash-in-c`, where you thought it was way
too early to move to `next`, and I am convinced that we simply were way
too late to start cooking in `next`.

So I keep offering to do work so that you would be happier, but none of my
suggestions seem to work.

> The history behind it may be messier than other segments of our history,
> and future developers may have harder time learning the intention of the
> topic when making changes on top, but this one was supposed to create a
> bug-to-bug reimplementation of the scripted version.

Right. But we moved right past that, and continued enhancing `git stash`,
(like the `--quiet` thing) and were now stuck with the unfortunate
situation that we had to do it in both built-in and scripted version.

> What matters more would be our future changes on top of this code, which
> improves what we used to have as scripted Porcelain.  They will
> genuinely be novel efforts, need to be built in logical order and
> explainable steps to help future developers.  Compared to that, so the
> history of our stumbling along the way to reach today's tip of the topic
> has much lower value.
> 
> Besides I think it is way too late for the current topic.  We
> established before the topic hit 'next' that reviewers' eyes all
> lost freshness and patience to review another round of this series
> adequately.
> 
> We at least know that the ordering and organization of the iteration
> we see in 'next' is crappy, because some reviewers did look at them.
> The rewrite will see no reviews, if any, far fewer and shallower
> reviews than the iteration we have; nobody would be able to say with
> confidence that the rewritten series achieves its goal of leaving a
> sensible history.  Doing so just before it hits 'master' makes it a
> sure thing.

Fine. But in that case, I would appreciate not being reminded of the
messiness. Not unless you let me do something about it. Don't put me
between a rock and a hard place, please.

> Let's just we all admit that we did a poor job when we decided to
> push this topic to 'next' before it was ready, and learn the lesson
> to avoid haste making waste for the future topics.

Quite honestly, I am at a loss what you are suggesting here. The original
contributor (Paul) got unexpectedly busy with university, so he was not
able to take care of any updates.

I would have made those updates (I promised, after all), but at some stage
it felt more logical to explain in add-on topics what breakages were
introduced by the built-in rewrite and fix them: squashing the fixes in
would have made it less obvious why certain changes had to be done that
way (after all, I missed in the original dozens of reviews, pre-submission
and post-submission, e.g. the ORIG_HEAD problems).

But you did not complain about me adding on top back then, so I do not
understand why you complain about it now...

I am more than willing to move on, but if we keep repeating how messy the
current state is and do not even come up with a way how we could handle
this better in the future, then I do not really feel that we *are* moving
on after all.

Ciao,
Dscho

> Thanks.
> 
