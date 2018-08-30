Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4146B1F404
	for <e@80x24.org>; Thu, 30 Aug 2018 11:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbeH3Pxk (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 11:53:40 -0400
Received: from mout.gmx.net ([212.227.17.21]:47943 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728297AbeH3Pxk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 11:53:40 -0400
Received: from [192.168.0.129] ([37.201.193.173]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LgdBZ-1fXrFR3G6P-00o1cH; Thu, 30
 Aug 2018 13:51:40 +0200
Date:   Thu, 30 Aug 2018 13:51:38 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Ulrich Gemkow <ulrich.gemkow@ikr.uni-stuttgart.de>,
        git@vger.kernel.org
Subject: Re: Trivial enhancement: All commands which require an author should
 accept --author
In-Reply-To: <xmqqpny1at28.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1808301350340.71@tvgsbejvaqbjf.bet>
References: <201808282305.29407.ulrich.gemkow@ikr.uni-stuttgart.de> <nycvar.QRO.7.76.6.1808291653190.71@tvgsbejvaqbjf.bet> <xmqqpny1at28.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:LQVHLZEL/7U75c7M3gHtg2QWkgzYgAT9HGUNhFZLqZv4JflYtHi
 l/3sUjBJtH3GpxU9hnZ9QbHdpc8UO8+S5XmNPyvIn0uzuIgbSnU53GbG36kwxlTMZFjxQ5n
 c4XDf9oO3UWTuTbci8m0y6KqYeMWdlA2UN6WmkJwTK7pt5czeYi2+VoaHiqbZu6ryYDtt/s
 AML9oO1c3ZG5L8FhB6Yqg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LSnYxaPahDM=:qEz5/lKt0r5HvW2yGabBIc
 Knokwfj0ltxgMFTzezd1b+tYTw9P9IVDHGZRSN4M2l/0PXGp7tVIWmqkMdDr3x8pvprM9MWxY
 TZMl2ofEhfoamVvQbLQvZvU1HUylbraGVieBp2w3tvQ28/3N7nQBMbqyYc7dyELZxt2VOeR6Z
 6KOzCFjbyXaVkhQWIpWRpb7JAWqIpJDlHVEU3Ja5jJLmSNPeLf+9jsYo9IDSD6cbEc/pl2AsU
 /9sbbtmzT9Sc0ox5yvuQyBxRJ5vcja3s+4R2/+ssXXeMIsl4gGn7U5c4AQneIb5XHEFQQT0DY
 l+5lYOGuNisApp6u4vV/gzQ6YsoY/tLBkBpLBQIhr7PrEWgjyGprQggdE0UY/rtRexpVBBmj+
 2vx1NedOsEx6uJhVjfGO3fKPHWez/V0Rp5fIQ/mZyt2lGnY9he6VsbweT2KKtBlVKZ1oB+Q3Q
 xqSQ6ttbzMVX7sgRw81qWlrsgGG8Foa5og2CkyT/n05gRcjhvydnzYy4hM7rvoMMeHfONWG+w
 ou9fbgDzAI7Nc7aMbICfkV4fvnZfto+oBc7IzZHTJi6Z2lAfhY3TSa2CHKMnuUwQXuc80BXx4
 /FSxl/++VGq8blV+IWR9nkRtM+WgjHGiW7WTjUy0M1iq0vIn4d6ff3JnzvRdXMgqfLsBXilNo
 gxny0Yt+z1gTceDGh9T0zM56BrKXJy5cTArPqraY/02+ngb5JM/uEHmsoI1RRaYu7PePDurck
 MUJxGH/GI+6qIhclU5m2KDLXd0dup2tWp9aTx38douSgM75753I4P3dqDWhyhWYKzhVWO6t9c
 b+wJay/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 29 Aug 2018, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > The `stash` command only incidentally requires that the author is set, as
> > it calls `git commit` internally (which records the author). As stashes
> > are intended to be local only, that author information was never meant to
> > be a vital part of the `stash`.
> >
> > I could imagine that an even better enhancement request would ask for `git
> > stash` to work even if `user.name` is not configured.
> 
> This would make a good bite-sized microproject, worth marking it as
> #leftoverbits unless somebody is already working on it ;-)

Right.

What is our currently-favored approach to this, again? Do we have a
favorite wiki page to list those, or do we have a bug tracker for such
mini-projects?

Once I know, I will add this, with enough information to get anybody
interested started.

Ciao,
Dscho
