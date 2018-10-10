Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0779C1F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 13:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbeJJVUZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 17:20:25 -0400
Received: from gateway1.unifiedlayer.com ([69.89.27.180]:52192 "EHLO
        gateway1.unifiedlayer.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbeJJVUZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 17:20:25 -0400
X-Greylist: delayed 1407 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Oct 2018 17:20:25 EDT
Received: from cm4.websitewelcome.com (unknown [108.167.139.16])
        by gateway1.unifiedlayer.com (Postfix) with ESMTP id 377662009269D
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 08:34:44 -0500 (CDT)
Received: from uscentral401.accountservergroup.com ([23.91.71.222])
        by cmsmtp with ESMTP
        id AEdQgFTORxLGAAEdQgoLtg; Wed, 10 Oct 2018 08:34:44 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lonetwin.net; s=default; h=Message-ID:References:In-Reply-To:Subject:Cc:To:
        From:Date:Content-Transfer-Encoding:Content-Type:MIME-Version:Sender:Reply-To
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=R+F2O1lFTb589iO5mhIs8Wjxqm412Q/yP5ui0ELC7RE=; b=eDO1B7r3LdsyYAjBzQ6T0ktt0X
        oTwZ1gwAwXaeHUDayQlKLrLofuza+vMbzGIZCr4ERNwJ0WtvKTb7YhcSucSZRW0h+Pw+IHq8kEjm5
        dOhawyxeebB5Wt1DVxaIReu/7Szi8IGynyVFdMljNGrsBaAeLF+fxFldcVohQlqDLwGl31dNewquE
        LgNW+Fj/mMavCl+JOAADz67oiBEZZv/NQzMZP4VUVQGYJogc8bWkqtqAH8R4zZ7NkIJNWtb9k32fF
        bu5OfaIXcDldnt4kh8NXEMvx0BkbSZjmeTp2x8QhclWW1UnUalVfeeABVhj7O4+tj4vRn/p5cCgw6
        bfKTQrQA==;
Received: from [23.91.71.222] (port=49141 helo=webmail.lonetwin.net)
        by uscentral401.accountservergroup.com with esmtpa (Exim 4.91)
        (envelope-from <steve@lonetwin.net>)
        id 1gAEdP-000ev4-Uf; Wed, 10 Oct 2018 09:34:43 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 10 Oct 2018 14:34:43 +0100
From:   steve@lonetwin.net
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Junio C Hamano <jch2355@gmail.com>
Subject: Re: [PATCH] git-completion.bash: Add completion for stash list
In-Reply-To: <xmqq36tiva0i.fsf@gitster-ct.c.googlers.com>
References: <ef5e9e8da180a5ead70b53d767a8ed4a0666e598.camel@lonetwin.net>
 <xmqq36tiva0i.fsf@gitster-ct.c.googlers.com>
Message-ID: <4e046cd43ff5bfb907a68c5504efd7b2@lonetwin.net>
X-Sender: steve@lonetwin.net
User-Agent: Roundcube Webmail/1.3.3
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - uscentral401.accountservergroup.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lonetwin.net
X-BWhitelist: no
X-Source-IP: 23.91.71.222
X-Source-L: Yes
X-Exim-ID: 1gAEdP-000ev4-Uf
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (webmail.lonetwin.net) [23.91.71.222]:49141
X-Source-Auth: steve@lonetwin.net
X-Email-Count: 2
X-Source-Cap: Z2FicmlsY287Z2FicmlsY287dXNjZW50cmFsNDAxLmFjY291bnRzZXJ2ZXJncm91cC5jb20=
X-Local-Domain: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-10-07 2:08 am, Junio C Hamano wrote:
> Steve <steve@lonetwin.net> writes:
> 
>> Since stash list accepts git-log options, add the following useful
>> options that make sense in the context of the `git stash list` 
>> command:
>> 
>>   --name-status --oneline --patch-with-stat
>> 
>> Signed-off-by: Steven Fernandez <steve@lonetwin.net>
>> ---
>> 
>> This is my first patch to the project so please be excuse any process
>> errors.
>> Although, I've tried my best to follow the guidelines in
>> Documentation/SubmittingPatches but I'm not sure if I missed anything.
> 
> Thanks.  Will queue with manual fix-ups, but since you asked, here
> are the things I'll be fixing up manually, which you may want to
> avoid next time.
> 

Thanks for accepting the patchset and the manual fixes. Thanks a lot 
also
for taking the time to explain the mistakes to avoid.

cheers,
Steve
