Return-Path: <SRS0=d/2q=6J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0680BC54FCB
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 18:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCA9E206B6
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 18:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbgDYSBC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Apr 2020 14:01:02 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:49510 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbgDYSBC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Apr 2020 14:01:02 -0400
Received: from [92.30.123.115] (helo=[192.168.1.39])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1jSP6q-0005Lj-Al; Sat, 25 Apr 2020 19:01:00 +0100
Subject: Re: [PATCH 1/8] Introduce CMake support for configuring Git on Linux
To:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        'Sibi Siddharthan via GitGitGadget' <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        'Sibi Siddharthan' <sibisiddharthan.github@gmail.com>
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
 <70ab1f03dd5413256166bf9db47be47b746ea6b1.1587700897.git.gitgitgadget@gmail.com>
 <20200425170740.GA6421@camp.crustytoothpaste.net>
 <02a401d61b28$141b8d00$3c52a700$@nexbridge.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <318e4641-3e21-ba9a-cca6-246d821812ad@iee.email>
Date:   Sat, 25 Apr 2020 19:01:01 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <02a401d61b28$141b8d00$3c52a700$@nexbridge.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25/04/2020 18:36, Randall S. Becker wrote:
> On April 25, 2020 1:08 PM, brian m. carlson Wrote:
>> On 2020-04-24 at 04:01:30, Sibi Siddharthan via GitGitGadget wrote:
>>> diff --git a/CMakeLists.txt b/CMakeLists.txt new file mode 100644
>>> index 00000000000..73703bd321f
>>> --- /dev/null
>>> +++ b/CMakeLists.txt
>>> @@ -0,0 +1,528 @@
>>> +#
>>> +#	Copyright (c) 2020 Sibi Siddharthan
>>> +#
>>> +
>>> +cmake_minimum_required(VERSION 3.14)
>> I don't plan a full review of this series, but I wanted to point out that this
>> version is newer than what's in Debian 10, so this isn't practically buildable on
>> many systems.
> I am unsure about this, but are non-git-foundation copyrights consistent GPL v2? Just asking for curiosity.
>
grep'ing for copyright gave plenty of examples, so it looks OK. Someone
had to author it.

Philip

