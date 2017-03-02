Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACF231F5FB
	for <e@80x24.org>; Thu,  2 Mar 2017 14:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753707AbdCBOe5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 09:34:57 -0500
Received: from mout.gmx.net ([212.227.15.15]:57172 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751531AbdCBOeg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 09:34:36 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LskfZ-1cHHh90jc1-012J3i; Thu, 02
 Mar 2017 15:26:14 +0100
Date:   Thu, 2 Mar 2017 15:26:13 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Mark Phillips <mark.phil@samsung.com>
cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: BUG Report: v12.0.0 "git difftool -d" fails with "fatal: cannot
 create directory at '': No such file or directory"
In-Reply-To: <f2a8495f22854a749e615fb642d5655d@CAMSVWEXC02.scsc.local>
Message-ID: <alpine.DEB.2.20.1703021523360.3767@virtualbox>
References: <CGME20170302105511eucas1p2c40bbbb719c8fb15cc7a6cb9424a92e4@eucas1p2.samsung.com> <f2a8495f22854a749e615fb642d5655d@CAMSVWEXC02.scsc.local>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:yQ/HrsvnaV3Sf3fBp10uhQQNOm0B1yPsEc5VKD80tBNMvOAq3lE
 j0a2EnrVDrKBIDdO36N2GA1vbTWi/F9myH+Te3JK3P1Ru8igNtww254cyWp+cidqxErqtv2
 hLSq7OVCuBTtauxMlcHSkj+mFS8G2RTsGO7HzJ0hxegg1sKsTb1VqQY4n7xjKo8pAnxeUd8
 zw9fjnTiYmHkJipYvZiDA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SqbP7kNWxpw=:kKMNOkbRL/qZy+1U+mDGV+
 hkDECACOrfpmYMRE5ta0Nb4Zg4HgvDLsRTTEqN0np5RmWmVO+eB0bGLNFHv3gHRTcBoV6fxXb
 dstsWwCtxy9xVSmAylZbB+Dp5UJsn4uFrlKKWefkVDTJgNECC63o8EbIyHNhNZB0YytiEH1JM
 eW5PQJWXPZUvvR9SXScUFdVRXoSDJzvRbmVPxVQ3EE4Dcd9fzCUcF3d4V/fJehjzCb+jB+W/O
 0qvjorRanUJXUnspv6a1/688uYdbTB+Gc7gmb24ukTDa7aiZb3gIk52fpx4tklsho/qsabuMQ
 gPclfi0/wrd+RbOBWMVSr9/cphacUwDzV482llXDwIscWGAl1GRdCJbp+3UixYbgStOx3SQMM
 TrV6wCIKIFbX/FX0WG4Z0WyzMY85eMiA89RgEN0LiR1b5IDHrjrfQWKHVG6awnG8BieyXzKUv
 3sY15KWlvPZGpNJdwbA71vDsK7FYgUV6bP2Z+WMCBbGp0ILE/Y9lXNqaYsh+OGaOvV/n4OT2e
 xsB6mH0XBaIqQS19KxswglkEnnJV7yqxYWMJzXD3LpfuRk+EIIjX76QwmxOYSFoxR81d1OT+U
 eOHUbcl03lJZRkZaV7qiUGZ8isipWsq3NiH3QdbcAtY8/BzBr4HvO7B2sOSEW7FtGXzmove1B
 DE0i3jQhKOZs5r5fuIBjnQKn7IYg27ZUD15hQaBA7hFDSWRhPqOX/XFMJmdMuTlP3yLVoGbDI
 X6Ucq3SO+oqB/IsLGqx0cry9rwNvKcXBMU/EF2A6kr29LZja9qwsqxdg31hmEowQMbw6CT38L
 CoU6fM6j6+Aal+hnw3UPkQZh2IZEQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Mark,

On Thu, 2 Mar 2017, Mark Phillips wrote:

> I am building git from source using gcc 4.8.5 on 64 bit linux.
> 
> I am sorry the log info is not very helpful, please tell me how to get
> more information about what is going wrong and I will collect the info
> for you!

Well, you could provide a Minimal, Complete and Verifiable Example
(http://stackoverflow.com/help/mcve): most likely, the error depends on
particular features of your current HEAD, or environment variables.
Because i do *not* get that error if I run `git difftool -d HEAD~`.

So it is not so much about collecting info as about distilling your use
case into an example that allows other developers to reproduce the
problem, and subsequently fix it.

Ciao,
Johannes
