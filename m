Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19C0F1FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 22:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932530AbdBIWML (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 17:12:11 -0500
Received: from mout.gmx.net ([212.227.15.18]:52875 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754162AbdBIWLT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 17:11:19 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MV5hN-1cuq4e206P-00YS0j; Thu, 09
 Feb 2017 23:02:53 +0100
Date:   Thu, 9 Feb 2017 23:02:51 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Ashutosh Bapat <ashutosh.bapat@enterprisedb.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Bug with fixup and autosquash
In-Reply-To: <xmqqwpcznjqi.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1702092301070.3496@virtualbox>
References: <CAFjFpRe8zqxs4OLbCrjnuEzF=75sbBJ+HuZqek49B=O=TFHq8A@mail.gmail.com> <xmqqbmucuwb0.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1702092142020.3496@virtualbox> <xmqqwpcznjqi.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:VWxHs2K9S2weBbDysubR1+HrnlvAPp43UNE9IYGmr2uYY2np55d
 tYMupwKOZAXSKnvz0ps/1qoxoulk4VxH6APvZGYpwIJ8I3awhw/Z4/Xrk8THwgFyM/U4YqY
 fYT2+5hfIkQMvrjiCPVFyW4p0PUF1rU7wXZNYqK11gQKVF79yMmWIQ6OdisxTwL3bXA12HQ
 aQgsXJmhklBZdvD71Yxzw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qZ+bsAvgqcM=:fD2izIhobtrCkT1XVy1PJ6
 aI0SIbrPZxOuwsJDD5yX9oiDtKQwoRlEsM+xasPyRjxWqPhfkZ0d6ZTvLMBJTTlADvArSLTv9
 w+TsG8yuAY2PSduYazEyMPery8ND571yuQfVY6Eeq0LA7mFEUjfLdlqautLU1bm3jmGJPYJCB
 u6B0Q+E5msmMXj3X8za4yaR6iFR8RNN+FKKkfXStkR1YfKLabpTnR3ChGIrj8fFSSk1s3+xm0
 KpRriYLbTxMufpMLLPlL4EdPRksg/k0fc7sT1LFS9iDoWSTB9Y/uAL7CZ5AxdgDerWgQ9N5fU
 lKtQ8cH1FWAUlfFNW8es5mENFc+vjMLo5Ugw8SBCf7UgnjxhNAKB2hU6V4EpsLhDmRVkfmEl2
 NZ+f+S3nNJodosPp5bUKN3/4ka5buDJawew84VyDCyj2NZ1S0fFEgYzhhdCSISFTBgG4hzUr6
 wFg0iRBNjZe3njFXUDt9ViTfQPJAHkA9G2hzWHj0q5VNCuTT4n8vpBwBPRA6rHI6NH3lhv8FF
 JIoHg9fpr883SWh7k+8mpPwLJA7+Mm4BZ8PajhSf05HyXXLi2dhSeOuKkAI9sbm6nwDAuFxmk
 FsnZ0X+GFPWp6k6eQlCDXXja3TRhGGihG7fAV+ZiSXyaMr0pPtlZ4hIYEHNmFp+klIj6uG50l
 FYA2DfNRFhlrGbSbUSXYYxbarBC/FAlBM9EXSQUssii9r76JY97soOQ/CN+XtOb7SECFd0Sf1
 /fWQ8GZIyVcSAMBfkAnKGG+iLxG9m0GAUxiPoJ2kC5WnJuHmpXj6aabIdK4YyO3Dvk8yJNoLB
 wdCsYut
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 9 Feb 2017, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > This prefix match also happens to introduce a serious performance problem,
> > which is why I "fixed" this issue in the rebase--helper already (which is
> > the case if you are using Git for Windows, whose master branch builds on
> > Linux and MacOSX as well). I quoted "fix" because my motivation was to fix
> > the performance problem, not the "incorrect match" problem.
> 
> In other words, regardless of your motivation, you "fix"ed both,
> which is very nice ;-)

Almost. While I fixed the performance issues as well as the design
allowed, I happened to "fix" the problem where an incomplete prefix match
could be favored over an exact match.

I really fixed the performance issues. Not "fixed" them.

Ciao,
Johannes
