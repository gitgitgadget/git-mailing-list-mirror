Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB01C5519F
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 00:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FB7E246E7
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 00:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgKSAaY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 19:30:24 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:56865 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbgKSAaX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 19:30:23 -0500
Received: from host-89-243-187-160.as13285.net ([89.243.187.160] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1kfXq8-000APc-6E; Thu, 19 Nov 2020 00:30:21 +0000
Subject: Re: [PATCH 00/28] Use main as default branch name
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
 <87r1oraewl.fsf@x220.int.ebiederm.org>
 <xmqqv9e34mq5.fsf@gitster.c.googlers.com>
 <1389dabc-33c9-1e65-a3de-43729a6c2e70@iee.email>
 <nycvar.QRO.7.76.6.2011190057370.56@tvgsbejvaqbjf.bet>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <d81da6b9-02ee-dd38-3c94-3509f5e3cbf4@iee.email>
Date:   Thu, 19 Nov 2020 00:30:18 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2011190057370.56@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On 19/11/2020 00:00, Johannes Schindelin wrote:
> Hi Philip,
>
> On Wed, 18 Nov 2020, Philip Oakley wrote:
>
>> An alternative in the other direction is to go with the 'not currently
>> on any branch' (detached at nowhere) but then require users to
>> deliberately create their first branch with their chosen name. This
>> moves the 'backward incompatibility' to a different place, which may be
>> easier to manage.
> It might be easier to manage for _us_, the Git developers. But every user
> who initializes a repository and wants to push now

Is this 'emerges fully formed' initialise & push  really that common.

I'd be expecting a few add & commits prior to the push, so plenty of
time for deciding and creating the chosen branch. At least that was the
thought process...

>  needs to take the extra
> step to give their unnamed branch

>  ("detached HEAD" is _still_ confusing
> new users!!!) a name.
I'd only mentioned the detached head to keep the devs happy ;-) I'm
quite happy with a "not on any named branch yet" type message for normal
usage.

>
> That would be much more disruptive than choosing a "rather dull and
> boring" name instead of a rather racially-charged one.
"Main" is fine, but Junio had mention say "Primary" as being more
positive, but that is begging the question for the user. We should let
them chose.

Hence using the not greatly inspiring 'main' as a starter offering would
match that desire that the user should, ideally, make their own choice. 
>
> And we promised to try to minimize the disruption to Git users.
...but we haven't said 'it' is an ignorable issue. There's still a lot
of old documentation and inertia to overcome.
>
> Ciao,
> Dscho
Philip
