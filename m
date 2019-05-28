Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F41A1F462
	for <e@80x24.org>; Tue, 28 May 2019 09:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfE1Jdg (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 05:33:36 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:59935 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbfE1Jdg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 05:33:36 -0400
Received: from [192.168.1.22] ([78.148.161.28])
        by smtp.talktalk.net with SMTP
        id VYU9hBgj1p7QXVYU9hicaL; Tue, 28 May 2019 10:33:34 +0100
X-Originating-IP: [78.148.161.28]
X-Spam: 0
X-OAuthority: v=2.3 cv=drql9Go4 c=1 sm=1 tr=0 a=ujKALdKAi7z8notBBWqKeA==:117
 a=ujKALdKAi7z8notBBWqKeA==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=anyJmfQTAAAA:8 a=_Dd1uWhXbKya2ipeAgcA:9 a=QEXdDO2ut3YA:10
 a=YJ_ntbLOlx1v6PCnmBeL:22
Subject: Re: git filter-branch re-write history over a range of commits did
 notwork
To:     LU Chuck <Chuck.LU@edenred.com>, Johannes Sixt <j6t@kdbg.org>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "chuck.lu@qq.com" <chuck.lu@qq.com>
References: <DB7PR05MB5573AD842E430342E2BD011B8D1D0@DB7PR05MB5573.eurprd05.prod.outlook.com>
 <db2dcf54-8b1c-39b1-579c-425ef158c6a1@kdbg.org>
 <75618ca1-748d-0761-9108-c7deac63cb53@iee.org>
 <DB7PR05MB5573B5B80C8A9CBE867803D88D1E0@DB7PR05MB5573.eurprd05.prod.outlook.com>
 <fa23e865-94ed-308f-6a19-75b6ea89eec3@kdbg.org>
 <DB7PR05MB5573B5FC17FD1F221F7AAD558D1E0@DB7PR05MB5573.eurprd05.prod.outlook.com>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <3cf99e80-98aa-639b-ac9d-a882da349fc8@iee.org>
Date:   Tue, 28 May 2019 10:33:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <DB7PR05MB5573B5FC17FD1F221F7AAD558D1E0@DB7PR05MB5573.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfPu0AdFMkzxJnBiCFHxwJTKOxigaTDDseDtjXt4Vy+9caVBWp2cVODOQ6APn4gpKCFbySMpY8arz0rPLsIbA8RCWqBCkNf9LGQqukXq1PAG+PG3f8661
 zgAt2BHs6NcfJsQl3+uc0VSa/QxJKZlizaN8/euTcwU9V/IFxMoAWjjWdZGD+nYxPnKlCPj/ySiM2G0Vw9CB6hFAs7HDDyIfZcOUheHzTY3Y3jqPbHBm77LA
 xvY6KIXd2JERDeYQaS6SBw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Chuck,

On 28/05/2019 08:10, LU Chuck wrote:
[snip]
>> Copying and pasting examples literally is dangerous. You should know what you
>> are doing.
>>
>> "..." is a revision range that computes the mergebase between HEAD and HEAD,
>> which is (surprise!) HEAD, and then includes the two end points, but excludes
>> everything below the mergebase. So, the revision specification that your
>> command ends up with is
>>
>>       HEAD HEAD ^HEAD ^67d9d9 f70bf4
>>
>> Which is empty if f70bf4 is an ancestor of HEAD.
> [LU Chuck] Sorry, I can't understand this part, did you have an documentation about the explanation for ...?
https://git-scm.com/docs/gitrevisions#Documentation/gitrevisions.txt-Theem82308203emthree-dotSymmetricDifferenceNotation
>           "computes the mergebase between HEAD and HEAD" I have no idea about this. And you also talked about mergebase, but in my situation, there is only one branch with 5 commits. I did not have a mergebase.
>           You can check the detail description below.
When there is no specific revisions around the three dots then HEAD is 
assumed (to save typing)

[snipping the comments on the alternate script]
