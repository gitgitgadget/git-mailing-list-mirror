Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70836C433F5
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 14:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 433F56138F
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 14:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbhJTOID (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 10:08:03 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:23161 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230024AbhJTOID (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 10:08:03 -0400
Received: from host-84-13-154-214.opaltelecom.net ([84.13.154.214] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1mdCDz-0008Gg-6e; Wed, 20 Oct 2021 15:05:47 +0100
Subject: Re: [PATCH 4/4] doc: add a FAQ entry about syncing working trees
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <dstolee@microsoft.com>
References: <20211020010624.675562-1-sandals@crustytoothpaste.net>
 <20211020010624.675562-5-sandals@crustytoothpaste.net>
 <a2719de4-d8ec-5e78-bb73-7712c07c90c7@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <3f92dde3-fdcc-fb76-7ebc-2c3cf8191af2@iee.email>
Date:   Wed, 20 Oct 2021 15:05:46 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <a2719de4-d8ec-5e78-bb73-7712c07c90c7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20/10/2021 05:58, Bagas Sanjaya wrote:
> On 20/10/21 08.06, brian m. carlson wrote:
>> +Be aware that even with these recommendations, syncing in this way is
>> +potentially risky since it bypasses Git's normal integrity checking for
>> +repositories, so having backups is advised.
>> +
>
> This raises question: how users can backup their repos? The answer is
> same as this FAQ for syncing working trees: have your repo to be
> pushed to the spare server at disposal, or use rsync (as long as the
> preconditions are met).
>
Perhaps, for backing up a repo, users might be pointed toward `git
bundle` (with caveats about `--all` being over complete..)

-- 
Philip
