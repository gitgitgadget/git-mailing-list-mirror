Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F02541F403
	for <e@80x24.org>; Wed,  6 Jun 2018 21:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752332AbeFFVGC (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 17:06:02 -0400
Received: from siwi.pair.com ([209.68.5.199]:59646 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752074AbeFFVGB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 17:06:01 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id A9E533F47FF;
        Wed,  6 Jun 2018 17:06:00 -0400 (EDT)
Received: from [10.160.98.81] (unknown [167.220.148.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 68AF83F47F5;
        Wed,  6 Jun 2018 17:06:00 -0400 (EDT)
Subject: Re: [PATCH v7 2/2] json-writer: t0019: add Python unit test
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20180605163358.119080-1-git@jeffhostetler.com>
 <20180605163358.119080-3-git@jeffhostetler.com>
 <20180606171052.GI3094@zaya.teonanacatl.net>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <75fc23f9-5a76-a4fc-9135-881a4e317408@jeffhostetler.com>
Date:   Wed, 6 Jun 2018 17:05:59 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180606171052.GI3094@zaya.teonanacatl.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 6/6/2018 1:10 PM, Todd Zullinger wrote:
> git@jeffhostetler.com wrote:
>> +# As a sanity check, ask Python to parse our generated JSON.  Let Python
>> +# recursively dump the resulting dictionary in sorted order.  Confirm that
>> +# that matches our expectations.
>> +test_expect_success PYTHON 'parse JSON using Python' '
> [...]
>> +	python "$TEST_DIRECTORY"/t0019/parse_json_1.py <output.json >actual &&
> 
> Would this be better using $PYTHON_PATH rather than
> hard-coding python as the command?
> 

good catch!
thanks
Jeff
