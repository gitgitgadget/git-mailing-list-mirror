Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 741D71F404
	for <e@80x24.org>; Mon, 10 Sep 2018 13:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbeIJSPa (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Sep 2018 14:15:30 -0400
Received: from siwi.pair.com ([209.68.5.199]:37274 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728241AbeIJSPa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Sep 2018 14:15:30 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id C5ADF3F4015;
        Mon, 10 Sep 2018 09:21:24 -0400 (EDT)
Received: from [10.160.98.162] (unknown [167.220.148.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 7528E3F4014;
        Mon, 10 Sep 2018 09:21:24 -0400 (EDT)
Subject: Re: [PATCH 1/2] t0051: test GIT_TRACE to a windows named pipe
To:     Sebastian Schuberth <sschuberth@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     jeffhost@microsoft.com, Junio C Hamano <gitster@pobox.com>
References: <pull.35.git.gitgitgadget@gmail.com>
 <03453cb521ae57475d046024f5840991553410d6.1536344387.git.gitgitgadget@gmail.com>
 <3b6960e4-df19-a00e-c8f9-e456ecf43ef7@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <cb27d0de-66ca-5b00-7bbb-0ba7041fbeb8@jeffhostetler.com>
Date:   Mon, 10 Sep 2018 09:21:23 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <3b6960e4-df19-a00e-c8f9-e456ecf43ef7@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/9/2018 3:28 AM, Sebastian Schuberth wrote:
> On 9/7/2018 8:19 PM, Jeff Hostetler via GitGitGadget wrote:
> 
>> +test_expect_success MINGW 'o_append write to named pipe' '
> 
> Shouldn't this be "test_expect_failure" here, and then be changed to 
> "test_expect_success" by your second patch?
> 
> 

yes. thanks!
Jeff
