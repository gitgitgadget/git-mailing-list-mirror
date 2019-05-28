Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,BODY_URI_ONLY,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D5551F462
	for <e@80x24.org>; Tue, 28 May 2019 14:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfE1ORM (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 10:17:12 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:11126 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbfE1ORM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 10:17:12 -0400
Received: from [192.168.1.22] ([78.148.161.28])
        by smtp.talktalk.net with SMTP
        id Vcuchga2lniZTVcuch4pXU; Tue, 28 May 2019 15:17:10 +0100
X-Originating-IP: [78.148.161.28]
X-Spam: 0
X-OAuthority: v=2.3 cv=B8HHL9lM c=1 sm=1 tr=0 a=ujKALdKAi7z8notBBWqKeA==:117
 a=ujKALdKAi7z8notBBWqKeA==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=xtxXYLxNAAAA:8 a=pGLkceISAAAA:8 a=5rxgeBVgAAAA:8
 a=VwQbUJbxAAAA:8 a=G0zndLs9XB2fkGGU-LUA:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19
 a=QEXdDO2ut3YA:10 a=j_Tf7YO6MbsA:10 a=xts0dhWdiJbonKbuqhAr:22
 a=PwKx63F5tFurRwaNxrlG:22 a=AjGcO6oz07-iQ99wixmX:22
Subject: Re: [PATCH] doc branch: provide examples for listing remote tracking
 branches
To:     Junio C Hamano <gitster@pobox.com>
Cc:     GitList <git@vger.kernel.org>
References: <CACsJy8CwY8gzeWa9kNRX3ecez1JGiQiaOknbAoU7S+hiXBoUGQ@mail.gmail.com>
 <20190528121315.2604-1-philipoakley@iee.org>
 <xmqq5zpuel4m.fsf@gitster-ct.c.googlers.com>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <d44cbf49-dea9-c518-17e3-f9b252f2dd06@iee.org>
Date:   Tue, 28 May 2019 15:17:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <xmqq5zpuel4m.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfNU+WD97QgD6UXpf/d54fRBRM/cIi3/CfiRBXJshHulFyLabVKlqmIJFWFxmSpoDuIUdl729Jvmq6mzrTlgNenEobs7EMPD6OyOgtQrFazH5qh9lmiC0
 hGlnQEfpEUBFnIGFBbmzP6zJO65QmUBphCkFB6hKpMt/XIXwHVcRR4WQEtdWEm9ANLaPUMxtl1aSRaG3FoT2WqTEGQ7ReF+t7Jo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28/05/2019 14:58, Junio C Hamano wrote:
> Philip Oakley <philipoakley@iee.org> writes:
>
>> The availability of these pattern selections is not obvious from
>> the man pages, as per mail thread <87lfz3vcbt.fsf@evledraar.gmail.com>.
>>
>> Provide examples.
>>
>> Signed-off-by: Philip Oakley <philipoakley@iee.org>
>> ---
> Please try again, perhaps after reading
> <CACsJy8B_3ZytR+5HvOax=ngw7ECse8_5ajkOvUEcOj3MuNxQvQ@mail.gmail.com>
Hi Junio
Sorry, I'm not understanding the comment, even having re-read the thread.
Philip
>
> Thanks.
>
>> in response to
>> <CACsJy8CwY8gzeWa9kNRX3ecez1JGiQiaOknbAoU7S+hiXBoUGQ@mail.gmail.com>
>> https://public-inbox.org/git/?q=%3CCACsJy8CwY8gzeWa9kNRX3ecez1JGiQiaOknbAoU7S%2BhiXBoUGQ%40mail.gmail.com%3E
>>
>> to: "Git Mailing List <git@vger.kernel.org>"
>> cc: "Duy Nguyen <pclouds@gmail.com>"
>> cc: "Ævar Arnfjörð Bjarmason <avarab@gmail.com>"
>>
>>   Documentation/git-branch.txt | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
>> index 3bd83a7cbd..7ed91f1be3 100644
>> --- a/Documentation/git-branch.txt
>> +++ b/Documentation/git-branch.txt
>> @@ -314,6 +314,18 @@ $ git branch -D test                                    <2>
>>   <2> Delete the "test" branch even if the "master" branch (or whichever branch
>>       is currently checked out) does not have all commits from the test branch.
>>   
>> +Listing branches from a specific remote::
>> ++
>> +------------
>> +$ git branch -a -l '<remote>/<pattern>'                 <1>
>> +$ git for-each-ref 'refs/remotes/<remote>/<pattern>'    <2>
>> +------------
>> ++
>> +<1> This can conflate <remote> with any local branches you happen to
>> +    have been prefixed with the same <remote> pattern.
>> +<2> `for-each-ref` can take a wide range of options. See linkgit:git-for-each-ref[1]
>> +
>> +Patterns will normally need quoting.
>>   
>>   NOTES
>>   -----

