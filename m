Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84C2A1F4BE
	for <e@80x24.org>; Mon,  7 Oct 2019 17:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbfJGRAZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 13:00:25 -0400
Received: from smtp60.i.mail.ru ([217.69.128.40]:60758 "EHLO smtp60.i.mail.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727801AbfJGRAZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 13:00:25 -0400
X-Greylist: delayed 6355 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Oct 2019 13:00:24 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail2;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=ty7/Ts+5xLjADwL7ZQZSPvJMNlsSUhKbQsi6j8VfhXA=;
        b=nTAw6A/9U7U3YhES1pHev4M81lvSixUnWciTGqGj62hbV5OhYPaBINndOEPJ5nSDlmZi7a7NsqLWg1wbyhSNkzmRmVI+esLtP2gXTLGNcC7G/H4fFjQJRLD6QmG+660RAQ2To7W5lKtkA9vAYFEfEPPIdk16t4T7ZYFjxKpBm7I=;
Received: by smtp60.i.mail.ru with esmtpa (envelope-from <kirnosenko@mail.ru>)
        id 1iHWMw-00089r-P3; Mon, 07 Oct 2019 20:00:23 +0300
Subject: Re: log -m output
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
References: <ee1f00fd-715c-5ecd-bc29-5e5a2de2d0f9@mail.ru>
 <20191007164310.GA11529@szeder.dev>
From:   Semyon Kirnosenko <kirnosenko@mail.ru>
Message-ID: <7b9c0b0b-2a1c-d4d3-13ba-f020ff15d5ad@mail.ru>
Date:   Mon, 7 Oct 2019 21:00:20 +0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20191007164310.GA11529@szeder.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: ru
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp60.i.mail.ru; auth=pass smtp.auth=kirnosenko@mail.ru smtp.mailfrom=kirnosenko@mail.ru
X-77F55803: 260C666A7D66B36A5A78504BD2AC29415E20F5A9228C2E59AB69C2907134B4C8A88C4B0DE97BC565E70E76816077F5BC
X-7FA49CB5: 0D63561A33F958A59EDE045272C6F5B44023BB83BBFA7DCA6EAA2DCCA1D0A29A8941B15DA834481FA18204E546F3947CEDCF5861DED71B2F389733CBF5DBD5E9C8A9BA7A39EFB7666BA297DBC24807EA117882F44604297287769387670735209ECD01F8117BC8BEA471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C2249A64C4E77951A82EE76E601842F6C81A12EF20D2F80756B5F5C318D1F9ECD513A76E601842F6C81A127C277FBC8AE2E8BFCB6192C5142207C3AA81AA40904B5D99449624AB7ADAF37F910319684D6E05D725E5C173C3A84C3EBF4D8D28E8B690309D29B49A3AAA6A9BEFCD6C56BCFE9CEC4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F05F538519369F3743B503F486389A921A5CC5B56E945C8DA
X-Mailru-Sender: 263D284DE1FEA85BBEF80A77B8F6DF1DB0551380F39F795B0483A30FDDBE29223DEB18D96A76F102DC4C2A81C984B8A5C77752E0C033A69E90207DEE2626FE2D9458A22DE3EF5D793453F38A29522196
X-Mras: OK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019-10-07 20:43, SZEDER Gábor wrote:
> On Mon, Oct 07, 2019 at 07:14:25PM +0400, Semyon Kirnosenko wrote:
>> I have a question about log command.
>> Probably I'm just missing something but anyway.
>> I can illustrate the question on the repository of Git.
>> Let's look at revision 1ed91937
>> It is a merge based on pair of revisions a9572072 and 294c695d.
>> According to blame these parent revisions have different content for
>> delta.h file.
> 
> I'm not sure what you mean by this statement; what blame command did
> you run?
> 
>> But when I get log with -m flag for merge revision, I can't see that
>> file in the list of changed files.
>> Why?
> 
> The contents of 'delta.h' is identical in both parents of that merge:
> 
>    $ git diff a9572072 294c695d delta.h
>    $
>    # no difference
> 
> So 'git log -m' does the right thing by not showing 'delta.h'.
> 
> .
> 

But blame shows different results:

git blame a9572072 delta.h
git blame 294c695d delta.h

-- 
С Уважением,
Кирносенко С.И.
