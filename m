Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AF7E1F576
	for <e@80x24.org>; Sun,  4 Feb 2018 08:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750844AbeBDIyn (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Feb 2018 03:54:43 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:12836 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750796AbeBDIyl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Feb 2018 03:54:41 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3zZ4KW3D3Fz5tlC;
        Sun,  4 Feb 2018 09:54:39 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 49DA83A1;
        Sun,  4 Feb 2018 09:54:38 +0100 (CET)
Subject: Re: [PATCH v7 17/31] merge-recursive: add a new hashmap for storing
 directory renames
To:     Elijah Newren <newren@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        git <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
References: <20180130232533.25846-1-newren@gmail.com>
 <20180130232533.25846-18-newren@gmail.com>
 <CAGZ79kYcmq9JyD4smH1Vdm5YOFXRXjhYhhHYjNV=Z7mxz2UVGw@mail.gmail.com>
 <CABPp-BGc0F5023yY1wRb3Gy+oXdbHAibkHYr35+zE=OnT2bQmQ@mail.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <911da66d-d6f3-2366-b2ae-4741ec9ff6d6@kdbg.org>
Date:   Sun, 4 Feb 2018 09:54:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CABPp-BGc0F5023yY1wRb3Gy+oXdbHAibkHYr35+zE=OnT2bQmQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.02.2018 um 22:34 schrieb Elijah Newren:
>  If anyone can find an
> example of a real world open source repository (linux, webkit, git,
> etc.) with a merge where n is greater than about 10, I'll be
> surprised.

git rev-list --parents --merges master |
 grep " .* .* .* .* .* .* .* .* .* .* "

returns quite a few hits in the Linux repository. Most notable is
fa623d1b0222adbe8f822e53c08003b9679a410c; spoiler: it has 30 parents.

-- Hannes
