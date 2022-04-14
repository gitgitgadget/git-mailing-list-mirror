Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C49C433EF
	for <git@archiver.kernel.org>; Thu, 14 Apr 2022 14:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237523AbiDNOpU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Apr 2022 10:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352662AbiDNOck (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Apr 2022 10:32:40 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D2CCD644
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 07:24:31 -0700 (PDT)
Received: from host-84-13-159-41.opaltelecom.net ([84.13.159.41] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1nf0Oa-0009gE-CK;
        Thu, 14 Apr 2022 15:24:29 +0100
Message-ID: <fc0015ac-9ad4-d3b4-39ee-0bf4f9c99fa0@iee.email>
Date:   Thu, 14 Apr 2022 15:24:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [GSoC][RFC][PROPOSAL] Reachability bitmap improvements
Content-Language: en-GB
To:     Taylor Blau <me@ttaylorr.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
References: <20220406200440.27010-1-chakrabortyabhradeep79@gmail.com>
 <YlckmDHRAYnE1J5t@nand.local>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <YlckmDHRAYnE1J5t@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Abhradeep,


On 13/04/2022 20:29, Taylor Blau wrote:
>> Though I had read many documentations, I was still not able to fully
>> understand the terminologies (like `refs`, `packfiles`, `blobs`, `trees`
>> etc.). (ProGit)[https://git-scm.com/book/en/v2] helped me tremendously here.
>> I read the full book and it cleared almost every doubt that came into my mind.
> Terrific! I am really glad that the MyFirst... documents were helpful
> and made it easier for you to contribute. The ProGit book is a great
> resource, too.
>
> If you are looking for more resources, I would encourage you to search
> around for blog posts written by Git contributors, particularly related
> to reachability bitmaps (at least for this GSoC project). Some helpful
> places to start there would be:
>
>     https://github.blog/2015-09-22-counting-objects/
>     https://github.blog/2021-04-29-scaling-monorepo-maintenance/
>
It's also worth looking at the Git Rev News articles and light reading links
     https://git.github.io/rev_news/ and
     https://git.github.io/rev_news/archive/
--
Philip.
