Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 231FE1F453
	for <e@80x24.org>; Thu, 24 Jan 2019 19:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733029AbfAXTjS (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 14:39:18 -0500
Received: from avasout05.plus.net ([84.93.230.250]:59552 "EHLO
        avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730329AbfAXTjS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 14:39:18 -0500
Received: from [10.0.2.15] ([146.198.133.33])
        by smtp with ESMTPA
        id mkqJgcfASNHE9mkqKgzDZ8; Thu, 24 Jan 2019 19:39:16 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=WMNRoEkR c=1 sm=1 tr=0
 a=VCDsReDbrwk4B7AcQzWGLw==:117 a=VCDsReDbrwk4B7AcQzWGLw==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=i5oBkh1g3CDnvbPjE0QA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: Git Test Coverage Report (Sat Jan 19)
To:     Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
References: <6addc879-a792-202f-2aeb-7097ea344894@gmail.com>
 <xmqqa7jp53d2.fsf@gitster-ct.c.googlers.com>
 <7aaec7c8-6cf9-fbd5-fbaf-60b110e2bac7@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <5fe36d0a-e7f1-6349-27ed-a6d48a3ba1e3@ramsayjones.plus.com>
Date:   Thu, 24 Jan 2019 19:39:14 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <7aaec7c8-6cf9-fbd5-fbaf-60b110e2bac7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfHquVD9TgcUBYHNNjzqnhl0PsqdRhVXV9CoXgTCKiDY4dIgimIND7KlU4eHByWUJ6oAwGEiFva3aGXc3IPMPwD2N3ShiWJttFr31OjZZ3GDJ3dB+3hsY
 X86c6Lp/ITC6h7waPC7M8KQPsbJbxe+Ip2ODKGBJxVDcCMtnaNyUbpv/X4ViQXrsr5V5kMB9LKPEVQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 24/01/2019 19:18, Derrick Stolee wrote:
> On 1/24/2019 1:15 PM, Junio C Hamano wrote:
>> Derrick Stolee <stolee@gmail.com> writes:
>>
>>> Here is today's test coverage report.
>>>
>>> Also, there has been some feedback that it can be hard to manually
>>> match up uncovered lines with names at the bottom of the summary. The
>>> suggestion was to auto-generate an HTML report that could be posted to
>>> a public page and referenced in this mail for those who prefer
>>> that.
>> I wanted to "grep" for lines attributed to certain commits that
>> appear in the list, by filtering lines that begin with enough number
>> of hexdigits, except for those object names, but the attempt failed
>> miserably because of the line wrapping (which probably comes from
>> the assumption that it is OK because the "text/plain; format=flowed"
>> would not care).  If you can keep the long lines (due to the object
>> names and line numbers prefixed to each line) unsplit, it would be
>> more useful to locate and isolate lines.
> This is likely more a problem with my workflow (pasting the report into Thunderbird and sending) than with the content itself.

Have you read Doucmentation/git-format-patch.txt (Thunderbird>
Approach #2 (configuration) - approx. line 487)?

ATB,
Ramsay Jones
