Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F8D41F804
	for <e@80x24.org>; Fri, 28 Dec 2018 20:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbeL1UkE (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Dec 2018 15:40:04 -0500
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:49989 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbeL1UkE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Dec 2018 15:40:04 -0500
Received: from [192.168.1.12] ([92.29.14.72])
        by smtp.talktalk.net with SMTP
        id cynSgPGEYoI6LcynSgBtz3; Fri, 28 Dec 2018 20:31:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1546029115;
        bh=IDTb2cHdqxq27i1BTLDMea7yfPBTBuDgnMNRXCwQRMA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Af9mUdeDqTkwX6WFLaufvJhbhAVSYdSFtqczEcyZ2lbyJVqM5oAAWjA0wG7RjlvVT
         63+3+/XTmdB6InLf/69jfFp7tzacORJ8UJxMe5+36btLbvz/cgismD2+9UnIvnUt93
         zCXxXClG1yFw3dtfgwZJD3WW0oTG/dF9VOb6co+U=
X-Originating-IP: [92.29.14.72]
X-Spam: 0
X-OAuthority: v=2.3 cv=FOE1Odgs c=1 sm=1 tr=0 a=U7W/PrDwRYoztbkIcndy/g==:117
 a=U7W/PrDwRYoztbkIcndy/g==:17 a=IkcTkHD0fZMA:10 a=yMhMjlubAAAA:8
 a=te1EGT4yAAAA:8 a=sviUEeZ0coD7ITIN4C8A:9 a=QEXdDO2ut3YA:10 a=yL7vsIf3ifUA:10
 a=RRElR4r2U1jGY2dU47NL:22
Subject: Re: [PATCH 0/2] Improve documentation on UTF-16
To:     Johannes Sixt <j6t@kdbg.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
References: <20181227021734.528629-1-sandals@crustytoothpaste.net>
 <93f0a854-9b8d-500c-b015-59c50ecdb0f3@kdbg.org>
 <20181227164353.GC423984@genre.crustytoothpaste.net>
 <435b6870-379c-7183-da99-35aec5cf1137@kdbg.org>
 <20181227234535.GD423984@genre.crustytoothpaste.net>
 <34d4f912-2ec3-9dd1-f5fb-aad6a26e1464@kdbg.org>
From:   Philip Oakley <philipoakley@talktalk.net>
Message-ID: <feeb0176-5bd5-229d-0ebb-d10120748aca@talktalk.net>
Date:   Fri, 28 Dec 2018 20:31:56 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <34d4f912-2ec3-9dd1-f5fb-aad6a26e1464@kdbg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfJpL+QyZD9lttwZohEk7RVMlVgA7gBZD9HyWiScDoY4905++ltjqdc//JJaj0Ec9XQp+YFk0UK7CVn96YRPBJg4yarGPVrCJbcTZ/aS4SUP0S0POwlT3
 Y1UZfLqpOX3taHHDnL9h1DJuW+ECJf0t2ufeIEOw1avXxwhtW5krbwxGkGT/MKUeD7wn2JvXZdXZkOJ99+369XLk0oS1/a2HTiUbNNAbXrLDVLLdKmJ4zPQw
 SiDqTDdBBBX18pObVeOw18KxLwLX4fwcYZv9uy5LLIvXYrlYjFh0PtkabHt0LOSh
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28/12/2018 08:59, Johannes Sixt wrote:
> Am 28.12.18 um 00:45 schrieb brian m. carlson:
>> On Thu, Dec 27, 2018 at 08:55:27PM +0100, Johannes Sixt wrote:
>>> But why do you add another U+FEFF on the way to UTF-8? There is one 
>>> in the
>>> incoming UTF-16 data, and only *that* one must be converted. If 
>>> there is no
>>> U+FEFF in the UTF-16 data, the should not be one in UTF-8, either.
>>> Puzzled...
>>
>> So for UTF-16, there must be a BOM. For UTF-16LE and UTF-16BE, there
>> must not be a BOM. So if we do this:
>>
>>    $ printf '\xfe\xff\x00\x0a' | iconv -f UTF-16BE -t UTF-16 | xxd -g1
>>    00000000: ff fe ff fe 0a 00 ......
>
> What sort of braindamage is this? Fix iconv.
>
> But as I said, I'm not an expert. I just vented my worries that 
> widespread existing practice would be ignored under the excuse "you 
> are the outlier".
>
> -- Hannes

For ref, I dug out a Microsoft document [1] on its view of BOMs which 
can be compared to the ref [0] Brian gave

[1] 
https://docs.microsoft.com/en-us/windows/desktop/intl/using-byte-order-marks

[0] https://unicode.org/faq/utf_bom.html#bom9

Maybe the documentation patch ([PATCH 1/2] Documentation: document 
UTF-16-related behavior) should include the line ", because we encode 
into UTF-8 internally,", and a link to ref [0], and maybe [1]


Whether the various Windows programs actually follow the Microsoft 
convention is another matter altogether .

-- 

Philip


