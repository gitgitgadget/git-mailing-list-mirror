Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D5351F454
	for <e@80x24.org>; Tue,  5 Nov 2019 19:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390901AbfKEThU (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 14:37:20 -0500
Received: from smtprelay02.ispgateway.de ([80.67.18.44]:64088 "EHLO
        smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390890AbfKEThU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 14:37:20 -0500
Received: from [84.175.180.230] (helo=[192.168.2.6])
        by smtprelay02.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1iS4df-0002PU-Kb; Tue, 05 Nov 2019 20:37:15 +0100
Subject: Re: [PATCH 3/5] reset: support the --pathspec-from-file option
To:     phillip.wood@dunelm.org.uk,
        Alexandr Miloslavskiy via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <pull.445.git.1572895605.gitgitgadget@gmail.com>
 <8d9f1fbc18346144a0c866a59891b652dcfe9b7f.1572895605.git.gitgitgadget@gmail.com>
 <3cee48dd-15bb-1bec-6d23-d05cce0f4eb1@gmail.com>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <f3a24b43-62ab-0912-bbd8-ae40052bc2ad@syntevo.com>
Date:   Tue, 5 Nov 2019 20:37:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <3cee48dd-15bb-1bec-6d23-d05cce0f4eb1@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05.11.2019 17:14, Phillip Wood wrote:

>> +        OPT_FILENAME(0, "pathspec-from-file", &pathspec_from_file,
>> +                N_("read pathspecs from file")),
>> +        OPT_BOOL(0, "pathspec-file-null", &pathspec_file_null,
>> +                N_("with --pathspec-from-file, pathspecs are 
>> separated with NUL character")),
> 
> One thing I forgot to mention before is that if you're going to add 
> these options to a number of commands then maybe it is worth defining a 
> macro for each one in parse-options.h. There are a couple of examples of 
> this at the end of that file.

Thanks for the pointer!
