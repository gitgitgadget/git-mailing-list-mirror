Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98DCD20195
	for <e@80x24.org>; Tue, 12 Jul 2016 21:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752176AbcGLVob (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 17:44:31 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:10013 "EHLO
	smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752029AbcGLVo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2016 17:44:29 -0400
Received: from PhilipOakley ([92.22.11.179])
	by smtp.talktalk.net with SMTP
	id N5Tfbr5rncpskN5Tfbkpaq; Tue, 12 Jul 2016 22:44:28 +0100
X-Originating-IP: [92.22.11.179]
X-Spam:	0
X-OAuthority: v=2.2 cv=ILRAMUnG c=1 sm=1 tr=0 a=811fezkhcwEiY9Bhi8bArg==:117
 a=811fezkhcwEiY9Bhi8bArg==:17 a=N659UExz7-8A:10 a=8q6LdnVOAAAA:8
 a=xtxXYLxNAAAA:8 a=60rhUDjN3AiatFKCWsIA:9 a=jNYSTCpFY2gkngftge3H:22
 a=xts0dhWdiJbonKbuqhAr:22
Message-ID: <27A6AC8B1E3B4C80B95AFF19CEF7A962@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:	"Philip Oakley" <philipoakley@iee.org>
To:	"GitList" <git@vger.kernel.org>,
	"Marc Branchaud" <marcnarc@xiplink.com>
Cc:	"Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>
References: <20160630202509.4472-1-philipoakley@iee.org> <20160711202518.532-1-philipoakley@iee.org> <20160711202518.532-8-philipoakley@iee.org> <5784F53E.9040104@xiplink.com>
Subject: Re: [PATCH v3 7/8] doc: revisions - define `reachable`
Date:	Tue, 12 Jul 2016 22:44:29 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="Windows-1252";
	reply-type=response
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfBdL1Ehlj1sNiyjlgEaLPvMluhbqN6pJVjFn6htgLf1yBXQojFipfXcak/F5U7siWjVs+oAiwrZnkZNk1kju66rMpij/iXF7Sl6bGSJcGLQws0M7QLVJ
 xkrWf2FVQLvJwSHJpfvGROhnit51XUKChF8rX+1rmeZBVc8OkXmSfCPDgsSy/s347+xgyqV+n5V8WOkmA1XNNed/dR3KH1aAPKu2oeQEfXoM9yXCaztio/+0
 3uFkXsUOM43k6RYlLqt8uw==
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: "Marc Branchaud" <marcnarc@xiplink.com>
> On 2016-07-11 04:25 PM, Philip Oakley wrote:
>> Do not self-define `reachable`, which can lead to misunderstanding.
>> Instead define `reachability` explictly.
>>
>> Signed-off-by: Philip Oakley <philipoakley@iee.org>
>> ---
>>   Documentation/revisions.txt | 14 ++++++++++----
>>   1 file changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
>> index 1c59e87..a3cd28b 100644
>> --- a/Documentation/revisions.txt
>> +++ b/Documentation/revisions.txt
>> @@ -237,10 +237,16 @@ SPECIFYING RANGES
>>   -----------------
>>
>>   History traversing commands such as `git log` operate on a set
>> -of commits, not just a single commit.  To these commands,
>> -specifying a single revision with the notation described in the
>> -previous section means the set of commits reachable from that
>> -commit, following the commit ancestry chain.
>> +of commits, not just a single commit.
>> +
>> +For these commands,
>> +specifying a single revision, using the notation described in the
>> +previous section, means the `reachable` set of commits of the given
>> +commit.
>
> Better as "... means the set of commits `reachable` from the given 
> commit."

OK. The main aspect is show that 'reachable' is a specific term.

>
>> +
>> +A commit's reachable set is the commit itself and the commits of
>> +its ancestry chain.
>> +
>
> s/of/in/

OK.
>
--
Philip 

