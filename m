Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD0882021E
	for <e@80x24.org>; Sat, 12 Nov 2016 12:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938756AbcKLMuJ (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Nov 2016 07:50:09 -0500
Received: from mout.gmx.net ([212.227.15.19]:61566 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932182AbcKLMuI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Nov 2016 07:50:08 -0500
Received: from virtualbox ([89.204.153.5]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MIuzJ-1c7SUy2mxF-002Vlc; Sat, 12
 Nov 2016 13:49:54 +0100
Date:   Sat, 12 Nov 2016 12:40:14 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] t0021, t5615: use $PWD instead of $(pwd) in PATH-like
 shell variables
In-Reply-To: <xmqqa8d53ky9.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1611121237230.3746@virtualbox>
References: <f4336a7fa3df8c0b426c3d01ada8d7d8f38e588a.1478881741.git.johannes.schindelin@gmx.de> <xmqq37iy3q0s.fsf@gitster.mtv.corp.google.com> <fa11def5-a878-a5c8-6e7b-627ea8cda7e2@kdbg.org> <2b69d098-92ef-77b0-367a-516e9edbe257@kdbg.org>
 <xmqqa8d53ky9.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:t/Na7RJyiCRY5Jnt88e9prwgWAWwUfrp7UbzDRDevYK3EuIHSG3
 LZ4izYevTj1SM9x30HHjIhjJshEWbQ1TI/R+SyafEsSlXiv9x0nTDKioczfO6u8LGjYGxxi
 6WANDA/fhJp6vlWDvqyMQ9rFosd1ivlqAEC8ZJI11yqD2ZhO4up/JWDeZgdxZ0P9LktsfEI
 +obpTiy0SmJAOETuyApfQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:eArjJ/WTjHE=:xoJCzK6SudVxEuRGQgWqk4
 R26OcpMno/nLgSkRL1TFkAzHTS0TJpu1BdgMi2POtgZWPef+Zxj1yBaFJ+W8r8GKqFd9MQgtx
 JQY6yJtNyDnkNgo8yDcex1CPh1gIyn7TGd8hz+zV+EEjg7vwi98Mvfa5P3VjyKBH+PDd4k4QX
 oLbsp3Kva6U/ne28stVTvBdUQz2qk4hVCpvA0PGjuS2FAM8C4cwbCcZEx3iXyED6hGPQlCCq2
 PmEN+auWa7dzSLzXnGC1Yg7DGtAsE1pUKdCCiHjoSxzeMYaVFtLcZUnvf4hiCH76gs9aBbzvn
 K0xX5wCHMIZyWc3WW8eI3zdlm6itLg8ccI72nC6ZbOON8HPSR31GasaOArahRRod17qL5UoHC
 tn+EB9hXxaBmdm9eC4+cxz/TQeu/VY5TktH+Za1JQWRGWIULih6YV1fTx3XItSzDbqQFvXzng
 BTo2POPzimrmBZ57hA3yX6MczA9s45wzNeEUZSJmenYQYmMuumW3eO4qIkKatjLWcKB0qY2wt
 x6QqUwe+PZ9d/ekrJlP2jlo+kwXrOzQTnNIsZIXhJPXyfZoEooPz/rY2kBqCxH598xyUjnVom
 nclRv5ojt2oMtY6KKxpM+8biHRI7OVsctJBJQP7ogN4yS8q+ZXFxeAplNt2an4Xl4pBY0hfBW
 wyxGvHiI+aqT0fDAIRfKk07c0qUXkJaXlKo8txmbBHTXi/CB4UmoLsXuFrrR0FLtoJ2q5D305
 /RHq5VMTnScrUcfElY2ObNTaSckK68dl/zRK+TzCjCemGCggNkb36ielMssZJuppnYBDxxWHo
 H+HQogeP14pB0CNHGVlQN0fUtOGWg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 11 Nov 2016, Junio C Hamano wrote:

> Johannes Sixt <j6t@kdbg.org> writes:
> 
> > We have to use $PWD instead of $(pwd) because on Windows the latter
> > would add a C: style path to bash's Unix-style $PATH variable, which
> > becomes confused by the colon after the drive letter. ($PWD is a
> > Unix-style path.)
> >
> > In the case of GIT_ALTERNATE_OBJECT_DIRECTORIES, bash on Windows
> > assembles a Unix-style path list with the colon as separators. It
> > converts the value to a Windows-style path list with the semicolon as
> > path separator when it forwards the variable to git.exe. The same
> > confusion happens when bash's original value is contaminated with
> > Windows style paths.
> >
> > Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> > ---
> > Am 11.11.2016 um 18:11 schrieb Johannes Sixt:
> >> Am 11.11.2016 um 18:06 schrieb Junio C Hamano:
> >>> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> >>> ...
> >
> > When the MSYS program such as bash invokes a non-MSYS program, it
> > translates the Unix-style paths in arguments and environment variables
> > to Windows stlye. We only have to ensure that we inject only Unix-style
> > paths in these places so as not to confuse the conversion algorithm.
> > Most of the time, we do not have to worry.
> >
> > On the other hand, when we write a path to a file that git.exe consumes
> > or receive a path from git.exe, i.e., when the path travels through
> > stdout and stdin, no automatic translation happens (which is quite
> > understandable), and we have do the translation explicitly. An example
> > for such a case is when we write a .git/info/alternates file via the
> > shell.
> >
> >> A simpler fix is to use $PWD instead of $(pwd). I'll submit a patch in a
> >> moment.
> >
> > Here it is. I had proposed the t0021 part earlier, but it fell through
> > the cracks during the temporary maintainer change.
> 
> Thanks.  Dscho, does this fix both of these issues to you?

Apparently it does because the CI jobs for `master` and for `next` pass.
The one for `pu` still times out, of course.

Ciao,
Dscho
