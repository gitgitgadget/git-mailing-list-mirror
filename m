Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B8DC433EF
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 13:00:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346460AbiCXNBe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 09:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242928AbiCXNBb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 09:01:31 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812A751E62
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 06:00:00 -0700 (PDT)
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KPQJm3SPXz67PrR;
        Thu, 24 Mar 2022 20:58:48 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 24 Mar 2022 13:59:58 +0100
Received: from [10.202.227.197] (10.202.227.197) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 24 Mar 2022 12:59:57 +0000
Message-ID: <da0bba94-8dc2-a5c0-98f9-42182345601c@huawei.com>
Date:   Thu, 24 Mar 2022 13:00:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [Question] .git folder file updates for changing head commit
To:     Andreas Schwab <schwab@linux-m68k.org>
CC:     <git@vger.kernel.org>
References: <6fa76f28-063b-8964-c0a2-642dae88f1b3@huawei.com>
 <87wngkpddp.fsf@igel.home>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <87wngkpddp.fsf@igel.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.202.227.197]
X-ClientProxiedBy: lhreml744-chm.china.huawei.com (10.201.108.194) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/03/2022 21:28, Andreas Schwab wrote:
> On Mär 23 2022, John Garry wrote:
> 
>> For building the linux perf tool we use the git head commit id as part of
>> the tool version sting. To save time in re-building, the Makefile rule has
>> a dependency on .git/HEAD for rebuilding.
> There is no guarantee that .git is a directory.  In a separate worktree
> .git is actually a gitfile.

ok, thanks. I'll keep that in mind.

John
