Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12E1C2D0E4
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 11:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 709B822256
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 11:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbgKSLu1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Nov 2020 06:50:27 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:23256 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727329AbgKSLu0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Nov 2020 06:50:26 -0500
Received: from host-89-243-187-160.as13285.net ([89.243.187.160] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1kfiSG-0004so-9d; Thu, 19 Nov 2020 11:50:25 +0000
Subject: Re: [PATCH 00/28] Use main as default branch name
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
 <87r1oraewl.fsf@x220.int.ebiederm.org>
 <xmqqv9e34mq5.fsf@gitster.c.googlers.com>
 <1389dabc-33c9-1e65-a3de-43729a6c2e70@iee.email>
 <xmqqh7pmyuzn.fsf@gitster.c.googlers.com>
 <7df660f2-ad74-7d1f-eb13-a0edadffbfbf@iee.email> <871rgpr497.fsf@osv.gnss.ru>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <fe8962ee-0e0b-19bb-4b89-4603cdabee74@iee.email>
Date:   Thu, 19 Nov 2020 11:50:23 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <871rgpr497.fsf@osv.gnss.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19/11/2020 11:10, Sergey Organov wrote:
> Philip Oakley <philipoakley@iee.email> writes:
>
>> On 19/11/2020 01:51, Junio C Hamano wrote:
>>> Philip Oakley <philipoakley@iee.email> writes:
>>>
>>>> An alternative in the other direction is to go with the 'not currently
>>>> on any branch' (detached at nowhere) but then require users to
>>>> deliberately create their first branch with their chosen name. This
>>>> moves the 'backward incompatibility' to a different place, which may be
>>>> easier to manage.
>>> As has already been mentioned by Peff, I do not think that is a
>>> workable alternative, especially given that people are generally
>>> afraid of and easily get confused by being on a detached HEAD.
>> Yes, our use of the technical phrase 'detached HEAD' is confusing,
>> compared with the more pleasant 'not on any branch', or 'not at a branch
>> tip'. Such is the curse of knowledge.
> To me "not on a branch [tip]" is also confusing, as in fact you are, as
> is easily seen after you perform a few commits, and now HEAD points
> directly to the tip of the branch (that has no other references).
>
> I wonder why Git didn't rather adopt "unnamed branch" or "nameless
> branch" to describe this mode of operation?
Given the ephemeral nature of branches they sound like good suggestion.

However I suspect "history" to be the "why" of the current 'detached
head' usage.
Maybe it's a side reference to Nearly Headless Nick or other discussions
of the time (aka lost in history)?
--
Philip
