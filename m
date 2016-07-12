Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B247620195
	for <e@80x24.org>; Tue, 12 Jul 2016 21:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752048AbcGLVrc (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 17:47:32 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:54750 "EHLO
	smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751973AbcGLVrb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2016 17:47:31 -0400
Received: from PhilipOakley ([92.22.11.179])
	by smtp.talktalk.net with SMTP
	id N5WLbr6BScpskN5WLbkpge; Tue, 12 Jul 2016 22:47:14 +0100
X-Originating-IP: [92.22.11.179]
X-Spam:	0
X-OAuthority: v=2.2 cv=ILRAMUnG c=1 sm=1 tr=0 a=811fezkhcwEiY9Bhi8bArg==:117
 a=811fezkhcwEiY9Bhi8bArg==:17 a=8nJEP1OIZ-IA:10 a=ybZZDoGAAAAA:8
 a=xtxXYLxNAAAA:8 a=eOPd68fHHo8BoEMKG-0A:9 a=0RhZnL1DYvcuLYC8JZ5M:22
 a=xts0dhWdiJbonKbuqhAr:22
Message-ID: <5ECE61F3B9CE4C6F80718AE457AF8278@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:	"Philip Oakley" <philipoakley@iee.org>
To:	"Junio C Hamano" <gitster@pobox.com>
Cc:	"GitList" <git@vger.kernel.org>, "Jeff King" <peff@peff.net>
References: <20160630202509.4472-1-philipoakley@iee.org><20160711202518.532-1-philipoakley@iee.org><20160711202518.532-3-philipoakley@iee.org> <xmqq1t2y7qi8.fsf@gitster.mtv.corp.google.com>
Subject: Re: [PATCH v3 2/8] doc: revisions - name the Left and Right sides
Date:	Tue, 12 Jul 2016 22:47:15 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfCq+qMhlXwPqx7Jcv7t01uuBtOeGNdB0Zf6vCOIWWuvVvJv9yIY87kEcNQaxCdZuU164jGoXFu9XtV3w5Uvwmjh0UxoGpnlckPfM+YD5+4IbUmUWdDrP
 Uq8bkc28PgPvZcNkNJKkh03nwrnxXZUhqcr7v9G3qyAgleyli4pE289W1pixY/DptrgmNnOKmr5oNMxBGveS0koAKx3ATYFKcfXeXxy3GfcHdc+9Dimb2YN1
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: "Junio C Hamano" <gitster@pobox.com>
> Philip Oakley <philipoakley@iee.org> writes:
>
>> The terms Left and Right side originate from the symmetric
>> difference. Name them there.
>> ---
>
> Sign-off?

Oops - will fix.
>
>>  Documentation/revisions.txt | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
>> index 19314e3..79f6d03 100644
>> --- a/Documentation/revisions.txt
>> +++ b/Documentation/revisions.txt
>> @@ -256,7 +256,7 @@ A similar notation 'r1\...r2' is called symmetric 
>> difference
>>  of 'r1' and 'r2' and is defined as
>>  'r1 r2 --not $(git merge-base --all r1 r2)'.
>>  It is the set of commits that are reachable from either one of
>> -'r1' or 'r2' but not from both.
>> +'r1' (Left side) or 'r2' (Right side) but not from both.
>
> I think it is a good idea to call them explicitly left and right,
> but I do not think they need to be capitalized here or on the title
> of the patch.

OK - can fix.

>
>>  In these two shorthands, you can omit one end and let it default to 
>> HEAD.
>>  For example, 'origin..' is a shorthand for 'origin..HEAD' and asks "What
>
--
Philip 

