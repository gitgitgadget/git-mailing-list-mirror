Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54A3F1F404
	for <e@80x24.org>; Thu,  4 Jan 2018 20:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752635AbeADUzb (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 15:55:31 -0500
Received: from mout.gmx.net ([212.227.15.19]:57046 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752544AbeADUza (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 15:55:30 -0500
Received: from [192.168.0.129] ([37.201.193.20]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lymoh-1f0ZUP0jwt-0165bM; Thu, 04
 Jan 2018 21:55:10 +0100
Date:   Thu, 4 Jan 2018 21:55:10 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
cc:     Adam Dinwoodie <adam@dinwoodie.org>,
        Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: Test failure for v2.16.0-rc0 on cygwin
In-Reply-To: <e69657de-9455-2b97-09d7-2bd58ce513f6@ramsayjones.plus.com>
Message-ID: <alpine.DEB.2.21.1.1801042152570.32@MININT-6BKU6QN.europe.corp.microsoft.com>
References: <519ac918-6b5f-bca3-05a0-0114683b9724@ramsayjones.plus.com> <20171230144019.GB29210@dinwoodie.org> <20180102113649.GC29210@dinwoodie.org> <3616d866-9a53-6e32-0a62-488342ae214f@ramsayjones.plus.com>
 <e69657de-9455-2b97-09d7-2bd58ce513f6@ramsayjones.plus.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:kU2n91maoOVROceuXqnWoMG4lzTp4VHJt2kQnBe+iZLtIbtkIpN
 7L/UQrzI9Fxabq0RvGoT+cvsz13ZSCzdrx3jwos4SIUYlOMrZXmz970uBgv6h4dfPcutjE0
 6WaizH8nWWJM2UcC7ADTc14+9Fyk1TDv0ezWcm+dSIGevj1Tgq6bhNnhTpGsidJyvXFN1AO
 yNX4BfvOFHs0OZr2CNxig==
X-UI-Out-Filterresults: notjunk:1;V01:K0:d/TYxfY+BAk=:s2akQyozh5qALiGNhKeAIr
 HctiY54DW7L8Ddo6tpNfO0Hu2tyy/eg8FVJDPr25fkVSDX+aVGLkzOFVrLSca2nTZKhFvKO/1
 bFpr2UslNzpZxesQXuPqnBbesa82GvWYaU9/X+bSBcCzXmHaOd2CChH8CZbEhfxQLKyxgjQpn
 md5ABZs4edDMJs2J9ztN19CQ29foKZfwP9GM9Dpk2IXsd8QMXZnZFaiZ0+oSMwd8MNXwzQSiP
 eUHeqEXCn9C/TgavmRKbiYgYPxT5KnSXdodPCFFDN2gqTNUlAR8XEyzyxMhZH+g0ruZ7YZ+uf
 20vLmpbxEsZYzS4RWMazxa6YXV9YPmMDCXG9WFnBzWZMYytYFwXMGBWkQC2DU/tAnrI5aIYMt
 K548eHq0RMeTyV+f6WIyHyDqIBhy4BZrIUW1jUcXJZvxENm/TA9PVgQh1TemS5jANQ+w/KeBk
 McFSk1i0qqagL9njNuHKrNo+U0WH91sLgrAu/5E3cRNkFttXOZNxva0rGUPsxyje4pAXWTLDN
 Baburj0IPxHwcy7rUf3oWlo2kFk3DDGcjah3AOCjRSsE8Wn+XuUOzGHOIR1oSoQLFlvCmVet0
 BfIM52p9UPgK26rSL+b2ll0LWIvGaDVM57I71iP5MGyB+EmDq/CFYc3vF4CQSca0lt5mIwg+1
 +nlSFTIP4tuJ2iGqHsl2xwr/n4eGs/yOGuv0MfgK3Tf60xmivzu7urtn77L1ovfFlRyCZ3NsY
 9/oy8QOOfA8usf8MMBdoPky2C+8PISkwszfL2LH+Rfx8yL4Y2TykTBRUatkjPErxTv695dQAT
 ClhQfQ4OwvZoQdEJsLN/2W41MTgqkeXlE8uOMIT5gqfRdT47wWsleeoGewuLkBDMHUgDwvi
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 2 Jan 2018, Ramsay Jones wrote:

> On 02/01/18 15:32, Ramsay Jones wrote:
> > On 02/01/18 11:36, Adam Dinwoodie wrote:
> >> On Saturday 30 December 2017 at 02:40 pm +0000, Adam Dinwoodie wrote:
> >>> On Saturday 30 December 2017 at 02:21 pm +0000, Ramsay Jones wrote:
> [snip]
> >> I'm not able to reproduce this: t5580 is passing on both my Windows 10
> >> test systems on v2.16.0-rc0.
> [snip]
> > I just tried running the test again by hand, and I can't get it to fail!
> > 
> > Hmm, I have just set off a complete test-suite run, so I won't be able
> > to report on that for a while ... ;-)
> 
> Yep, as expected, the test-suite passes no problem now! ;-)
> 
> > I have an idea: when running the failing tests the other day, I was
> > remotely logged in via ssh (I have cygwin sshd running on my win10
> > box), but today I was logged in directly. The sshd daemon is run by
> > a privileged user, so maybe that could be related ... dunno.
> 
> Also, when logged-in remotely it fails consistently, when logged-in
> directly it passes consistently. :-D

You are most likely hitting cmd.exe at some point there. In cmd.exe, there
are some restrictions that are inherited by spawned processes AFAIU. For
example, the current directory cannot be a UNC path.

You are most likely running the interactive Cygwin session in MinTTY? Then
you do not get those restrictions. If you start Cygwin in a cmd.exe
window, you should see the exact same test failures again.

Ciao,
Dscho
