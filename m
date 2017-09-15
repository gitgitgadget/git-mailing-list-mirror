Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86EAC20281
	for <e@80x24.org>; Fri, 15 Sep 2017 16:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751466AbdIOQS2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 12:18:28 -0400
Received: from mout.gmx.net ([212.227.17.22]:49597 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751211AbdIOQS1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 12:18:27 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Ldspr-1d9tni00yR-00j5PN; Fri, 15
 Sep 2017 18:18:21 +0200
Date:   Fri, 15 Sep 2017 18:18:19 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2017, #05; Tue, 22)
In-Reply-To: <xmqq1so0wyjd.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1709151816390.219280@virtualbox>
References: <xmqq4lsz2x6r.fsf@gitster.mtv.corp.google.com>        <7D99B245-4D22-4C9C-9C43-C8B8656F8E6D@gmail.com> <xmqq1so0wyjd.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:9P387GFvDdHs1jMCaN/5zBdkWWbDDlyhs0z/XM5d+AR0W/ZRi9j
 VIy3jqti6MRnoF+ZkqhljL3HLLndzXPA7Np8F0rXzUFI6EmTwffDVsnLp7ook3NhhrO6Iqn
 WsS4UtFeLTEXIgYQO1Ogoa/EFDvk46/w4PGGPGVJ9MHNbbHVrfKSXsKjgiSI8ivYt7TQi34
 wrI46BrUCzwL/Uof8RXYQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CkEOy7jhX78=:6InMed5dUQT56i7ZB6X4og
 gMn/RP1f/1VSnYFFlPphZB0y9qpNKgkJRe+9wWVIpU9tES74yYOQ2HFy/VkF3k86/x/BbjI7P
 ocRNBZKUjr/S2CSFkIyuRkSmnIIsSNj0FqTg1XS9rULcNZg5qThXk8SA6oDcWo8/Cv2qgf/r+
 1SFkZKMpz3ppKL0+Bnv6cNCB5XrSvHrVVJKEk/JZs+hwamKkthY4sPOaZwUXXZGdydIG//c+6
 3Eu+4wMkKeKzpI8PKYK6GEWvJzviqdySrdXKyuGKeuAdw317/cvgjmdSeEmNjRCdv5xnMqIZ6
 LpYy/n+kWdLQCz29CXB7nLzCCLocc2YZsZIJ0FtZ6WmIu64hoK3MagVxEJp5yrOUTYoS7gze2
 PZSDmfzdRt4MP+gOMGMiXnnhSUFQikPHw0yYuKlZGRsFI9XTRY51Zde8o4pXmYYbec1g6agkR
 uqO5s0sqlqMi+aMXXfm7Tr9LdonsiEmnJRqoYPELNkU+nnHmzFXCR7JKlj/ILPAZWcL3p6B77
 k4TfR+tvVQjsyoAZmMF4V7rdkC9RgHpUE2X37lybBnKNfPusoMM+w2eHBiRD7wCGXgQ+AHCod
 uGQKmLFiYmpRrE8t0xZI03HJz6+Ie6elsXu91Zt4uwq5zlt26GUTZc73+76txy6GM363sPxP7
 NYsvZiPVRMqcrOPeU26F4MSrnYoeE0B321TpOeV+reBn9HSDhKGGpJVES8OwuKRwAR2hIt1Rt
 pgl6DVqrWMBEXy74zbCeRBkVSxiVzJfB1/6JWAkyfXTCEltBIerEc+qgFLi3UW6bInS2ZSwLb
 kZ574gIeimal1m1DWlnYDnTnYHwU4yY9wxh2xwwGM6py3YHw6M=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 24 Aug 2017, Junio C Hamano wrote:

> Lars Schneider <larsxschneider@gmail.com> writes:
> 
> > On 22 Aug 2017, at 21:56, Junio C Hamano <gitster@pobox.com> wrote:
> >
> >> Here are the topics that have been cooking.  Commits prefixed with
> >> '-' are only in 'pu' (proposed updates) while commits prefixed with
> >> '+' are in 'next'.  The ones marked with '.' do not appear in any of
> >> the integration branches, but I am still holding onto them.
> >> 
> >> The second batch of topics are in.  This cycle is going a bit slower
> >> than the previous one (as of mid-week #3 of this cycle, we have
> >> about 200 patches on 'master' since v2.14, compared to about 300
> >> patches in the cycle towards v2.14 at a similar point in the cycle),
> >> but hopefully we can catch up eventually.  
> >> 
> >> I am planning to be offline most of the next week, by the way.
> >> 
> >> You can find the changes described here in the integration branches
> >> of the repositories listed at
> >> 
> >>    http://git-blame.blogspot.com/p/git-public-repositories.html
> >> 
> >> --------------------------------------------------
> >> [Graduated to "master"]
> >> 
> >
> > Hi Junio,
> >
> > just in case this got lost: I posted a patch with an improvement to 
> > 2841e8f ("convert: add "status=delayed" to filter process protocol", 
> > 2017-06-30) which was merged to master in the beginning of 2.15.
> >
> > https://public-inbox.org/git/20170820154720.32259-1-larsxschneider@gmail.com/
> 
> Thanks for pinging, but next time ping the thread itself if it is
> about something that is not in What's cooking report you are
> responding to.

If you want *contributors* to ping the thread themselves, how about
*posting your updates there, too*?

It does make things inconvenient for contributors if they have to monitor
those Whats' cooking emails in addition to the mail threads, you know?

Ciao,
Dscho
