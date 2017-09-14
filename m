Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD34820A21
	for <e@80x24.org>; Thu, 14 Sep 2017 22:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751782AbdINWRN (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Sep 2017 18:17:13 -0400
Received: from mout.gmx.net ([212.227.17.21]:61650 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751543AbdINWRM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2017 18:17:12 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MGzwE-1deofa0V2w-00Dqc3; Fri, 15
 Sep 2017 00:16:56 +0200
Date:   Fri, 15 Sep 2017 00:16:40 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Michael Haggerty <mhagger@alum.mit.edu>
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 00/20] Read `packed-refs` using mmap()
In-Reply-To: <ef919cc7-7e41-afb6-38b2-e2fae4efcbf1@alum.mit.edu>
Message-ID: <alpine.DEB.2.21.1.1709150012550.219280@virtualbox>
References: <cover.1505319366.git.mhagger@alum.mit.edu> <ef919cc7-7e41-afb6-38b2-e2fae4efcbf1@alum.mit.edu>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:lddnY01d9t1w2cLLeT4DkJdcfn3XnD90CSpMmNQ6I3Sln1a3xs6
 iEo3MBNRd0XpTBJNaF99dJPSZ8BZYk3vzEghFwb5JL5g1CCIjonxfOkSJX1QpAktLjleVbq
 DBR6WkM/nyDV64q1Mo8gLr9biFmlqoq1BejbR13Yjy/Ycc5AtRgx8BPQmTvD/PB421KonLt
 XOySyDPUk2n82iJ6FZYQQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wRr7p+b57R8=:pSldDTH8pZWrFYdc7Z+Cro
 iOC+sCyFTUxaBXZA3QG6ok7J5Hu5p9acXE6A4OYB0nuNc0z2dm3nyT9D2j80/gf4SV6slbJq2
 o/ZfK6rqr4IsNhzgt/kfEBQan8srHEydKz0qbYOlHk/plPuf9mGskNoxVO2xk53TGFmTw/CHT
 4V0rQvtByBnuZNkY+BFGlK+6Lkx9+44cTQyTf9PCP2WUVr6YgLpLKGDSx1dFx8Lep+X0Wc+dm
 luuXXFYGTrTc7bauRpAuuoyfvkqlWYpcHezEdyNrcdB3Jg3xB3nxE9EVycW5XgxXUVvvxt0SZ
 kVOp99oYbEGXmEvbwkRXr7OFDwgYZUP7BhnWqdAdoGp3y3Pb3H13bhTir/SS/kCO85QI7LLzW
 xYPpJpYawovCWUHFBO0XdwCANFUrYHGLm2CgxwckitnBEI2UH5OFA+epDtPilmiti1WizNQJZ
 Ek/CCK+vOOVjUvz3goBemi2v4lTtZJDbXLV+93mcU3YpDCgt4xSYO38FdJsqpJjJHnKs4XvPT
 7UFOcRvCizDAS8e88VjGMZje47BBJkD05auipyWQ6Go33AAGiW6K9CPKbgubuU6dmC3P6B/HL
 qzh/ksPL3m3FuzKbDobyImFbAPCjVEOghuIXYBLtVVXwk/W9PswCzsc5GtOTNznK3RrcGqFdK
 3Ft+GRM3coyA1ottYxKEPLsZUc3ScwzAqVdBSddQ7ybPw/QWsEdF4H0rAfWF537unJoWtOIuV
 Vmwzz9MmdkCwYesBKjZ7QTIU0uFIzDcUFl04CDjRzH/eUzwkoathpVO9e+2usSNjmjwVS2iv+
 sY8sexYh02xG9F2LlZ75Vpw2L3CXmCCG10sQceb8QT4qZsTvbU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Michael,

On Thu, 14 Sep 2017, Michael Haggerty wrote:

> On 09/13/2017 07:15 PM, Michael Haggerty wrote:
> > [...]
> > * `mmap()` the whole file rather than `read()`ing it.
> > [...]
>
> Apparently this doesn't work on Windows, because the `snapshot` is
> keeping the `packed-refs` file open too long, so the new file can't be
> renamed on top of it.

Indeed, I sent you a mail about it before I checked for new mails ;-)

> I didn't realize that this is even allowed, but TIL that you can close a
> file while keeping it mmapped. Does that technique work on Windows? If
> so, I'll change v2 to do it as sketched below.

I do not know whether that technique works on Windows, but it would not
solve the problem *entirely*, as I outlined in my reply: in
delete_branches(), for example, the main_worktree_ref_store is implicitly
getting its snapshot initialized, and nothing seems to release it.

This is only one example, as I figure that multiple worktrees could cause
even more ref_stores to have unreleased snapshots of the packed-refs file.

I imagine that something like close_all_packs() is needed
("clear_all_snapshots()"?).

Ciao,
Dscho
