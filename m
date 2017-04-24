Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C782207D6
	for <e@80x24.org>; Mon, 24 Apr 2017 14:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1171980AbdDXOUd (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 10:20:33 -0400
Received: from mout.gmx.net ([212.227.17.21]:61528 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1172531AbdDXOUY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 10:20:24 -0400
Received: from virtualbox ([95.208.59.55]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lqhaw-1cOfOI272A-00eOrF; Mon, 24
 Apr 2017 16:20:04 +0200
Date:   Mon, 24 Apr 2017 16:19:48 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org,
        peff@peff.net, bmwill@google.com
Subject: Re: What's cooking in git.git (Apr 2017, #04; Wed, 19)
In-Reply-To: <xmqqfugy4pnx.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1704241609300.3480@virtualbox>
References: <xmqq4lxjabce.fsf@gitster.mtv.corp.google.com> <D61D47BD-9750-4FB6-892E-013504E03738@gmail.com> <xmqqbmrq8z4j.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1704211135430.3480@virtualbox> <xmqqfugy4pnx.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ZbkM+YcyulQQVrhSavZbbIk9r/dIqai2RfUxgSG23helt3gePW+
 AX5MRF+//HUWvdzxe06h06+hSGUENL6iWFzmWrZBq410kPuuN2IfCNQGtR9Jc2ShbB9AzdU
 5/fjSJqvvyUCwfnz9VIYpbmqmOMVabeYwdzrNEgPIYghGhV6Zju9IP60ru4qR5+6jFpQv21
 Njp3Ys26RaeSJwmJpBbsg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8pFEjHWKfUc=:Lv7NyCZgx09vXS4lFAtz7g
 SVoz2oMJD5dnUSqPdhMfvqpswhxlEW64cWziKKwRpvZ9AVvf1UwwpvZ58sPxkvPSnkKpC33A6
 f5Lby4OGKaZOLUHlRID+YqYwh0ZTN7aA6Fn/j8ul64DxyFObfmO2wIR7YsywMjbXwV+aqMRk2
 ClBBWFz9FIzHXPouCK0cVG+cIayLIPmRRHqWu/N87UBcKSNrh5/7Duunr4tWU3sNXxni8GNBe
 n8uSdJFkBr6OFFgo8JUGCPxcfMaNPlGEPbjt6iyG+Oiv0nxKGULu2qC2OU6ll942L2yobMcYl
 6n3DsxsTWFpJC0y4fA/2ngMCkmXYV3hsdrqO4gKRoJEG/8xzYQ0PDY82LyIZZVq4agPb3DDx6
 d5SUoHvC4UCuUJZsjGsGokoTj1RxcJr4g41vr992vEjZjeWxIALWZd7caD57ujjhBumedNDQw
 sFzdsb0exM5n20OOxMV1lZqo67AWzKPEog9EzG1lBheAtLH6tNNE91q1SsAWVtasrbUBpvQGr
 koU68aEqlDNjo/YHt7xkpY4qKFb5w3yVvJQlZr2vdUI9RBNso+Pg6miZ8ZvztH+P2nofuBD+R
 tdzwx85nGrKMbxSonW+B4TcsLEFe5lRP0jI8gO1+o20OkZb/bLuf3KWrDjwGSJbXD9H5nGG/f
 0NX9i0QibmCE/s+KSNI5D0wNMiUABBUk2GclDaWcDm5OQpZN1lonA2Ww6ZtiP1e2XA5UR2das
 WhskwfH2shYrIY3GjQuM2ldcjgFD1B3vMmPNsiA4mJxOCHq+p6K7f5cfR939JLSbYmFQys++P
 rILfDa3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sun, 23 Apr 2017, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Part of the reason is that you push out all of the branches in one go,
> > typically at the very end of your work day. The idea of Continuous
> > Integration is a little orthogonal to that style, suggesting to build
> > & test whenever new changes come into the integration branch.
> >
> > As a consequence, my original setup was a little overloaded: the VM
> > sat idle most of the time, and when you pushed, it was overloaded.
> 
> I do not see pushing out all them in one go is making the problem worse
> for you, though.

Oh no, you don't see that? Then let me spell it out a little more
clearly: when you push out four branches at the same time, the same
Virtual Machine that hosts all of the build agents has to build each and
everyone of them, then run the entire test suite.

As I have pointed out at several occasions (but I was probably complaining
too much about it, so you probably ignored it), the test suite uses shell
scripting a lot, and as a consequence it is really, really slow on
Windows. Meaning that even on a high-end VM, it typically takes 1.5 hours
to run the test suite. That's without SVN tests.

So now we have up to four build agents banging at the same CPU and RAM,
competing for resources. Now it takes more like 2-3 hours to run the
entire build & test.

The situation usually gets a little worse, even: you sometimes push out
several iterations of `pu` in relatively rapid succession, "rapid" being
relative to the time taken by the builds.

That means that there are sometimes four jobs still hogging the VM when
the next request to build & test `pu` arrives, and sometimes there is
another one queued before the first job finishes.

Naturally, the last two jobs will have started barely before Travis
decides that it waited long enough (3 hours) to call it quits.

To answer your implied question: the situation would be much, much better
if the branches with more time in-between.

But as I said, I understand that it would be asking you way too much to
change your process that seems to work well for you.

> As of this writing, master..pu counts 60+ first-parent merges.
> Instead of pushing out the final one at the end of the day, I could
> push out after every merge.  Behind the scenes, because some topics
> are extended or tweaked while I read the list discussion, the number
> of merges I am doing during a day is about twice or more than that
> before I reach the final version for the day.  
> 
> Many issues can be noticed locally even before the patches hit a
> topic, before the topic gets merged to 'pu', or before the tentative
> 'pu' is pushed out, and breakage at each of these points can be
> locally corrected without bothering external test setups.  I've been
> assuming that pushing out all in one go at the end will help
> reducing the load at external test setups.

Pushing out only four updates at the end of the day is probably better
than pushing after every merge, for sure.

Ciao,
Dscho
