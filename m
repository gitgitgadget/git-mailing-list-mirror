Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFDB91F4BE
	for <e@80x24.org>; Mon,  7 Oct 2019 17:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728814AbfJGR52 (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 13:57:28 -0400
Received: from fallback19.mail.ru ([185.5.136.251]:33252 "EHLO
        fallback19.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728081AbfJGR51 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 13:57:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail2;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=xPL/gMUd72g4E5IRUaFzXMAxK5lBZWEGcUo0bvzSJ58=;
        b=WCBH4EtNqQnH86zSqfUT5do0r8+zR1/tn3DgoljlBMmApJcG6PFTtC0WMUPU2ONlGXsuDr1KPoAXkMPdG+n1kco9vjFeOoYEf2P5LII+iIwCJlDrcF9uZAPiaSPxawNc1c7s2tfOseIK5pq9Rv0BXQFV4ffsH0l3oitKgshB+do=;
Received: from [10.161.64.44] (port=59014 helo=smtp36.i.mail.ru)
        by fallback19.m.smailru.net with esmtp (envelope-from <kirnosenko@mail.ru>)
        id 1iHXG8-0006wh-Sj
        for git@vger.kernel.org; Mon, 07 Oct 2019 20:57:25 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail2;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=xPL/gMUd72g4E5IRUaFzXMAxK5lBZWEGcUo0bvzSJ58=;
        b=WCBH4EtNqQnH86zSqfUT5do0r8+zR1/tn3DgoljlBMmApJcG6PFTtC0WMUPU2ONlGXsuDr1KPoAXkMPdG+n1kco9vjFeOoYEf2P5LII+iIwCJlDrcF9uZAPiaSPxawNc1c7s2tfOseIK5pq9Rv0BXQFV4ffsH0l3oitKgshB+do=;
Received: by smtp36.i.mail.ru with esmtpa (envelope-from <kirnosenko@mail.ru>)
        id 1iHXG7-000435-2q; Mon, 07 Oct 2019 20:57:23 +0300
Subject: Re: log -m output
To:     Elijah Newren <newren@gmail.com>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <ee1f00fd-715c-5ecd-bc29-5e5a2de2d0f9@mail.ru>
 <20191007164310.GA11529@szeder.dev>
 <7b9c0b0b-2a1c-d4d3-13ba-f020ff15d5ad@mail.ru>
 <CABPp-BFPrweNZ=ubT+8EE9xPyNjzEuUXKvESmXDb3Mhh37dAVA@mail.gmail.com>
From:   Semyon Kirnosenko <kirnosenko@mail.ru>
Message-ID: <300294ff-987e-c868-2917-f8743772bc7c@mail.ru>
Date:   Mon, 7 Oct 2019 21:57:23 +0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BFPrweNZ=ubT+8EE9xPyNjzEuUXKvESmXDb3Mhh37dAVA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: ru
Content-Transfer-Encoding: 8bit
X-77F55803: 3FFC80838138E3AB5A78504BD2AC29415E20F5A9228C2E5929309CB592A126BCEF10688910A94AD7CC555E43237975FC
X-7FA49CB5: 0D63561A33F958A55C605AEB1E4CA7D9075212014857FBEEB25D8049E017F92F8941B15DA834481FA18204E546F3947C1D471462564A2E19F6B57BC7E64490618DEB871D839B7333395957E7521B51C2545D4CF71C94A83E9FA2833FD35BB23D27C277FBC8AE2E8B2EE5AD8F952D28FBA471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C2249A64C4E77951A82EE76E601842F6C81A12EF20D2F80756B5F5C318D1F9ECD513A76E601842F6C81A127C277FBC8AE2E8BFCB6192C5142207C3AA81AA40904B5D99449624AB7ADAF37F910319684D6E05D725E5C173C3A84C3EBF4D8D28E8B6903E2D95B528A3DBD9F28A6D463EDFD0DBBC4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F05F538519369F3743B503F486389A921A5CC5B56E945C8DA
X-Mailru-Sender: 263D284DE1FEA85BBEF80A77B8F6DF1D582358570B8ADD060683E9E8DBA667F9BDFD8BD19E8FD7DEDC4C2A81C984B8A5C77752E0C033A69E90207DEE2626FE2D9458A22DE3EF5D793453F38A29522196
X-Mras: OK
X-77F55803: E8DB3678F13EF3E07F9F52485CB584D7271FD7DF62800FDCD07DBA66E3FF58CB5FE1D3CF60F3BC4EA0EB18776358A6C31C15400A1D58C36E
X-7FA49CB5: 0D63561A33F958A53D086926A15F9CEF50BC14FF25D5C2AEE8B7A1C0147988FF8941B15DA834481FA18204E546F3947C2FFDA4F57982C5F4F6B57BC7E64490618DEB871D839B7333395957E7521B51C2545D4CF71C94A83E9FA2833FD35BB23D27C277FBC8AE2E8BF1175FABE1C0F9B6A471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C2249E534D5F67D1EC79B76E601842F6C81A12EF20D2F80756B5F5C318D1F9ECD513A76E601842F6C81A127C277FBC8AE2E8B0C576453C6160EE83AA81AA40904B5D99449624AB7ADAF37F910319684D6E05D462275124DF8B9C9DE2850DD75B2526BE5BFE6E7EFDEDCD789D4C264860C145E
X-Mailru-Sender: A5480F10D64C9005E7955441BDF86265047CED679E2279885FE1D3CF60F3BC4E7AD558DE3329E344747DBA6A7B69AB523DDE9B364B0DF2894997D260BF952801D63E4CEE33A69112AE208404248635DF
X-Mras: OK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019-10-07 21:20, Elijah Newren wrote:
> On Mon, Oct 7, 2019 at 10:05 AM Semyon Kirnosenko <kirnosenko@mail.ru> wrote:
>>
>> On 2019-10-07 20:43, SZEDER Gábor wrote:
>>> On Mon, Oct 07, 2019 at 07:14:25PM +0400, Semyon Kirnosenko wrote:
>>>> I have a question about log command.
>>>> Probably I'm just missing something but anyway.
>>>> I can illustrate the question on the repository of Git.
>>>> Let's look at revision 1ed91937
>>>> It is a merge based on pair of revisions a9572072 and 294c695d.
>>>> According to blame these parent revisions have different content for
>>>> delta.h file.
>>>
>>> I'm not sure what you mean by this statement; what blame command did
>>> you run?
>>>
>>>> But when I get log with -m flag for merge revision, I can't see that
>>>> file in the list of changed files.
>>>> Why?
>>>
>>> The contents of 'delta.h' is identical in both parents of that merge:
>>>
>>>     $ git diff a9572072 294c695d delta.h
>>>     $
>>>     # no difference
>>>
>>> So 'git log -m' does the right thing by not showing 'delta.h'.
>>>
>>> .
>>>
>>
>> But blame shows different results:
>>
>> git blame a9572072 delta.h
>> git blame 294c695d delta.h
> 
> blame does not at all claim those two revisions have different
> versions of delta.h:
> 
> $ diff -u <(git blame a9572072 delta.h) <(git blame 294c695d delta.h)
> --- /dev/fd/63    2019-10-07 10:16:43.092356078 -0700
> +++ /dev/fd/62    2019-10-07 10:16:43.092356078 -0700
> @@ -9,8 +9,8 @@
>   a310d434946 (Nicolas Pitre  2005-05-19 10:27:14 -0400  9)
>   void *delta_buf, unsigned long delta_size,
>   a310d434946 (Nicolas Pitre  2005-05-19 10:27:14 -0400 10)
>   unsigned long *dst_size);
>   d1af002dc60 (Nicolas Pitre  2005-05-20 16:59:17 -0400 11)
> -dcde55bc58a (Nicolas Pitre  2005-06-29 02:49:56 -0400 12) /* the
> smallest possible delta size is 4 bytes */
> -dcde55bc58a (Nicolas Pitre  2005-06-29 02:49:56 -0400 13) #define
> DELTA_SIZE_MIN    4
> +c7a45bd20e4 (Junio C Hamano 2005-12-12 16:42:38 -0800 12) /* the
> smallest possible delta size is 4 bytes */
> +c7a45bd20e4 (Junio C Hamano 2005-12-12 16:42:38 -0800 13) #define
> DELTA_SIZE_MIN    4
>   dcde55bc58a (Nicolas Pitre  2005-06-29 02:49:56 -0400 14)
>   dcde55bc58a (Nicolas Pitre  2005-06-29 02:49:56 -0400 15) /*
>   dcde55bc58a (Nicolas Pitre  2005-06-29 02:49:56 -0400 16)  * This
> must be called twice on the delta data buffer, first to get t
> 
> It does say that _how_ those two arrived at the *same* version of the
> file differed, but if you compare the portions of the differing lines
> corresponding to the actual file contents you see that they are the
> same...just as SZEDER pointed out.
> 

Now I see. I just was confused about changing code ownership without 
changing code. Thanks!
