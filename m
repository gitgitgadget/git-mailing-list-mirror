Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F7D42023D
	for <e@80x24.org>; Mon, 22 May 2017 16:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757277AbdEVQSX (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 12:18:23 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:35139 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750928AbdEVQSV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 12:18:21 -0400
Received: by mail-qt0-f196.google.com with SMTP id r58so18743819qtb.2
        for <git@vger.kernel.org>; Mon, 22 May 2017 09:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=4YpXIBDXyN9Woad/QW8HVmIe5Ge/dhxXSNYc44uA+ug=;
        b=ZeRsXfAeBOm9BqENtMAh9tUeumQA+UIMMqm/LTxNPabz3MySh4tu6oqUMwGAYK58+N
         nTlO7pzRtaozLkl/2e7kTMxzcpKtblfDN1qRNIVIM0hox1TOiUKig3XEo+Ud1bNrV0PH
         RA3CEomI1T3nwJGJUhI2jQ1pXPQEcxiIrDj9m5u/kZieNjKjPusoXFTbu6GeUiaA/yiu
         V1ff5c2ymLEZqKKkYT/Pbh2pJY/EpmJCqSIW2LDCmUzk5lSsFApS8RX3XRxM6MYEEa2J
         OBYN1MclF3P0ctccj/0zQ15BTuhimVx5cMk3fa8elBfR2dXojgaCoC/bhb4nWOA3l6oT
         RSnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=4YpXIBDXyN9Woad/QW8HVmIe5Ge/dhxXSNYc44uA+ug=;
        b=Lhb4fXBcqWb8aRTD0o4/vsupyb6y8a2O3Yxknha9TjZ+jYBIm0/vTWDSsBYGgzKUla
         e3RBQAw1sDXdAKH6pGrHBt6NQCn0k5TQHXHopopQBjr3WPaTKxOJ4ZLrxc4j1itxYrf4
         EcdZ/NGeeyTqIRavJ5bLR3IdDmEVcRzzbr8mUrUqi9EV6ld7mcdAwEpB5V4j0yYMDnLI
         0Rs8SPv4zKwnAsIj2QSqd7EMDWG5rSMQ3pqFK+LJJud1KcBLFmQPlujWBYtoKOYwqexb
         MWznyScigSuPfOTFFZaoTrRHcgFXdUQU/Z3Ln5a91d15GhCpPezrHbCaoXIkZ/P8rpf8
         QDiA==
X-Gm-Message-State: AODbwcDkwruZQIpjdWV+RpjANPqclCPkAIflUFH0V/jCcuDc7KGHkPk9
        +3VIGLJhjDiy2g==
X-Received: by 10.200.41.165 with SMTP id 34mr24068357qts.243.1495469900857;
        Mon, 22 May 2017 09:18:20 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id n189sm12080609qke.45.2017.05.22.09.18.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 May 2017 09:18:20 -0700 (PDT)
Subject: Re: [PATCH v2 5/6] fsmonitor: add documentation for the fsmonitor
 extension.
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20170518201333.13088-1-benpeart@microsoft.com>
 <20170518201333.13088-6-benpeart@microsoft.com>
 <CACBZZX5URAeA+=12ezW-oDGnkdAqvQqV7it=HBaYCKUdx0p_XA@mail.gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, benpeart@microsoft.com,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        David.Turner@twosigma.com, Jeff King <peff@peff.net>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <5ab333a4-c3cd-1cb5-ba3e-6b08fa14c9e7@gmail.com>
Date:   Mon, 22 May 2017 12:18:20 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CACBZZX5URAeA+=12ezW-oDGnkdAqvQqV7it=HBaYCKUdx0p_XA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/20/2017 8:10 AM, Ævar Arnfjörð Bjarmason wrote:
>> +== File System Monitor cache
>> +
>> +  The file system monitor cache tracks files for which the query-fsmonitor
>> +  hook has told us about changes.  The signature for this extension is
>> +  { 'F', 'S', 'M', 'N' }.
>> +
>> +  The extension starts with
>> +
>> +  - 32-bit version number: the current supported version is 1.
>> +
>> +  - 64-bit time: the extension data reflects all changes through the given
>> +       time which is stored as the seconds elapsed since midnight, January 1, 1970.
>> +
>> +  - 32-bit bitmap size: the size of the CE_FSMONITOR_DIRTY bitmap.
>> +
>> +  - An ewah bitmap, the n-th bit indicates whether the n-th index entry
>> +    is CE_FSMONITOR_DIRTY.
>
> We already have a uint64_t in one place in the codebase (getnanotime)
> which uses a 64 bit time for nanosecond accuracy, and numerous
> filesystems already support nanosecond timestamps (ext4, that new
> Apple thingy...).
>
> I don't know if any of the inotify/fsmonitor APIs support that yet,
> but it seems inevitable that that'll be added if not, in some
> pathological cases we can have a lot of files modified in 1 second, so
> using nanosecond accuracy means there'll be a lot less data to
> consider in some cases.
>
> It does mean this'll only work until the year ~2500, but that seems
> like an acceptable trade-off.
>

I really don't think nano-second resolution is needed in this case for a 
few reasons.

The number of files that can change within a given second is limited by 
the IO throughput of the underlying device. Even assuming a very fast 
device and very small files and changes, this won't be that many files.

Without this patch, git would have scanned all those files every time. 
With this patch, git will only scan those files a 2nd time that are 
modified in the same second that it did the first scan *that came before 
the first scan started* (the "lots of files modified" section in the 1 
second timeline below).

|------------------------- one second ---------------------|
|-lots of files modified - git status - more file modified-|

Yes, some duplicate status checks can be made but its still a 
significant win in any reasonable scenario. Especially when you consider 
that it is pretty unusual to do git status/add/commit calls in the 
middle of making lots of changes to files.

In addition, the backing file system monitor (Watchman) supports number 
of seconds since the unix epoch (unix time_t style).  This means any 
support of nano seconds by git is academic until someone provides a file 
system watcher that does support nano second granularity.

Finally, the fsmonitor index extension is versioned so that we can 
seamlessly upgrade to nano second resolution later if we desire.
