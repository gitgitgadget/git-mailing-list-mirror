Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369A6C2D0E4
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 15:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C139A2080A
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 15:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=whinis.com header.i=@whinis.com header.b="nFU3ZKkr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388290AbgKWPqR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 10:46:17 -0500
Received: from whinis.com ([198.205.115.165]:54596 "EHLO whinis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388010AbgKWPqQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 10:46:16 -0500
X-Greylist: delayed 395 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Nov 2020 10:46:15 EST
Received: from localhost (localhost [127.0.0.1])
        by whinis.com (Postfix) with ESMTP id D46B87C52CE;
        Mon, 23 Nov 2020 10:39:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=whinis.com; s=mail;
        t=1606145979; bh=d6SYu9/axXgwkReU4YTl5A9td/q5gHTFBGlZ0sKEQ7U=;
        h=To:Cc:References:Subject:From:Date:In-Reply-To;
        b=nFU3ZKkrfy6xM5Wws0NixlV9V2JLvJV+y4A7ALLf+NlqRxvhHEEnp2jWQtW9GBioQ
         U7YQSn6CCBe4nIdoKvNcbZ9u42jQymdSWNKz3kn4xgwK6dnWisUR2jajnpNerA+Fe7
         Xkppn7xLrr5F/ISQW6yMnbMb+CErF4V3WrvdMmfA=
X-Virus-Scanned: Debian amavisd-new at whinis.com
Received: from whinis.com ([127.0.0.1])
        by localhost (asgard.whinis.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id b5z5sWLEpKLw; Mon, 23 Nov 2020 10:39:39 -0500 (EST)
Received: from [10.129.131.239] (unknown [129.171.6.203])
        by whinis.com (Postfix) with ESMTPSA id 5C5B27C240A;
        Mon, 23 Nov 2020 10:39:38 -0500 (EST)
To:     levraiphilippeblain@gmail.com
Cc:     Johannes.Schindelin@gmx.de, don@goodman-wilson.com,
        felipe.contreras@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        sandals@crustytoothpaste.net
References: <3EC700EE-8DB1-4A31-9061-6C5899330CCC@gmail.com>
Subject: Re: The master branch rename, and avoiding another v1.6.0 git-foo
 fiasco
From:   Whinis <Whinis@whinis.com>
Message-ID: <8240e2a1-5191-1f81-463f-f8f6ed36996b@whinis.com>
Date:   Mon, 23 Nov 2020 10:39:37 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <3EC700EE-8DB1-4A31-9061-6C5899330CCC@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I couldn't agree more. We really need to be warning users several versions in advance,
> and I mean months or even years. I don't wan't to come up with a number, but I would
> guess that maybe 85 %, (or even 95 % ?) of the world-wide Git user base is unaware that any discussion
> on that topic ever took place.
>
> Brian mentioned that some people voicing their concern on the list did not abide by the code of conduct.
> There was also very vocal disagreement voiced in the Git-for-Windows GitHub project before the
> discussion reached the mailing list, of which a lot was also considered to not abide by that project's
> code of conduct. While I agree that discussion should be done with respect, and some people that
> are driven to react to such important changes might not be aware of any code of conduct they should
> follow, because they don't participate in the "day-to-day" life of the project, just the fact that they even
> care enough to voice their disagreement should be a big red flag in terms of how this change should be done,
> in my opinion.
>
> I had avoided commenting on this whole subject, but the main point you are bringing,
> that such a change, if done, should be made with great care to our user base and a lot
> more warning, is a very important one.
>
> Thanks for bringing it up.
>
> Philippe.
Not just Git-for-Windows but there is also numerous reddit threads 
expressing both disbelief that this would even be considered and anger 
at how it might hurt various workflows as well as issues on gitlab and 
gitea which were closed as soon as any discussion started normally 
citing the code of conduct even if no real violations occurred. The one 
exception was gitlab where it was closed, reopened and allowed for long 
discussion before being closed again. In the gitlab one certainly user 
issues were brought up, even if primarily by me, before being discarded 
as those for the change purely on emotional reasoning. What I find sort 
of interesting is the constant claim that its a direct reference to 
slavery also without any proof.

Overall this is a massive change that will affect users, documentation, 
and classes for years to come if made and should only be made with 
clear, articulatable, realizable benefits such as the SHA1 change. 
Breaking years of documentation and books without that clear and obvious 
benefit is a disservice to users and likely to cause significant harm in 
the short and long term and a clear tenant of why few projects change 
things just to change things. The risk of unintended effects is too 
great once something is well recognized as python and others have found 
out trying to remove what their perceived as problematic language 
leading to multiple incompatible versions.

Whinis

