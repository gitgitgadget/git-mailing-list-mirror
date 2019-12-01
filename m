Return-Path: <SRS0=LEOb=ZX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF032C432C0
	for <git@archiver.kernel.org>; Sun,  1 Dec 2019 11:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8E5320833
	for <git@archiver.kernel.org>; Sun,  1 Dec 2019 11:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbfLALno (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Dec 2019 06:43:44 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:21108 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbfLALno (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Dec 2019 06:43:44 -0500
Received: from [79.66.3.179] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1ibNde-0005rf-6U; Sun, 01 Dec 2019 11:43:42 +0000
Subject: Re: [PATCH v6 2/3] git-gui: update status bar to track operations
To:     Pratyush Yadav <me@yadavpratyush.com>,
        Jonathan Gilbert via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Gilbert <rcq8n2xf3v@liamekaens.com>,
        Jonathan Gilbert <JonathanG@iQmetrix.com>
References: <pull.436.v5.git.1574627876.gitgitgadget@gmail.com>
 <pull.436.v6.git.1574929833.gitgitgadget@gmail.com>
 <ab3d8e54c3d3d5174fe222ee77101ab3b8e9cab8.1574929833.git.gitgitgadget@gmail.com>
 <20191130230543.p5xtapnx5a56arng@yadavpratyush.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <90eb7e96-6352-deb9-0c22-14993ce42c8e@iee.email>
Date:   Sun, 1 Dec 2019 11:43:41 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191130230543.p5xtapnx5a56arng@yadavpratyush.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30/11/2019 23:05, Pratyush Yadav wrote:
 > On 28/11/19 08:30AM, Jonathan Gilbert via GitGitGadget wrote:
>> +# Operation displayed by status mega-widget during _do_clone_checkout =>
>> +# _readtree_wait => _postcheckout_wait => _do_clone_submodules =>
>> +# _do_validate_submodule_cloning. The status mega-widget is a difference
should this be "different", rather than 'difference'?

>> +# instance than that stored in $o_status in earlier operations.
> The last sentence doesn't make a lot of sense to me. What is "earlier
> operations"? If this refers to previous versions of this file, then I
> don't think such a comment belongs here. It should be in the commit
> message instead.
>
Philip
