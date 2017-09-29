Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 087EE20281
	for <e@80x24.org>; Fri, 29 Sep 2017 21:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752203AbdI2VJH (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 17:09:07 -0400
Received: from mout.gmx.net ([212.227.15.15]:50490 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752123AbdI2VJG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 17:09:06 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M3zT0-1d6cf43LV4-00rUkS; Fri, 29
 Sep 2017 23:08:56 +0200
Date:   Fri, 29 Sep 2017 23:08:41 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jonathan Tan <jonathantanmy@google.com>
cc:     git@vger.kernel.org, gitster@pobox.com, git@jeffhostetler.com,
        peartben@gmail.com, christian.couder@gmail.com
Subject: Re: [PATCH 00/18] Partial clone (from clone to lazy fetch in 18
 patches)
In-Reply-To: <cover.1506714999.git.jonathantanmy@google.com>
Message-ID: <alpine.DEB.2.21.1.1709292301440.40514@virtualbox>
References: <cover.1506714999.git.jonathantanmy@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:DhrdrrgF02vvNrCSJR415yLknHZ69swRAue74mTywUtdV4fqhFt
 fqfU642M+I3e7BrZrHd32P7qEp7w6PFkHLX+BBdrQ+emBFlpO7nNfj5mDaH6fMvFAoUT4h8
 bQEy7VcLBMMpfmPpyoh87vyp3okV4FmvLxCWctUmUrR3oWk7p1VhohqYNpmn3jG5UegcrNY
 M6CdF2az7oPO0nIJQA5sg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8jNCLUARo5k=:Sg1gJEXifMB+YLCzSetPx5
 d3L4688qG2XCQwANMWXucjpoq3dJ+E6T5m4d2f2SlikzMRXJnrNTs/08VfYrH5JJSRzi73KAD
 RZNrPhbnrTvV2l0mlo+ehCbMvALElkyaveyBxosZ1i9D4X4JZcqDsD/1mNYOY0mQdOj1whvCK
 HX5unR137/WDPySQ1PNAD3/T1vkSg/dDr79nRnidiVaLnqxXoKuQ64FmTz4idFC8eSEFtGiqb
 qHMq+1SnGWPvgScaLgFY7eRYDZBsSS6RvGIgnnq50ocvZK+kXmNPOszzVXjJOp83pbfgX8oMy
 0AX/+CYgMPAFySnTmA6WUqt0TFI5gtb+hqMv9Hpl9aRlGab/EtXDA0CQJ6UHcOA7JzDbOO/nd
 9sLkFbKyc7Q6j9IoZKnEFX/EZtTmDezs+n4YvXPKH1HtlAnR2M+BnKSkNorWt8pxVy8ISZrMG
 oh2quF9h1Tcu64GSowc4e5W8l3W+6gCjvAjwXz4kNeCtmtUqag9rCA2r1MCObbLsTFdBINniW
 KdsSAVnOsw6uV95YFBkoISFDLtVY2kffdXnqW82qwSmaE8ZU9unIi0p/CeAeZObdrfDPgg/gd
 Rs2llvoOcb8MDsgpIxpsyhFYfFZxEy+HBrd99UJ7223BrUVkTkAPUXnrs8F8E1ipQg2k/L4Ce
 GdPmed0ReeB1fHp8y8/sCyvF/PxetxkopofW/ewi/ul87rpwVxH3Vi3RPFt21bzZOVWOeJcGT
 E89Od4Owu9z8wGzIFmgNhGJi7IxR7Y8ogSwMhIDTjARDF9HQ8Wu+qWoNrxTvaweHnw5dfbO9W
 f66L4+xW7EJyEu2YF1JmCrs0JccDVTvBbPG4S9X5fMKqWhZhIg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Fri, 29 Sep 2017, Jonathan Tan wrote:

> Jeff Hostetler has sent out some object-filtering patches [1] that is a
> superset of the object-filtering functionality that I have (in the
> pack-objects patches). I have gone for the minimal approach here, but if
> his patches are merged, I'll update my patch set to use those.

I wish there was a way for you to work *with* Jeff on this. It seems that
your aims are similar enough for that (you both need changes in the
protocol) yet different enough to allow for talking past each other (big
blobs vs narrow clone).

And I get the impression that in this instance, it slows everything down
to build competing, large patch series rather than building on top of each
other's work.

Additionally, I am not helping by pestering Jeff all the time about
different issues, so it is partially my fault.

But maybe there is a chance to *really* go for a minimal approach, as in
"incremental enough that you can share the first <N> patches"? And even
better: "come up with those first <N> patches together"?

Ciao,
Dscho


