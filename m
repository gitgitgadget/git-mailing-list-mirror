Return-Path: <SRS0=7IA6=Z3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CCEC43603
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 10:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78CE62464D
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 10:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbfLEKym (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Dec 2019 05:54:42 -0500
Received: from smtprelay01.ispgateway.de ([80.67.31.35]:41790 "EHLO
        smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728735AbfLEKym (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Dec 2019 05:54:42 -0500
Received: from [24.134.116.61] (helo=[192.168.92.208])
        by smtprelay01.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1icobf-0003J2-1o; Thu, 05 Dec 2019 11:43:35 +0100
Subject: Re: [PATCH v4 00/13] Add --pathspec-from-file option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Alexandr Miloslavskiy via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.445.v3.git.1574182135.gitgitgadget@gmail.com>
 <pull.445.v4.git.1575381738.gitgitgadget@gmail.com>
 <xmqqpnh55oxi.fsf@gitster-ct.c.googlers.com>
 <e4165215-c0f0-8659-8abf-9e91be671e8b@syntevo.com>
 <xmqqfthz51vt.fsf@gitster-ct.c.googlers.com>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <4e7a7d10-f558-1560-62bd-735696794da2@syntevo.com>
Date:   Thu, 5 Dec 2019 11:43:33 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <xmqqfthz51vt.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04.12.2019 20:25, Junio C Hamano wrote:

> Scary will probably not be an issue for the follow-up topics around
> the pathspec-from-file theme, but a huge topic tends to wear out the
> author and the reviewers, inviting trivial bugs that would otherwise
> be found easily go unnoticed.

OK, thanks! I will pause for now and wait until existing patches are in 
`master`.
