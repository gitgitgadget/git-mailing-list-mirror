Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77271C56201
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 23:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CC41246BC
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 23:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbgKRXpn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 18:45:43 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:43443 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726527AbgKRXpm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 18:45:42 -0500
Received: from host-89-243-187-160.as13285.net ([89.243.187.160] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1kfX8u-0008q2-AS; Wed, 18 Nov 2020 23:45:40 +0000
Subject: Re: [PATCH 00/28] Use main as default branch name
To:     Junio C Hamano <gitster@pobox.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
 <87r1oraewl.fsf@x220.int.ebiederm.org>
 <xmqqv9e34mq5.fsf@gitster.c.googlers.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <1389dabc-33c9-1e65-a3de-43729a6c2e70@iee.email>
Date:   Wed, 18 Nov 2020 23:45:37 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <xmqqv9e34mq5.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17/11/2020 22:55, Junio C Hamano wrote:
>  I personally
> do not like the word 'main' used as such, but the rest of the world
> seems to be moving in that direction,

I feel that 'main' is rather a rather dull and boring sort of word.

In that sense, it could be useful as the fall back for those who haven't
yet got a clear view of what they want to call their first born. So I
sort of support both views.

An alternative in the other direction is to go with the 'not currently
on any branch' (detached at nowhere) but then require users to
deliberately create their first branch with their chosen name. This
moves the 'backward incompatibility' to a different place, which may be
easier to manage.
--
Philip
