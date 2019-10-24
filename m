Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DD9E1F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 22:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731992AbfJXWq3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 18:46:29 -0400
Received: from mout.gmx.net ([212.227.15.18]:38309 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbfJXWq2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 18:46:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571957182;
        bh=TJV8jW+VkB6SuDlCxM3Vtfvn+3rWgjKemEqgNWfZzc0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=eEoJGTc7Qjw1b5y8PAT2yPNvDPzTh5GNhRC5gjmuhBaRbjymAtbw34H4/BcD7zKXC
         PJy1ZwyRw6TobnXP05grIBejAC3tyzp0rKtDtyf1A8N8O+VrMv1tglkraOB52x+UPL
         TOOQ1L0/ZgR3Mx/hkNrmLEfh+PRPKs4Cn8ADPClw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mj8mV-1hlhpD1aw1-00fEU8; Fri, 25
 Oct 2019 00:46:22 +0200
Date:   Fri, 25 Oct 2019 00:46:07 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Subject: Git for Windows v2.24.0-rc1, was Re: [ANNOUNCE] Git v2.24.0-rc1
In-Reply-To: <xmqqeez2fzsy.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1910250043140.46@tvgsbejvaqbjf.bet>
References: <xmqqeez2fzsy.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:LimGOaiPwtSycrKeWcrmxyK5aR51+BaNw0CDy6+qZ9MOZEq9Crr
 7SK4e26YiNIpMydC1ok4/sqMd+tv1NmKFnS6w6K5McOj7k9nhwB7X0COZaXR3J2cYnxWDsa
 W5Zbbedz4Uaq05Pj2h7VJ0QbZmbOeLIDjrll+i8uGdZ/JehLiQ5UFcVlY4+BuonrlGrQasD
 bnzluylb58ByGwv6HjAlA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WErhESRki+s=:BFF1qG+P58LBrWXdEFAb3a
 5u2t2jxrySmBFsy9JzcDJFEBceuQhFFjRwLOc+bOZDdzEJWpTDsAMjYWDZ8+oP5VcwSwa3BNx
 DzOe3vGxo0eXA/Kb5LHtYiwMLCZc/Do6RzR+mmJs4CS9toppxHGXa9WwDlUihS0xW7KHfhEgX
 gRzPJ/rG8tl2a02V/LgCjNJwsWOEK/scmW6guObi+0h7SBFO3PWjsGPF9NyoAdMCmRpIQpF/I
 gtxJ1n59N4Nw6c80J+LSr3jbk6YE1P2scEbBd+9vVl8fFx9JdOZS2LSDIfN50B8SbwEkq/qTJ
 T5LUm28IP2AtUeub11hBLM3o5UCEa+IoWp4LUNJtYn7My1lHyy1ovI8ERpVs5Jw/9H+7Yqxcv
 dkcfjivO03DGaQe31bc+twMX2aVUh+2xJvMtf5Ma5AqS7e/P0cyVx0mFIdTdRMHRiMRhuarmM
 PkNmco+vv8WGfIg3Q2JZCRE0C1fjX9YLbulY6iz2lOArCdC4gltfZ+ZMAYC7BM6me+9TN0bWr
 GParWjicfU0myXE8MgsAUjirIOnj4PdnkTZzVG4hnDQxDeDwKuwX731LRc4XVpnRw/eupUMJ2
 z5WPh6fj+Qa95HaKRF1cFyYkSpn3bdOrFpXs9bDstYZ0WOaA81fEMM9EEetAHJR35Qrz44haA
 d4ag1OPoQ7kuwVKLZLQpofrh0x1snwtUJjzBiOIhb4/yAGN18JEsdoZ1R4bwu65/qNeHdgpte
 yddwc1lYJfizs/9k9zB8jZaV6IBBUWRAWi83j+eOBdD3COzBWLBl0TokQEFGktHGlYX3bABCu
 VD7XFjFjnJEg1CzkvyimG3U/fzEVVZNsSPTw4SAsh/hexXcdMnLETXdXvfnrF6SNHfO4iatkn
 GlK8V7+dUXl86YRMUEhCNS9rsxAQfhByk3A+i+Nuwoj8qpBIcgpsz27SLQ/MqKFVnfC67r6/n
 e7Ug0fYfh835Kn6uEPjefU4xVoYlBNksg/9+eQBiTH/R7Lw9nb2+LnIaO5DX1ZQJpXXD6vg3L
 AVDqEXnghyG6ap9c9JtfszXmwpybhFRmyZL1o8xQzJAg38HAnIejGuts7LVNpT/ywKgfqpoUJ
 4FFmZqJVj4rRBfP2RcIbS0fcvNctfC+shOY7Qs8k1eAo7DFFoeZR/xRNiEQ5cPGxefdfaaJBO
 D/q/2CQjY56P1gRjrptZQ0A0flQZqpmAEaVEyStiD714OTvuyNfOvZKqKhJN17rowQtJp/eiR
 dwX2Jr1CQRL0/XFDGPOq6TaSb4G4novXLtUWijMLmojpI2UCfyF5kzWwQ7cA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Team,

On Thu, 24 Oct 2019, Junio C Hamano wrote:

> A release candidate Git v2.24.0-rc1 is now available for testing
> at the usual places.  It is comprised of 511 non-merge commits
> since v2.23.0, contributed by 66 people, 18 of which are new faces.

The corresponding Git for Windows v2.24.0-rc1 can be found here:

	https://github.com/git-for-windows/git/releases/tag/v2.24.0-rc1.windows.1

I would be delighted if we could squash bugs in the -rc phase, and the
more people test this, the more likely we can squash those bugs timely.

The most obvious source of potential problems is the consolidation of
Git for Windows "two system gitconfigs" into a single one. So if you
regularly modify those gitconfigs, it might be a good idea to test with
-rc1.

Thanks,
Johannes
