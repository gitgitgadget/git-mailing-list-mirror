Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 779B41F453
	for <e@80x24.org>; Wed,  1 May 2019 08:59:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbfEAI7p (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 May 2019 04:59:45 -0400
Received: from taro.getmail.no ([84.210.184.13]:34998 "EHLO
        taro.get.c.bitbit.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725776AbfEAI7p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 May 2019 04:59:45 -0400
X-Greylist: delayed 419 seconds by postgrey-1.27 at vger.kernel.org; Wed, 01 May 2019 04:59:44 EDT
Received: from montes.get.c.bitbit.net (unknown [10.7.88.21])
        by taro.get.c.bitbit.net (Postfix) with ESMTPS id B2D25F9E2
        for <git@vger.kernel.org>; Wed,  1 May 2019 10:52:48 +0200 (CEST)
Received: from bouvier.getmail.no (unknown [10.7.88.12])
        by montes.get.c.bitbit.net (Postfix) with ESMTPS id 333DB16AD
        for <git@vger.kernel.org>; Wed,  1 May 2019 10:52:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by bouvier.getmail.no (Postfix) with ESMTP id 7DC0B40036;
        Wed,  1 May 2019 10:52:42 +0200 (CEST)
Received: from bouvier.getmail.no ([127.0.0.1])
        by localhost (bouvier.get.c.bitbit.net [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id EgOm6KDE73UH; Wed,  1 May 2019 10:52:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by bouvier.getmail.no (Postfix) with ESMTP id 8C9DF40034;
        Wed,  1 May 2019 10:52:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at bouvier.get.c.bitbit.net
Received: from bouvier.getmail.no ([127.0.0.1])
        by localhost (bouvier.get.c.bitbit.net [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jBazdNOvEU5y; Wed,  1 May 2019 10:52:32 +0200 (CEST)
Received: from perkele.intern.softwolves.pp.se (cm-84.209.6.62.getinternet.no [84.209.6.62])
        by bouvier.getmail.no (Postfix) with ESMTPSA id 5FD354002E;
        Wed,  1 May 2019 10:52:32 +0200 (CEST)
Received: from peter (helo=localhost)
        by perkele.intern.softwolves.pp.se with local-esmtp (Exim 4.89)
        (envelope-from <peter@softwolves.pp.se>)
        id 1hLkye-0006t6-3b; Wed, 01 May 2019 10:52:32 +0200
Date:   Wed, 1 May 2019 09:52:32 +0100 (CET)
From:   Peter Krefting <peter@softwolves.pp.se>
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff Schwartz <jefftschwartz@gmail.com>, git@vger.kernel.org
Subject: Re: Request to add option to interactive rebase to preserve latest
 commit date
In-Reply-To: <xmqq4l6kvnuu.fsf@gitster-ct.c.googlers.com>
Message-ID: <alpine.DEB.2.20.1905010900260.23829@perkele.intern.softwolves.pp.se>
References: <CAL3M-FZ7b3H7Z+Vr9Wbey5iYVoWiUBnDKVEenyAMrUXeNfL56w@mail.gmail.com> <xmqq4l6kvnuu.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
Organization: /universe/earth/europe/norway/oslo
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano:

>> Using interactive rebase has one flaw IMHO and that is the way it
>> handles dating its commit. Can you add an option to interactive rebase
>> that would make it use the date from the commit that is most recent
>> and not the date from the commit that is the oldest?
>
> I am not sure what you mean by this.  If you interactively rebase
> the topmost two commits (assuming that since three commits ago, you
> have a linear history):

I sort of assume that this is when merging several fixup! or squash! 
commits. I often end up adding lines the code to date these with the 
current date, but the date of the last fixup'ed or squash'ed commit 
would probably be better.

-- 
\\// Peter - http://www.softwolves.pp.se/
