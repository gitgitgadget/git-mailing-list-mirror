Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 741F2C433B4
	for <git@archiver.kernel.org>; Thu,  6 May 2021 06:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D3B8611AD
	for <git@archiver.kernel.org>; Thu,  6 May 2021 06:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhEFGI7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 02:08:59 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:17721 "EHLO bsmtp3.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229604AbhEFGI7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 02:08:59 -0400
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 4FbNR14Mtvz5tl9;
        Thu,  6 May 2021 08:07:41 +0200 (CEST)
Subject: Re: [feature suggestion] Add 'git stash export', 'git stash import'
 commands to allow to backup stash externally
To:     Yuri <yuri@rawbw.com>
References: <d8aef355-0718-8b3d-7e9f-614673dd250f@rawbw.com>
Cc:     Git Mailing List <git@vger.kernel.org>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <fff9baee-ac4e-66ea-1dfb-791a8b044527@kdbg.org>
Date:   Thu, 6 May 2021 08:07:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <d8aef355-0718-8b3d-7e9f-614673dd250f@rawbw.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.05.21 um 21:51 schrieb Yuri:
> I work in a very large repository, but all of it except for my stashed
> items can be re-downloaded from the remote URL.
> 
> 
> Stash though is much smaller in size and is especially valuable. Its
> loss would be very expensive.

I would argue that you are doing something wrong if your stashes are
particularly valuable. If you regularly revert temporary, but precious
work, then you should commit the work and mark it with a branch tip or tag.

> Could you please consider adding 'git stash export', 'git stash import'
> commands so that in case of an accidental repository loss stash can be
> imported from the external backup?

-- Hannes
