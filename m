Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67EE72035F
	for <e@80x24.org>; Fri, 11 Nov 2016 16:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756574AbcKKQyY (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 11:54:24 -0500
Received: from mout.gmx.net ([212.227.17.22]:63604 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756184AbcKKQyW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 11:54:22 -0500
Received: from virtualbox ([37.24.142.46]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LuJDv-1cmAMX1pTT-011jUF; Fri, 11
 Nov 2016 17:54:18 +0100
Date:   Fri, 11 Nov 2016 17:54:16 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     stefan.naewe@atlas-elektronik.com
cc:     git-for-windows@googlegroups.com, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Prerelease: Git for Windows v2.11.0-rc0
In-Reply-To: <1784ec06-2557-aa99-ead8-b8997b68d8d9@atlas-elektronik.com>
Message-ID: <alpine.DEB.2.20.1611111750580.3746@virtualbox>
References: <alpine.DEB.2.20.1611051025030.3108@virtualbox> <1784ec06-2557-aa99-ead8-b8997b68d8d9@atlas-elektronik.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:vjSrJ9lEjZAiiagGfQP/opoqegCITKrG428ATdHDaBMDUz6w24J
 PyZNdQsY1aZFoS9go+m+4HzA+2PObzksvLzp9JeEKQECLFeMgH86YIO9a2L7fLZGsm2Th9V
 R266vE6FDVgFb8Ocqs/rx7alJB+pBMjyvkhbcUal2tNlMVUYJFpY5B3nbXJmO+g6crTLzo+
 DfaYgfl86xpnxPag0bc/A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AFqD5KN0lAQ=:dipwJnnaQb7Lc189A1dNaZ
 2mWyVtaOMl+sLNK3n9Db5+Wl2rNBQssa9qml0oDJf+79+Rbx77HWXWKwjM9ygmLjMCr/bU9iZ
 7oq4kyLGQXOn+QotIYN2iE5ZKvexzWMObYilLoNnFJf1oh7fxoJa7J/yPT4B/ueylLIWhw0Y2
 tX/6nOq03hz+4MDAFMiXCpCrEwCFEvEiSh/ZcVVICh0CjoBK0kL60klz71K0oFaGAAvyEWULB
 NPIIKLsNXuaDDm+SvErZ8CVHccZvAdT5JHXjKbcfRKO/pt/GQDwHYUH31RkPv27H7mGzMZl0K
 lridD3CZtFTE2z2/+ttDEAqxsDLNTEfc7BR6GuNFQ86kOBIFxLqZjchmS0CiUrHYGLTOnV33/
 jGtnxVmjrzNYYTzsvj1wRV/oBRA+nrE1ZAkBo236YmyV2+NzTRbawTtIaCaJxGVkOMDWGGCK3
 ZZVscaXJgUNbO6ExRI6egT/F7Ex71PvaxwtZ9XkXVI7eQJnL4Y8Q5FwgFIhKBQnr3U8Lbe1CZ
 VEr39oY7mN8gN+4w6ydzUP27j8cJ2bCbzpevhda4vYx2PZi/1O1mYFbt5+fYbW9Tz6P3grVwv
 uhduiYrGerzbss+XlMtKCkGrIYh1gE6I+vVipbZVCzLeXxnPog8r+0fLepe1IETlYyYPyZCr7
 uGPWIv6aADC4iw3U5bQdyg3q1JDjSyjjhxV9wXnrqU36WGZwAoA8UvW2v6Xeb83Te7ye+l0By
 8rFs0lZ0JqWfaST2L6s3oXxUBi7dpRLEe1aU7Nl2A8NtmOT3HWYztmBxH5gl0prO33Sa0y5CA
 wKxU1qk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Thu, 10 Nov 2016, stefan.naewe@atlas-elektronik.com wrote:

> Am 05.11.2016 um 10:50 schrieb Johannes Schindelin:
> > Dear Git users,
> > 
> > I finally got around to rebase the Windows-specific patches (which seem to
> > not make it upstream as fast as we get new ones) on top of upstream Git
> > v2.11.0-rc0, and to bundle installers, portable Git and MinGit [*1*]:
> > 
> > https://github.com/git-for-windows/git/releases/tag/v2.11.0-rc0.windows.1
> > 
> > It would be really nice if those of you who have access to Windows [*2*]
> > could try it out and report bugs before v2.11.0 final.
> 
> I tried that version on 64bit Win7.
> Somehow the PATH env. variable does no longer get set correctly.

You are absolutely correct. There was a change in MSYS2 that I missed: by
default, it re-sets the PATH to be minimal now. This is obviously not what
we want.

I worked around this in the usual way [*1*].

Thank you so much for testing. It would have been really awful if Git for
Windows v2.11.0 would have shipped with this bug.

Unfortunately I have to re-build and re-package the installers I promised
to upload today; Hopefully I will get around to upload the fixed ones
soon.

Will keep you posted,
Dscho

Footnote *1*:
https://github.com/git-for-windows/build-extra/commit/db24c0378adf33c07d6c053f39f04a6a025150cc
