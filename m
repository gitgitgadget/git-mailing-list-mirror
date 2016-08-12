Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A7121F859
	for <e@80x24.org>; Fri, 12 Aug 2016 22:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752206AbcHLWRj (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 18:17:39 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:30423 "EHLO
	smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372AbcHLWRi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 18:17:38 -0400
Received: from PhilipOakley ([92.22.69.35])
	by smtp.talktalk.net with SMTP
	id YKlWbWaUoY8RwYKlWbsbIv; Fri, 12 Aug 2016 23:17:23 +0100
X-Originating-IP: [92.22.69.35]
X-Spam:	0
X-OAuthority: v=2.2 cv=b+Xw2ZOx c=1 sm=1 tr=0 a=118V6UEFpCLMRzptT8w30g==:117
 a=118V6UEFpCLMRzptT8w30g==:17 a=IkcTkHD0fZMA:10 a=8q6LdnVOAAAA:8
 a=xtxXYLxNAAAA:8 a=pGLkceISAAAA:8 a=5rxgeBVgAAAA:8 a=fqbMTqNF4WbzCJTDO8kA:9
 a=jNYSTCpFY2gkngftge3H:22 a=xts0dhWdiJbonKbuqhAr:22 a=6kGIvZw6iX1k4Y-7sg4_:22
 a=PwKx63F5tFurRwaNxrlG:22
Message-ID: <38431C3FB1444813A222858D8F4D0390@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:	"Philip Oakley" <philipoakley@iee.org>
To:	"GitList" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Marc Branchaud" <marcnarc@xiplink.com>
Cc:	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
References: <20160720211007.5520-1-philipoakley@iee.org> <20160812070749.2920-1-philipoakley@iee.org> <20160812070749.2920-6-philipoakley@iee.org> <c3271034-8fc5-3e29-ea1a-1c543abc7c52@xiplink.com>
Subject: Re: [PATCH v5 05/12] doc: revisions: extra clarification of <rev>^! notation effects
Date:	Fri, 12 Aug 2016 23:17:21 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=response
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfHvdRC7TDGmfwWUg03IiB+CVam/vMTqUaRVGqpoYYB+U+6PEhwnl72v6Ngf/tWxdVTQrrm9IjPpEn8CxPNMQFU8wvMZxQbIGeJYzg/PC2f4H8aSv9hKi
 ORmGw7ewSnR5nx1FrYZUxOX6S0EWA6kaxUMHZcLnD2H4SCyD9RnSSW7HHHDwPRGyOREtyKY52WNMfBx0W+wXTRWrh03BG9bEchg05gF++suId2gduZgg7v69
 Z1K7FT0iA7Qy2iqbMpAUtQ==
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: "Marc Branchaud" <marcnarc@xiplink.com>
> On 2016-08-12 03:07 AM, Philip Oakley wrote:
>> Signed-off-by: Philip Oakley <philipoakley@iee.org>
>> ---
>> new
>> Cc: Jakub Narębski <jnareb@gmail.com>
>> https://public-inbox.org/git/578E4F4A.2020708%40gmail.com/
>> ---
>>  Documentation/revisions.txt | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
>> index 3da0083..0b5044d 100644
>> --- a/Documentation/revisions.txt
>> +++ b/Documentation/revisions.txt
>> @@ -281,7 +281,8 @@ for naming a set that is formed by a commit and its 
>> parent commits.
>>
>>  The 'r1{caret}@' notation means all parents of 'r1'.
>>
>> -'r1{caret}!' includes commit 'r1' but excludes all of its parents.
>> +'r1{caret}!' notation includes commit 'r1' but excludes all of its 
>> parents.
>
> This sentence should start with "The".

Accepted. I'd simply split the the previous text, so the nice run-on effect 
it initially had has been lost.

>
>> +This is the single commit 'r1', if standalone.
>
> That reads awkwardly to me.  Perhaps
>
>        By itself, this notation denotes the single commit 'r1'.

Like it. I'd toyed wth quite a few variants. It's jsut a case of finding the 
nicest one;-)

>
> ?
>
> M.
>
> --

Philip 

