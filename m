Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6793C433EF
	for <git@archiver.kernel.org>; Sun,  5 Sep 2021 17:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D03560F21
	for <git@archiver.kernel.org>; Sun,  5 Sep 2021 17:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233994AbhIERKY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Sep 2021 13:10:24 -0400
Received: from shell1.rawbw.com ([198.144.192.42]:19357 "EHLO shell1.rawbw.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230471AbhIERKX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Sep 2021 13:10:23 -0400
Received: from yv.noip.me (c-73-189-35-76.hsd1.ca.comcast.net [73.189.35.76])
        (authenticated bits=0)
        by shell1.rawbw.com (8.15.1/8.15.1) with ESMTPSA id 185H9KkO090221
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
        for <git@vger.kernel.org>; Sun, 5 Sep 2021 10:09:20 -0700 (PDT)
        (envelope-from yuri@rawbw.com)
X-Authentication-Warning: shell1.rawbw.com: Host c-73-189-35-76.hsd1.ca.comcast.net [73.189.35.76] claimed to be yv.noip.me
To:     Git Mailing List <git@vger.kernel.org>
From:   Yuri <yuri@rawbw.com>
Subject: stash push/pop unstages files?
Message-ID: <0e1f7a47-89e3-5f49-663e-bdd3e8efb6e5@rawbw.com>
Date:   Sun, 5 Sep 2021 10:09:19 -0700
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In one sub-directory I altered some files, added a directory with files 
and added the changes (git add .)

Then I called 'git stash push && git stash pop'.

After this the newly added directory remained in the staged status, but 
altered files became unstaged.

Is this an intended behavior?

Why stash push/pop unstages files? Shouldn't it preserve the directory 
as-is?


Thanks,

Yuri


