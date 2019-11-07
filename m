Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC1281F454
	for <e@80x24.org>; Thu,  7 Nov 2019 11:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387629AbfKGLFP (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 06:05:15 -0500
Received: from smtprelay03.ispgateway.de ([80.67.18.15]:20710 "EHLO
        smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbfKGLFO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 06:05:14 -0500
Received: from [24.134.116.61] (helo=[192.168.92.208])
        by smtprelay03.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1iSfbE-0007DM-5V; Thu, 07 Nov 2019 12:05:12 +0100
Subject: Re: [PATCH 2/5] doc: reset: unify <pathspec> description
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Alexandr Miloslavskiy via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.445.git.1572895605.gitgitgadget@gmail.com>
 <1740ac7a291cfc81418c2d437201c3373487fa26.1572895605.git.gitgitgadget@gmail.com>
 <xmqqh83hveiz.fsf@gitster-ct.c.googlers.com>
 <b7acd8d1-d17a-29bd-44d3-59d425842c10@syntevo.com>
 <xmqqo8xoqlvf.fsf@gitster-ct.c.googlers.com>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <5121d118-6a4c-80c1-ccd5-60c3c6b5f6ee@syntevo.com>
Date:   Thu, 7 Nov 2019 12:05:10 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <xmqqo8xoqlvf.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07.11.2019 6:46, Junio C Hamano wrote:
> I do not know if removal of the only-half-correct "This is the
> opposite of add" should be part of this change, or it should be a
> separate fix.  The half-wrong sentene was not introduced by this
> patch, so leaving it as-is is OK.  It just leaves another thing for
> us to think about later.

My feeling is that this problem is separate from the topic I'm working 
on. I only touched docs to synchronize <pathspec>, so that I can 
copy&paste new option description in next commit without tailoring it to 
local speech. Also, I must admit that upon reading your explanation, I 
felt that I lack the experience to update the writing properly.
