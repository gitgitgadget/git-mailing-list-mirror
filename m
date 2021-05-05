Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDFFC433ED
	for <git@archiver.kernel.org>; Wed,  5 May 2021 10:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC563613BC
	for <git@archiver.kernel.org>; Wed,  5 May 2021 10:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbhEEKuU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 06:50:20 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:8614 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229689AbhEEKuU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 06:50:20 -0400
Received: from host-92-1-139-132.as13285.net ([92.1.139.132] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1leF5l-000APT-Af; Wed, 05 May 2021 11:49:21 +0100
Subject: Re: Advise request on adding a new SSH variant
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>, git@vger.kernel.org
References: <043101d73aae$026409b0$072c1d10$@nexbridge.com>
 <fa8f81db-d470-130e-115d-7aef5e97e5a7@iee.email> <xmqqlf8u57jl.fsf@gitster.g>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <6bde927d-19da-a350-825b-b8bf71d19269@iee.email>
Date:   Wed, 5 May 2021 11:49:20 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <xmqqlf8u57jl.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/05/2021 01:49, Junio C Hamano wrote:
> Philip Oakley <philipoakley@iee.email> writes:
>
>> I was also thinking that the lack of replies maybe links to the "Pain
>> points in Git's patch flow" thread <YHaIBvl6Mf7ztJB3@google.com> whereby
>> it's all about the proposed patch, rather than thoughts about a
>> potential patch.
>> (Sort of like the philosophy of science [method] that ignores opinion,
>> and demands evidence)
> Actually, the initial message on this matter from Randall came in
> the patch form <011e01d73dd0$ec141530$c43c3f90$@nexbridge.com>, so
> if it were truly "it's all about the proposed patch, rather than
> thoughts about a potential patch", it would have gained much more
> responses.

I'd missed the patches (at the time) as my mail client hadn't grouped
them together, so that mail looked a bit lonely, hence my reply ;-)
I saw a later note by Randall that send-email hadn't worked on his
system which gave rise to the patches being 'spread about'.
>
> Other than I didn't have time, the reason I didn't respond was that
> the concept and notation used there were a bit too foreign to me to
> decide from where to start asking questions.  It wasn't clear what
> '$ZSSHX' meant (is it the value of an environment variable whose
> name is ZSSHX, or is it literally a name with dollar in it and is
> the issue being addressed that it is too cumbersome to quote it
> properly in value of the GIT_SSH_COMMAND environment variable?) for
> example.  And after reading the message you are responding to twice,
> I do not quite get what problem we are trying to solve.  Especially
> since
>
>     No, it would be GIT_SSH_COMMAND='/G/system/zssh/sshoss -Z -Q -S
>     $ZSSH0' and that does not work correctly in the current git code
>     base.
>
> in <012601d73ddf$3d0cf660$b726e320$@nexbridge.com> sounded like we
> have a fairly clearly demonstratable problem (i.e. the handling of
> the command line given via GIT_SSH_COMMAND is somehow broken). The
> details of "does not work correctly in the current code base" is not
> yet disclosed but it sounded like it would be possible to tease it
> out and solve the issue in a more direct way.  But yet the solution
> presented in the three-patch series looked like it was sidestepping
> the entire issue and adding a special case for NonStop without
> having to touch GIT_SSH_COMMAND at all (presumably leaving it still
> "broken").
I didn't understand all that either. I'd just spotted the other ssh
variants being common on Windows.. A classic curse of knowledge (or lack
of it) problem.

Philip
