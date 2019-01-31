Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE1201F453
	for <e@80x24.org>; Thu, 31 Jan 2019 20:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbfAaUkq (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Jan 2019 15:40:46 -0500
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:24328 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727200AbfAaUkq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 15:40:46 -0500
Received: from [192.168.2.240] ([92.26.116.186])
        by smtp.talktalk.net with SMTP
        id pJ8dgK30SwhzSpJ8dgbr2A; Thu, 31 Jan 2019 20:40:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1548967244;
        bh=bGC4pOGph6hUUnVMCWiZyZ5qd8ZG8KSjuuIr9SML1Z4=;
        h=Reply-To:Subject:To:References:From:Cc:Date:In-Reply-To;
        b=O+7OwSBe+MNf6gLXKXTXimLl2U+Rhnx+sYrTIPSEQxEg3f7awCCIXn6xC4k4LoHxd
         oGCIUm9xJYUNGpC2lLjyPENT3YTEIv9i1xTiL+gp5KSQJtkI977aozStcnODVsZsr5
         jTyqeMUlJs+nHlgZNXeAaDARI54YdpVRt+zDv1H8=
X-Originating-IP: [92.26.116.186]
X-Spam: 0
X-OAuthority: v=2.3 cv=e8Iot5h/ c=1 sm=1 tr=0 a=Pfo8oxCPEre7EYRssK5nbQ==:117
 a=Pfo8oxCPEre7EYRssK5nbQ==:17 a=IkcTkHD0fZMA:10 a=uZvujYp8AAAA:8
 a=b4LDLZbEAAAA:8 a=UlqV6C1OAAAA:20 a=lHt9L8fR2SPNheQdvnwA:9
 a=pqQZu3MpBdBQb9Sp:21 a=gh0n3hHsHZsq9kwZ:21 a=QEXdDO2ut3YA:10
 a=FXZrL07QY1wA:10 a=SLzB8X_8jTLwj6mN0q5r:22 a=20T61YgZp4ItGotXEy2O:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Broken interactive rebase text after some UTF-8 characters
To:     Alban Gruin <alban.gruin@gmail.com>, phillip.wood@dunelm.org.uk,
        Michal Nowak <mnowak@startmail.com>, git@vger.kernel.org
References: <a50734d9-4d30-5847-b5df-67a8458a36cb@startmail.com>
 <339d4dbd-b1bd-cf88-12b0-2af42f35ded7@talktalk.net>
 <23c60f2f-43ff-94ec-6100-861c655ec80b@startmail.com>
 <8c43e31b-01d8-a1c5-d19c-8efd0e5c1714@talktalk.net>
 <505c2e2e-c9bc-aa57-c498-2acced0b8afa@gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Message-ID: <2cbb5818-643d-bafd-6721-91e0d291a5fd@talktalk.net>
Date:   Thu, 31 Jan 2019 20:40:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <505c2e2e-c9bc-aa57-c498-2acced0b8afa@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfKHuPLz97iAzYqOodehWgEwJ6KlSAaYFY5alWGogIEPEN/quZXQJorCp1NVrH6tIvBaW1B60HbBBhDBQDhBCRDA1YxhyiwXO6hS66vmZEXHk6XGH7R7B
 8yPxGr7HItGuf9B35vxQ7NSd1JT4B2c3XF6J8LKjQ3RuEmyQQYiy07zJh0rkJtHaOPYlZQ1P2e6gB+6y0MA6dSFIxkIfqxe0/6vVnEUL1VjyFr56cy4HDDC7
 7ZJTbKen2ihnQL8o8zXsZ5zJyiIFMf9rGozMVXOQHT5rOIjcfXGJKKyVuU2UDcRCZCP7BnaGQyVtEYtoUEbFqeBqlxcrrPe0I4AQ7ufs5bg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban

On 31/01/2019 17:43, Alban Gruin wrote:
> Hi Phillip and Michal,
> 
> I think I found the bug.

Good find! Which os are you on?
> 
> If you look at .git/rebase-merge/git-rebase-todo.backup, which is
> created before the editor is opened, you can see that it does not have
> this problem.  In between, transform_todos() is called and causes the
> problem reported by Michal.
> 
> This seems to be caused by a single line, sequencer:4661 (on b5101f9297,
> "Fourth batch after 2.20", 2019-01-29)[1].  If you add just before a
> something like this:
> 
>      fwrite(item->arg, item->arg_len, sizeof(char), stdout);
> 
> You will see that the argument is properly written to stdout.  But if
> you write this:
> 
>      printf("%.*s\n", item->arg_len, item->arg);
> 
> You will have the same broken output as in the todo file.
> 
> Are we misusing C formats?

The C standard and POSIX both say that the * refers to the maximum 
number of bytes to print but it looks like it is being treated as the 
maximum number of characters on OpenIndiana.

Johannes - Perhaps we should change it to use fwrite() unless printf() 
gets fixed and we're sure no other operating systems are affected?

[1] http://pubs.opengroup.org/onlinepubs/9699919799/functions/fprintf.html
[2] http://www.open-std.org/jtc1/sc22/wg14/www/docs/n1548.pdf page 309

Best Wishes

Phillip

> [1] https://github.com/git/git/blob/master/sequencer.c#L4661
> 
> Cheers,
> Alban
> 
> 

