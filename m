Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE4481F404
	for <e@80x24.org>; Wed, 29 Aug 2018 14:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbeH2S0e (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 14:26:34 -0400
Received: from mout.gmx.net ([212.227.17.20]:38307 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727428AbeH2S0e (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 14:26:34 -0400
Received: from [192.168.0.129] ([37.201.193.173]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MPlMc-1fytLj1elO-0053Dq; Wed, 29
 Aug 2018 16:29:17 +0200
Date:   Wed, 29 Aug 2018 16:29:16 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jonathan Nieder <jrnieder@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/1] Teach the builtin rebase about the builtin interactive
 rebase
In-Reply-To: <20180828171748.GC23314@aiede.svl.corp.google.com>
Message-ID: <nycvar.QRO.7.76.6.1808291525130.71@tvgsbejvaqbjf.bet>
References: <pull.23.git.gitgitgadget@gmail.com> <20180823024856.GH92374@aiede.svl.corp.google.com> <nycvar.QRO.7.76.6.1808260144570.18296@tvgsbejvaqbjf.bet> <xmqqa7p7lmzp.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1808281451191.73@tvgsbejvaqbjf.bet>
 <20180828171748.GC23314@aiede.svl.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:/is1p9fBwduNmvDj1nSrStq2zlKe+MZiMR/qlNvuOtGp1MCKb5d
 cHLozljVekJoYNq53g9onkmDQfou3IwtvfIOuGzhY2ilow0VIFYBqSMpx1eXmSiwPqrX6Wy
 UHBUEXLnd+9kPhCiQbtuO+TrIfjmGXkpSa3Yy+OsCQxrRTUvc/F1+inl22iSvcN7F8slcLF
 Xtc4VHSvjI+wBYjsb+xKw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zPwL7wPp0JU=:kZxPGJ2ZCMitUm2r7aWZs7
 5PalxoGcjR38E7k8bVa/+6ZrLbR258/Y1qeCdUTZ+YnhwdoSKJoHip/SoQCUQdFRYPCVw6w4r
 h3A0gQVwuyS8Gqs4LZKcDUW/9E7qxenDCLOxExdIOeLQW6d20NpBLZnczbP9tieOCiwnjkzB5
 49//9IZy8iTu553fwfk/nraM0U8v3BBbN8O72aF0FvyelaxPqexMVY2NYRsLlpN7MGJjBLgfP
 tJJzTW6MPg4jPUyPFXxSkip6Z30K29HtaWpBTPcaf8gfi6c+jRz0VrB9Gw2/zhl9HRJLcGFFe
 Gctb+w1ahUakEI5+j4l3DYyrRx6rTr2zX/jb/PRFquJgYOiVTLvPHRaGAUYN+trltlP6fVWSw
 6pIM6ERJ1DLix/pONiGZmXtvmOtTP5SyuETJs6qbO8ZG8KYWJnLRpdxFZ5UVzyT1Ok90zeE/7
 BhsJJyiASBmUOTsCAV3bzEUEax5+hj95aXFhDJtviNwLUEKv4ZA8GTLHxxlU41401hUyJE/jA
 Nt0+BPclyEiSL72rWbc4RFV/sLtpasM6z1YJETi9uOWNN3cxpNzTZpoJdE39Ny6zBzeUvqXzW
 LHM6OsN6xO1SyV2ZurugUyIfgaTqnbZEsCXz0Oj1Bsbx3UrnqBfYO0ieJdj5H26q+vkD70vCd
 W/qcM0TJBFNAxBskrlB2T5guIoyQL2llcFIT96YYQfVaAnQY0ZDpHjZaWCkAi70998FBZug9l
 gOX3++8kyobrqmLlEUi0rER2zveQ2rP/koAODcpNvrEcY65d3HJNNAoJiAlE9qM1cAXcuNMRV
 OcVRTDV
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Tue, 28 Aug 2018, Jonathan Nieder wrote:

> Johannes Schindelin wrote:
> > On Mon, 27 Aug 2018, Junio C Hamano wrote:
> >> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >>> Jonathan Nieder wrote:
> 
> >>>> Please include this information in the commit message.  It's super
> >>>> helpful to find this kind of information about why a patch does what
> >>>> it does when encountering a patch later "in the wild" (in git log -S
> >>>> output).
> [...]
> >> I think what Jonathan finds helpful is the other half of the story
> >
> > I will await Jonathan's clarification.
> 
> Junio's understanding is correct.
> 
> More generally, I greatly appreciate the kind of motivation and
> backstory that you write in cover letters, and I wish that more of
> that would find its way into the commit messages instead.  Really I
> wish (and don't take this the wrong way --- I am not asking you to
> write it unless it's your own itch) that GitGitGadget would put the
> cover letter in single-patch series after the "---" line in the
> individual patches, since that would make it easier for reviewers to
> point out what content from the cover letter would be useful to add to
> the commit message.
> 
> That said, this is minor and not a reason to reroll this patch.  It was
> more that I wanted to give the hint for later patches.
> 
> Thanks much and hope that helps,

It does.

I'll "rick-roll" a new iteration, as I just realized that (contrary to my
recollection; I guess I'll need that vacation) the commit message is
*seriously* lacking. I thought I had remembered that I copy-edited the
commit message into the PR description. Clearly that was not the case.

Thanks for the clarification that triggered my looking,
Dscho
