Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E06931F516
	for <e@80x24.org>; Thu, 28 Jun 2018 11:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933703AbeF1LmR (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 07:42:17 -0400
Received: from smtprelay08.ispgateway.de ([134.119.228.107]:39987 "EHLO
        smtprelay08.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932118AbeF1LmP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 07:42:15 -0400
X-Greylist: delayed 355 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Jun 2018 07:42:15 EDT
Received: from [91.113.179.170] (helo=[192.168.92.26])
        by smtprelay08.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <marc.strapetz@syntevo.com>)
        id 1fYVDl-0007xH-7w; Thu, 28 Jun 2018 13:36:17 +0200
Subject: Re: [PATCH v3] Documentation: declare "core.ignorecase" as internal
 variable
To:     Junio C Hamano <gitster@pobox.com>
References: <7f6b2a42-334d-9443-7b89-625069931ca7@syntevo.com>
 <c899089d-c195-26b5-66ce-de0273a7152b@syntevo.com>
 <xmqqzhzgdoyb.fsf@gitster-ct.c.googlers.com>
From:   Marc Strapetz <marc.strapetz@syntevo.com>
Cc:     aaron@schrab.com, git@vger.kernel.org
Message-ID: <8f01e60e-2f4f-49dd-277a-845363554fa9@syntevo.com>
Date:   Thu, 28 Jun 2018 13:36:22 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqzhzgdoyb.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Df-Sender: bWFyYy5zdHJhcGV0ekBzeW50ZXZvLmNvbQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27.06.2018 21:11, Junio C Hamano wrote:
> Marc Strapetz <marc.strapetz@syntevo.com> writes:
> 
>> [1. text/plain]
>> The current description of "core.ignoreCase" reads like an option which
>> is intended to be changed by the user while it's actually expected to
>> be set by Git on initialization only. Subsequently, Git relies on the
>> proper configuration of this variable, as noted by Bryan Turner [1]:
>>
>>      Git on a case-insensitive filesystem (APFS, HFS+, FAT32, exFAT,
>>      vFAT, NTFS, etc.) is not designed to be run with anything other
>>      than core.ignoreCase=true.
>>
>> [1] https://marc.info/?l=git&m=152998665813997&w=2
>>      mid:CAGyf7-GeE8jRGPkME9rHKPtHEQ6P1+ebpMMWAtMh01uO3bfy8w@mail.gmail.com
>>
>> Signed-off-by: Marc Strapetz <marc.strapetz@syntevo.com>
>> ---
>>   Documentation/config.txt | 9 ++++++---
>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>
> 
> Hmph.  Do other people have difficulty applying this patch to their
> trees?  It is just several lines long so I could retype it myself,
> but I guess "Content-Type: text/plain; charset=utf-8; format=flowed"
> has destroyed formatting of the patch rather badly.

I had copy-pasted the patch into Thunderbird. The received email was 
looking fine in the inbox, however it seems that some leading 
whitespaces have been added to several lines (when comparing raw 
contents of v3 and v4). I have resent the patch with git send-email now.

-Marc
