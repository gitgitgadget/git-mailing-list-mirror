Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D04C433F5
	for <git@archiver.kernel.org>; Sat, 18 Dec 2021 01:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbhLRBG7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 20:06:59 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:34516 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229502AbhLRBG6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 20:06:58 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1639789618; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=PkPNXvRSbpL2hlIf9Ga+dpz0OgE4lYhaev+QqVBM0Y8=;
 b=HHrm+s/WrbEqWRtkaVSDDm/Znv3i+9fetqYgKDzb2Wp0zK8KWWmg+mY0Y44UeYK6t3rOaG0b
 9QmsXbrD8poybWsk+VejHCyK9uE6tfd33Q5RVJd6rCtyCu9eOQD6t6eKFDT3ideLIJvnIMK8
 yrdU7J1yCPzDRTOqzvwMNrnAUOs=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyJjNzk3NCIsICJnaXRAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 61bd343286d0e4d88845fc82 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 18 Dec 2021 01:06:58
 GMT
Sender: mfick=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3F192C4360D; Sat, 18 Dec 2021 01:06:57 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mfick)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 66F5EC4338F;
        Sat, 18 Dec 2021 01:06:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 17 Dec 2021 18:06:56 -0700
From:   Martin Fick <mfick@codeaurora.org>
To:     =?UTF-8?Q?Jo=C3=A3o_Victor_Bonfim?= 
        <JoaoVictorBonfim@protonmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Fw: Curiosity
In-Reply-To: <1X3gQ48NK5aBDHcpYMlxESRjqubcCBKJUQu2K0dBOnTyvsXCXXoGDBg2Ff4KarK6WsZnzN3HgqHGOlCKKdF-wtZQ5tHsoAcfit2CTXMWqh4=@protonmail.com>
References: <Wlh_w2gSCDQ2ieJnIY7TStWrzxbwP98SNRIFMTYpva7SRFipqk63HEYFVF7wFn1oSHOkQNsjWGOa5L49vyRlvSLbuZqpmvOaDOHmFkdt2zw=@protonmail.com>
 <wVwq9WVLpVt7MNLmIYOWCFKVSf8l532MD_vu4yTA8hl1fCARnW8nOUJjxYmKSzFw1SnPp5iYRD-aW4gAT2HnyQbC5aLBOvyT6npn88lxwNQ=@protonmail.com>
 <xmqq8rwl91yf.fsf@gitster.g> <YbqiQ1B9ezF/RPOn@camp.crustytoothpaste.net>
 <xndBIO9EtrXaA932eF-0YkvHCAOL1GOKQQlIigssmcwhtZWqGxhc6I_A-lXt7vMK-j1oDrQMHUIuExlpqFS4v88nWci32qx3W5Xi1_hPpUM=@protonmail.com>
 <54fe7ba20109f974b61a7e6c24ba8264@codeaurora.org>
 <1X3gQ48NK5aBDHcpYMlxESRjqubcCBKJUQu2K0dBOnTyvsXCXXoGDBg2Ff4KarK6WsZnzN3HgqHGOlCKKdF-wtZQ5tHsoAcfit2CTXMWqh4=@protonmail.com>
Message-ID: <df4a5ac37e8d703fa54af91269a9a736@codeaurora.org>
X-Sender: mfick@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-12-17 17:15, João Victor Bonfim wrote:
>> I suspect that for most algorithms and their implementations, this 
>> would
>> 
>> not result in repeatable "recompressed" results. Thus the checked-out
>> 
>> files might be different every time you checked them out. :(
> 
> How or why?
> 

Here are some reasons I can think of (I am no expert):

1) Most compression formats are file formats, not exact algorithms, thus 
different program implementations of similar algorithms can create 
vastly different outputs.

2) The same program will evolve over time, get improvements, bug fixes, 
etc. so each version of the same program could vary over time even with 
the same settings. The same program version on different platforms could 
have different output.

3) Settings, compression programs have compression levels, perhaps 
memory utilization parameters... The way the program measures these may 
not be deterministic and non-repeatable.

4) Threading. Some compressions algorithms, such as git repack itself, 
can use several threads to analyze the input data. And since the timing 
between different threads is not deterministic, when cooperating, they 
can have different results.

Much of this has to do with the idea that there is usually no such thing 
as "done" when it comes to compression. You can probably search 
infinitely to try and find more data patterns to compress the data more. 
Thus compression programs have to have limits based on heuristics (how 
far to look ahead/behind, how many patterns to remember...) programmed 
into them to come to an end somehow. How these limits are determined can 
sometimes be non deterministic, it may even involve system resources 
(how much RAM the machine has, how long it has run...) or system config.

I hope that helps,

-Martin


> ‐‐‐‐‐‐‐ Original Message ‐‐‐‐‐‐‐
> 
> Em quinta-feira, 16 de dezembro de 2021 às 18:33, Martin Fick
> <mfick@codeaurora.org> escreveu:
> 
>> On 2021-12-16 14:20, João Victor Bonfim wrote:
>> 
>> > > To expand on this, if what you're storing is already compressed, like
>> > >
>> > > Ogg Vorbis files or PNGs, like are found in that repository, then
>> > >
>> > > generally they will not delta well. This is also true of things like
>> > >
>> > > Microsoft Office or OpenOffice documents, because they're essentially
>> > >
>> > > Zip files.
>> > >
>> > > The delta algorithm looks for similarities between files to compress
>> > >
>> > > them. If a file is already compressed using something like Deflate,
>> > >
>> > > used in PNGs and Zip files, then even very similar files will
>> > >
>> > > generally
>> > >
>> > > look very different, so deltification will generally be ineffective.
>> 
>> ...
>> 
>> > Maybe I am thinking too outside the box, but wouldn't it be quite more
>> >
>> > effective for git to identify compressed files, specially on edge cases
>> >
>> > where the compression doesn't have a good chemistry with delta
>> >
>> > compression,
>> >
>> > decompress them for repo storage while also storing the compression
>> >
>> > algorithm as some metadata tag (like a text string or an ID code
>> >
>> > decided
>> >
>> > beforehand), and, when creating the work mirrors, return the
>> >
>> > compression
>> >
>> > to its default state before checkout?
>> 
>> I suspect that for most algorithms and their implementations, this 
>> would
>> 
>> not result in repeatable "recompressed" results. Thus the checked-out
>> 
>> files might be different every time you checked them out. :(
>> 
>> -Martin
>> 
>> -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
>> 
>> The Qualcomm Innovation Center, Inc. is a member of Code
>> 
>> Aurora Forum, hosted by The Linux Foundation

-- 
The Qualcomm Innovation Center, Inc. is a member of Code
Aurora Forum, hosted by The Linux Foundation
