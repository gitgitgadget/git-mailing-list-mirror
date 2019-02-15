Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9016E211B5
	for <e@80x24.org>; Fri, 15 Feb 2019 14:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbfBOO7Z (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Feb 2019 09:59:25 -0500
Received: from mout.gmx.net ([212.227.17.22]:47925 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726831AbfBOO7Z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Feb 2019 09:59:25 -0500
Received: from [192.168.0.171] ([37.201.195.16]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MYOCL-1gYspj3t6v-00V5qQ; Fri, 15
 Feb 2019 15:59:11 +0100
Date:   Fri, 15 Feb 2019 15:59:12 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Randall Becker <rsbecker@nexbridge.com>
Subject: Re: [PATCH 1/1] tests: teach the test-tool to generate NUL bytes
 and use it
In-Reply-To: <xmqqimxm6msi.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1902151558080.45@tvgsbejvaqbjf.bet>
References: <pull.126.git.gitgitgadget@gmail.com>        <34cde0f2849a098c17ab83786da5ce06f69cfafa.1550179990.git.gitgitgadget@gmail.com> <xmqqimxm6msi.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:hfjKigIiC0Gs9yeApojnODLRxmytfo7wCerun+CqYi1RJLvAhW2
 bh2dA6tHGt4tvi5p//QK2qzsWM4mU1I7LP3ZIxcyg8DuIA8sE7mqK9NdyF2yZfcLdsElAIa
 HJsDScaslihlvVimqDTrTaPE3BDGt6E9Fcn0nGNOrfuMp+ZnXsaSWJQ1xx4stQUCUapAg/T
 ZAWHBJlUiqedAMsDFU9Jg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LgxaMjv9ni0=:jvOW/CjjoZrxLR6gOSCzkP
 lFIo37aljLig1asNnpH7QK1yTL2gKtO0KSQYuj5QKcXwRQiXU4nh/i2KTBWRfxnlsBoIf+a8U
 +49Gq3Ig2IfQ2qdimaSjXuxx9EQ+qGwlaxm5FQFsh5+r/Dk7Z35SduO/VhQfhRYfIiuyPpH/I
 S4y040b7ta5Lk2XlrxjCTw5yzRH2AlubrjQxFbYo9SaPJA9U5XoO2BlHImAzdBCeSXpezoYPV
 mG7YlKxh15FTOnAjFradKpCgsh3LwCNWVODua6IjEdV3vFuXmxlwwXIcmXRSwjr/PIIkr/DTt
 2jR1UY9kd2wIplOeSC0rc08JnwIQDOAZwMIrB2fw7ZJQ/O0QzNVfY8IwRqsbcMq1WXXPt6ykg
 4hfCqLeEhPswmnyxsARvaTMYN5ZaOzDbaZDZ4fZSZZnVF22Yrh3mOoEywLvjUv8VGYHWDhIhc
 fYdoFfME1zSp/AVZnuo9SkTNBl1IsDD/RxBPpGRbKTjU95AARDKBhK58U9WBT0r+ZsjDRp95j
 j9gDDy2Ra+B9cEsfg5FH0ysfYZYGWPV1CcEWdmuXLPdQcYsCkgHC+F/ql/EVGQ2bm759SeyTM
 /mhfXbV/0k2syeLHcdujoHWUiLXW9akMrts9qf5ucsuAOzg4SOXJDQKRgNVaWRB/5aBt5hpt+
 zkXSt8nSIRNtdtvVwWzwKi3U097WeSEA5TqL0AkHX9ZHnt+Rfj9V1y/TK6sYqa/aNVctYsUGk
 KUWrKe8M4RjfHXG/0jlwO+Y+Aur3UEsPsD84nezMocl1xHucyw6sOJJ3VJI9Ceok5/yBuWd7R
 BsVm4E9+xQFe7i4Hr+p8FN0uTuu8ro+NVY8ds1Wlmvl3bK8Uyj+t2g2OUH1wuXs2uxdZ2qKpO
 VCuHnCAZlNu6R7Z0JvtOnkf3R8Sv/DTZQ1dPYFrEVpwVdkprSUMoorRiC7bKW/ByvLALRaYuM
 yFClGCHXFsQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 14 Feb 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > In cc95bc2025 (t5562: replace /dev/zero with a pipe from
> > generate_zero_bytes, 2019-02-09), we replaced usage of /dev/zero (which
> > is not available on NonStop, apparently) by a Perl script snippet to
> > generate NUL bytes.
> >
> > Sadly, it does not seem to work on NonStop, as t5562 reportedly hangs.
> > ...
> > In the end, though, what counts is that this here change incidentally
> > fixes that hang (maybe also on NonStop?). Even more positively, it gets
> > rid of yet another unnecessary Perl invocation.
> 
> Thanks for a quick band-aid.
> 
> Will apply directly to 'master' so that we won't forget before -rc2.

Thank you, that will be good, as the builds still seem to fail. All of
them.

> In the meantime, perhaps somebody who knows Perl interpreter's
> quirks well can tell us what's different between the obvious and
> simple C program and an equivalent in Perl to convince us why this
> is a good solution to the problem.

I would be *really* curious about that, too.

Ciao,
Dscho
