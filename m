Return-Path: <SRS0=gkpi=AN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A270C433E0
	for <git@archiver.kernel.org>; Thu,  2 Jul 2020 12:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55A5D20884
	for <git@archiver.kernel.org>; Thu,  2 Jul 2020 12:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=whinis.com header.i=@whinis.com header.b="WepbLphV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728991AbgGBMTJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jul 2020 08:19:09 -0400
Received: from whinis.com ([198.205.115.165]:33918 "EHLO whinis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728661AbgGBMTI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jul 2020 08:19:08 -0400
Received: from localhost (localhost [127.0.0.1])
        by whinis.com (Postfix) with ESMTP id 4D9827C51DC;
        Thu,  2 Jul 2020 08:19:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=whinis.com; s=mail;
        t=1593692347; bh=QO82CxSTZw5oLR4FqdTN/gwO7dkZhLHMsUbOywSvH5k=;
        h=To:Cc:References:Subject:From:Date:In-Reply-To;
        b=WepbLphVtwwS3xfbfHR+2To0/VmX3eJGjCULe9SXnxF3e9G4oRJOhqY2vZ7BnKb8O
         ZuW/mcUFT1xdI1Da2Cg+jfaKJQMqrH1HecERLau6lzvS1DWldGXJ/IrL6tufKKQFtL
         3WvPNM58xynYxU9n6I8o2LmINMBOwTFQ7wkh4iTY=
X-Virus-Scanned: Debian amavisd-new at whinis.com
Received: from whinis.com ([127.0.0.1])
        by localhost (asgard.whinis.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ZsF9o9s1yvJf; Thu,  2 Jul 2020 08:19:05 -0400 (EDT)
Received: from [192.168.1.117] (c-73-139-109-188.hsd1.fl.comcast.net [73.139.109.188])
        by whinis.com (Postfix) with ESMTPSA id 090CB7C51DB;
        Thu,  2 Jul 2020 08:19:04 -0400 (EDT)
To:     peff@peff.net
Cc:     bturner@atlassian.com, git@vger.kernel.org, james@jramsay.com.au,
        me@ttaylorr.com, msuchanek@suse.de
References: <20200701215744.GA952178@coredump.intra.peff.net>
Subject: Re: Consensus on a new default branch name
From:   Whinis <Whinis@whinis.com>
Message-ID: <16f1c63a-8b30-e95e-50d1-c5baa9a72fa4@whinis.com>
Date:   Thu, 2 Jul 2020 08:21:35 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200701215744.GA952178@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Peff,

With all respect I have yet to see any evidence actually presented 
against master either. The original list makes the claim its offensive 
and everyone I have asked on other forums just says its obvious its 
offensive but cannot say how it is without resorting to `Do you not find 
enslaving humans offensive`. About all we have is twitter where you can 
easily find people saying its time to go and that changing it makes them 
feel worse as they had no problem with it and yet its being forced 
through in their name. L makes a case with research that the initial 
claim was also not made in good faith at 
https://lore.kernel.org/git/20200621195023.3881634-1-lkcl@lkcl.net/ . 
The link is also more on the master/slave depart but many of the points 
researched cover this one as well.

I like that you want to err on the side of empathy but based on how most 
of these changes have been forced through their communities I do not 
think the ones arguing for this would do the same for you. As can 
partially be seen with the claim that there is no amount of work that 
can justify continuing to use master or a host of other terms.

My personal feeling is it should not change as while many on this list 
certainly are speaking in good faith and want to help the momentum 
behind the change very much is not. While I know its not part of this 
list check out the gitlab issue where they finally opened it back up for 
discussion at https://gitlab.com/gitlab-org/gitlab/-/issues/221164 and 
it adds onto those that seem to argue for attack any who argue against. 
If a change is going to be made that will affect million of developers 
and possibly break thousands to millions of applications  I would say 
that you need a mountain of proof and not what has been seen so far.

If I may ask what is the intended result of the change if it cannot be 
measured?

-Whinis

