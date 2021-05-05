Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C42FC433ED
	for <git@archiver.kernel.org>; Wed,  5 May 2021 19:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63AA1613C0
	for <git@archiver.kernel.org>; Wed,  5 May 2021 19:52:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233565AbhEETw4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 15:52:56 -0400
Received: from shell1.rawbw.com ([198.144.192.42]:46294 "EHLO shell1.rawbw.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232992AbhEETwz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 15:52:55 -0400
Received: from yv.noip.me (c-73-189-35-76.hsd1.ca.comcast.net [73.189.35.76])
        (authenticated bits=0)
        by shell1.rawbw.com (8.15.1/8.15.1) with ESMTPSA id 145Jpv29079668
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
        for <git@vger.kernel.org>; Wed, 5 May 2021 12:51:58 -0700 (PDT)
        (envelope-from yuri@rawbw.com)
X-Authentication-Warning: shell1.rawbw.com: Host c-73-189-35-76.hsd1.ca.comcast.net [73.189.35.76] claimed to be yv.noip.me
To:     Git Mailing List <git@vger.kernel.org>
From:   Yuri <yuri@rawbw.com>
Subject: [feature suggestion] Add 'git stash export', 'git stash import'
 commands to allow to backup stash externally
Message-ID: <d8aef355-0718-8b3d-7e9f-614673dd250f@rawbw.com>
Date:   Wed, 5 May 2021 12:51:56 -0700
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I work in a very large repository, but all of it except for my stashed 
items can be re-downloaded from the remote URL.


Stash though is much smaller in size and is especially valuable. Its 
loss would be very expensive.


Could you please consider adding 'git stash export', 'git stash import' 
commands so that in case of an accidental repository loss stash can be 
imported from the external backup?


Thanks,

Yuri

