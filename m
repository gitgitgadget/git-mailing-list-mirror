Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05F0E207EC
	for <e@80x24.org>; Wed, 12 Oct 2016 16:14:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754096AbcJLQOp (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 12:14:45 -0400
Received: from mout.gmx.net ([212.227.15.15]:49957 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753823AbcJLQOm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 12:14:42 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LrePN-1armYG1ikX-013Qhe; Wed, 12 Oct 2016 18:14:33
 +0200
Date:   Wed, 12 Oct 2016 18:14:18 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Stefan Beller <sbeller@google.com>
cc:     Joshua N Pritikin <jpritikin@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: interactive rebase should better highlight the not-applying
 commit
In-Reply-To: <CAGZ79kYg3sZ42W-PEE7MgCDvt_h7hEQ7KWZsVKMb3DY=x5VK+w@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1610121811250.197091@virtualbox>
References: <20161011190745.w2asu6eoromkrccu@droplet> <CAGZ79kYg3sZ42W-PEE7MgCDvt_h7hEQ7KWZsVKMb3DY=x5VK+w@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:cPDUJZ4yIjgiIn0b3dZO0LladlH66a292/WeHuHCe2j/qmOL8Wz
 s8M4ZWpJZZGKVT8bEFeATCDcPQvtR35vpLAVYQQfoWTipGE/A33PuZDuBbH5iYjHajE/WkK
 zMnR38M+IR3y40/xehb/1EJSS5hvCrfAzK+H/zoOdCw70Jq1/VepxG1RIom+KlOFWUa9jAh
 RmmNIFyt5BK+jQL2CsMSg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:T+TtNfw87Xw=:oeKN67mPfsFOvyr1SCuIMN
 Nlr+lbqYiFALpou4Biast2v1Zga1/pnrydPF+goC5xa8l3d9LhtzTbgQ3bhEmC1WA83muw2K3
 1XDGRvWApKRqtxHlV/ZhTYvmlGT+q3DQ8CrwzM5RivPYhzACDFptNfzbHM8Y/uBOi2sPgkfzM
 o52+MGqhUkvXbMxazbQbalzb5s5n+pOXtZtnQX5TCYyBqAR2eg//rA5pYdFUeNklawI0lE2um
 ndYevlSbLGfVfQpZJ1xl/dtbg9KmNmGluehyKuTZwh/xRTd04Q+SJx2UzeSB9kQSdzpK7zcg3
 68sNrS69y0mRY4Hv6858/wSIalRAFctwuVgwh1q1YpkFMQ6u9Bb22I8gZpYnWJv+F8zv4xxHr
 PbCYFKZ4D7faW3FwvA8HMZae9PQeNqvD7TYsq50db/1OT5QzG9FSrCJoDrnqocvzq1L//uar5
 Cxq2aYvDqr9uTM6DsPPMkWYgkafEOe60ZE4Kc4FuvUiD01+WXw/tDsfms8YDbbZTdTy43YzUI
 +oUtJpHv0BDnZtEEtwzVepuscEGsT6Clv3/5oa0smucTwj9TqCO7rc31wwIg0+pxaKzUYBmM2
 2vuGeDRAdNcrzXf8jjCk5VFG52nGrkwydJYx7t3A6Zcj77hrL1PhyECH8gsMAW10SbiPgkW0d
 klSC5ifdZRXq6lBD+UVSUoYIEOjRAYZnXGQN9De+meXy+vfOUUGc6SFPyycRlv7MOyF41G8Vz
 gbi2ZNH8d9uhfh7xniJ5seL2TpP5iqfaUvBbg7jlA/M2Bwvwbx7Ij0ZdVTRXEFduBkujA2W+F
 3K8t/Tb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Tue, 11 Oct 2016, Stefan Beller wrote:

> On Tue, Oct 11, 2016 at 12:07 PM, Joshua N Pritikin <jpritikin@pobox.com> wrote:
> > I assume somebody familiar with GIT's code base could make this change
> > in about 10 minutes.
> 
> Can you elaborate how you come to that estimate?

Why do you ask? He obviously has "a very good brain" ;-)

Seriously again, Git's source code is not that hard to read, and the Git
developer community is pretty helpful when anybody asks for pointers what
code to change.

Having said that, I did reimplement some parts of the shell script that is
git-rebase--interactive.sh [*1*] in C and am in the process of getting
those integrated into the next (or hopefully not a *much* later) version
of Git.

So what I'd like to see is an *exact* copy-paste of a message in question,
and a *concrete* proposal how it should look like instead.

Ciao,
Johannes

Footnote *1*:
https://github.com/git/git/blob/master/git-rebase--interactive.sh
