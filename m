Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 918B61F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 16:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbfKSQxq (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Nov 2019 11:53:46 -0500
Received: from smtprelay06.ispgateway.de ([80.67.31.101]:41455 "EHLO
        smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbfKSQxq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 11:53:46 -0500
Received: from [24.134.116.61] (helo=[192.168.92.208])
        by smtprelay06.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1iX6l4-0007bF-Cu; Tue, 19 Nov 2019 17:53:42 +0100
Subject: Re: [PATCH v2 5/6] doc: commit: unify <pathspec> description
To:     Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.445.git.1572895605.gitgitgadget@gmail.com>
 <pull.445.v2.git.1573055478.gitgitgadget@gmail.com>
 <20c4495fd31110c56cca84385bee6d1ab4a6f33e.1573055478.git.gitgitgadget@gmail.com>
 <xmqqk17wxuev.fsf@gitster-ct.c.googlers.com>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <839aaf51-147f-19b2-514f-bf9b1ea78101@syntevo.com>
Date:   Tue, 19 Nov 2019 17:53:41 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <xmqqk17wxuev.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19.11.2019 7:16, Junio C Hamano wrote:
>> +For more details about the <pathspec> syntax, see the 'pathspec' entry
>> +in linkgit:gitglossary[7].
> 
> What you added in [PATCH 3/6] (git reset doc) sends a slightly
> different message, i.e.
> 
>      The <pathspec> is used to limit the paths affected by the operation
>      (see the entry for 'pathspec' in linkgit:gitglossary[7] for more details).
> 
> and I think that was more appropriate than what we see here.  You
> are referring your readers to the glossary entry not just for the
> syntax but also the entire concept of <pathspec>.
> 
> IOW, it would be needed to drop "syntax" from "about the <pathspec>
> syntax" from here to match the update to "git reset" documentation.

I shortened it even more in V3, I think it's better now?
