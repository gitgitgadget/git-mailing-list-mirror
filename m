Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 787811FF40
	for <e@80x24.org>; Wed, 21 Dec 2016 21:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757112AbcLUVPO (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Dec 2016 16:15:14 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:61985 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754466AbcLUVPN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Dec 2016 16:15:13 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3tkS9C111Jz5tlS;
        Wed, 21 Dec 2016 22:15:11 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id C45172222;
        Wed, 21 Dec 2016 22:15:10 +0100 (CET)
Subject: Re: [PATCH 0/2] Really fix the isatty() problem on Windows
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
References: <cover.1482342791.git.johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Pranit Bauva <pranit.bauva@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <b0541907-ee79-207b-dc0f-1e3e7d761950@kdbg.org>
Date:   Wed, 21 Dec 2016 22:15:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <cover.1482342791.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 21.12.2016 um 18:53 schrieb Johannes Schindelin:
> The current patch series is based on `pu`, as that already has the
> winansi_get_osfhandle() fix. For ease of testing, I also have a branch
> based on master which you can pull via
>
> 	git pull https://github.com/dscho/git mingw-isatty-fixup-master

Will test and report back tomorrow.

-- Hannes

