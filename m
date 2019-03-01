Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AB9620248
	for <e@80x24.org>; Fri,  1 Mar 2019 06:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbfCAG4F (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Mar 2019 01:56:05 -0500
Received: from bsmtp7.bon.at ([213.33.87.19]:27987 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbfCAG4E (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Mar 2019 01:56:04 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 449gDf1qdDz5tlR;
        Fri,  1 Mar 2019 07:56:02 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 2EC7A207F;
        Fri,  1 Mar 2019 07:56:01 +0100 (CET)
Subject: Re: Prevent reset --hard from deleting everything if one doesn't have
 any commits yet
To:     Manuel Guilamo <manuel.guilamo@publicis.com.do>
References: <15568DDA-F501-48C9-A1C0-97C72C29DA23@publicis.com.do>
Cc:     git@vger.kernel.org
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <d1b34077-1c0e-7a2a-d2c7-da013dd56cd9@kdbg.org>
Date:   Fri, 1 Mar 2019 07:56:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <15568DDA-F501-48C9-A1C0-97C72C29DA23@publicis.com.do>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.02.19 um 22:43 schrieb Manuel Guilamo:
> I accidentally executed git reset —hard in a project that doesn’t
> have any commits yet. git erased everything, everything I’ve worked
> the past week, I believe this is not a desired behavior, considering
> I’m not able to undo that action, because git doesn’t have any
> history whatsoever.

I tested this, and it does not happen for me as long as I do not `git
add` anything.

So, I assume you did `git add` your content and then you did a `git
reset --hard`. In that case, I'm afraid Git behaved as designed and
"doesn't have any commits" is a red herring.

-- Hannes
