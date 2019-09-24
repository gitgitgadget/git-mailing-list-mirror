Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A6071F463
	for <e@80x24.org>; Tue, 24 Sep 2019 10:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504415AbfIXKCY (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Sep 2019 06:02:24 -0400
Received: from smtprelay07.ispgateway.de ([134.119.228.101]:37918 "EHLO
        smtprelay07.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504358AbfIXKCX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Sep 2019 06:02:23 -0400
X-Greylist: delayed 519 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Sep 2019 06:02:23 EDT
Received: from [24.134.116.61] (helo=[192.168.92.208])
        by smtprelay07.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.2)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1iChVs-00056f-Rl; Tue, 24 Sep 2019 11:53:40 +0200
Subject: Re: [PATCH v2 1/2] t0028: fix test for UTF-16-LE-BOM
To:     =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        Alexandr Miloslavskiy via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <pull.347.git.gitgitgadget@gmail.com>
 <pull.347.v2.git.gitgitgadget@gmail.com>
 <d717a60932223443e95c000f4d17210b07d7b1a9.1569233057.git.gitgitgadget@gmail.com>
 <20190924034611.6bsy627udlzgxuv2@tb-raspi4>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <847a5ce7-0228-501b-e753-1688c4a24b01@syntevo.com>
Date:   Tue, 24 Sep 2019 11:53:39 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190924034611.6bsy627udlzgxuv2@tb-raspi4>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24.09.2019 5:46, Torsten Bögershausen wrote:
> Out of curiosity:
> What made the test fail, and does it pass noe ?

It failed to a bug in Windows Debug build, which caused iconv() to fail
in most cases, see:
https://public-inbox.org/git/pull.348.git.gitgitgadget@gmail.com/

> How about the following:

Sure thing, I will use the wording you suggested.
