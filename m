Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E18621F576
	for <e@80x24.org>; Fri,  2 Mar 2018 10:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426654AbeCBKtM (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 05:49:12 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:45685 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1426649AbeCBKtG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 05:49:06 -0500
Received: from [192.168.2.201] ([92.22.16.137])
        by smtp.talktalk.net with SMTP
        id riFLerV3rXdHHriFLeFkGd; Fri, 02 Mar 2018 10:49:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1519987744;
        bh=ROAQ9heNPe/WT6byuhhr6HjUbAeZR4NQhJknPYIYsMU=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=IVkST3Dtx5KwHKVtOSo8HZ951uynxpaPn7KW21KfbmDy9HATfmf6y4VysW1u0IsU+
         svX8hZ60p/DMB4QSRA/ytzPVYsswyA/z7m42I98kfYaAyMh9h3sHznXqZ7jMcUgnL5
         uqAQ7Djo971eAetR9QIWRI4iBfBMiViK6NZ9sWDc=
X-Originating-IP: [92.22.16.137]
X-Spam: 0
X-OAuthority: v=2.3 cv=JaySU3CV c=1 sm=1 tr=0 a=nWy375ASyxHoIYnPohIYMA==:117
 a=nWy375ASyxHoIYnPohIYMA==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=evINK-nbAAAA:8 a=XjT5drRJKY2r1323DG0A:9 a=QEXdDO2ut3YA:10 a=SHUmGpGg8TAA:10
 a=RfR_gqz1fSpA9VikTjo0:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 9/9] add -p: don't rely on apply's '--recount' option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20180213104408.9887-1-phillip.wood@talktalk.net>
 <20180301105103.24268-1-phillip.wood@talktalk.net>
 <20180301105103.24268-10-phillip.wood@talktalk.net>
 <xmqqo9k7fsht.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <97910405-bdb5-d85b-1de1-d3548d0e4e18@talktalk.net>
Date:   Fri, 2 Mar 2018 10:49:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqo9k7fsht.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfNvKqgFkyujWbIvfl7skjfP+lYRkFm1z4tZwP7HOFimVzfP+76ZodKDZnKt68z9VzwFtuYfuAh7HQVPtagIgxufsDCmtr1un/D+xZO33nyjeMzBbhMoK
 5SqgRRMLTgpQ16HRl8A0y/4kB81dU6lPP3U5JXgjM/rStcE4/cH2sZX3xT2jUL5fh+7tMC95FlIRIOJBiN3SrFY/zELenUKPKfR8Y75f8gMsBuRSP9bf4rdU
 Zxwx9FRg0vi5ptSifONEwC4jBn9gfIxDBTEGQ7PPnRT1PZiEotyt2p5ZSoG0D+6LlDctxGKBseVsBbexY9yt8iucmoO6P1NiUSe8rw9kuvU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/03/18 20:30, Junio C Hamano wrote:
> Phillip Wood <phillip.wood@talktalk.net> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> Now that add -p counts patches properly it should be possible to turn
>> off the '--recount' option when invoking 'git apply'
> 
> Sounds good ;-)
> 
Lets hope it works! Thanks for your comments, I'll send a re-roll of
this series at the beginning of next week

Best Wishes

Phillip
