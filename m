Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B203FC432BE
	for <git@archiver.kernel.org>; Sat, 28 Aug 2021 05:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 829A460EB3
	for <git@archiver.kernel.org>; Sat, 28 Aug 2021 05:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbhH1FoP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Aug 2021 01:44:15 -0400
Received: from shell1.rawbw.com ([198.144.192.42]:45418 "EHLO shell1.rawbw.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229555AbhH1FoP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Aug 2021 01:44:15 -0400
Received: from yv.noip.me (c-73-189-35-76.hsd1.ca.comcast.net [73.189.35.76])
        (authenticated bits=0)
        by shell1.rawbw.com (8.15.1/8.15.1) with ESMTPSA id 17S5hLLk030473
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Fri, 27 Aug 2021 22:43:23 -0700 (PDT)
        (envelope-from yuri@rawbw.com)
X-Authentication-Warning: shell1.rawbw.com: Host c-73-189-35-76.hsd1.ca.comcast.net [73.189.35.76] claimed to be yv.noip.me
Subject: Re: Git re-creates newly added directory when it is pushed
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <c0557284-8f82-76cc-8c47-0b1bc9f2ce5a@rawbw.com>
 <CABPp-BFwvDY6-6pQ2MSPzAGafONjTEMNUkLwuRuQCJ_wx2ns2w@mail.gmail.com>
From:   Yuri <yuri@rawbw.com>
Message-ID: <2a7fab29-e7c4-7c23-5932-80c403a37cce@rawbw.com>
Date:   Fri, 27 Aug 2021 22:43:19 -0700
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BFwvDY6-6pQ2MSPzAGafONjTEMNUkLwuRuQCJ_wx2ns2w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/27/21 10:33 PM, Elijah Newren wrote:
> And I think you left out that you cd'ed into the directory as well
> before running your `git pull --rebase`.


Yes, this is how people normally work with this repository. They change 
individual directories (ports are like sub-projects) and commit them 
while staying in them.


Yuri

