Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC7CC4361B
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 15:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E73E323A7B
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 15:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729926AbgLHPVj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 10:21:39 -0500
Received: from dd36226.kasserver.com ([85.13.153.21]:55508 "EHLO
        dd36226.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729334AbgLHPVj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 10:21:39 -0500
Received: from client3368.fritz.box (i5C747E10.versanet.de [92.116.126.16])
        by dd36226.kasserver.com (Postfix) with ESMTPSA id 7B3F83C0073;
        Tue,  8 Dec 2020 16:20:57 +0100 (CET)
Subject: Re: [PATCH 1/1] git-gui: fix colored label backgrounds when using
 themed widgets
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     git@vger.kernel.org
References: <20201122194537.41870-1-stefan@haller-berlin.de>
 <20201122194537.41870-2-stefan@haller-berlin.de>
 <20201201200634.bazwncj7yyp7vksn@yadavpratyush.com>
 <c8cbdfa1-f3f3-725a-124d-6f70b96767d1@haller-berlin.de>
 <20201206130711.halhskksavsvojm2@yadavpratyush.com>
From:   Stefan Haller <stefan@haller-berlin.de>
Message-ID: <55dfab3f-e031-615f-435a-aad78d0a0c73@haller-berlin.de>
Date:   Tue, 8 Dec 2020 16:20:56 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201206130711.halhskksavsvojm2@yadavpratyush.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06.12.20 14:07, Pratyush Yadav wrote:
> On 02/12/20 09:52AM, Stefan Haller wrote:
>> On 01.12.20 21:06, Pratyush Yadav wrote:
>>> Hi Stefan,
>>>
>>> Thanks for the patch.
>>>
>>> On 22/11/20 08:45PM, Stefan Haller wrote:
>>>> The aqua theme on Mac doesn't support changing the background color for labels
>>>> and frames [1]. Since the red, green, and yellow backgrounds of the labels for
>>>> unstaged and staged files and the diff pane are so important design elements of
>>>> git gui's main window, it's not acceptable for them to have grey backgrounds on
>>>> Mac.
>>>
>>> I unfortunately don't have access to a Mac machine to I can't test this 
>>> patch.
>>
>> I could send screenshots if that helps.
> 
> Yes, that would be helpful.

Here are some screenshots; with and without the patch, with and without
ttk, and in light mode and dark mode.

   https://cp.sync.com/dl/1cf0e2cd0/dynix3qc-ev5q8crr-sp2kjxuy-h4pcwr68

-Stefan
