Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10ED6C433F5
	for <git@archiver.kernel.org>; Mon, 23 May 2022 11:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234532AbiEWLKJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 07:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234522AbiEWLKH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 07:10:07 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975023FBD2
        for <git@vger.kernel.org>; Mon, 23 May 2022 04:10:05 -0700 (PDT)
Received: from [185.69.145.122] (helo=[192.168.43.68])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1nt5wp-0009Tx-4P;
        Mon, 23 May 2022 12:10:03 +0100
Message-ID: <3067d8e3-15a7-75fc-20d7-90de0fc3fee6@iee.email>
Date:   Mon, 23 May 2022 12:10:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Git commands version documentation
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Hrushikesh Rao <hrushikesh20thegreat@gmail.com>,
        git@vger.kernel.org
References: <ccb312dc-c2cc-ca3a-e659-0f87ceec0d15@gmail.com>
 <f3814646-4763-62e1-b64e-d1aab3fdbbc8@iee.email> <xmqqr14l87jp.fsf@gitster.g>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <xmqqr14l87jp.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 23/05/2022 00:35, Junio C Hamano wrote:
> Philip Oakley <philipoakley@iee.email> writes:
>
>> One manual method is to look at the history (blame) for the respective
>> man pages to see when the man page was initially committed, and when
>> appropriate options were added.
>>
>> Maybe use one of the hosting providers GUI if that is your choice e.g.
>> https://github.com/git/git/blame/master/Documentation/git-gc.txt
> I got an impression that blame/log is an overkill for the request,
> which asks for "what tagged version?", to which the answer would be
> to compare the manual pages for each release (or scan the release
> notes), perhaps?
>
>

I was also concerned as to which way the problem was being addressed: 
was it a need for a cross reference table for all commands, or was it 
for just a select few?

For me, who likes a good UI, I found the GitHub blame UI quite useful 
when looking at files from the latter direction. It was much easier to 
scan the blame for the command's documentation page than try and scan 
through the endless release notes. Obviously this does expect that our 
documentation is fairly complete, at least at the 'mention an option' 
level, even if the occasional nuance didn't reach the docs.


I can see that a cli terminal representation is likely to be harder to 
scan, and that some hosters don't provide a blame page, so it would be a 
'horses for courses' choice.

Philip
