Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CC76207D6
	for <e@80x24.org>; Mon, 24 Apr 2017 20:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1173872AbdDXUGS (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 16:06:18 -0400
Received: from mout.web.de ([217.72.192.78]:51097 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1173864AbdDXUGQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 16:06:16 -0400
Received: from [192.168.178.36] ([79.213.114.92]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M2MUi-1cAvAn03BE-00s2uJ; Mon, 24
 Apr 2017 22:06:13 +0200
Subject: Re: [PATCH v3 4/5] archive-zip: support archives bigger than 4GB
To:     Peter Krefting <peter@softwolves.pp.se>
Cc:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
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
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <d453610f-dbd5-3f6c-d386-69a74c238b11@web.de>
Date:   Mon, 24 Apr 2017 22:06:11 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.11.1704241912510.30460@perkele.intern.softwolves.pp.se>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:dY76ZEvBjdB5TPx3fU7n5YMoDfHqqEwhtbL/dlqO4/8EkR1pTeu
 Kdp+fiwrGfPFoJyAwAcwcq2e7dDt/KdkCXLTsbo9+y+jkvPsS7LfKc/vavbi7mI1QVsUh7/
 RMNwhGukpsvwmxfJ8uoDzceK2lFci6LOmplOG2S1mlw/BIjp4chGJxVmtunOtYElRfRj8Rw
 oRVEKEotpgxinY1UD/8AQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:deKioZUTAP0=:6lNk83IW90jwqiiNryQ9t+
 QWZd+raExZQl0SfUFtBS8oPiB8Hiqfk+pnzeZVm4pM0Y76B1TOwbuRclwGwLM7LcFyorymaoz
 LPAchW/qRRpctk3aH1hnjrbXkEEV4pZjyvyOrf3XCIxGNidjby1KHsZXZ98qsrfrrqh7jrQRs
 rxfFIQuZeMnYIlkce3GASn5s1r3syqLX6hk28HXIm5pIf5551mlqY44LPknshmv5h1mLw631l
 S16J5pQL3d56fESooHGXofb7s5SULSb0PNGKKIYoc3ugj0lXYEtuV3DFjschIMYyKU+CDNU1r
 hFMwjp7u6xBn8ahWtG9aBME+gYwTudHFmyeHoKRx8HT6yrkpl8nRcLyy/hpF32UujJeTJ1Vkc
 +wad3ZyzG4eDWdulPnM/WNLhX0/Um8H9pHSc7iS2w5Cy6G9U+yA6f7BlBJ269YdwCrkbVqCc4
 l8xxQzUpdW6U93GuhIk6QEMg/Q8NhIh9AJR6lvog/GiudVOrgfUch6XOG6OlGHefvWZlkk+Xb
 LOXKGEN++wjTSB49IYReZ78IRlKcxIQrbpig5Xe6Ub0+mx6xg2/pRVtSdTCBXgTjuQMXfHYBo
 +tFudFprst6mai11Sdvt37mQJQ7JT/YWP45QTBb2aF72C+zDi4DRh5Fa+UMaxGgDpZeGfhdi6
 g4TTAEsJn2lnjTY5VJ9L3f1JbfvdgVqbdu6zLRSScsI36d5G7MxbX9zM5PN+c2Ua/ZHV9CPr0
 Q9JIElOtdcnR5O4fNyFCWKC4MWmgUK3yblcabZSvMQbX7u66woq9kbHSVOKqro9/NHFlEvUil
 ICahvrm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.04.2017 um 20:24 schrieb Peter Krefting:
> René Scharfe:
> 
>> @@ -433,6 +446,11 @@ static int write_zip_entry(struct archiver_args 
>> *args,
>>     free(deflated);
>>     free(buffer);
>>
>> +    if (offset > 0xffffffff) {
>> +        zip64_dir_extra_payload_size += 8;
>> +        zip_dir_extra_size += 2 + 2 + zip64_dir_extra_payload_size;
>> +    }
>> +
>>     strbuf_add_le(&zip_dir, 4, 0x02014b50);    /* magic */
>>     strbuf_add_le(&zip_dir, 2, creator_version);
>>     strbuf_add_le(&zip_dir, 2, 10);        /* version */
> 
> This needs to be >=. The spec says that if the value is 0xffffffff, 
> there should be a zip64 record with the actual size (even if it is 
> 0xffffffff).

Could you please cite the relevant part?

Here's how I read it: If a value doesn't fit into a 32-bit field it is 
set to 0xffffffff, a zip64 extra is added and a 64-bit field stores the 
actual value.  The magic value 0xffffffff indicates that a corresponding 
64-bit field is present in the zip64 extra.  That means even if a value 
is 0xffffffff (and thus fits) we need to add it to the zip64 extra.  If 
there is no zip64 extra then we can store 0xffffffff in the 32-bit 
field, though.

> Also set the version required to 45 (4.5) for any record that has zip64 
> fields.

Ah, yes indeed.

René
