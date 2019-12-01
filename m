Return-Path: <SRS0=LEOb=ZX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA84CC432C0
	for <git@archiver.kernel.org>; Sun,  1 Dec 2019 16:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DC802073C
	for <git@archiver.kernel.org>; Sun,  1 Dec 2019 16:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfLAQwj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Dec 2019 11:52:39 -0500
Received: from smtprelay07.ispgateway.de ([134.119.228.97]:46027 "EHLO
        smtprelay07.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbfLAQwi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Dec 2019 11:52:38 -0500
Received: from [84.175.182.25] (helo=[192.168.2.6])
        by smtprelay07.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1ibSSX-0005sF-PD; Sun, 01 Dec 2019 17:52:33 +0100
Subject: Re: [PATCH v2 0/2] checkout: die() on ambiguous tracking branches
To:     Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <pull.477.git.1574848137.gitgitgadget@gmail.com>
 <pull.477.v2.git.1574872991.gitgitgadget@gmail.com>
 <xmqqwobgyrnf.fsf@gitster-ct.c.googlers.com>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <10e7d07d-9432-1c41-289e-2be86539aa56@syntevo.com>
Date:   Sun, 1 Dec 2019 17:52:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <xmqqwobgyrnf.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01.12.2019 16:47, Junio C Hamano wrote:
> When sending an updated series after getting review comments from
> others to your earlier round of the same series, please make sure
> these reviewers are CC'ed, especially those who thought the earlier
> one(s) were not quite right, so that they can say "oh, I changed my
> mind.  This round is good", or "I think it is still wrong in this
> round, because of ...".
> 
> You do not necessarily have to include me on CC: line before the
> list seems to have reached concensus that the patches are good.

OK, thanks for explaining! I'm new and didn't know about that.

For this patch, I already informed reviewers via explicit replies. From 
the next one, I'll try to remember to also CC them.
