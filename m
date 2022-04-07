Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2BBC433EF
	for <git@archiver.kernel.org>; Thu,  7 Apr 2022 20:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbiDGUwy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Apr 2022 16:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbiDGUwm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Apr 2022 16:52:42 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521DF2B5ED9
        for <git@vger.kernel.org>; Thu,  7 Apr 2022 13:46:31 -0700 (PDT)
Received: from host-84-13-159-41.opaltelecom.net ([84.13.159.41] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1ncZ1R-000A5C-9z;
        Thu, 07 Apr 2022 21:46:29 +0100
Message-ID: <2063f989-715a-93b2-a665-e6975d54c8b5@iee.email>
Date:   Thu, 7 Apr 2022 21:46:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
From:   Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH 4/4] object-name: diagnose trees in index properly
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, vdye@github.com, shaoxuan.yuan02@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1207.git.1649349442.gitgitgadget@gmail.com>
 <99c09ccc2406e4f54c620bd7fb2d1205386e23a6.1649349442.git.gitgitgadget@gmail.com>
Content-Language: en-GB
In-Reply-To: <99c09ccc2406e4f54c620bd7fb2d1205386e23a6.1649349442.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

spelling nit

On 07/04/2022 17:37, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
>
> When running 'git show :<path>' where '<path>' is a directory, then
> there is a subtle difference between a full checkout and a sparse
> checkout. The error message from diagnose_invalid_index_path() reports
> whether the path is on disk or not. The full checkout will have the
> directory on disk, but the path will not be in the index. The sparse
> checokut could have the directory not exist, specifically when that

s/checokut/checkout/
> directory is outside of the sparse-checkout cone.
[...]
--
Philip
