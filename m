Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8D1C47082
	for <git@archiver.kernel.org>; Wed, 26 May 2021 23:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C925360C40
	for <git@archiver.kernel.org>; Wed, 26 May 2021 23:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234564AbhEZXnN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 19:43:13 -0400
Received: from shell1.rawbw.com ([198.144.192.42]:56738 "EHLO shell1.rawbw.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233431AbhEZXnN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 19:43:13 -0400
Received: from yv.noip.me (c-73-189-35-76.hsd1.ca.comcast.net [73.189.35.76])
        (authenticated bits=0)
        by shell1.rawbw.com (8.15.1/8.15.1) with ESMTPSA id 14QNfdY9022007
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Wed, 26 May 2021 16:41:39 -0700 (PDT)
        (envelope-from yuri@rawbw.com)
X-Authentication-Warning: shell1.rawbw.com: Host c-73-189-35-76.hsd1.ca.comcast.net [73.189.35.76] claimed to be yv.noip.me
Subject: Re: [BUG REPORT] File names that contain UTF8 characters are
 unnecessarily escaped in 'git status .' messages
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <f7e2e271-dcec-2886-f33e-62778a429850@rawbw.com>
 <xmqq35u9ax5j.fsf@gitster.g>
From:   Yuri <yuri@rawbw.com>
Message-ID: <6318ccec-ec96-91a8-fd65-85daf4a9a22b@rawbw.com>
Date:   Wed, 26 May 2021 16:41:38 -0700
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <xmqq35u9ax5j.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/26/21 4:32 PM, Junio C Hamano wrote:
> "git config core.quotepath no"?


I didn't have the 'core.quotepath' value set. 'git config core.quotepath 
no' changed the behavior to no quoting.

So it looks like the default value of 'core.quotepath' is incorrect: it 
should be based on terminal capabilities.



Yuri


