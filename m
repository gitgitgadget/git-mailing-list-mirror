Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC8BC433EF
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 06:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234233AbiAFGRo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jan 2022 01:17:44 -0500
Received: from smtprelay03.ispgateway.de ([80.67.18.15]:55289 "EHLO
        smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiAFGRo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jan 2022 01:17:44 -0500
Received: from [91.113.179.170] (helo=[192.168.92.29])
        by smtprelay03.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <marc.strapetz@syntevo.com>)
        id 1n5M5y-00063T-W5; Thu, 06 Jan 2022 07:17:55 +0100
Message-ID: <b265de46-9ccd-4f31-d51c-1df1b39606d5@syntevo.com>
Date:   Thu, 6 Jan 2022 07:17:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] t/README: fix typo
Content-Language: en-US
From:   Marc Strapetz <marc.strapetz@syntevo.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Marc Strapetz via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.1110.git.1641338224631.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2201051701120.7076@tvgsbejvaqbjf.bet>
 <9f74fc04-ea68-6bdd-3341-ecf7a2aed6cd@syntevo.com>
In-Reply-To: <9f74fc04-ea68-6bdd-3341-ecf7a2aed6cd@syntevo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Df-Sender: bWFyYy5zdHJhcGV0ekBzeW50ZXZvLmNvbQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/01/2022 17:47, Marc Strapetz wrote:
> Hi Dscho,
> 
> On 05/01/2022 17:22, Johannes Schindelin wrote:
>>> @@ -466,7 +466,7 @@ explicitly providing repositories when accessing 
>>> submodule objects is
>>>   complete or needs to be abandoned for whatever reason (in which 
>>> case the
>>>   migrated codepaths still retain their performance benefits).
>>>
>>> -GIT_TEST_REQUIRE_PREREQ=<list> allows specifying a space speparated 
>>> list of
>>> +GIT_TEST_REQUIRE_PREREQ=<list> allows specifying a space separated 
>>> list of
>>
>> Good find!
>>
>> I'm curious, how did you find it? If it was a spell checker, did it also
> 
> I found it by plain reading :) as I had troubles to get a test working.
> 
>  > find the "dotsh" typo in the same file (it should be "dots", I think)?
> 
> I wouldn't have noticed that, but I agree that it should be 
> "test_name_without_dots".

Please disregard my last statement. "test_name_without_dotsh" means 
"test name without .sh extension". For 
"t2109-update-index-index-version.sh", the directory will be "trash 
directory.t2109-update-index-index-version".

-Marc
