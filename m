Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A08AC1F453
	for <e@80x24.org>; Fri, 21 Sep 2018 16:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390730AbeIUWgs (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 18:36:48 -0400
Received: from avasout06.plus.net ([212.159.14.18]:55627 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388909AbeIUWgs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 18:36:48 -0400
Received: from [10.0.2.15] ([80.189.70.183])
        by smtp with ESMTPA
        id 3Oa7gJVn9WLW23Oa8gxLPj; Fri, 21 Sep 2018 17:47:04 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=fJUXI6Se c=1 sm=1 tr=0
 a=6SF67mWK+VR8hB1Kjo6y2g==:117 a=6SF67mWK+VR8hB1Kjo6y2g==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=SHWgZ3sZ2X1AwTs8gKIA:9 a=QEXdDO2ut3YA:10
 a=t8EmEut40mcA:10 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] fetch-object.h: add missing declaration (hdr-check)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
References: <12cd9928-d04d-d208-a1b4-ceecbdf79432@ramsayjones.plus.com>
 <xmqq1s9myg67.fsf@gitster-ct.c.googlers.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <f6663e27-cfe6-c927-746c-dfbeed5bb3a2@ramsayjones.plus.com>
Date:   Fri, 21 Sep 2018 17:47:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <xmqq1s9myg67.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfD32e/XPjoDUgstQpfquMz3/EPo81QF3hsYEm9S2X8vKe7do5EycdlWPNMW8Mf0H0H7PHa+JZTTGrKNuZsjQg03ij3RZ8vULkOBt0yaZYldLlQgpfKtm
 60GOuGZtR00H6yn5fLlOszUxuEdJdQdZoemS6DOnGn/qtYNcfPlnAqIe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 21/09/18 17:21, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> 
>> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
>> ---
>>
>> Hi Junio,
>>
>> This is the patch I needed for the current 'next' branch to get
>> a clean 'hdr-check'
> 
> Which means that this is a fix on top of jt/lazy-object-fetch-fix
> topic, I think.
> 
> Will apply there.

Yes, indeed. Sorry, I should have added that information, rather
than forcing you to look it up! (Similar comment on the userdiff.h
patch as well) :(

BTW, I notice that patch #9 (commit-reach.h: add missing declarations
 (hdr-check)) didn't make it onto 'pu' - was there something else I
needed to do? (I am still in two minds about sending an RFC patch
on-top of patch #9).

Thanks!

ATB,
Ramsay Jones

