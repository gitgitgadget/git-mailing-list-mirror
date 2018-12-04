Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85B93211B3
	for <e@80x24.org>; Tue,  4 Dec 2018 21:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbeLDVyB (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Dec 2018 16:54:01 -0500
Received: from bsmtp7.bon.at ([213.33.87.19]:21088 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbeLDVyB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Dec 2018 16:54:01 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 438bGt4rPWz5tlF;
        Tue,  4 Dec 2018 22:53:58 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 2D66D12DF;
        Tue,  4 Dec 2018 22:53:58 +0100 (CET)
Subject: Re: [PATCH] rebase docs: fix incorrect format of the section
 Behavioral Differences
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
References: <f26b53e3-e7d1-f0fe-cdd3-dd734beb1628@kdbg.org>
 <20181204212411.11572-1-newren@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <f2ed3730-03f3-ae92-234c-e7500eaa5c33@kdbg.org>
Date:   Tue, 4 Dec 2018 22:53:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181204212411.11572-1-newren@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 04.12.18 um 22:24 schrieb Elijah Newren:
> +....  The am backend sometimes does not because it operates on
> +"fake ancestors" that involve trees containing only the files modified
> +in the patch.  Without accurate tree information, directory rename
> +detection cannot safely operate and is thus turned off in the am
> +backend.

Directory rename detection does not work sometimes. That is, it works 
most of the time. But how can that be the case when it is turned off?

-- Hannes
