Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D94C433F5
	for <git@archiver.kernel.org>; Thu, 12 May 2022 21:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358686AbiELVTI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 May 2022 17:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358690AbiELVTA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 May 2022 17:19:00 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B5A142817
        for <git@vger.kernel.org>; Thu, 12 May 2022 14:18:58 -0700 (PDT)
Received: from host217-43-165-125.range217-43.btcentralplus.com ([217.43.165.125] helo=[192.168.1.168])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1npGD2-0007Pq-Eo;
        Thu, 12 May 2022 22:18:56 +0100
Message-ID: <c9097f6d-3bae-a5ee-96e5-1760bb51112c@iee.email>
Date:   Thu, 12 May 2022 22:18:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: Git Submodules ref setting
Content-Language: en-US
To:     =?UTF-8?B?0JLQsNC00LjQvCDQptCy0LXRgtC60L7Qsg==?= 
        <vadim.tsvetkov80@gmail.com>, git@vger.kernel.org
References: <F20FCD5B-7788-4D4C-8402-2C4CF447B2F5@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <F20FCD5B-7788-4D4C-8402-2C4CF447B2F5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/05/2022 21:01, Вадим Цветков wrote:
> Hello,
>
> I've started a small project which involves several git repositories, which depends on each other.
> For dealing with these repos I wanted to use git submodules as a simple package manager.
> However, it seems impossible to lock a submodule to particular ref, only to a branch.
> I would like to ask if this is deliberate design choice?

This may be a confusion about how some large projects use sub-modules 
and are now able to follow the developments within a sub-module branch.

The original sub-module mechanism is still available where the 
sub-module is locked at a specific commit object id's hash i.e. a 
specific 'library' version of that sub-module (in that context assumed 
to be rarely changing).
> And if it's not, may I contribute this feature?
--
Philip
