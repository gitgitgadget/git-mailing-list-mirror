Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93B7B1F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 17:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbfKSRCd (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Nov 2019 12:02:33 -0500
Received: from smtprelay07.ispgateway.de ([134.119.228.100]:53535 "EHLO
        smtprelay07.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbfKSRCc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 12:02:32 -0500
Received: from [24.134.116.61] (helo=[192.168.92.208])
        by smtprelay07.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1iX6ta-0006dw-Hm; Tue, 19 Nov 2019 18:02:30 +0100
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
Message-ID: <1d3cb1f6-1537-0619-6484-9bbd187c67fe@syntevo.com>
Date:   Tue, 19 Nov 2019 18:02:29 +0100
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

This has shown me that I didn't synchronize docs enough. I have studied 
docs for other commands and found out that most of them list <pathspec> 
in a separate paragraph under options.

I find it very reasonable, because that's where I would normally expect 
it as a reader, together with other options.

So I adjusted 'git-reset' docs to also list <pathspec> under options.

