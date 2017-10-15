Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B22B20372
	for <e@80x24.org>; Sun, 15 Oct 2017 15:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751386AbdJOPrA (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Oct 2017 11:47:00 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:44736 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751258AbdJOPq7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Oct 2017 11:46:59 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 3yFQmx1gRtz1qsh0;
        Sun, 15 Oct 2017 17:46:57 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 3yFQmx150cz1qqkV;
        Sun, 15 Oct 2017 17:46:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id QoXckXnrGMyK; Sun, 15 Oct 2017 17:46:56 +0200 (CEST)
X-Auth-Info: 6k3FlA7zm/CE9QEnbLQsVFAlu9XycWe2GqnvygkEu/Yf5cMbMVD4GXp0oC/GbI1q
Received: from igel.home (ppp-188-174-154-33.dynamic.mnet-online.de [188.174.154.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sun, 15 Oct 2017 17:46:56 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id CA99B2C2D6F; Sun, 15 Oct 2017 17:46:55 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     "Jason Pyeron" <jpyeron@pdinc.us>
Cc:     "'Joris Valette'" <joris.valette@gmail.com>, <git@vger.kernel.org>
Subject: Re: Consider escaping special characters like 'less' does
References: <CA+o7MD8bhXWxy2M7z++jrq+k85SwzdEV6uwnUjV9=0_X99=VJg@mail.gmail.com>
        <773EDE3B5FDB48AD8FB0DB048CAEC8DE@blackfat>
X-Yow:  I want to kill everyone here with a cute colorful Hydrogen Bomb!!
Date:   Sun, 15 Oct 2017 17:46:55 +0200
In-Reply-To: <773EDE3B5FDB48AD8FB0DB048CAEC8DE@blackfat> (Jason Pyeron's
        message of "Sun, 15 Oct 2017 10:15:52 -0400")
Message-ID: <87zi8sxvkg.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Okt 15 2017, "Jason Pyeron" <jpyeron@pdinc.us> wrote:

>> -----Original Message-----
>> From: Joris Valette
>> Sent: Sunday, October 15, 2017 9:34 AM
>> To: git@vger.kernel.org
>> Subject: Consider escaping special characters like 'less' does
>> 
>> The pager 'less' escapes some characters when calling 'git diff'. This
>> is what I might get:
>> 
>> $ git diff --cached
>> diff --git a/some_file b/some_file
>> new file mode 100644
>> index 0000000..357323f
>> --- /dev/null
>> +++ b/some_file
>> @@ -0,0 +1 @@
>> +<U+FEFF>Hello
>> \ No newline at end of file
>> 
>> This example is a simple file encoded in UTF-8 *with BOM*.
>> On the other hand, the built-in git output shows this:
>> 
>> $ git --no-pager diff --cached
>> diff --git a/some_file b/some_file
>> new file mode 100644
>> index 0000000..357323f
>> --- /dev/null
>> +++ b/some_file
>> @@ -0,0 +1 @@
>> +?Hello
>> \ No newline at end of file
>
> It is your terminal, not git's fault that you get a ? rendered.

It's your MUA's fault that you get a ?, the mail didn't contain any.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
