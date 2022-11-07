Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA91C433FE
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 12:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbiKGMT2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 07:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbiKGMT1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 07:19:27 -0500
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055FC104
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 04:19:25 -0800 (PST)
Received: from 88-110-102-84.dynamic.dsl.as9105.com ([88.110.102.84] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1os163-0005g3-EJ;
        Mon, 07 Nov 2022 12:19:23 +0000
Message-ID: <88b30b5f-2712-4c84-331c-2ea7338053ad@iee.email>
Date:   Mon, 7 Nov 2022 12:19:22 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: What's cooking in git.git (Nov 2022, #01; Thu, 3)
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
References: <Y2RldUHTwNzmez73@nand.local>
 <e1c10d50-779d-2a22-b0c6-83bc0769ea37@iee.email>
 <Y2Wtn0wKhbQrScGU@nand.local>
Content-Language: en-GB
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <Y2Wtn0wKhbQrScGU@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/11/2022 00:26, Taylor Blau wrote:
> On Sat, Nov 05, 2022 at 12:21:23AM +0000, Philip Oakley wrote:
>> On 04/11/2022 01:05, Taylor Blau wrote:
>>> --------------------------------------------------
>>> [Cooking]
>>> * po/pretty-hard-trunc (2022-11-02) 1 commit
>>>  - pretty-formats: add hard truncation, without ellipsis, options
>>>
>>>  Add a new pretty format which truncates without ellipsis.
>>>
>>>  Missing test coverage.
>> Is that out of date? V3 did include tests in t4205 and t6006.
>>
>>>  source: <20221102120853.2013-1-philipoakley@iee.email>
>> This source is the V3.
> Yes, thanks for catching. Indeed, the version that I have at:
>
>     git@github.com:ttaylorr/git.git
>
> on po/pretty-hard-trunc has the new tests. I think we are still waiting
> for review on that topic, though...
>
> Thanks,
> Taylor
An extra review would be useful.

I wasn't certain about the use of `qz_to_tab_space` in the here-doc
formulation of t6006-rev-list-format where some of the new tests now
included trailing spaces (but others didn't).

Ta,
Philip
