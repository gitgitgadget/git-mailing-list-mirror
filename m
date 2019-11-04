Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AC161F454
	for <e@80x24.org>; Mon,  4 Nov 2019 10:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbfKDKYH (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 05:24:07 -0500
Received: from smtprelay03.ispgateway.de ([80.67.31.41]:6935 "EHLO
        smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727766AbfKDKYH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 05:24:07 -0500
Received: from [24.134.116.61] (helo=[192.168.92.208])
        by smtprelay03.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1iRZWk-0004Mz-VT; Mon, 04 Nov 2019 11:24:03 +0100
Subject: Re: 'git reset -- NonExistingFile' succeeds
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <f6d853ce-6f27-ed58-a850-d9a6f245509a@syntevo.com>
 <xmqqo8xu51cv.fsf@gitster-ct.c.googlers.com>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <df35c20c-669e-35a1-9b2c-22940637b560@syntevo.com>
Date:   Mon, 4 Nov 2019 11:24:01 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <xmqqo8xu51cv.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02.11.2019 5:49, Junio C Hamano wrote:
> It's sort of expected ;-)

Didn't expect such a detailed reply, thanks!

Not really a problem for me, just I was surprised and thought that I'd 
ask about it.

I came across this issue when writing a test for 'git reset'. I'll 
simply change the test to verify the repository state instead of 
expecting 'git reset' to fail.
