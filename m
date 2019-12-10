Return-Path: <SRS0=g4/7=2A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1615C43603
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 17:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B2EF2077B
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 17:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbfLJRVi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Dec 2019 12:21:38 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:18440 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727553AbfLJRVi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Dec 2019 12:21:38 -0500
Received: from [92.30.123.115] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1iejCa-00024X-6i; Tue, 10 Dec 2019 17:21:36 +0000
Subject: Re: [PATCH 2/6] config: add string mapping for enum config_scope
From:   Philip Oakley <philipoakley@iee.email>
To:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Cc:     "\"Matthew Rogers\" mattr94"@gmail.com
References: <20191210023335.49987-1-emilyshaffer@google.com>
 <20191210023335.49987-3-emilyshaffer@google.com>
 <e0bcedec-dd1c-9cb7-1b0f-a8fda0bbf610@iee.email>
Message-ID: <f5d109b0-edc3-914a-1b73-5bae8ddd9eee@iee.email>
Date:   Tue, 10 Dec 2019 17:21:36 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <e0bcedec-dd1c-9cb7-1b0f-a8fda0bbf610@iee.email>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

correcting Matt's email address.
original thread 
https://lore.kernel.org/git/20191210023335.49987-3-emilyshaffer@google.com/

On 10/12/2019 11:16, Philip Oakley wrote:
> On 10/12/2019 02:33, Emily Shaffer wrote:
>> If a user is interacting with their config files primarily by the 'git
>> config' command, using the location flags (--global, --system, etc) then
>> they may be more interested to see the scope of the config file they are
>> editing, rather than the filepath.
> There's asimilar issue being worked on under Git-for-Windows with some 
> proposed code for this very 'problem'
> https://github.com/git-for-windows/git/pull/2399 and a GitGitGadget PR 
> https://github.com/gitgitgadget/git/pull/478
>
> cc'ing Matthew to help coordination.
Philip
