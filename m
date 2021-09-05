Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD86C433EF
	for <git@archiver.kernel.org>; Sun,  5 Sep 2021 19:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75A286054F
	for <git@archiver.kernel.org>; Sun,  5 Sep 2021 19:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbhIETD1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Sep 2021 15:03:27 -0400
Received: from shell1.rawbw.com ([198.144.192.42]:50100 "EHLO shell1.rawbw.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229865AbhIETD1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Sep 2021 15:03:27 -0400
Received: from yv.noip.me (c-73-189-35-76.hsd1.ca.comcast.net [73.189.35.76])
        (authenticated bits=0)
        by shell1.rawbw.com (8.15.1/8.15.1) with ESMTPSA id 185J2MWb001180
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Sun, 5 Sep 2021 12:02:23 -0700 (PDT)
        (envelope-from yuri@rawbw.com)
X-Authentication-Warning: shell1.rawbw.com: Host c-73-189-35-76.hsd1.ca.comcast.net [73.189.35.76] claimed to be yv.noip.me
Subject: Re: stash push/pop unstages files?
To:     Chris Torek <chris.torek@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <0e1f7a47-89e3-5f49-663e-bdd3e8efb6e5@rawbw.com>
 <CAPx1Gvc6noTDYPt9x3b4_TE0z8-KE5cB6KQHcn5UL9pi0cKoGg@mail.gmail.com>
From:   Yuri <yuri@rawbw.com>
Message-ID: <5f09cba9-b7dc-d7b6-1d3f-e7fb8ca28c6c@rawbw.com>
Date:   Sun, 5 Sep 2021 12:02:21 -0700
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAPx1Gvc6noTDYPt9x3b4_TE0z8-KE5cB6KQHcn5UL9pi0cKoGg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/5/21 10:15 AM, Chris Torek wrote:
> It does,*provided*  you invoke the pop step with `--index`.
>
> When `git stash push` makes a stash, it saves both the index
> (staging area) and working tree, as two separate commits.


Why 'stash push' and 'stash pop' are asymmetric in what they do by default?
Wouldn't it make more sense to make 'stash pop' precisely revert what 
'stash push' does, and have an option '--no-index' instead?


Yuri


