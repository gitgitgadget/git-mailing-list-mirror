Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D784F207D6
	for <e@80x24.org>; Mon, 24 Apr 2017 21:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S978265AbdDXVlh (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 17:41:37 -0400
Received: from mout.web.de ([212.227.17.11]:64896 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S978144AbdDXVlg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 17:41:36 -0400
Received: from [192.168.178.36] ([79.213.114.92]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MI63m-1cyvys1NVu-003z4K; Mon, 24
 Apr 2017 23:41:32 +0200
Subject: Re: [PATCH v3 4/5] archive-zip: support archives bigger than 4GB
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Peter Krefting <peter@softwolves.pp.se>, git@vger.kernel.org,
        Keith Goldfarb <keith@blackthorn-media.com>
References: <37eb7c14-eb61-7a63-bdf0-ee1ccf40723f@kdbg.org>
 <alpine.DEB.2.11.1704222341300.22361@perkele.intern.softwolves.pp.se>
 <a1504d15-36d6-51f8-f2c9-a6563789bb6f@kdbg.org>
 <alpine.DEB.2.11.1704231526450.3944@perkele.intern.softwolves.pp.se>
 <e0d1c923-a9f5-9ffc-a7e7-67f558e50796@kdbg.org>
 <alpine.DEB.2.00.1704240901520.31537@ds9.cixit.se>
 <b3f2f12c-2736-46ed-62c9-16334c5e3483@web.de>
 <85f2b6d1-107b-0624-af82-92446f28269e@web.de>
 <02ddca3c-a11f-7c0c-947e-5ca87a62cdee@web.de>
 <alpine.DEB.2.11.1704241912510.30460@perkele.intern.softwolves.pp.se>
 <d453610f-dbd5-3f6c-d386-69a74c238b11@web.de>
 <13bc4fd9-984d-8b37-a18a-c7d273fbba36@kdbg.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <5dcbd1a6-056b-9a81-746d-329d5dafad3b@web.de>
Date:   Mon, 24 Apr 2017 23:41:31 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0.1
MIME-Version: 1.0
In-Reply-To: <13bc4fd9-984d-8b37-a18a-c7d273fbba36@kdbg.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:uZx2hlBVYRG2QIEggqSVceTAJe0W8sANNnYDO58s2gmgHC26sUV
 +wqyn3SMIv3cYl5xaJLJZOfJRh6XFWMwqdCjcfzC+2KaC0cm8vKdS5cxtZaPSaesFzeyuAo
 2BTP8EzbqW7nniKMuWMK+xJCbhyJvZgDRsU20IjKnFq1UfLK3FMp0lZKSNT5/FaQwkyln2H
 wHesEMS7trTcp5ugmVsng==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Zrp4M9I+KjY=:nN/sqAPUDeUeHMgSYGvuC2
 RLhx3HCqW13Sp+Zrvpqpf+otIKr8pKgdoz/pUUvP5nGHHaeTwCrxv5t6az7j6KLCHretIYYkL
 cj7breIqvDBZaS2k3nbSLPT6BEnhEu6gb4bVgdMHnwsEfM/E9vfMdyMZLieeyhn65sV3maJ+I
 bCvVEIdpfP3lZwEw38DNsmTKFti3jflqSTwe+xjLvNDNBNUusiC2Swp9sLr3tQ3Bf5dAtSrl9
 y8GJUItdYSsAyzIsQm+wU+EXeGphuimIAfpvnSD3FlGmavqkFxIpQ4+GxpksIow5CwqkrKt4O
 P066NYY1ZzhU/0nI7P4dM4hoVZ5gkY3QaKZKKXISfA3exW+RiDvm2+1PtJM0MnOPJLG4HpFZP
 bVGXEuD95fF+LKjVHP3PjB79EUEb1amgmfZQP7Innpu9BJnFRUcNpfw8R8J/QKt4sz5GySdgz
 +EkF8840lHU/F75j4lV0kTMeZfivkSLHTQ4Asom7ii0010jrypq6+irm+Tj07G7UAy5BjTXTh
 TaJoc6oUWdmJMrIBWN8LojM4T+Cd5+CPoO8ALld3VUi311B67WfDbFmN0KiUPTBmN2wyhHSSE
 gcFivLd6v/xZgdVmhUMeXjcJKoWy9AL1WjNATuuJIFTca1kOGHF5P6D++bFW/TsEP+dcRUqhN
 o+Dw9fdm8Bw5MEj2csKIh0znujIvyMutGcJy87lC+YfhgGZ7cmIz4SHv8/9UPOwqbW9tRW6fn
 d6iuAagCC95G8AkTiRh7g14r+QSKdUVoWXGukOlrQ2c0gE1SvcCwihvLNIiW5ysYXnV4bMDCO
 Qnw1CBs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.04.2017 um 23:02 schrieb Johannes Sixt:
> Am 24.04.2017 um 22:06 schrieb René Scharfe:
>> Am 24.04.2017 um 20:24 schrieb Peter Krefting:
>>> René Scharfe:
>>>
>>>> @@ -433,6 +446,11 @@ static int write_zip_entry(struct archiver_args
>>>> *args,
>>>>     free(deflated);
>>>>     free(buffer);
>>>>
>>>> +    if (offset > 0xffffffff) {
>>>> +        zip64_dir_extra_payload_size += 8;
>>>> +        zip_dir_extra_size += 2 + 2 + zip64_dir_extra_payload_size;
>>>> +    }
>>>> +
>>>>     strbuf_add_le(&zip_dir, 4, 0x02014b50);    /* magic */
>>>>     strbuf_add_le(&zip_dir, 2, creator_version);
>>>>     strbuf_add_le(&zip_dir, 2, 10);        /* version */
>>>
>>> This needs to be >=. The spec says that if the value is 0xffffffff,
>>> there should be a zip64 record with the actual size (even if it is
>>> 0xffffffff).
>>
>> Could you please cite the relevant part?
>>
>> Here's how I read it: If a value doesn't fit into a 32-bit field it is
>> set to 0xffffffff, a zip64 extra is added and a 64-bit field stores the
>> actual value.  The magic value 0xffffffff indicates that a corresponding
>> 64-bit field is present in the zip64 extra.  That means even if a value
>> is 0xffffffff (and thus fits) we need to add it to the zip64 extra.  If
>> there is no zip64 extra then we can store 0xffffffff in the 32-bit
>> field, though.
> 
> The reader I wrote recently interprets 0xffffffff as special if the 
> version is 45. Then, if there is no zip64 extra record, it is a broken 
> ZIP archive. You are saying that my reader is wrong in this special case...

The "version needed to extract" field is not particularly well-suited
for feature detection.  If you e.g. compress with LZMA then it should be
set to 63 even for small files that need no zip64 extra field.  So it
seems to rather be meant to allow readers to spot headers they can't
interpret because they were written against an earlier version of the
spec.

InfoZIP's zip writes 10 into the version field, no matter if the entry
has a zip64 extra field or not, as I wrote in my other reply.  That
seems to collide with the spec, but I'd expect readers to be able to
handle its output.

René
