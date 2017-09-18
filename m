Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B4CE2047F
	for <e@80x24.org>; Mon, 18 Sep 2017 13:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753014AbdIRN1k (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Sep 2017 09:27:40 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:32847 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752377AbdIRN1j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2017 09:27:39 -0400
Received: by mail-qt0-f196.google.com with SMTP id b1so328130qtc.0
        for <git@vger.kernel.org>; Mon, 18 Sep 2017 06:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pdwKFGRMho8fschxYxSEAZahgvmJ8JckEEbi/lZjOhw=;
        b=J4gOjrpMVUfCml0l9NA/Efc78iwA3AloCizuHrQR7fxO9Y6cpi537ysByUJCJNcWHu
         OatKwlOI64oA3HHtBLgl7uJLwC4pGjCH+psvqmYi/tDWrFPrdEf8SxccMwOlnO1z7t3X
         bD21rz61ZSwm2PYcnsOp7MxxFS9tF836Ifo67fzHHFqmVtCD+koIGFGij0pMeqpuMS2+
         enNClN1OW1uL20hU7TX2N31aor+OvgzMUQfFltce6f1kz2HECxrmbhomyTsfKwfAjb/a
         RSIPSqlhPnAYRNrXiXKoCjre6U2UhEaZZ4aiiRQe7qZG8xEWBXhibkuCjVzgnRwB8Zu2
         Gyrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pdwKFGRMho8fschxYxSEAZahgvmJ8JckEEbi/lZjOhw=;
        b=t+8I47ufMhTh7mr5gIpznnKNcp+t90e0YxtAbVADjuOUFRtwI7B9Af3LZPTPFuOnJ9
         K9D2jE3EY1CYXgcD1v30m+a2nRSHYqEUOyxfeUk9wHNSQ81Liltt/mBmfEDjQtDvkP4t
         tVXG/4O1LDfI4c33ca0ukGd57Wy+7BgCzXLdodexnXrlJNIz1kvWcrL2y3rdyXZQnDHN
         E4rgeVbh9qSmOGK0tx5ItLfAKrcAaqs6wf/50Jipe7MgqPa7U5Kn+yykofwA33rjO0El
         xe8pb1V7hXcxNdfPgj3IeyyK7G3452q/E6OoCeHHCE4kfIqz8OCCpfwc3s4gl/DkxL8e
         1Pxg==
X-Gm-Message-State: AHPjjUgBpm/LVg5mVW72/h77+F9HF/sM+KlexTzT2NIzrfc5sl7AKWu/
        lu9S90B02OATSQ==
X-Google-Smtp-Source: AOwi7QBs7Ew4oV0Kl2QzLM/5DWpivBGvAH2+BJgFGeKFPwMGqqFboRau2zO/7MpZJiraDhiNpY/aSA==
X-Received: by 10.200.24.187 with SMTP id s56mr33287453qtj.64.1505741258651;
        Mon, 18 Sep 2017 06:27:38 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id b26sm5167507qkj.64.2017.09.18.06.27.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Sep 2017 06:27:37 -0700 (PDT)
Subject: Re: [PATCH v6 05/12] fsmonitor: add documentation for the fsmonitor
 extension.
To:     David Turner <David.Turner@twosigma.com>,
        'Ben Peart' <benpeart@microsoft.com>
Cc:     "avarab@gmail.com" <avarab@gmail.com>,
        "christian.couder@gmail.com" <christian.couder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "johannes.schindelin@gmx.de" <johannes.schindelin@gmx.de>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "peff@peff.net" <peff@peff.net>
References: <20170610134026.104552-1-benpeart@microsoft.com>
 <20170915192043.4516-1-benpeart@microsoft.com>
 <20170915192043.4516-6-benpeart@microsoft.com>
 <297da9019d8c44faa89434d699623408@exmbdft7.ad.twosigma.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <532a74ca-804d-93f3-9eef-ceffc9f49623@gmail.com>
Date:   Mon, 18 Sep 2017 09:27:35 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <297da9019d8c44faa89434d699623408@exmbdft7.ad.twosigma.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/15/2017 3:43 PM, David Turner wrote:
> 
> 
>> -----Original Message-----
>> From: Ben Peart [mailto:benpeart@microsoft.com]
>> Sent: Friday, September 15, 2017 3:21 PM
>> To: benpeart@microsoft.com
>> Cc: David Turner <David.Turner@twosigma.com>; avarab@gmail.com;
>> christian.couder@gmail.com; git@vger.kernel.org; gitster@pobox.com;
>> johannes.schindelin@gmx.de; pclouds@gmail.com; peff@peff.net
>> Subject: [PATCH v6 05/12] fsmonitor: add documentation for the fsmonitor
>> extension.
>>
>> This includes the core.fsmonitor setting, the query-fsmonitor hook, and the
>> fsmonitor index extension.
>>
>> Signed-off-by: Ben Peart <benpeart@microsoft.com>
>> ---
>>   Documentation/config.txt                 |  6 ++++++
>>   Documentation/githooks.txt               | 23 +++++++++++++++++++++++
>>   Documentation/technical/index-format.txt | 19 +++++++++++++++++++
>>   3 files changed, 48 insertions(+)
>>
>> diff --git a/Documentation/config.txt b/Documentation/config.txt index
>> dc4e3f58a2..c196007a27 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -413,6 +413,12 @@ core.protectNTFS::
>>   	8.3 "short" names.
>>   	Defaults to `true` on Windows, and `false` elsewhere.
>>
>> +core.fsmonitor::
>> +	If set, the value of this variable is used as a command which
>> +	will identify all files that may have changed since the
>> +	requested date/time. This information is used to speed up git by
>> +	avoiding unnecessary processing of files that have not changed.
> 
> I'm confused here.  You have a file called "fsmonitor-watchman", which seems to discuss the protocol for core.fsmonitor scripts in general, and you have this documentation, which does not link to that file.  Can you clarify this?

I'll add the missing link to the documentation in githooks.txt.  The 
documentation should be enough for someone to develop another 
integration script.

The fsmonitor-watchman script allows people to easily use this patch 
series with the existing Watchman monitor but it can certainly also be 
used as a sample for how to integrate with another file system monitor.

> 
> <snip>
> 
>> +The hook should output to stdout the list of all files in the working
>> +directory that may have changed since the requested time.  The logic
>> +should be inclusive so that it does not miss any potential changes.
> 
> +"It is OK to include files which have not actually changed.  Newly-created and deleted files should also be included.  When files are renamed, both the old and the new name should be included."
> 
> Also, please discuss case sensitivity issues (e.g. on OS X).
> 
>> +The paths should be relative to the root of the working directory and
>> +be separated by a single NUL.
> 
> <snip>
> 
>> +  - 32-bit version number: the current supported version is 1.
>> +
>> +  - 64-bit time: the extension data reflects all changes through the given
>> +	time which is stored as the nanoseconds elapsed since midnight,
>> +	January 1, 1970.
> 
> Nit: Please specify signed or unsigned for these.  (I expect to be getting out of
> cryosleep around 2262, and I want to know if my old git repos will keep working...)
> 

While I'm not opposed to specifying unsigned, I did notice that the only 
place signed/unsigned is specified today is in "index entry." Everywhere 
else doesn't specify so I left it off for consistency.  I've not seen 
negative version numbers nor negative time so am not entirely sure it is 
necessary to clarify. :)

>> +  - 32-bit bitmap size: the size of the CE_FSMONITOR_VALID bitmap.
>> +
>> +  - An ewah bitmap, the n-th bit indicates whether the n-th index entry
>> +    is not CE_FSMONITOR_VALID.
> 
