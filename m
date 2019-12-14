Return-Path: <SRS0=+pXB=2E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860B4C43603
	for <git@archiver.kernel.org>; Sat, 14 Dec 2019 11:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59A8224656
	for <git@archiver.kernel.org>; Sat, 14 Dec 2019 11:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbfLNLMG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Dec 2019 06:12:06 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:18394 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbfLNLMG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Dec 2019 06:12:06 -0500
Received: from [92.30.123.115] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1ig5L9-00072m-6Q; Sat, 14 Dec 2019 11:12:04 +0000
Subject: Re: git checkout --autostash and git branch --autopop
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Denton Liu <liu.denton@gmail.com>, rottis@fea.st,
        git@vger.kernel.org
References: <8ab7d980-9584-4ce7-b4ee-9acac62c030c@www.fastmail.com>
 <20191212180901.GA35927@generichostname>
 <e7850a51-4396-4698-ed98-62f991e33992@iee.email>
 <xmqq7e30m9i4.fsf@gitster-ct.c.googlers.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <2e2c7d89-d820-0643-61f9-11e74ab4ab9f@iee.email>
Date:   Sat, 14 Dec 2019 11:12:03 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <xmqq7e30m9i4.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13/12/2019 17:16, Junio C Hamano wrote:
> Philip Oakley <philipoakley@iee.email> writes:
>
>> Isn't this meant to be something similar to the --no-merge option for
>> checkout. That is: I am where I am, but really I want this to be on
>> branch X. Or is the --no-merge option meant to be something else?
> Is there a --no-merge option to "git checkout"?  
My mistake. I misremembered or misunderstood. I'd been looking at both
checkout and branch man pages to see if there was a way out of the do
the 'rewind current branch and create new branch at current state'
dance. I thought I'd seen 'no-merge' as a 'checkout -b' style option.

> I know the reason
> why I invented "git checkout --merge" was because I wanted the
> command to carry more changes in the working tree than the default
> behaviour would while checking out another branch, but I do not
> think I added an option to do less, i.e. forbid it from carrying any
> change in the working tree while checking out another branch.
For creating a new branch when in a dirty state (based on some other
start point than HEAD), there should be an option for numpties that have
already started digging the hole for themselves (stick's hand up
apologetically)...

I was hoping that @rottis would clarify if his request has the same
symptoms.

--

Philip
