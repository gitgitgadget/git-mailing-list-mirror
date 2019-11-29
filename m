Return-Path: <SRS0=rBju=ZV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36272C432C3
	for <git@archiver.kernel.org>; Fri, 29 Nov 2019 13:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03C9920833
	for <git@archiver.kernel.org>; Fri, 29 Nov 2019 13:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbfK2NTo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Nov 2019 08:19:44 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:21700 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726608AbfK2NTo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Nov 2019 08:19:44 -0500
Received: from [79.66.3.179] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1iagBS-0003Tn-8K; Fri, 29 Nov 2019 13:19:42 +0000
Subject: Re: [PATCH 1/1] contrib/buildsystems: fix Visual Studio Debug
 configuration
From:   Philip Oakley <philipoakley@iee.email>
To:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Alexandr Miloslavskiy via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <pull.348.git.gitgitgadget@gmail.com>
 <525669b3b38ed57d6d4f188dfe0bb8fe10b63749.1569227313.git.gitgitgadget@gmail.com>
 <c89cc506-b515-b913-bb0a-353b04fe4210@iee.email>
 <8e7ff0b2-9f62-8ec6-5316-eb9cee25024e@syntevo.com>
 <70bc64f6-3513-2924-9ba0-0e38e0e9d308@iee.email>
 <0b2124b5-6d40-08bb-6cc5-a8cef2b7a9b1@syntevo.com>
 <365668d0-ebb8-6b5c-99bd-29f0c8cec132@iee.email>
Message-ID: <9c5157df-adb0-0a84-2ff2-852ad7536874@iee.email>
Date:   Fri, 29 Nov 2019 13:19:41 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <365668d0-ebb8-6b5c-99bd-29f0c8cec132@iee.email>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29/11/2019 11:53, Philip Oakley wrote:
> On 28/11/2019 10:07, Alexandr Miloslavskiy wrote:
>> On 28.11.2019 1:34, Philip Oakley wrote:
>>
>>> Hmm, 45 minutes of cloning and rebuild, but finally it compiled 
>>> clean (both Release and Debug)
>>
>> I understand that the issue is resolved now.
>>
>> Probably your old repo was missing the libraries for whatever reason 
>> (like antivirus deleting them, etc), but build script thought that 
>> dependencies are properly built, so didn't attempt to rebuild them.
> I think I'll report that as an issue to the 
> https://github.com/microsoft/vcpkg folks so that there's better 
> detection for 'out of date' / updated vcpkg issues.
>
> The vcpkg_install.bat in /compat/vcbuild may need updating to do a 
> 'pull' if there is an existing directory. At the moment it's a rather 
> simplistic 'all or nothing' for getting all those extra packages.

Issue submitted as https://github.com/microsoft/vcpkg/issues/9148
--
Philip
