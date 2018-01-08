Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE07A1FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 20:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755904AbeAHUd2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 15:33:28 -0500
Received: from mail-qk0-f170.google.com ([209.85.220.170]:41131 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755899AbeAHUd1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 15:33:27 -0500
Received: by mail-qk0-f170.google.com with SMTP id a8so15825644qkb.8
        for <git@vger.kernel.org>; Mon, 08 Jan 2018 12:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GT4vqJKZoN6VhsDe9nKMUQ/MMeD8OA0LaOfXpyRbNBk=;
        b=B8KW3AjiL6m+n2YITi7ffwREUVtIvwNj/gWKXRkhB92b+LZMyjTUTGbzc7HPWSYUt7
         t1i9J9xm7B2vzdkogSunYUF9T11E/gAvcRQqRfHxYmynRCpuXuU5uPFFCW10iNrlNx7G
         bEFZAgAwgj2TequW74erywGeT7W9MNO6M2yjWox8iO3CcoZgahQm8ypleoLrmXtTCEb+
         guzp5j+wR6pavqx7kHm20zhetJJHWq+1rQOkLSxdJd5DkwEiNXlqEmD9X8ku8ZodeZBR
         xs01W+4IdMsusUkcIhS0ChTZtn7ZSbl3CHeF4tta1fd3CIOZzn96VnulASlkojEVilUP
         0O2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GT4vqJKZoN6VhsDe9nKMUQ/MMeD8OA0LaOfXpyRbNBk=;
        b=haGgrwXNPerth8IeJ79Dq1a42FUCF6a2u9yRu4mGJ8yKr/ZWpQ/B62N99t8DT/ginY
         EurF6mD6kL50ARoC6Qddiyi9R6ZDPjQhVxFMnHgWIef1//jlQ7SURlP8srclyk9buR61
         BoT+MNeEbT5rLc/NhCQECJFZHay7gBPaHbONxqnLmWIRykh03RaU6umDAmEWeENZddZB
         0dIjuUnsi5U2STbOA1lnfgIC4MRM6XPx8DogbW5qvIq9R6CdbYZGuDjwBkzwnU/fEjiu
         pACGpzpJd7TbPGTd3x9mU4Wa8IFA9vHFgUrY9Nil7M/JqvhnEGPtPusjcQg5HYNfkKB8
         nr3A==
X-Gm-Message-State: AKwxytd89Jf01QLmMDOf32SDw4ohjpIiaYA+QzzQ1GDh5wf6e/06eSiy
        qyVgv+NdBoPC1pkHcjECenuuE9Kx
X-Google-Smtp-Source: ACJfBovKmCbactvxHjIb0Hs1D6pBrkYNGAZot8kViQZG9jR+SwFeJIPssRH9K4sJ0PGdcZvVnhqlOA==
X-Received: by 10.55.186.134 with SMTP id k128mr8515366qkf.23.1515443606360;
        Mon, 08 Jan 2018 12:33:26 -0800 (PST)
Received: from [192.168.1.105] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id m77sm8274605qke.76.2018.01.08.12.33.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jan 2018 12:33:25 -0800 (PST)
Subject: Re: [PATCH 4/6] fsmonitor: Make output of test-dump-fsmonitor more
 concise
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Alex Vandiver <alexmv@dropbox.com>
Cc:     git@vger.kernel.org
References: <20180103030456.8181-1-alexmv@dropbox.com>
 <36db77ccb5c025a73bf3f5841cd11607427ffdc0.1514948078.git.alexmv@dropbox.com>
 <alpine.DEB.2.21.1.1801042331590.32@MININT-6BKU6QN.europe.corp.microsoft.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <af33fb18-fd31-727b-efcc-b3873c6e58f1@gmail.com>
Date:   Mon, 8 Jan 2018 15:33:24 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1.1801042331590.32@MININT-6BKU6QN.europe.corp.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 1/4/2018 5:33 PM, Johannes Schindelin wrote:
> Hi Alex,
> 
> On Tue, 2 Jan 2018, Alex Vandiver wrote:
> 
>> Rather than display one very long line, summarize the contents of that
>> line.  The tests do not currently rely on any content except the first
>> line ("no fsmonitor" / "fsmonitor last update").
> 
> The more interesting part would be the entries with outdated ("invalid")
> information. I thought that this information was pretty useful for
> debugging. Maybe we could still keep at least that part, or at least
> trigger outputting it via a command-line flag?
> 

During the development and testing of fsmonitor, I found the '+-' to be 
helpful (especially since it is in index order).  I could touch a file 
and verify that it showed up as invalid and that it was the file I 
expected by its placement in the index.

I'd hate to have to add options to a test program for more/less output. 
I do like your additions of the time since updated and the final counts. 
  I prefer more information rather than less in my test tools - how 
about this?


diff --git a/t/helper/test-dump-fsmonitor.c b/t/helper/test-dump-fsmonitor.c
index 5d61b0d621..8503da288d 100644
--- a/t/helper/test-dump-fsmonitor.c
+++ b/t/helper/test-dump-fsmonitor.c
@@ -20,11 +20,13 @@ int cmd_main(int ac, const char **av)
                (uintmax_t)istate->fsmonitor_last_update,
                (now - istate->fsmonitor_last_update)/1.0e9);

-       for (i = 0; i < istate->cache_nr; i++)
+       for (i = 0; i < istate->cache_nr; i++) {
+               printf((istate->cache[i]->ce_flags & CE_FSMONITOR_VALID) 
? "+" : "-");
                 if (istate->cache[i]->ce_flags & CE_FSMONITOR_VALID)
                         valid++;
+       }

-       printf("  valid: %d\n", valid);
+       printf("\n  valid: %d\n", valid);
         printf("  invalid: %d\n", istate->cache_nr - valid);

         return 0;


> Ciao,
> Johannes
> 
