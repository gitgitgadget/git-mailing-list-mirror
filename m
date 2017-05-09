Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4461020188
	for <e@80x24.org>; Tue,  9 May 2017 10:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752186AbdEIKub (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 06:50:31 -0400
Received: from mout.gmx.net ([212.227.15.15]:53381 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751723AbdEIKua (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 06:50:30 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MX16a-1dVDrY4428-00VyeN; Tue, 09
 May 2017 12:50:25 +0200
Date:   Tue, 9 May 2017 12:50:22 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     Lars Schneider <larsxschneider@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Script to rebase branches
In-Reply-To: <20170509040943.j3n5li7fapiuvgbj@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.21.1.1705091244420.146734@virtualbox>
References: <8D018370-79F9-450F-97AF-31EF4C95BA44@gmail.com> <20170509040943.j3n5li7fapiuvgbj@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:zMIjlEjYeMYIR6ThR68gkysPPuof3yzUQnUAp2zz4Xlhuc6+lx1
 HNSrM9O0gCw4Sm5Xh93BVsdadJ6d/3rOuz5V/KMdExMU79R3dD79q+jiV6i8p8xcpPwBy4c
 fKuckiHjp7NEwKB6yUWrNNlsdmxeGYlDTuTf18I/AS016D4lpsjdv173AKaLwhOxzY01rFq
 U2gzh3QZFMt+KiCiVxfVA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lr0RyDxXEY0=:sE3PAWInWg6grwBYwvmQp5
 Kj4vB/X9gkmsVbZPHPUy1K4Hr/YkpITF5f9WHLfKikpUm9k7VuPEWQI4Sdwbc9BWpwwvg7GIV
 FtNu5Xll3j/6ZBjWyTp8SUaMFsI2f8UfXW/UZ6qpYT0fb72zzGohpe/7PASJwPwxllmeSaKXu
 19E1ECcnEMGo2VDf0RBlkzpPwvZyhbOI4AKfu3CxW/DqHXSnrxO1wvqXPUX6UtTXzEoV5e4bv
 /FF8jacfi9SEyphQsqB+AbCQTy9iCC6bGutMbXJ1PGP5xTsXwrdR7XaL7fH/sSvR3pR4hl2GN
 o+iMpcQG5hcaAb+kibCyu5VPvcyGSlkjYd5/sL4+HzcpUqSQYn0Xx81Y4ft2rYtj1gcL77wIE
 XmVdyt9kYeBwIW86G1eZ2DICZsbcUk/LUkMG7UHXWsLuskigTtuq4XQvArdWtDM3BI/nuXZUc
 KwdumH4l0gPLHBAz07TA0Wxu6qthEdYP7HEbDX7szn7dK7V+TXyJJjHDATgOsjbufTF9jNcCF
 Ho69rmKbhMXrqDUmIWClmIkbxzkJe5AeLP24Weu4D+Q/ipDYMIUHXLzsIr/tFiR5VNSTUR+zi
 bJ2AlCJK2gSzKahYgLdMCsvZOvVt4iqk2xZLAhPHoLdDQMtfYzL/HV51oTNUohXUFC9JnNqrg
 GrlwC1YeufnqDDUpazIqLFk7+NRVIQxSxkMB3d0aRwkGekOWyAlJ68SDrEg3a+E8nKphHphBs
 iQEH0TZX+0LEmWfkZbNWnafGV7hkkFEUeCbKFfxxb73//cFlZgMDvcvrIDF6esx1PDCcvQice
 0c/f0M8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Tue, 9 May 2017, Jeff King wrote:

> On Sat, May 06, 2017 at 12:23:32PM +0200, Lars Schneider wrote:
> 
> > I am about to write a bash/sh script that helps me to rebase a bunch of 
> > branches (e.g. select branches based on prefix, conflict resolution/
> > rerere support, ...).
> > 
> > I wonder if anyone has such a script already and is willing to share it.
> 
> This is what I use:
> 
>   https://github.com/peff/git/blob/meta/rebase
> 
> There's no documentation in the script, but the commit message in its
> history should give a good sense of what each part does.

That requires Meta/ to be checked out and up-to-date. I'd bet there are
exactly two people who fall into that category.

Also, I see that you do not use worktrees. Otherwise your script would
fail.

When I still hoped to be able to get the rebase--helper related topic
branches in by August last year, I had grandiose plans to teach the
sequencer not only to perform the Git garden shears' trick (i.e. recreate
merges), but also to optionally update local branches corresponding to the
merge commits, including updates to the worktrees that checked them out
(if any).

Maybe I'll still get around to do this, some time this year. And it'll
probably hit git.git by mid next year ;-)

Ciao,
Dscho
