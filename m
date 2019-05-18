Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2CEE1F461
	for <e@80x24.org>; Sat, 18 May 2019 16:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbfERQim (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 May 2019 12:38:42 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:62138 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727073AbfERQil (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 May 2019 12:38:41 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 455rSw2xLkz5tl9;
        Sat, 18 May 2019 18:38:40 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id E1DA120BA;
        Sat, 18 May 2019 18:38:39 +0200 (CEST)
Subject: Re: Git config "ignorecase = true" has issues
To:     Ax Da <discussion@gmx.net>
Cc:     git@vger.kernel.org
References: <trinity-4a160867-2036-4f8a-8363-7bf2e021d840-1558184320864@3c-app-gmx-bs48>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <b75455b6-139a-aa6c-c7f6-7c9330e2ac6f@kdbg.org>
Date:   Sat, 18 May 2019 18:38:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <trinity-4a160867-2036-4f8a-8363-7bf2e021d840-1558184320864@3c-app-gmx-bs48>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 18.05.19 um 14:58 schrieb Ax Da:
> You can rename files like this:
> git mv File.txt file.txt

On a case-insensitive, case-preserving filesystem, a case-only rename
operation is better performed in two steps that do not just change the case:

git mv File.txt  file.txtx
git mv file.txtx file.txt

> git commit
> 
> and Git will record the changes.

-- Hannes
