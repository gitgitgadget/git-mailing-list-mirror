Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDDAC5519F
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 00:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EDE1246A7
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 00:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgKSAoi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 19:44:38 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:61215 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbgKSAoi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 19:44:38 -0500
Received: from host-89-243-187-160.as13285.net ([89.243.187.160] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1kfY3w-0007De-7x; Thu, 19 Nov 2020 00:44:36 +0000
Subject: Re: [PATCH 00/28] Use main as default branch name
To:     Peter Hadlaw <hadlawp@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
 <87r1oraewl.fsf@x220.int.ebiederm.org>
 <xmqqv9e34mq5.fsf@gitster.c.googlers.com>
 <1389dabc-33c9-1e65-a3de-43729a6c2e70@iee.email>
 <nycvar.QRO.7.76.6.2011190057370.56@tvgsbejvaqbjf.bet>
 <CABrPy+HYji9yD4pjYcGpmRq488nSgwEMfqFMOsxbmhO3GaXctA@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <36e028c3-b2be-30ba-11a0-7dc277c1ceca@iee.email>
Date:   Thu, 19 Nov 2020 00:44:34 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <CABrPy+HYji9yD4pjYcGpmRq488nSgwEMfqFMOsxbmhO3GaXctA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19/11/2020 00:30, Peter Hadlaw wrote:
> That leaves us with 10 million users of git that are either unaware or
> are not on board. Let's say it takes 3 minutes for a user to search on
> the web why exactly they can't
> navigate to their "master" branch. That's 30 million minutes of time
> wasted, or about 57 man-YEARs of time wasted.... for what?
That's (3 mins) probably about the same amount of time as most users
waste on stack overflow for Git questions, or the old 'RTFM', for their
problems in a typical week anyway.

3 mins out of a 35 hr week, over a 44 week x 25 year life is 1.3 ppm,
unless you work too hard and too long, where it's an even lower ppm.

There are mechanism in this series for setting the default branch name.

--
Philip

