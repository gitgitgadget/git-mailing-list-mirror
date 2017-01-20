Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A83220756
	for <e@80x24.org>; Fri, 20 Jan 2017 15:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752809AbdATPdr (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jan 2017 10:33:47 -0500
Received: from mout.gmx.net ([212.227.17.22]:61616 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752796AbdATPdq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2017 10:33:46 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lcjdr-1c57uU02Ex-00k9ij; Fri, 20
 Jan 2017 16:27:01 +0100
Date:   Fri, 20 Jan 2017 16:27:00 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Marc Branchaud <marcnarc@xiplink.com>
cc:     Stephan Beyer <s-beyer@gmx.net>, git <git@vger.kernel.org>
Subject: Re: [RFC] stash --continue
In-Reply-To: <1fba12e3-78f0-6b2f-31ca-8d888744b9aa@xiplink.com>
Message-ID: <alpine.DEB.2.20.1701201625440.3469@virtualbox>
References: <cd784a4e-ee99-564e-81de-9f7f6cc26c67@gmx.net> <alpine.DEB.2.20.1701161153340.3469@virtualbox> <d5456165-bdf2-e9e7-117f-aeab0ff4b417@xiplink.com> <alpine.DEB.2.20.1701181725130.3469@virtualbox> <38d592b8-975c-1fd9-4c42-877e34a4ab70@xiplink.com>
 <alpine.DEB.2.20.1701191341530.3469@virtualbox> <aa8104ad-45f4-7bef-f199-6e6021cf0c06@xiplink.com> <alpine.DEB.2.20.1701192220320.3469@virtualbox> <1fba12e3-78f0-6b2f-31ca-8d888744b9aa@xiplink.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:2Lia18Qa19TnLEJ3B5Yo3AlpbBJKizKmut+oFszmWr7MKcGtb3L
 4VnxzseigFy1ycXldMJNiQ5MkTumQtoJPupK6CSMncFBkVsV4LlDdo6rYyNkONmJ8Gbs1Eh
 c68T3y5oALLoJRqxuszuB+gDWXJcTe7A9VFD1boykLiBUZa3cKEYZzviDR/VASTsYAwwCdi
 6I7MwwV/qOwQAaPQgVN0A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:80/lt3ckmVM=:Kt1/ZE7fRfOKepP01EDwDJ
 WOoMyW1Qgg5U4ME+mQ+FAnnT6rUBr1qH0T87UAl8Qd2VTkiRVPJ+yJozYpimHxCn8k87FhlMe
 WVcVXHnRFp82Jtfg+1w5ItXHTltJDSRCEegTd1YmBrt+Tc/hIStCuHLd4d5EijPKq1HI6wix7
 GfEuw4Dtm2u7oKG+QexIjaLv3+TyZi07IQ6OuqnUOXv9L3hWQWDqw+vDmq05vrqdhP/87TG9m
 lTueRJEZj1BK/l3cQWhVlhpgydEaqYMP833Z6woGj9h3+UoZmhp4RDzXxPze0LlJUWZGzB/6r
 ozO5oW1l+PD/G6Bhnc2Nqjc+8x8nroczDGPo47rToJKRMVMEmCtC6GZa41gq/nSolAzR/befE
 EiZASfSfRLayVHMgjLZxH3qFRD/rSHzUo38h4PmigRjo74o8fzNfJIgnqtORAI+YVKbH6ueEn
 Mq2HvJ16iV5yPllIXF4fIIso8Df0vRaC7gyw2rgAhATZqRb7cAEIvsNtbbvbNlCrvOB6mCqVj
 tsWfr1LkbrG2mVL0KG9f5tia7WqXaJTOw1DdQ1kBfUlACiWXGJRVzkedCN/e/UxBAe7FfRQgi
 tksybY4GW5vmbzyZui3jgRmaxy3ptA1MwFh3Hv9Oncw+hz4o1GIFUWWsjQ55T/Df6nh6+cWh5
 R1yjDLQU73pa/TVhs8T7uDAWg+KAHvXkHiGIbB/GJiLi0lWudtatDb8Ax2MccDmOhPFBc9m87
 DFY3l3WzowlcqAvQsgFFqpzaRDGJi9eYjd5W7Z/c7mdl4vkDm0YyVl/1KwUWrNdKkuu4WK3x1
 50sSQ1GzaFspWNR0WWDM7AAWzQ0aw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Marc,

On Fri, 20 Jan 2017, Marc Branchaud wrote:

> On 2017-01-19 04:30 PM, Johannes Schindelin wrote:
> >
> > At this point I will stop commenting on this issue, as I have said all
> > that I wanted to say about it, at least once. If I failed to get my
> > points across so far, I simply won't be understood.
> 
> Yes, we're obviously looking at this from completely different
> perspectives.

Yes, but you claim to argue from the users' perspective, while I actually
work with enough users to be really certain that I described their mental
model of what an operation is very accurately.

> Stephan (or whoever) if you decide to do this work, I will be content
> with whichever way you choose to go.

So you only wanted to argue and not actually do anything? Tsk, tsk...

:-)

Ciao,
Johannes
