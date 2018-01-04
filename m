Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76E181F404
	for <e@80x24.org>; Thu,  4 Jan 2018 22:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753268AbeADW2B (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 17:28:01 -0500
Received: from mout.gmx.net ([212.227.17.21]:57019 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753152AbeADW2A (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 17:28:00 -0500
Received: from [192.168.0.129] ([37.201.193.20]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MGRhs-1ekPGf40sy-00DEOP; Thu, 04
 Jan 2018 23:27:58 +0100
Date:   Thu, 4 Jan 2018 23:27:58 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Alex Vandiver <alexmv@dropbox.com>
cc:     git@vger.kernel.org, Ben Peart <peartben@gmail.com>
Subject: Re: [PATCH 2/6] fsmonitor: Stop inline'ing mark_fsmonitor_valid /
 _invalid
In-Reply-To: <9bb36cea369530b980f6542e3e0f24dc142a20a8.1514948078.git.alexmv@dropbox.com>
Message-ID: <alpine.DEB.2.21.1.1801042326581.32@MININT-6BKU6QN.europe.corp.microsoft.com>
References: <20180103030456.8181-1-alexmv@dropbox.com> <9bb36cea369530b980f6542e3e0f24dc142a20a8.1514948078.git.alexmv@dropbox.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:q77Cw6SvINKetViVxkW2h79SS6h3dKr+HSLSAcedvO85eQdvLUf
 l1T4DGGvW5mQAel9xXQpoxlpujXbmnHKn1wj4uTqDzJV12vhf/WMApDfABcRY/MjcORzf1E
 gFyE8YMejPfLu+4WYpRF5mVNMKRjmJggeh52bHaT9Xkx98bkYz0oDzSTKCYdpugsqIqBDB1
 3c/u9noEaS621UEIuc2Vg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5ylxkhA0hFY=:d/5JEqpjBSEXIeTZ2tYcqV
 cIphzM9+t6gT7wzP2w/1dGqWkoh8saR0957Uf9dXK/+wmzVZ67UhssDWngDAIHketLbsBC2NN
 Ksl3etxieEeTCvOPvXBUEnfY7kIrBX9qNkCHDxDYe1GPTmqGLzVPEDNq697IXjsfwmKM8/x7v
 j9SLd2z1a9SgTs7Gxg5HIcHvp1GP51QBcbKsRn0O9z/IY2exHYyBvvlIZcGgef2MEjzBJaUAq
 bEtA2KpQQCz5tdmWLdtxJ45aKv+YpdhIdGjbAObmcyTAIkWMUFQrGNDylKQH93Ge3b5nlODOq
 tK+KNOwucdMnIfTjv1ceGXTPErMXb4jCoAu2QYTnophP0HXmlpYSopeVHPe4TWxEhAkFNbm8Q
 4dvzIrRMyEL4D3P2IN25JQbYPxLjS6Q6jRXupUA811ysfIlFZINBQ3yj9MsJWjR/Pt0zU7APK
 jHM+x60cm6+2SSrzGdQBSqmYrkk9Fa0NMbf7nccb0SnAF+yaMFcWYjYkFweiU3YvkQmWGLmAJ
 wWVujDC0EFKCNKwNBRjRoxRSp3XroUpCT8UYizWErqdsveNkXXfKS5wzlZC5DpgMZOSGVjWbD
 nhMpgHkRzSvw0JHTuKRjksHFmWQ8SxcVkHfQt+Jgh2hJQXcA7h2xtgsIOKqT/sCKuTyXTei8q
 unCeMBEcTRNBQGm5JvYxeQeQJG6Iv0FsNdjXC8nxzd9h2FvH4/nvDjDNs1tVITXRxWMciReYl
 0ZvSSMb6ExRdvWyvy/b5bxFxTTKgPNyRWeMXHt7lIW5IZT7HqevB4sGFz2fYCS6MpcXBn2tmt
 pFCGweh8IWD9jSqtlYEHZx6tzD16vofAZ3Gp5EEnVhyyRmOqvbFhGkTkHADRy4nfsSczkf8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex,

On Tue, 2 Jan 2018, Alex Vandiver wrote:

> These were inline'd when they were first introduced, presumably as an
> optimization for cases when they were called in tight loops.  This
> complicates using these functions, as untracked_cache_invalidate_path
> is defined in dir.h.
> 
> Leave the inline'ing up to the compiler's decision, for ease of use.

As a compromise, you could leave the rather simple mark_fsmonitor_valid()
as inlined function. It should be by far the more-called function, anyway.

Ciao,
Johannes
