Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CB3C54EBD
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 16:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjAMQNO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Jan 2023 11:13:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjAMQMu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 11:12:50 -0500
Received: from mail.turbocat.net (turbocat.net [IPv6:2a01:4f8:c17:6c4b::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E7D21F
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 08:06:58 -0800 (PST)
Received: from [10.36.2.145] (unknown [46.212.121.255])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mail.turbocat.net (Postfix) with ESMTPSA id 06BE126280F;
        Fri, 13 Jan 2023 17:06:56 +0100 (CET)
Message-ID: <a2e6fdc3-fbb0-821c-078f-1ad4e55dc8e3@selasky.org>
Date:   Fri, 13 Jan 2023 17:06:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Gitorious should use CRC128 / 256 / 512 instead of SHA-1
Content-Language: en-US
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     rsbecker@nexbridge.com, git@vger.kernel.org
References: <39dd1a00-786b-acf5-8a40-2425f7dab6cc@selasky.org>
 <20230113133059.snyjblh3sz2wzcnd@carbon>
 <446984f6-0d2e-04da-11a3-8b1481fac953@selasky.org>
 <009701d9275a$678416b0$368c4410$@nexbridge.com>
 <8a8fbe42-7809-f3e7-b233-6bef790254e1@selasky.org>
 <20230113154516.jxm2cer4sogatayp@meerkat.local>
 <d087568b-919e-61f8-c203-e59a2e0572c6@selasky.org>
 <20230113160218.d3nsoxpbrxrrszhz@meerkat.local>
From:   Hans Petter Selasky <hps@selasky.org>
In-Reply-To: <20230113160218.d3nsoxpbrxrrszhz@meerkat.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/13/23 17:02, Konstantin Ryabitsev wrote:
> On Fri, Jan 13, 2023 at 04:54:39PM +0100, Hans Petter Selasky wrote:
>> On 1/13/23 16:45, Konstantin Ryabitsev wrote:
>>>    If, for some reason, Linus ever needs to remove something
>>> from linux.git, he will do it and just give a heads-up why and for what
>>> reason.
>>
>> This gotta be a joke.
>>
>> There are 46K forks of Linus Torvalds Linux kernel on GitHUB, and if Linus
>> Torvalds one day decides to do a forced push, it will for sure be a
>> disaster!
> 
> No it won't, and I speak from some position of authority on this subject (I'm
> responsible for git.kernel.org).
> 
> If Linus has to alter the history of linux.git, it will for sure be an
> extraordinary event -- it's never happened yet.  However, it will be widely
> publicised, the reasons for it will be made clear, and everyone will just
> accept it and move on.
> 
> Git history edits occur all the time. Most tooling expects this to
> occasionally happen and deals with it correctly.
> 

OK, if you say so. Though in my mind 46K rebases of millions of commits 
seem a lot overhead.

However, if history can be edited anyway, why do you need the 
cryptographic hash algorithm. Why not use a non-cryptographic one?

What's the point? Only so that one party can stay in control?

--HPS

