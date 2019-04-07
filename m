Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65CBA20248
	for <e@80x24.org>; Sun,  7 Apr 2019 11:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfDGLwM (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Apr 2019 07:52:12 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:45678 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbfDGLwM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Apr 2019 07:52:12 -0400
Received: from [192.168.1.12] ([2.101.245.142])
        by smtp.talktalk.net with SMTP
        id D6LIhRkRtgI7iD6LIhSdeA; Sun, 07 Apr 2019 12:52:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1554637929;
        bh=1ewEEyHVq18dBac2Mhl0GjuRacdkwKCRUQ96O6b6B9w=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=c+coMkCJ1EbxLfdnoKYNmG6FbHdneMoxwM939GSvMS1GtZTUCR/ufnuc1YF9zPlIL
         aLfiQ3Axyl0skKlxLcFBKx9/hLUt7drARjZ0i2xurFPK5o/+fmyzpP5UQ08c6aUt6W
         EbYTC/ZvWd/gy2L6uVOG/lo+6rf0J47qHPv6hPTA=
X-Originating-IP: [2.101.245.142]
X-Spam: 0
X-OAuthority: v=2.3 cv=KYisTjQD c=1 sm=1 tr=0 a=mQgiQ6BlbOv19lEfDgieCg==:117
 a=mQgiQ6BlbOv19lEfDgieCg==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=xtxXYLxNAAAA:8 a=5rxgeBVgAAAA:8 a=pGLkceISAAAA:8
 a=bDADMGTweaP0FWVwrZcA:9 a=QEXdDO2ut3YA:10 a=xts0dhWdiJbonKbuqhAr:22
 a=PwKx63F5tFurRwaNxrlG:22
Subject: Re: git glossary --help ?
To:     Duy Nguyen <pclouds@gmail.com>,
        Philip Oakley <philipoakley@iee.org>
Cc:     Git List <git@vger.kernel.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <05e6a0ad-36ea-e594-f253-ded3e5392375@iee.org>
 <CACsJy8DE4WfbU2y8+__4qD7V5FLodKjxX-bu+seE8mh65q8FYQ@mail.gmail.com>
From:   Philip Oakley <philipoakley@talktalk.net>
Message-ID: <8e40eb85-0368-d12f-f238-acababdcd858@talktalk.net>
Date:   Sun, 7 Apr 2019 12:52:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CACsJy8DE4WfbU2y8+__4qD7V5FLodKjxX-bu+seE8mh65q8FYQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfCiYU5O575gkTPDNYl3ISog3G3eku5hs3e/0lfB1y4T1Ph5iEsX6/PCIPQSW7Ck1TuaOIdhT7AO3bXXa4c9mbX65wsSThePw56z6fgZflb594fWegdoI
 gOlF06RvIpy4zao4Hx8zRwnFkXgQyiu9jrnQV7JY2kMzSXgYNjhvi/zy1nAKgQpTB6u50HxuPqNVWXxLl4O9Z3LfeVyuArmIjV5iMi9opBV7VR1XvnIWqEn1
 8zpaHuHA25YCWDF0wVJCT/79mPU7ujxHCJMkt6AdXWsHKswWqRnR0XC4dt/JVwJg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Duy,

On 07/04/2019 04:20, Duy Nguyen wrote:
> On Sun, Apr 7, 2019 at 12:31 AM Philip Oakley <philipoakley@iee.org> wrote:
>> Following the discussions about the tag peeling issue, I thought to have
>> a look at what the git glossary says.
>>
>> I had it in my head that when the git guides were linked to the help
>> system, that the --help option provided a short circuit direct to help
>> item. However this did not happen.
>>
>> I found that the capability had been lost, which given that a lot of the
>> underpinning knowledge is in the guides this would appear to be a loss.
>>
>> I don't have an older version to test, but I thought I remember the
>> capability from about the time of my 65f98358c0 ("builtin/help.c: add
>> --guide option", 2013-04-02).
>>
>> Have I misremembered the --help capability?
>>
>> cc'ing Duy in case he remembers something from the recent update
> Phew... I didn't break anything!
>
> That behavior has been gone since 2c6b6d9f7d (help: make option --help
> open man pages only for Git commands, 2016-08-26). Ralf did not
> mention why he thought "git <concept> --help" was a bad idea. But it
> was considered a bug by Junio [1]
>
> [1] https://public-inbox.org/git/CAPc5daXicjUDi6B-MA8Sn=_UZ_jHvc8SE4ZXt2dHbbDQkD7=WA@mail.gmail.com/
Thanks for the link. I see I responded later in the thread but didn't 
follow it up sufficiently (not sure what I was doing back then.. summer 
break maybe).

I do think we are sometimes a bit dismissive of features (accidental 
bias) that help the general user in getting help. If we think that 'git 
help' is the (one) right way of providing access to manuals (such as the 
concept guides) then maybe we shouldn't have the ubiquitous --help 
option for all the commands. Or,

Or, we should be liberal in what we accept from others (Postel's Law). 
It is normal to type 'git foo --help'. So maybe allow these multiple 
ways of accessing the documentation. Given the update to the command 
list capability, I'll add it to my todo list to see if we can accept 
guide names with --help and, one way or another, get folk to the right 
place (the guide or command they should have used/requested).
-- 
Philip
