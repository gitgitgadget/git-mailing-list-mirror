Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A36720798
	for <e@80x24.org>; Sat, 14 Jan 2017 18:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751810AbdANSJy (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Jan 2017 13:09:54 -0500
Received: from mout.gmx.net ([212.227.15.19]:51627 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751790AbdANSJx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2017 13:09:53 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M7Yhz-1cgZwn0CyV-00xKhm; Sat, 14
 Jan 2017 19:09:50 +0100
Date:   Sat, 14 Jan 2017 19:09:49 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Michael Gooch <goochmi@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: problem with insider build for windows and git
In-Reply-To: <1bddbd50-86ea-6c38-6ab8-08336de2ba72@gmail.com>
Message-ID: <alpine.DEB.2.20.1701131300390.3469@virtualbox>
References: <1bddbd50-86ea-6c38-6ab8-08336de2ba72@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:xrEUIRygFIAdzGSoKHSZ/zwzHyE/OOoZFJUUS/xqVn/DnonWQVE
 bqJ0jfUPq47IjVOy39aBtR/utF2/cdTViFy2wyzag4QVEogGX4IxEit0ka/1H3uOsoyMgNL
 zYSYkoG0dqUx5/aFww/ZE9ix7o2j7ZvYRsNsp2hoq6At8gPf5WkmSxPil0YHmBbupKCKGsm
 kHmbi6nl8tbKSrcv9tgrw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:eDP7Hh+1qZ0=:M+KfHqBmyxCGfKE2bGRUtj
 7acElM4URoGm1CmHhrf32E//PJFZyPIjdQXquADGECUtoiirHK8vi0rQFS0p/dEVJW/Ki/QxD
 UKGLBNR7hjyIYoWiNz3Uyn0IHD5i6Qd0d2IAiFR3uCzKqRyxQ6Mln2oF41zo2r7O+NHwbc8f9
 v3qLtJjkmjQX/2HDt4zgqJG+2AXJrANg9TSPye34nr6ygZGS63PLkYUgwkce95OULpGlGGKMn
 yPOR3qjb0WaPMImYilUAUXMek8FmoQAESGzhLYfdVdWWstJy86wfsR8E1FeOSNLhH4eKQm7rw
 htASl/iLr9Wd1/8+9xex28NOmt2qppLE+2M5ateqFctkEUhE541O27RazyqN3K3kPXKOEDh1/
 Za+48lN2inAz33hSEiq98uUIj8Uog8pNowuXYMgidn3kZoq9ad9Me8Mmz6B5tLLb5YCvw44kk
 LiNXBClb4QgtD03gxVmR72LbQIsRREwVd/xa+YTgCpBCjjvHOcVR0bx+UDxYan3HK7yMsCfHs
 wZpYZEzpyojB5IWjUyiIbAsUK2JqipjljgdKzhuhha9P0VsOFzdkGWOFtOYGwXPWeEimYtB5T
 1be0aN2N+UF50DnSQadYZ7009Vr/VPKJ7JkGGVLE+kMQs2G+vZ5QYTgIZ/XsddRASVGv7pOLx
 to5pOPvmxg5Ky0oFLtszrXfwC7ItSnd1311E6lE31oMtiPkW4lmniORcsNZHfec1z+XfbX0ev
 bqwcDmiucA1D1Rlx+eKDNton7M1snv20MLAdpRkXThTz0cSZYTMv9jKWLFmgZbLu1vPYKz3Sq
 FBHU5We
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Michael,

On Thu, 12 Jan 2017, Michael Gooch wrote:

> when running commands like pull and clone I get the following message:
> 
> Cygwin WARNING:
>   Couldn't compute FAST_CWD pointer.  This typically occurs if you're using
>   an older Cygwin version on a newer Windows.  Please update to the latest
>   available Cygwin version from https://cygwin.com/.  If the problem 
> persists,
>   please see https://cygwin.com/problems.html
> 
> Windows build is version 1607, OS BUILD 15002.1001
> 
> I assume they broke something that cygwin was depending on.

This is not only a known problem, we already have a fix for it, too.

Please note that the recommended way [*1*] to report bugs in Git for
Windows would have led you to this ticket:

	https://github.com/git-for-windows/git/issues/1029

Please also note that this is only a warning, not an error. Even so, the
problem has been reported independently several times...

There have been enough real fixes have been accumulated in Git for
Windows' `master` branch, and the next official Git version is far enough
in the future [*2*] that it was time for a Git for Windows version,
including the fix for the FAST_CWD warning.

Ciao,
Johannes

Footnote *1*: https://git-for-windows.github.io/#contribute

Footnote *2*: http://tinyurl.com/gitCal suggests that Git v2.12.0 will be
released early February soon after Git Merge (and Git for Windows v2.12.0
will follow soon thereafter), and with no patches applied to the `maint`
branch since v2.11.0, I do actually not expect any v2.11.1 to happen
before v2.12.0 comes out.
