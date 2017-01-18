Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D8D31F89C
	for <e@80x24.org>; Wed, 18 Jan 2017 15:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752692AbdARPvj (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 10:51:39 -0500
Received: from smtp98.iad3a.emailsrvr.com ([173.203.187.98]:50981 "EHLO
        smtp98.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752617AbdARPvj (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 18 Jan 2017 10:51:39 -0500
Received: from smtp29.relay.iad3a.emailsrvr.com (localhost [127.0.0.1])
        by smtp29.relay.iad3a.emailsrvr.com (SMTP Server) with ESMTP id 469CE25030;
        Wed, 18 Jan 2017 10:41:01 -0500 (EST)
X-Auth-ID: mbranchaud@xiplink.com
Received: by smtp29.relay.iad3a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 1EE3724DC7;
        Wed, 18 Jan 2017 10:41:01 -0500 (EST)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Wed, 18 Jan 2017 10:41:01 -0500
Subject: Re: [RFC] stash --continue
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stephan Beyer <s-beyer@gmx.net>
References: <cd784a4e-ee99-564e-81de-9f7f6cc26c67@gmx.net>
 <alpine.DEB.2.20.1701161153340.3469@virtualbox>
Cc:     git <git@vger.kernel.org>
From:   Marc Branchaud <marcnarc@xiplink.com>
Message-ID: <d5456165-bdf2-e9e7-117f-aeab0ff4b417@xiplink.com>
Date:   Wed, 18 Jan 2017 10:41:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1701161153340.3469@virtualbox>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-01-16 05:54 AM, Johannes Schindelin wrote:
> Hi Stephan,
>
> On Mon, 16 Jan 2017, Stephan Beyer wrote:
>
>> a git-newbie-ish co-worker uses git-stash sometimes. Last time he used
>> "git stash pop", he got into a merge conflict. After he resolved the
>> conflict, he did not know what to do to get the repository into the
>> wanted state. In his case, it was only "git add <resolved files>"
>> followed by a "git reset" and a "git stash drop", but there may be more
>> involved cases when your index is not clean before "git stash pop" and
>> you want to have your index as before.
>>
>> This led to the idea to have something like "git stash --continue"[1]
>
> More like "git stash pop --continue". Without the "pop" command, it does
> not make too much sense.

Why not?  git should be able to remember what stash command created the 
conflict.  Why should I have to?  Maybe the fire alarm goes off right 
when I run the stash command, and by the time I get back to it I can't 
remember which operation I did.  It would be nice to be able to tell git 
to "just finish off (or abort) the stash operation, whatever it was".

		M.

