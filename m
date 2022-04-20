Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49F8C433F5
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 22:34:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239674AbiDTWhD convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 20 Apr 2022 18:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233746AbiDTWhC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 18:37:02 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7EA3BF9D
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 15:34:13 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [174.119.96.21] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 23KMY5jo015109
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 20 Apr 2022 18:34:06 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        "'Daniel Habenicht'" <daniel-habenicht@outlook.de>
Cc:     <git@vger.kernel.org>
References: <f1647260b37d492d96ac92f8ef30a087AS1P190MB1750B08CC923A45E2C959250ECF59@AS1P190MB1750.EURP190.PROD.OUTLOOK.COM> <YmB7gvfKY/0njjZy@camp.crustytoothpaste.net>
In-Reply-To: <YmB7gvfKY/0njjZy@camp.crustytoothpaste.net>
Subject: RE: Bug Report
Date:   Wed, 20 Apr 2022 18:34:00 -0400
Organization: Nexbridge Inc.
Message-ID: <017001d85506$bee0adf0$3ca209d0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQDi6/6aDysiTDJiT9w4TLgatF0saQGPFPeQrte0ulA=
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On April 20, 2022 5:31 PM, brian m. carlson wrote:
>On 2022-04-20 at 19:45:32, Daniel Habenicht wrote:
>> Hi there,
>>
>> I think I found a bug or at least some unexpected behavior. Please
>> have a look at the following reproduction repo:
>>
>> https://github.com/DanielHabenicht/bug-reproduction.git-repo/blob/main
>> /README.md
>
>You're more likely to get someone to look at this if you post the actual text to the
>list.  While I might be willing to look at it on GitHub, other folks won't, and I
>probably won't get a chance to look at this issue anytime soon.

The only thing that I can see that is apparently a problem is that autocrlf=false is not documented in the config help, so it is not apparent what the expected result should be relative to the test case. That could be considered confusing. There could also be confusion relative to when the git diff was done relative to what is in the staging area given his test case. I think what Daniel may really want is to use autocrlf=input.

Daniel, please post your entire report to this list rather than using GitHub, links, or attachments. I happened to be on GitHub at that moment, so looked, but otherwise, I would not have specifically looked.

--Randall

--
Brief whoami: NonStop&UNIX developer since approximately
UNIX(421664400)
NonStop(211288444200000000)
-- In real life, I talk too much.

