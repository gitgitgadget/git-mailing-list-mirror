Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 940F82021E
	for <e@80x24.org>; Thu,  3 Nov 2016 20:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758675AbcKCUrk (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Nov 2016 16:47:40 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:15052 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758622AbcKCUrk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2016 16:47:40 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3t8xqY6BMgz5tlF;
        Thu,  3 Nov 2016 21:47:37 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 871B3149;
        Thu,  3 Nov 2016 21:47:37 +0100 (CET)
Subject: Re: [PATCHv2 00/36] Revamp the attr subsystem!
To:     Stefan Beller <sbeller@google.com>
References: <20161028185502.8789-1-sbeller@google.com>
Cc:     gitster@pobox.com, bmwill@google.com, pclouds@gmail.com,
        git@vger.kernel.org
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <18e8d0bb-ceb0-17dd-1318-f07585f8709b@kdbg.org>
Date:   Thu, 3 Nov 2016 21:47:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20161028185502.8789-1-sbeller@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.10.2016 um 20:54 schrieb Stefan Beller:
> previous discussion at https://public-inbox.org/git/20161022233225.8883-1-sbeller@google.com
>
> This implements the discarded series':
> jc/attr
> jc/attr-more
> sb/pathspec-label
> sb/submodule-default-paths
>
> This includes
> * The fixes for windows

I've tested the incarnation currently in pu (1928fcc65dc6), which also 
has these fixes, and they work well after a cursory test (it at least 
passes the 3 test scripts that the series touches).

>  t/t0003-attributes.sh                         |  26 ++
>  t/t6134-pathspec-with-labels.sh               | 185 +++++++++
>  t/t7400-submodule-basic.sh                    | 134 +++++++

-- Hannes

