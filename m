Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02D2E20248
	for <e@80x24.org>; Mon, 18 Mar 2019 10:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfCRKKT (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 06:10:19 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:57761 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727130AbfCRKKT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 06:10:19 -0400
Received: from [192.168.1.12] ([2.101.244.128])
        by smtp.talktalk.net with SMTP
        id 5pDlhAhUhnuQZ5pDlhViy2; Mon, 18 Mar 2019 10:10:17 +0000
X-Originating-IP: [2.101.244.128]
X-Spam: 0
X-OAuthority: v=2.3 cv=echDgIMH c=1 sm=1 tr=0 a=8nsoD1t2XaTH5iSUU4dp1Q==:117
 a=8nsoD1t2XaTH5iSUU4dp1Q==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=nhVhcl4fmmMikjbPP08A:9 a=QEXdDO2ut3YA:10
Subject: Re: "man gitattributes" doesn't explain comma-separated attribute
 values
To:     Johannes Sixt <j6t@kdbg.org>,
        "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
References: <alpine.LFD.2.21.1903160816410.10724@localhost.localdomain>
 <408d82f6-e935-487a-6d0c-9ec4be5e8b6e@kdbg.org>
 <alpine.LFD.2.21.1903161807480.19900@localhost.localdomain>
 <6aeca231-c024-1063-0f8c-03276c83161c@kdbg.org>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <21e31142-ace2-71e1-8a36-1940c35eb24d@iee.org>
Date:   Mon, 18 Mar 2019 10:10:16 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <6aeca231-c024-1063-0f8c-03276c83161c@kdbg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfLR2hAYx7KLnpPkfZgpkatWKmlERPSMcSHcVrxqKkkhyys8i25AZUT/eODxFQ+nQYBgnSD5Wrx5G49jswNfi4jX+F9Xy9gbeThs1CTO7bcnCfTANsRNT
 TM5t4QsBymxcjLEpQ2Ryh+MfacrhRRlP2DkS2IEq2KvA/QVjKlFBAI/OFXbpqbaRZgxr+XusoMJCGem+mcCNmmBKJ96qnXBmTd5eiNjNu4kosgASsqzDJxZf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17/03/2019 08:18, Johannes Sixt wrote:
> Am 16.03.19 um 23:09 schrieb Robert P. J. Day:
>> On Sat, 16 Mar 2019, Johannes Sixt wrote:
>>
>>> Am 16.03.19 um 13:22 schrieb Robert P. J. Day:
>>>>    as a working example, i looked at the top-level .gitattributes file
>>>> in the git source code itself, which opens with:
>>>>
>>>>    * whitespace=!indent,trail,space
>>>>    *.[ch] whitespace=indent,trail,space diff=cpp
>>>>    *.sh whitespace=indent,trail,space eol=lf
>>>>    ... snip ...
>>>>
>>>> first observation is that i see nothing in the man page that explains
>>>> the notion of a comma-separated list of attribute values.
>>> This comma-separated list is not a property of attributes in
>>> general, but a property of the whitespace attribute in particular.
>>> See core.whitespace in git-config(1) and "Checking whitespace
>>> errors" in gitattributes(5).
>>    ah, i was digging through the code trying to figure out where the
>> whole CSV thing was explained -- it's massively helpful to understand
>> that that property is specific to whitespace. that does not appear to
>> be clarified anywhere.
> But it is. The very first paragraph of gitattributes(5) states that
> attributes are whitespace separated. From this, conclude that the
> comma-separated list must pertain to the whitespace attribute.

I can't say that I follow that 'by omission'  argument. It is one of 
those argument types that sounds good in retrospect but is very hard for 
the unknowing reader to guess, especially as commas are widely taught as 
being one of the ubiquitous separators.

There is a similar issue with '/' in refs regarding the subtle 
distinctions between embedded characters that have a common convenience 
meaning vs the idea that they are all just a single whitespace separated 
string.

Given that, Robert may be able to suggest a short addendum that 
clarifies that the comma is processed elsewhere (IIUC).

>   Now
> follow the documentation of that, and you end up at core.whitespace in
> git-config(1). There you have it as the very first phrase.
>
> -- Hannes

-- 

Philip

