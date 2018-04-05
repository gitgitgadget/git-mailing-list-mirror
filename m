Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D78E1F404
	for <e@80x24.org>; Thu,  5 Apr 2018 13:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751249AbeDENiB (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Apr 2018 09:38:01 -0400
Received: from mout.gmx.net ([212.227.15.18]:56263 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751165AbeDENiA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Apr 2018 09:38:00 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0McVGq-1emYEg20x6-00HcdL; Thu, 05
 Apr 2018 15:37:58 +0200
Date:   Thu, 5 Apr 2018 15:37:58 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Wink Saville <wink@saville.com>
cc:     Git List <git@vger.kernel.org>
Subject: Re: [RFC PATCH 0/1] bdl-lib.sh: add bash debug logger
In-Reply-To: <CAKk8isqA6Ru05kRJ+xiVHEkzPgH24cKUZbbgw2tEnw4rhafDQw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1804051536080.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1522190580.git.wink@saville.com> <nycvar.QRO.7.76.6.1803301231430.5026@qfpub.tvgsbejvaqbjf.bet> <CAKk8isqA6Ru05kRJ+xiVHEkzPgH24cKUZbbgw2tEnw4rhafDQw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:prtlGUl6jr2ZV9Du754EIGkEVgxODXHXlFd6b6/kRcerNz3IHuS
 qvj7/DsCM9OQI47LkvX3bMYtm0tWEnwblY5YheQTp99cug0iRZwMIJm3ACI9zJcgcyqaqI1
 IwBykwGfuC0GZQEycdN3rn8b6V7vRKXp1GQ9mJ5AU2e/Xt4OZJL2MjCA2uegb14/4vqqU7j
 vdn4QDhJqTHRHACJ10U6w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ErSx+hHEL0M=:Uf3+Hh3BYijEwR/1druXRK
 6evlQ5q4nszRLfqiZPKiiu39nlebpuZ3Kk2SmdXQW9mEvKJcT5S1WyIQkJe5/NRzh/nVoGtfe
 hGT6paES8JHyUGjOfdOFsTdX3R5szTGUPbcoUQ7uLCjdOVycBVuX7F1PfoH0iBsSOxRttMCob
 uT9CER08vPyUwZpt3uid3EUeX6ExULYtfe0tES+q32KZBW4yQBtPXSlrBtyOd3FdrawENEwXd
 rf++mi17fnGPm8XneCCeZoPyIp9Mu11xP+jC3BUZOm+sDtwv75QuoZTxY030b/6L0ykgKo9Qk
 gPghr/jATpY+y9kP48/mJyqX02G+rS/Rwh7nTJ1WuO0VYbYoKk+dv6187pMymw95icIOwIAoO
 9w1PZeHv8GUHA3/EUGhOkq20WL63/6CLlKzdSXqvh4ZgBQdwbNWaFVHG3JphFMSQYYKe2DQpu
 ohzMt7/BCTGWAe/zskeDm2rWKr+oEu5voUdYR92+2y8LUzDmwdIkKJiCYH4TSfsX01J112MMU
 7gagCHvs+5HTngivoIV8zC8cNPZZ1AXa+gcUZj8mhdqXRmUJgw+EWC1uxDsOzmKLYrALTgFmH
 DyEuSuUUBEFppT4KEYxChN8fah6ctQ4EVFN+gpympiH7tgJOejlgfsRyxz2CrE6YZasUJdOR3
 xU9scCrGAhjuSy3yDVo5fkAFxXezsWjHDaykkyE5Gv+K4+MxazO4kc/+81ODOQ7+ShEjALWjh
 YGSusSZZklCTuQAPcrgTooLNqetcN0I/5A7ZcIMM7NROV6QY5Y4nE/mUbJHC0o4ymf7Cxdmb1
 /8NePL31gUid+BywIuZS7EcLu7SZzheA6/p6C0FXLfp6Z7+LVC6PpiGp5BMI1LvrGJowDrr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Wink,

On Fri, 30 Mar 2018, Wink Saville wrote:

> On Fri, Mar 30, 2018 at 3:34 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Tue, 27 Mar 2018, Wink Saville wrote:
> >
> >> Add bdl-lib.sh which provides functions to assit in debugging git
> >> shell scripts and tests.
> >
> > Interesting idea. It is Bash-only, though... (and it is not a secret
> > that I want to discourage using Unix shell scripts in Git's production
> > code, they are a decent way to prototype things, but they fall short
> > of being robust and portable in practice, and don't get me started on
> > speed issues).
> >
> > So rather than spending time on making it easier to debug shell
> > scripts, I would love to see us going into the direction of a
> > consistent C source code. I still believe that we can get there, and
> > that the benefits are worth the (huge) effort.
> 
> I totally agree the code base should use primarily one language!

Great!

> But that's not the case now and "bdl" gave me insight into the workings
> of rebase--interactive and I found little guidance on how to debug
> or learn the code base. So I thought I'd see if there was interest
> in what I'd done.

And realistically, requiring Bash is not all that much of a problem when
targeting developers.

> If I were to make it non-bash specific would there be any interest?

After thinking about this more, I am a lot less opposed to including this
in Git's source code. However, as it is not necessary for Git's
functionality, it should probably go into contrib/, and I would much
rather have a more descriptive name such as
contrib/bash-debugging-library/...

Ciao,
Johannes
