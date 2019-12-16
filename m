Return-Path: <SRS0=PvcO=2G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8C5C43603
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 15:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECDBF2072D
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 15:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbfLPPxi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 10:53:38 -0500
Received: from smtprelay05.ispgateway.de ([80.67.31.97]:5317 "EHLO
        smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726916AbfLPPxh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 10:53:37 -0500
Received: from [24.134.116.61] (helo=[192.168.92.208])
        by smtprelay05.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1igsgf-0004K9-3w; Mon, 16 Dec 2019 16:53:33 +0100
Subject: Re: [PATCH 02/16] commit: forbid --pathspec-from-file --all
To:     Phillip Wood <phillip.wood123@gmail.com>,
        Alexandr Miloslavskiy via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <pull.490.git.1576161385.gitgitgadget@gmail.com>
 <c0980519ed319295c273d358b0547340cc511a6b.1576161385.git.gitgitgadget@gmail.com>
 <5928a257-a1f4-dad3-052e-7a0dbf1df8e3@gmail.com>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <a44bc260-c325-ce31-1a12-6c34fdbc8d39@syntevo.com>
Date:   Mon, 16 Dec 2019 16:53:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <5928a257-a1f4-dad3-052e-7a0dbf1df8e3@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16.12.2019 13:02, Phillip Wood wrote:

> Thanks for fixing this. If you want to credit me then I think
> Reported-by: would be more appropriate as I didn't write this patch.
> Also I tend to use phillip.wood@dunelm.org.uk for footers as it's a
> portable email address (I should add a mailmap entry...). It would be
> nice to have tests for the various error conditions at some point.

Thanks, I have addressed both issues in V2.
