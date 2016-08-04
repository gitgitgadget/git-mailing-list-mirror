Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 524EA20193
	for <e@80x24.org>; Thu,  4 Aug 2016 12:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933558AbcHDMhW (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 08:37:22 -0400
Received: from siwi.pair.com ([209.68.5.199]:37530 "EHLO siwi.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933388AbcHDMhV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 08:37:21 -0400
Received: from [10.160.15.137] (unknown [167.220.148.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by siwi.pair.com (Postfix) with ESMTPSA id 7799184682;
	Thu,  4 Aug 2016 08:37:20 -0400 (EDT)
Subject: Re: [PATCH v4 2/8] status: cleanup API to wt_status_print
To:	Junio C Hamano <gitster@pobox.com>
References: <1470147137-17498-1-git-send-email-git@jeffhostetler.com>
 <1470147137-17498-3-git-send-email-git@jeffhostetler.com>
 <xmqqr3a57cxm.fsf@gitster.mtv.corp.google.com>
Cc:	git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	Jeff Hostetler <jeffhost@microsoft.com>
From:	Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <57A33682.9080305@jeffhostetler.com>
Date:	Thu, 4 Aug 2016 08:35:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqr3a57cxm.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org



On 08/03/2016 05:36 PM, Junio C Hamano wrote:
> Jeff Hostetler <git@jeffhostetler.com> writes:
>
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>> diff --git a/wt-status.h b/wt-status.h
>> index 2023a3c..a859a12 100644
>> --- a/wt-status.h
>> +++ b/wt-status.h
>> @@ -43,6 +43,15 @@ struct wt_status_change_data {
>>   	unsigned new_submodule_commits : 1;
>>   };
>>
>> + enum wt_status_format {
>> +	STATUS_FORMAT_NONE = 0,
>> +	STATUS_FORMAT_LONG,
>> +	STATUS_FORMAT_SHORT,
>> +	STATUS_FORMAT_PORCELAIN,
>> +
>> +	STATUS_FORMAT_UNSPECIFIED
>> + };
>
> Is it your editor, or is it your MUA?  This definition is indented
> by one SP, which is funny.
>
> Also throughout the series, I saw a handful of blank lines that
> should be empty but are not (e.g. three tabs and nothing else on a
> new line).  I've fixed them up all but I won't be sending an
> interdiff just for them, so please make sure they won't resurface
> when/if you reroll.

That's odd.  I'll double check everything and trim
them in case I need to resubmit this.  Sorry.

Jeff
