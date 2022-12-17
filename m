Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA19C4332F
	for <git@archiver.kernel.org>; Sat, 17 Dec 2022 01:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiLQBDW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Dec 2022 20:03:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiLQBDV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2022 20:03:21 -0500
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516FDCE09
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 17:03:20 -0800 (PST)
Received: from Mazikeen (ec2-15-222-1-203.ca-central-1.compute.amazonaws.com [15.222.1.203])
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 2BH13EVV011340
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 16 Dec 2022 20:03:15 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     "'Nemmaier, Christoph'" <christoph.nemmaier@cpp.canon>,
        <git@vger.kernel.org>
References: <AM8P195MB0820A54FEA04231D440F74D780E69@AM8P195MB0820.EURP195.PROD.OUTLOOK.COM>        <000b01d9112a$541c4de0$fc54e9a0$@nexbridge.com> <xmqqcz8jmz4e.fsf@gitster.g>
In-Reply-To: <xmqqcz8jmz4e.fsf@gitster.g>
Subject: RE: PROBLEM: "git pull -v" fails with exit code denoting a submodule syntax error
Date:   Fri, 16 Dec 2022 20:03:09 -0500
Organization: Nexbridge Inc.
Message-ID: <006a01d911b3$57e0d1b0$07a27510$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKA00gnj0PRGFmvn6C71jr6pUa0VwLhvIGcAclkgpus/GbPIA==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On December 16, 2022 5:17 AM, Junio C Hamano wrote:
><rsbecker@nexbridge.com> writes:
>
>> On December 16, 2022 3:28 AM, Nemmaier, Christoph wrote:
>>>I expected "git pull -v" to simply work and exit correctly without
>>>telling me the syntax of "git submodule".
>>> ...
>>
>> Hi Christoph,
>>
>> I have gone back to git 2.36.0 and cannot find support for the -v
>> submodule command parameter. At what version did this last work for
>> you? Do you have a git alias in effect that might be adding -v?
>
>I suspect it is the same issue as the one that triggered
>
>
https://lore.kernel.org/git/f805f2da-a7e1-9fde-cc0a-04a30f79c9af@cs-ware.de/
>
>which came out recently?

If that is the case, perhaps the -v needs to be documented in the online
help if/when this condition is fixed.

