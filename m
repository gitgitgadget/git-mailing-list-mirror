Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF361C433F5
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 18:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243188AbiAESu7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 13:50:59 -0500
Received: from smtprelay07.ispgateway.de ([134.119.228.97]:44450 "EHLO
        smtprelay07.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243179AbiAESu5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 13:50:57 -0500
X-Greylist: delayed 7399 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Jan 2022 13:50:57 EST
Received: from [91.113.179.170] (helo=[192.168.92.29])
        by smtprelay07.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <marc.strapetz@syntevo.com>)
        id 1n59Pt-0005LJ-3D; Wed, 05 Jan 2022 17:45:37 +0100
Message-ID: <9f74fc04-ea68-6bdd-3341-ecf7a2aed6cd@syntevo.com>
Date:   Wed, 5 Jan 2022 17:47:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] t/README: fix typo
Content-Language: en-US
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Marc Strapetz via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.1110.git.1641338224631.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2201051701120.7076@tvgsbejvaqbjf.bet>
From:   Marc Strapetz <marc.strapetz@syntevo.com>
In-Reply-To: <nycvar.QRO.7.76.6.2201051701120.7076@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Df-Sender: bWFyYy5zdHJhcGV0ekBzeW50ZXZvLmNvbQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On 05/01/2022 17:22, Johannes Schindelin wrote:
>> @@ -466,7 +466,7 @@ explicitly providing repositories when accessing submodule objects is
>>   complete or needs to be abandoned for whatever reason (in which case the
>>   migrated codepaths still retain their performance benefits).
>>
>> -GIT_TEST_REQUIRE_PREREQ=<list> allows specifying a space speparated list of
>> +GIT_TEST_REQUIRE_PREREQ=<list> allows specifying a space separated list of
> 
> Good find!
> 
> I'm curious, how did you find it? If it was a spell checker, did it also

I found it by plain reading :) as I had troubles to get a test working.

 > find the "dotsh" typo in the same file (it should be "dots", I think)?

I wouldn't have noticed that, but I agree that it should be 
"test_name_without_dots".

-Marc
