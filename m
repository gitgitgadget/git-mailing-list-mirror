Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC59C32773
	for <git@archiver.kernel.org>; Wed, 17 Aug 2022 20:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbiHQUYG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Aug 2022 16:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241689AbiHQUYE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Aug 2022 16:24:04 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3255B5F116
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 13:24:01 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 922243F414B;
        Wed, 17 Aug 2022 16:24:00 -0400 (EDT)
Received: from jeffhost-mbp.local (unknown [IPv6:2600:100e:b003:bb50:a8f5:f3c3:a597:485d])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 231723F4117;
        Wed, 17 Aug 2022 16:24:00 -0400 (EDT)
Subject: Re: t7527 intermittent failure on macOS APFS and possible fix
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        git@vger.kernel.org
References: <YvZbGAf+82WtNXcJ@danh.dev>
Cc:     git@jeffhostetler.com
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <a68f842a-4c96-3639-ca0c-48b79f146182@jeffhostetler.com>
Date:   Wed, 17 Aug 2022 16:23:57 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <YvZbGAf+82WtNXcJ@danh.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.09 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/12/22 9:52 AM, Đoàn Trần Công Danh wrote:
> Hello,
> 
> Running t7527 on macOS with encrypted APFS filesystem.
> I observes intermittent failure, however, when I manually check the
> test cases, they're all passed.
> 
> I suspected fileystem caching issue.
> I added those sync-s into test steps and the test pass.
> I'm not sure if this is the intending "fix" for the tests
> since we're testing the fsmonitor with t7527.
> 
> Please advise!
> 
> P/S: When debugging, I also found out that:
> "test-tool fsmonitor-client query" doesn't write the final newline
> character, thus making the output harder to read. The diff also have
> the final newline added.

Thanks for the report.  Sorry for the delay, I'm still digging thru
my email backlog after a long vacation.  I'll take a look at this
and get back to you shortly.

Thanks,
Jeff

