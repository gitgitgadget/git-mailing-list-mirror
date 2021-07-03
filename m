Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63394C07E97
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 11:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 309B9617ED
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 11:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbhGCLip (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Jul 2021 07:38:45 -0400
Received: from smtprelay04.ispgateway.de ([80.67.18.16]:34098 "EHLO
        smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbhGCLin (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jul 2021 07:38:43 -0400
Received: from [87.152.157.83] (helo=[192.168.2.202])
        by smtprelay04.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <test2@mfriebe.de>)
        id 1lzbbq-0005ch-PJ; Sat, 03 Jul 2021 11:06:46 +0200
Subject: Re: Logical bug during MERGE or REBASE
To:     skottkuk@wp.pl, git@vger.kernel.org
References: <1932019063.20210702192555@wp.pl>
From:   martin <test2@mfriebe.de>
Message-ID: <4bae5d01-fa6d-7216-55cf-fa7003f5c75c@mfriebe.de>
Date:   Sat, 3 Jul 2021 11:07:25 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1932019063.20210702192555@wp.pl>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-Df-Sender: bWVAbWZyaWViZS5kZQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/07/2021 18:25, skottkuk@wp.pl wrote:
> But as for me, it would be logical to consider the construction inside {} as something whole,
For git the {} are just text, like anything else in your file.

Also, seeing the function as a whole, i.e. always give a conflict for 
any 2 changes within one function, is not wanted.
There a plenty of cases where 2 or more changes within the same (bigger) 
function are merged together, and expected to be merged.

For all else see the reply from Atharva Raykar.
