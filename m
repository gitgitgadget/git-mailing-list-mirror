Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F23D1F70F
	for <e@80x24.org>; Thu, 26 Jan 2017 12:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753791AbdAZMIQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 07:08:16 -0500
Received: from mout.gmx.net ([212.227.17.20]:61388 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753096AbdAZMIM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 07:08:12 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MfiFU-1ctlV726gW-00NCCo; Thu, 26
 Jan 2017 13:07:53 +0100
Date:   Thu, 26 Jan 2017 13:07:51 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] fsck: lazily load types under --connectivity-only
In-Reply-To: <20170126041206.5qfv7r7czbwfqvaa@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1701261307261.3469@virtualbox>
References: <20170126041025.hqg3znwew7jxgxxg@sigill.intra.peff.net> <20170126041206.5qfv7r7czbwfqvaa@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:YvL789VxJEpMtcGBz1v+maCd3A4k2G8sRIQZ6KmLxrQ1DS5nj9k
 gnwV6ai8N5Cpz1E3CPinJRNYOh5grLAUyOuX4pFiN0vF4ppfUggbOlrayRWN2iMRFmGVKRu
 k4Y6M2BKHJKsLLmx52eHDiGxt1KiNMAHZG6IyYyopg08ou5pkosB/3FZLWdovaeeWgvMryu
 F77j9jLI+zXU11NUVgziw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ekUijC3Sawk=:wbrK39IRBMW2kkn6jo7CE6
 co3HANpx42nHSOscyo9DQrzVIGjgxBkCLxFftm3WgQlolpXtF32FB9JMXuc/WExjBqgD/k9vy
 nV+4qV1PNJwSKVH1D+bC+T6yTR+AeRSGLcLJ4RRqsFlY6pOpLBkEpl5BCWl/kppyolha8Zvfm
 TiQqb7UV8d2emD5GK0RJy1vk5dSDiSOIJI8BtvQhyW55RfpZJwNjZq+PLMANhaDgAOUfJzYh3
 QX/N7tHNYWjk/+/6CxwcujEK7zjlgRBoZFBlNTtNlm/hsqKJffWWVxDAjZWhH0EOfFiKNQqJA
 KMqzxVGTNujOSPZXvG1GQGMkTkUAnt54ARDCMxeMN/Hn8iA+uMop2aIknz62Bpyk6/sxbR+7C
 44tg/8IQCvmo7n5QTIhww7KL2bYwzI6rd+5L7oW8q4JckbvetNAJEkgSoWC+Vkgke7/EruEgs
 0CvJaBC6g/EnW4ufNjenm4g5qPqIOcLalJYninYK3I5nSrHW/YZsXEsnZuwhu8aGZnHMU6nTv
 WuxWl2j45bYlfnwEo3hkoOj3KXEwkniiTL4BEyRsVKYDub4RP6y9+6ogxZ82MVJ6/8DQsY9rT
 AblDg+02wvpou1R5imnkcQdDrCCqzQE22JeTKfAp8LPpGoo50n2NSurqfHFY+4/EZf6/CXzoq
 n0Awd1cNPjrxvyjDs518LkT76X+d5SLZa1kRU66PQiF8ZZ3MQrYXuQWAjU5dghEqpDmnC11Vi
 absDYr0IEYDiN7Eiz2324at1D/m4QIHhAOzVIhIs2dXnCZRQQLq+nMGc6aTjcyPTSOfAYPAlw
 S2KC40m
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Wed, 25 Jan 2017, Jeff King wrote:

>  builtin/fsck.c | 58 +++++++---------------------------------------------------
>  fsck.c         |  4 ++++
>  2 files changed, 11 insertions(+), 51 deletions(-)

Patch looks good to my eyes.

Ciao,
Johannes
