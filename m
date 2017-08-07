Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3ED692047F
	for <e@80x24.org>; Mon,  7 Aug 2017 19:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751921AbdHGTXO (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 15:23:14 -0400
Received: from mout.gmx.net ([212.227.15.19]:50724 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751800AbdHGTXN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 15:23:13 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MhAVV-1e17qv0mhd-00MLLp; Mon, 07
 Aug 2017 21:23:00 +0200
Date:   Mon, 7 Aug 2017 21:22:57 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Michael Forney <mforney@mforney.org>, git@vger.kernel.org
Subject: Re: [PATCH] Drop some dashes from built-in invocations in scripts
In-Reply-To: <xmqqshh3qqs4.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1708072113570.4271@virtualbox>
References: <20170805064905.5948-1-mforney@mforney.org> <xmqqshh3qqs4.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:lJljG7CfsUiqkPHObSt0wNi/T+myeGdDtZOd0Nb+AaL7buR3abL
 N8kxHhgl2g2NHHbFZiggZDvW1dpaT8M3wzp2gGpOTIpGWNAcyMU7fy12AGbOgRDE9nWnFpy
 UJgYQOyBtfAy5HV1a8HoOSYckU1s9m0pUK22u6XM6OOaYEVrE0mrDGmAV/HT7+/yq/Ps+J1
 fiM4+Dgi+32EGHic7LHcg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:k1FT/Q1z9X8=:qzzP60dVTtNUOcmHHG3O4N
 /Ij97YevZXh4yGxmU6UujlIpNRKYFd4d4PP7WXWwZwoXGCl/ms/hAWcdrrlRCLjRI6ULQeY9X
 0IitcnHUhELpW9f0J9ZsX9gaI5w5RnNRm56lcK4x5DHkGVFN6Q6CtIKp06cnZDYTttiO3hfad
 6tl0V7F3zpDBFrNhyvVvQCxyUC+wsNr+BqR6MBlI/wPjSdc462KK6Q7Ctl5H8W5r76w4iud2a
 xLUbttFHz4A31n/exjDbD7mzZolJyCzeYLAJkUvY6zHMt34Xmq2Jer3vKDw6fKDFyoim7zmqh
 878s/FSWyE07ayH5zanNJYiJmqPQpdpiD1SrYsQ7Yi1SUmwPWxlXq4Zg56gplY/rjrd/aR+Jx
 XXZ6Xhzeo9YU0ltUnaE9YKU0wJ7nTmOXmWDi9k9bw/v/v+D+vglEO+CShV4dMQJgpG5LIhk52
 LD6SCsdh6mA0JeUuMC87G9Lvvvhlh54jAwyaypOa9pP98Eq1V2tM3QemoqeYw8NToUD0+FATd
 lGcdMk4TO+U/MHOZ38lXj2Ru1nzVIHUg/9sP+dayq7hC59e5JW+U/7dD4NrmJSxglEwc2mbCQ
 BxpCcdlyP9IX5EL9ugK5NzkwaT218czM+FkbqA0Vr4zkTNIjBpanqOl3AzDxez8j2pamuwFmc
 f5lZq1x1uOMZGlUoxg+mLLCIdFCjLQ6s3kFg7PfaOktSNfZyGOuNQj146YVrVpUU/VLg2lgML
 C0hBXpOvkF2YQtYzdHL3s2pgj/aCEgSGlvRzEQxtfXupWKJemA0qHA+ZGSQSVwk2g1k34Z278
 Bl23NVd0xxWko9jtIwhCrWA8numrMCVAeAdBPSN5N1ZB0sR1KY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 7 Aug 2017, Junio C Hamano wrote:

> Michael Forney <mforney@mforney.org> writes:
> 
> > This way, they still work even if the built-in symlinks aren't
> > installed.
> >
> > Signed-off-by: Michael Forney <mforney@mforney.org>
> > ---
> > It looks like there was an effort to do this a number of years ago (through
> > `make remove-dashes`). These are just a few I noticed were still left in the
> > .sh scripts.
> 
> Our goal was *not* to have *no* "git-foo" on the filesystem,
> though. It happened in v1.6.0 timeframe and it was about removing
> "git-foo" from end-user's $PATH.

That was in the v1.6.0 timeframe. It is past time to reconsider the goal,
though, as there is really very little use in keeping the dashed forms.

And it does hurt in some circumstances. Take for example .zip files: they
do not support hard-links. So if you need to distribute Git binaries in
.zip files, you are not only affected negatively by the less-than-stellar
compression ratio compared to .bz2 let alone LZMA, Git adds insult to
injury by *forcing* an additional inflation by pointlessly adding the
builtins *again*.

> Earlier there was a more ambitious proposal to remove all "git-foo"
> even from $GIT_EXEC_PATH for built-in commands, but that plan was
> scuttled [*1*].

That *1* is not a good reference, I am afraid. It says very little in
addition to paraphrased commands to stop responding (when a more civilized
call back to rational arguments might have been a lot more productive).

In that light, would you kindly explain in your own words what is your
current thinking on shipping dashed forms of builtins?

I mean, I can understand for git-upload-pack, to help with determining
permissions on server sides (it is easier to filter out all `git` commands
than to painstakingly look whether argv[1] equals `upload-pack`). It's
sort of a very unfortunate outlier.

But I cannot understand at all why we insist on installing hardlinked
copies (or not so hardlinked copies when hardlinks are unavailable) for
builtins, when these copies really outlived their usefulness a long, long
time ago.

So I would love to hear the arguments for keeping the dashed forms of
builtins, even if the only surviving argument may be "I dig in my feet
because I always said we'd keep them".

Ciao,
Dscho
