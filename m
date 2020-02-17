Return-Path: <SRS0=dbxk=4F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F16D0C34021
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 17:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6C5820836
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 17:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729517AbgBQRkQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Feb 2020 12:40:16 -0500
Received: from smtprelay01.ispgateway.de ([80.67.31.24]:12852 "EHLO
        smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbgBQRkQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Feb 2020 12:40:16 -0500
Received: from [24.134.116.61] (helo=[192.168.92.208])
        by smtprelay01.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1j3k9P-0006a6-1q; Mon, 17 Feb 2020 18:25:43 +0100
Subject: Re: [PATCH 2/8] rm: support the --pathspec-from-file option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Alexandr Miloslavskiy via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
References: <pull.530.git.1579190965.gitgitgadget@gmail.com>
 <5611e3ae326bb7f61abf870e3b2851226b6af1d8.1579190965.git.gitgitgadget@gmail.com>
 <xmqqftg8a9fp.fsf@gitster-ct.c.googlers.com>
 <19ab18db-3149-02b1-41d8-7ddb42c3757d@syntevo.com>
 <xmqqd0amz3ai.fsf@gitster-ct.c.googlers.com>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <8e24eab8-fc75-d676-8b11-ee01355813c4@syntevo.com>
Date:   Mon, 17 Feb 2020 18:25:42 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <xmqqd0amz3ai.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10.02.2020 19:48, Junio C Hamano wrote:
> I expected that the proposed log message to explain and justify why
> a change (in behaviour, in design, etc.) is made.  "There is this
> limitation" is not a justification---"because of such and such
> reasons, there is this limitation, otherwise such and such bad
> things happen" is.

I have rewritten the commit message in V3. Is that better?
