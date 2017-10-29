Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14543202A0
	for <e@80x24.org>; Sun, 29 Oct 2017 12:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751209AbdJ2MHe (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Oct 2017 08:07:34 -0400
Received: from mout.gmx.net ([212.227.17.21]:60406 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750928AbdJ2MHd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Oct 2017 08:07:33 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LZmd6-1dRmb10Twi-00lRor; Sun, 29
 Oct 2017 13:07:31 +0100
Date:   Sun, 29 Oct 2017 13:07:29 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Stefan Beller <sbeller@google.com>
cc:     git <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] builtin/describe: describe blobs
In-Reply-To: <CAGZ79kYpPga-aWmJYXCXT1WyvfeEKnwXEXxq2E0YNYanhUw-Xw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1710291305190.6482@virtualbox>
References: <20171028004419.10139-1-sbeller@google.com> <20171028004506.10253-1-sbeller@google.com> <20171028004506.10253-3-sbeller@google.com> <alpine.DEB.2.21.1.1710281926020.6482@virtualbox>
 <CAGZ79kYpPga-aWmJYXCXT1WyvfeEKnwXEXxq2E0YNYanhUw-Xw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:W4k3LBMT7Q7O+mibcTGmdXs+bbv7Y8KepVKMYgIjBpvZb4/d0Go
 /KUoTqrnN5n7vdndzNNxXCm/VY4zCntTaD3tXGSm5ZHYJkGf+d7B6cBCH4yamFJOS5nmgUx
 l5BQBGBPabQXmRJ5ulnSunRODFRaoYcfXCJiFa5dDVhbm/UKgWurJTgZR3FdjG2+oNfeURe
 bAJ43jhvg327lcDmZUoVA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UTq3t+NFdgk=:tdZAgzmgzBPSVhdRD2Liwe
 /M1XV4RyYhxodYx6GC3DMUaaSGNQchpQHLWtCHQRA4ZLXTMvVKG/EVBPvYHtTK+EyzdpQRjlt
 mMCfB3SZXBn7xz7VnqOjKxIVo1lwitqF4EUZpz8otkFhw1ouexjL6LFIFcET+mNnk6y8E4GsE
 jqgnE8JebcMET7yIHA8XVkGWchUQw/ghqMsAOqGu9Cm47aaqR0OzQ5SVJw3aXRjV72GB6PDVx
 ZU4uYAm5CBQEdo0stfX7DfEK9ISNxteIoy6HiUDyRYZ/K/jy/H2odtkqmqjBW2+aBTSpY4zy0
 5Tdqe0bWSIy7iZDzXu7Rz09y3fLl4p2mqV0O77PoZnq6L3YYVIutiEth2I2LmOhHcnsp3CbW5
 qput9dYD12EQrqjrURts9ONtZGOWjIzdIw2kXG6R1dWsXR9lRXFVBKM+Szr8+ucKp7dq354ND
 5RGXaVhiYCg01rxK7NsVcINmjQPsCtPosML8ftwWHjCB76YEFiiMcg5X0yU5O2b8fjyf26PV7
 pPLQAKTJEnxrFNC4ppfJKNWfVsuwhL5tIlOdjzev5PK5vKzSJaJvTDoT+Amqr4pZz6aSrKwod
 +FnIv3M/KSLd0iNpeXDFMdygrCIrXmLGjr+O4GuGg1FU5OA3TcYdOaZo8T9iYtJ4ffxh/PyfU
 dlcB9pbA9meZ9++Ke18wlKwEiQ7v7koz4NA83VeTQqt69O2Bqoh6yZSiczG9V03Ik7XnUeqcL
 V1XYWahDW9A4BTooYw5wViKZAVJ3SiFQTn9v9aMrrkMC4f+svIi7vWu/HbIEXFSpeEXas6Zu9
 euZwp8gyzUfgwGHsTBkVWDplFIPpATtR5fTs6zJ6H+9Suzo9xznyevkckOmDa07Yxgp4PLA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,


On Sat, 28 Oct 2017, Stefan Beller wrote:

> On Sat, Oct 28, 2017 at 10:32 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>
> > I wonder whether it would make sense to extend this to tree objects
> > while we are at it, but maybe that's an easy up-for-grabs.
> 
> I can look into incorporating that, too. What is the use case though?
> (Is there any error message, common enough that users want to identify
> trees?)

I remember that I wanted to know in the past where that tree object came
from that is now missing (back in the days when worktrees gc'ed away
detached worktree HEADs and their reflogs), but on second thought, I guess
`git describe` would go belly up in that case (die()ing due to the very
same missing tree object)...

Ciao,
Dscho
