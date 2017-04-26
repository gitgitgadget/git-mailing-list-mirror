Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C1E1207D6
	for <e@80x24.org>; Wed, 26 Apr 2017 09:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1434980AbdDZJ2W (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 05:28:22 -0400
Received: from mout.gmx.net ([212.227.15.15]:53503 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937876AbdDZJZl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 05:25:41 -0400
Received: from virtualbox ([95.208.59.147]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MTjua-1dTbWg34tM-00QT64; Wed, 26
 Apr 2017 11:25:26 +0200
Date:   Wed, 26 Apr 2017 11:25:25 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff King <peff@peff.net>, liam Beguin <liambeguin@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] rebase -i: add config to abbreviate command-names
In-Reply-To: <xmqqpofzstsf.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1704261124250.3480@virtualbox>
References: <20170424032347.10878-1-liambeguin@gmail.com> <20170425044320.17840-1-liambeguin@gmail.com> <alpine.DEB.2.20.1704252148400.3480@virtualbox> <1493165607.29673.31.camel@gmail.com> <20170426014704.blyczgmbuqd5amys@sigill.intra.peff.net>
 <xmqqpofzstsf.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:f0BpFx9GV/q5DNgOg57zLinY17dGI25h0fowTMxo2Qbs7f5K0ph
 oKA2XADf/kfnyF95m/qjsmc08VECcaqOmrwGjpU2uM3GSyj59dDdTwOaKU6KIaQKZharzJj
 vFVIezpy/XkZNL9I5m1cbVXZafMUyoY/c8aq/e6UmcG2z2KmJHRCyWUhG51pYNTnQkfSRSt
 yA5DLCyqwO+Qnnf+iaxVg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DcOSZvgfLmI=:ORBOzkn54BMVlsK5FSZBmv
 Ip0xw/0/P49W4Gx60a4rmmZNvzI/TTRPQDpNYwlT8mkp6YoCxl20C91Xk32NiONxmYLVqb+Iy
 3paHACXzu03sFxu3WcXBBiv8/agPWwi+nTPJHlR8r2hT7rVPBYHY625y1EC+td+tBZ6ZB8mG+
 LyR8toy/psFqBuHF3HRsnJ0dhS/p397nQYITJwGm4gMUVevl65UXqgyWDi5xeEI6U0f6iCMGl
 Sh2v0hlHe6XJW70Em87JXvS41WDAwt7R4PZATzRfmKAEJvem7gNgiipgPwLhMx9RGk665b1aq
 LlfWgfC6s8zdf1v/GjAHVqibedazMZ4/oBiZ52ruehem4B4+t5l0GPjM8xPF0I1SibY220f22
 xPx+yVwBh84j/QB6RGz6n/dSAtRda1a8QMYnNCHrd27eLHvLpgIGKglRgDnmZLXX2hacHP/Kx
 eJS73i2yqHMJmeP8BU2f/zJw7R1yxxIRlIuPc+qv8EuGVrDwvT08bYdTfqJqxN3rL8lLBhSaS
 wdrUzZNfd1C8r8o+fsG+MtNKkdyMNKFPygYc9gwO4YYaOSzPfHmdr6Jcm/bZg/kZhsPINDwBK
 6E+fhbGPaWm4KYAXH5g3nSPzXzyZiYczok3hyG7ZxZtAENpCvYjAgw7ECTWjEIgPcqKPtAAFI
 p2D5oU2fWQrX/4d5V3AC4+0lmyvqMebnOte7u9Ih18POvOaYpLs1I7l0DWcBCQiG33bTCuc82
 FjcB7JmXOhp/2VxyLhCGR9SrH9hFj2YEuMtdRtyZoWZtsNwcsSxMbjZfYSHS3HAYLugPHijCb
 VzfmlHw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 25 Apr 2017, Junio C Hamano wrote:

> Running
> 
> $ git grep -i -e 'instruction [ls]' -e 'todo l'
> 
> lets us count how we call them, and we can see there is only one
> instance of 'instruction list'.
> 
> Running the above in v1.7.3 tree shows that it was originally called
> 'todo list', and we can see that an enhancement of cherry-pick in
> cd4093b6 ("Merge branch 'rr/revert-cherry-pick-continue'",
> 2011-10-05)) started calling this instruction sheet around v1.7.8.
> 
> A follow-on patch to unify all three would be nice, indeed.

But we cannot unify them, as the config option's name uses "instruction"
and to keep backwards-compatibility, we are simply unable to resolve the
confusion.

Ciao,
Dscho
