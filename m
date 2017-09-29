Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3589020A2A
	for <e@80x24.org>; Fri, 29 Sep 2017 11:55:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752281AbdI2Lzw (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 07:55:52 -0400
Received: from mout.gmx.net ([212.227.17.22]:63372 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752092AbdI2Lzv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 07:55:51 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LiIgB-1dbiRE0lOd-00nT2W; Fri, 29
 Sep 2017 13:55:47 +0200
Date:   Fri, 29 Sep 2017 13:55:45 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jonathan Nieder <jrnieder@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneiider <larsxschneider@gmail.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2017, #05; Tue, 22)
In-Reply-To: <20170919160753.GA75068@aiede.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1709291344220.40514@virtualbox>
References: <xmqq4lsz2x6r.fsf@gitster.mtv.corp.google.com> <7D99B245-4D22-4C9C-9C43-C8B8656F8E6D@gmail.com> <xmqq1so0wyjd.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.21.1.1709151816390.219280@virtualbox> <xmqqo9qbx14b.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.21.1.1709152214100.219280@virtualbox> <xmqq377nwtbe.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.21.1.1709181637420.219280@virtualbox> <xmqqbmm7s9ja.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.21.1.1709191733450.219280@virtualbox>
 <20170919160753.GA75068@aiede.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:GLt4o23V7Gwu06c2e45sMAefo5boIGDTHY4YOVmnh1PdN7bPMNH
 xCC6nBYmITKGIMLnGD96vSAwyQ2QQ8/JF2ISI2kKIsItsVTRzWJAuYBuLFP9wKVESWB0A7K
 xGn84PBEHe0NQoKYbBZWvol+hvTmsBivXvcV1MpxKOB9PNJlZ07MLImb81M+MWiNhuSFnYW
 FoAAsqLaMoCgbA4tQsx4A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Jfgr4skuNbw=:JAKEbfHnz7WzriwbAcY1Wi
 QMoJp5yaFP9hUjSujlIVDh7ZOEV7LEUNMjvHqnzv0bARB8d5ANYI28CUWKOO33DhKZvdPLA9c
 ywoCqFqRfnO4HD6DUHUgzBQm5NSoH21JB5EuWTnEuCJkbc1vQu0DJdfvXdpgK881xXpMdU2Cq
 8k8nMLnOh4/bl0lmWflnItUUYJELoatO/oKt4j+K0awUJ4mAn8az+R9sUwPcI3sx1JIMVpxnT
 z5N+59kaelzvCOFGyFLb3edE3GZ4YWIt/BFv3zCg8M5SKho9VJxI/cIygdLZNCK6EId/mNWO4
 JR4uPjgb/Xy2yea/ZCES7O27AceCyMUqrChrDwaK7Vk2ce156+aFIWFPXOtb2Q5jfKuKiw3is
 ARs9psy8jrNIGHncjN/RWUQXjJjbDJfwahM6loshMnFW45M49CelAF9vkXf4IM4C9QG2+Ds3y
 IHTIHaWosJ5yLu2wgydLrKeXy3NoQ1IPK306qpc+Yry3XlYre7zrOgUL4vkW6Gb+Uulv9cDuh
 RQwrEQNGx+63LPrQYTqzmEhBtQMTrnXVxC+JsiNh7CUV9CgHNqHu5xI+tYU1iIu5yIm4q/6pS
 PBn8/LczU1bkMnekbFYhfSqRDx1OIs9Sj0MvvRu5dyeo1tqBqrYO7MscMGZvw2ZAS0RM6BHDR
 Bx1OCf8p6ziXzi4KP31EFvJ9dIfw67fEN+f7UzWBHpeIwe6R8xYVyXRKfisFDrB1m+rcJqCFV
 wTZ3GROI+VyRMBJFSsrtuifij4vvNrMImSIYtaT7ri0e88J9lJY7gMPzXOvNpU7b/HLQpF3Dh
 vlLr1Q8eqWSdmTHwVKyyVAhyLtoCTGR2PQPVWnMUq4Px7oaZVI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Tue, 19 Sep 2017, Jonathan Nieder wrote:

> Johannes Schindelin wrote:
> 
> > To relate that, you are using a plain text format that is not well
> > defined and not structured, and certainly not machine-readable, for
> > information that is crucial for project management.
> >
> > What you need is a tool to aggregate this information, to help working
> > with it, to manage the project, and to be updated automatically. And
> > to publish this information continuously, without costing you extra
> > effort.
> >
> > I understand that you started before GitHub existed, and before GitHub
> > was an option, the script-generated What's cooking mail was the best
> > you could do.
> 
> I think you are subtly (but not directly, for some reason?) advocating
> moving project management for the Git project to GitHub Issues.

No, I don't. I know how cumbersome it would be to move tons of people over
from one type of project management to another.

However, the current situation is not really tenable, is it? It is tedious
for everybody involved. I know Junio defends the status quo, but I cannot
imagine that he really likes it, as too much is too manual and
labor-intensive.

As I mentioned at the GitMerge (which was a bit pointless, because Junio
was not there, not even via Skype), I do not advocate one radical change,
ever.

> For what it's worth:
> 
>  1. I would be happy to see Git adopt a bug tracker.  As we've
>     discussed on the list before, I suspect the only way that this is
>     going to happen is if some contributors start using a bug tracker
>     and keep up with bugs there, without requiring everyone to use it.
>     That is how the Linux Kernel project started using
>     bugzilla.kernel.org, for example.

I agree that a bug tracker goes a long way. Personally, I feel Bugzilla is
way too clunky to use, but I am pampered. However, I could imagine that
allowing issues to be opened at https://github.com/git/git, and
encouraging bug submissions there for people who really need to be able to
find out very, very quickly what the current state of their bug report is,
would go a long way.

Of course, this would require a commitment by Junio and others to allow
discussions to move to that bug tracker from the mailing list. Once that
willingness is there, this should be a viable alternative to reporting
bugs on the mailing list (and have those reports go unanswered because
they fell off the radar...).

>  2. GitHub Issues is one of my least favorite bug trackers, for what
>     it's worth.  If some sub-project of Git chooses to use it, then
>     that's great and I won't get in their way.  I'm just providing
>     this single data point that approximately any other tracker
>     (Bugzilla, JIRA, debbugs, patchwork) is something I'd be more
>     likely to use.

My experience with Git for Windows, where I try to live Postel's Law by
accepting bug reports via mailing list and GitHub issues (and earlier
Google Code, when that was still alive and kicking), and to a certain
extent even via Twitter: next to nobody likes sending bug reports via mail.

So to add to your sentiment, I like Bugzilla *less* than GitHub issues,
and the worst bug tracker is a mailing list.

Or maybe you have written a shell script that can answer the question
"which of my reported bugs/submitted patch series are still open?" for
the Git mailing list?

>  3. This advice might feel hopeless, because if the maintainer is not
>     involved in the initial pilot, then how does the bug tracker get
>     notified when a patch has been accepted?  But fortunately this is
>     a problem other people have solved: e.g. most bug trackers have an
>     API that can be used to automatically notify the bug when a patch
>     with a certain subject line appears on a certain branch.

Yes, I agree. The willingness to see the problem, followed by the
willingness to discuss possible solutions, those two need to be the first
steps.

Ciao,
Dscho
