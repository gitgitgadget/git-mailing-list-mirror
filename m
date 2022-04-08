Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C38C433EF
	for <git@archiver.kernel.org>; Fri,  8 Apr 2022 08:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbiDHIGI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Apr 2022 04:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbiDHIGG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Apr 2022 04:06:06 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432EC25E87
        for <git@vger.kernel.org>; Fri,  8 Apr 2022 01:04:00 -0700 (PDT)
Received: from host-84-13-159-41.opaltelecom.net ([84.13.159.41] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1ncjb3-000BNM-8W;
        Fri, 08 Apr 2022 09:03:57 +0100
Message-ID: <9920b355-9003-e7c7-77ab-3432651674e9@iee.email>
Date:   Fri, 8 Apr 2022 09:03:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] blame: report correct number of lines in progress when
 using ranges
Content-Language: en-GB
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Edmundo Carmona Antoranz <eantoranz@gmail.com>,
        whydoubt@gmail.com, git@vger.kernel.org
References: <20220404182129.33992-1-eantoranz@gmail.com>
 <b2f5d6af-8da1-3a3a-cc21-848c14a8fb98@gmail.com>
 <8622e48c-9f34-c644-4016-02c3795ac1e9@iee.email> <xmqqsfqq1bx9.fsf@gitster.g>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <xmqqsfqq1bx9.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/04/2022 16:14, Junio C Hamano wrote:
> Philip Oakley <philipoakley@iee.email> writes:
>
>> On 05/04/2022 08:34, Bagas Sanjaya wrote:
>>> On 05/04/22 01.21, Edmundo Carmona Antoranz wrote:
>>>> When using ranges, use their sizes as the limit for progress
>>>> instead of the size of the full file.
>>> The progress limit is defined by number of affected lines, right?
>> I'd also wondered about 'their', thinking it was 'the files', rather
>> than 'the ranges' [within those files].
>>
>> perhaps: s/their/range/
> I actually think that it is obvious that "their" refers to the
> ranges and not the file.  Between "the ranges" and "the file", only
> the former is plural that "their" could possibly refer to.  Also,
> "instead ... the full file" makes the sentence nonsensical if it
> referred to the "file"---"we must use the number of lines in the
> file, instead of the number of lines in the file" simply would not
> make much sense.
I'm on the 'context and guidelines' side of English comprehension, so it
was all about files being blamed.

>
> But I do not object to being more explicit.

The core point though was that it can be misunderstood, thus avoiding
the indirection, as you say, makes it more explicit for the reader.
>
>> "When using ranges, use the range sizes as the limit for progress' ..
--
Philip
