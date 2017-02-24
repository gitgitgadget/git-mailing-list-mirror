Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEB4F201A9
	for <e@80x24.org>; Fri, 24 Feb 2017 16:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751293AbdBXQ7K (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 11:59:10 -0500
Received: from mout.gmx.net ([212.227.15.18]:58911 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751219AbdBXQ7I (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 11:59:08 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MCLx3-1cYkX62Hj7-0096Hd; Fri, 24
 Feb 2017 17:52:29 +0100
Date:   Fri, 24 Feb 2017 17:52:28 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Sean Hunt <southpark67439@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: git bugs
In-Reply-To: <CAHikyLoK-h4tY_rxGikaSSv6AmcrBAXiayDFTtLa44A9qMZDqA@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1702241751350.3767@virtualbox>
References: <CAHikyLoK-h4tY_rxGikaSSv6AmcrBAXiayDFTtLa44A9qMZDqA@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:RP+GTpn8bOt8sSDOoXXUwp1qIZ1HU++XLspoxhkA3jFcYx37Vx4
 C1EzHPaRnLQyz/VElJ0hOT2l+Jxb1be8fhiXluJLLypDscsum369+C4pVm7cjIi8Z4M8m0j
 3FWZCsENoDvlGuQnhzOCPM5VE36uiJX2WW5GHu9tsczxtaEtMNUaGrg/7ymB6Ymui352sDG
 NHyBX7q3aT8qukaLNvUow==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+QSRcz27esY=:50CFp0p0eWhFSA7HrQYX6b
 B5JHSqQU+bTjbTZTO7IgKGNUwVf/xkVnFllvd5uHHptTaghGsNXKJHOicLMl5TGZirCW4J34Z
 O+bSDV4ewemtuMwkuNH9uVughxWlwiqpdl85bJqrHjedjsy61iomUWBkl8DFkY1/PHG+KtFJN
 ev0kWRTh+blLpQxlXxTH09ZYIYb/9nL22kF2cOD60FPN/4GnJ14Dsow45VYdF3v0EkjxnVR1k
 +QaVrT9ASwa4YlVm5bmObdZ6pUM1PWPQ7cutTotwfZowZd5wIHe0j8e/wE05JYeLeofkKCFH6
 TbskICiKTlqsBM2H8pqxoKK8wVmSzUJvBYI2tfhqM79AEuwXAkR42iCdfwqeXCdH/Qry8QLH8
 ekPpBMdi9DfXXzrf6DIfFNdlqDNxR2XItIUkOz80sbqN2eh6HSWbBl2Bdu3kk8mGx2pXO2WuZ
 96XqNY+dIav0epRjkjTkD8h3+CeB/SKe5S2D20eOUxsu1OvbwHN17g26OasG5jXa9nHIPMN28
 1iHhRh5C7fr/ov2T+THWF2y3Dj4HHs1TmSDQs7yu0EWdcZRcaq/0dB6RJf2vqNr7IHLSE+Inq
 WBSkQSmLPFEZHHWAas+f3FnDqt1cgyQekT3oOqY0HhRUrorIJJcUqfjZIdP95ilKfCDll89wJ
 fi21nxhxIlqenQGwEZB4JLJa21NtLZvdWC3stUpggDz35RmVDqoSn7BGmIJSIhuPhuqC8porQ
 BqVmXFaosUSygF5SCd4ECVDkEpaw7/hMUbIg3hB1RXDiaEh/7fGknGgJViFh+MZf4cR2uezuU
 ySmJDLm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,


On Thu, 23 Feb 2017, Sean Hunt wrote:

> There are a few bugs I git I noticed when using mingw, mingw64,
> cygwin, and cygwin64. These bugs are the following:
> 
> if I do git ``rebase -i --root`` and tell it to edit every commit to
> gpg sign all my commits it bugs out and merges all of the commits into
> 1 commit instead of only appending the ``-S`` to each and every commit
> and keeping all of the commits. It is as if I told it to squash the
> commits but yet I did not. There is also another bug where if I clone
> a repo on Windows and not on github desktop and that I placed commits
> to the repo on github web and then when I rebase to squash the commits
> to 1 commit (some repos are doing it as a requirement for 1 commit
> PR's) that all of my commits on the remote (fork in this case) that is
> linked to an open pull request are discarded and then the pull request
> is somehow and oddly closed. It is super annoying.

It appears this was reported as
https://github.com/git-for-windows/git/issues/1072, too.

I asked for clarification there, as I am quite confused by the
description.

Ciao,
Johannes
