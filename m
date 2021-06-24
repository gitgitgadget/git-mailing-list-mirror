Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45795C49EA6
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 16:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2192E613ED
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 16:59:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbhFXRBa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 13:01:30 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:40932 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229445AbhFXRB3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 13:01:29 -0400
Received: from host-78-147-180-220.as13285.net ([78.147.180.220] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1lwSh2-000BTv-9J; Thu, 24 Jun 2021 17:59:09 +0100
Subject: Re: [PATCH 1/2] doc: pull: explain what is a fast-forward
To:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Cc:     =?UTF-8?Q?V=c3=adt_Ondruch?= <vondruch@redhat.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
References: <20210621175234.1079004-1-felipe.contreras@gmail.com>
 <20210621175234.1079004-2-felipe.contreras@gmail.com>
 <b4e612ba-21c7-3bef-d113-0f070449cd87@iee.email>
 <60d49748b8538_2fb2082c@natae.notmuch>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <c2170f74-b93b-599b-1fb4-45b013c7bff1@iee.email>
Date:   Thu, 24 Jun 2021 17:59:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <60d49748b8538_2fb2082c@natae.notmuch>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Felipe,
On 24/06/2021 15:31, Felipe Contreras wrote:
> Philip Oakley wrote:
>> On 21/06/2021 18:52, Felipe Contreras wrote:
>>> --- a/Documentation/git-pull.txt
>>> +++ b/Documentation/git-pull.txt
>>> @@ -41,16 +41,41 @@ Assume the following history exists and the current branch is
>>>  ------------
>>>  	  A---B---C master on origin
>>>  	 /
>>> -    D---E---F---G master
>>> +    D---E master
>>>  	^
>>>  	origin/master in your repository
>>>  ------------
>>>  
>>>  Then "`git pull`" will fetch and replay the changes from the remote
>>>  `master` branch since it diverged from the local `master` (i.e., `E`)
>>> -until its current commit (`C`) on top of `master` and record the
>>> -result in a new commit along with the names of the two parent commits
>>> -and a log message from the user describing the changes.
>>> +until its current commit (`C`) on top of `master`.
>>> +
>>> +After the remote changes have been synchronized, the local `master` will
>>> +be fast-forwarded to the same commit as the remote one, therefore
>> Perhaps s/be fast-forwarded/have been 'fast-forward'ed/ ?
> No, there's multiple steps:
My key point was to 'quote' the fast-forward term.
And then (if suitable, with appropriate grammar corrections) indicate
subtly that 'nothing actually moved', we just moved the post-it note
showing the branch-name on the DAG [hence the confusion about timing] ;-)
>
>  1. origin/master is synchronizd with master on origin
>  2. master is fast-forwarded to origin/master
>
> So, after 1 is done, 2 will happen.
>
--
Philip
