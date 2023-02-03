Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A956FC636CC
	for <git@archiver.kernel.org>; Fri,  3 Feb 2023 11:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbjBCLLY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Feb 2023 06:11:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjBCLLX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2023 06:11:23 -0500
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A9B76407
        for <git@vger.kernel.org>; Fri,  3 Feb 2023 03:11:21 -0800 (PST)
Received: from host-2-103-194-72.as13285.net ([2.103.194.72] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1pNtyS-0006rm-3w;
        Fri, 03 Feb 2023 11:11:20 +0000
Message-ID: <22255406-42da-9ac3-4783-11a035877a3c@iee.email>
Date:   Fri, 3 Feb 2023 11:11:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Hash for a commit sourcetree beside to a commit hash
Content-Language: en-GB
To:     Andry <andry@inbox.ru>,
        =?UTF-8?B?xJBvw6BuIFRyw6LMgG4gQ8O0bmcgRGFuaA==?= 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
References: <1798489336.20230203042837@inbox.ru> <Y9xq5VAMjzUqTb6X@danh.dev>
 <563617028.20230203052145@inbox.ru>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <563617028.20230203052145@inbox.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/02/2023 02:21, Andry wrote:
> Đoàn, 
> Friday, February 3, 2023, 5:01:09 AM, you wrote:
> ĐTCD>         git rev-list <a-commit-tish> |
> ĐTCD>         while read commit; do
> ĐTCD>                 if test $(git rev-parse $commit^{tree}) = $hash; then
> ĐTCD>                         echo $commit
> ĐTCD>                         break
> ĐTCD>                 fi
> ĐTCD>         done
>
> Nice, but I can not apply this over a git hub or a web interface without a clone.

As a 'Distributed'-VCS, cloning the repository would be the de-facto
normal approach, otherwise you have re-invented centralised VCS ;-)

Alternatively, you could approach the server (hub/web interface)
provider to see if they are willing to provide that level of search
interface.

That said, having extra search capability within rev-list to search for
blobs and tree would/could be useful in specialised scenarios, though
that is becoming rather niche.
--
Philip
