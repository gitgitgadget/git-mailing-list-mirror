Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54BF91FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 13:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756407AbeAHNv5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 08:51:57 -0500
Received: from mout.gmx.net ([212.227.15.15]:59179 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756246AbeAHNv4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 08:51:56 -0500
Received: from [192.168.0.129] ([37.201.193.20]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M5Lqx-1eoGu73a9v-00zVtf; Mon, 08
 Jan 2018 14:51:52 +0100
Date:   Mon, 8 Jan 2018 14:51:51 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Myles Fong <i@myles.hk>
cc:     git <git@vger.kernel.org>
Subject: Re: Possible bug report: git checkout tag problem
In-Reply-To: <160d3e3f291.df909f06277296.7997490218741761365@myles.hk>
Message-ID: <nycvar.QRO.7.76.6.1801081447350.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <160d3e3f291.df909f06277296.7997490218741761365@myles.hk>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:VqiWB0iiKI0glEYQWq4v4xKPr+t7rkJoZ/IMIs+aOoHMscor47h
 jrpqhWFH3/a8RwRolAi6FCXGgRt+L4EAcX0lVLXaHo/MRHWMgXbIQvIMvFz2pHskf0AOliV
 hc1Tds7590/nDhWcMhWKOvBb9RQoKcmpjPvFZDEUO74/4pKxYOm/yD+4kZ0UxzlIi6J8Ywy
 QZmIW0VTA80HjB4jhfGkw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VDTEDdISEiM=:IhrLtO9nW+G16jvk/9zK4K
 RM36Ra+Axaleu44Pvx0Q4B/6PINEWsKR8KsJVXK6j5fUj5oIPSEmLJTjowvdsz61S87pS06rF
 JyUkrHEgCqNpQhO5/gCfCSWBKTwufYIIpUm8QrrYpLDeuZtXfEaEfrAVueu1/1EOdKEyLYh+H
 Fm7ZklHAznxr//Kr21NSM/l8HOVgqymnjTpcnt1KdoSR+NhgBUpLy5mwGSffBtBfqV8VQy51d
 TpSt8NUrIS1JxrhV2WAumGzAvjIOzmsJN8q9x+qskBUK9dWrxKUIRbS3IB2Xy09WiBETLXXVn
 K3w/KN/0zzuO68BM8tjUnB4XBj1P7HQb9nUITTdFg36ZEUsycODrwq+fFaRhADv3sZbukq++/
 pnEM8iTAp/pO9DPp8cXhTiPd4rnNJMZ4Ni9OYv8RgN0iXVblNNJDZOfMAGI8mxOtJyrLfxrvr
 RqwVNewIm3Ke0bGKvZS5v8iuU45ps3HRJbDgYX2p5X/5o/lS4AlFEIWuK3t1Lf51eJ1gxbtmF
 36o0ZWoypVOsLtE+iKSfdyZDU1GwUPgKoFl7fcheiPU13zXKx1v2SwRt6BwFCPrJiLihc05cE
 l/5ADKi96wt6OLu2GwKwkWCwsFps7vxl4wvmFMsIxikD6tqQwRg+gi8EO64P3wAYpKPmuytXV
 lE+DTMFSpRYkRYAcB1RaFlyEvpU+l2NJO4BAh3mZB8qo+thPBgFL7z0z3EqYnlGTTS3i9fMFX
 tpL8QkWzTyqzqIcI1dGpEv4g5KlKcNRdwlCL8rhet4zRSKPz2l41ATGKtQVouyOH1SeZASovk
 tJANGJpUYl51BWNS5Rnk4b7S437ax0yeCUBEROfUiMZY8sBdMYmMb+Cr5M8URkBSyk0Sg0I
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Myles,

On Mon, 8 Jan 2018, Myles Fong wrote:

> Brief description:
> When two tags are pointing to the same commit, e.g. tagA and tagB, if I
> do `git checkout tagA` then `git checkout tagB`,  and then `git status`,
> it shows `HEAD detached at tagA`
> 
> Expected behaviour:
> I'm expecting it to show `HEAD detached at tagB`, though I understand
> this makes no difference for the repo code, but still a bit confusing
> for me.

The problem here is that Git understands something different from what you
intended: if you say `git checkout <commit-ish>`, Git is mostly interested
in the revision, i.e. the commit. Only if that parameter refers to a local
branch name (which is the only type of ref Git expects to advance via the
worktree) does it switch to a named branch. Otherwise it switches to what
I like to call "unnamed branch" (and which for historical reasons is
called "detached HEAD" by Git, something that is unlikely to be understood
without explicit explanation).

Now, as a convenience, Git tries to name the revision when it is on such
an unnamed branch. If a tag points to it, it uses the name of that tag to
describe it. If *multiple* tags point to it, it uses the newest one.

That's why you see what you see. It is intended behavior...

Ciao,
Johannes
