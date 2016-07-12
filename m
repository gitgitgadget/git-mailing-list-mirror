Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72C8B20195
	for <e@80x24.org>; Tue, 12 Jul 2016 21:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbcGLVl4 (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 17:41:56 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:54473 "EHLO
	smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750829AbcGLVlz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2016 17:41:55 -0400
Received: from PhilipOakley ([92.22.11.179])
	by smtp.talktalk.net with SMTP
	id N5Qrbr5XHcpskN5QrbkpUc; Tue, 12 Jul 2016 22:41:34 +0100
X-Originating-IP: [92.22.11.179]
X-Spam:	0
X-OAuthority: v=2.2 cv=ILRAMUnG c=1 sm=1 tr=0 a=811fezkhcwEiY9Bhi8bArg==:117
 a=811fezkhcwEiY9Bhi8bArg==:17 a=N659UExz7-8A:10 a=8q6LdnVOAAAA:8
 a=xtxXYLxNAAAA:8 a=yCC0OsAxP2qAXSE5OuAA:9 a=jNYSTCpFY2gkngftge3H:22
 a=xts0dhWdiJbonKbuqhAr:22
Message-ID: <37D91D4F45C6444792E9B9205EF88BE1@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:	"Philip Oakley" <philipoakley@iee.org>
To:	"GitList" <git@vger.kernel.org>,
	"Marc Branchaud" <marcnarc@xiplink.com>
Cc:	"Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>
References: <20160630202509.4472-1-philipoakley@iee.org> <20160711202518.532-1-philipoakley@iee.org> <20160711202518.532-5-philipoakley@iee.org> <5784F43E.3080400@xiplink.com>
Subject: Re: [PATCH v3 4/8] doc: give headings for the two and three dot notations
Date:	Tue, 12 Jul 2016 22:41:35 +0100
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
X-CMAE-Envelope: MS4wfI+InYdugTbpNqJxONPkXIiAMGPBTd6hnGjnuCClWMgbS2d6eiYyXSFscgP8d2ZXs6ADJuctE2InMn5mvnuPNY0/xfNsPg4ZMcOufG6dDhxTEicS+qcq
 Hr91lMAWYmRHya2RKKkZ6/ozOQw+ZJZOjOc9TQyXeU5GQFAgTFgLZ2gDiJ55BZoXhObuWfxgNScsfqI/PbbOKM5S1RDUmySUVC5AsDtRd+mJk+kWkUlSYz0K
 xpkFQQnq3HEz81PsMGCfzA==
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: "Marc Branchaud" <marcnarc@xiplink.com>
> On 2016-07-11 04:25 PM, Philip Oakley wrote:
>> While there, also break out the other shorthand notations and
>> add a title for the revision range summary (which also appears
>> in git-rev-parse, so keep it mixed case).
>>
>> Signed-off-by: Philip Oakley <philipoakley@iee.org>
>> ---
>>   Documentation/revisions.txt | 23 +++++++++++++++++------
>>   1 file changed, 17 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
>> index 79f6d03..1c59e87 100644
>> --- a/Documentation/revisions.txt
>> +++ b/Documentation/revisions.txt
>> @@ -242,35 +242,46 @@ specifying a single revision with the notation 
>> described in the
>>   previous section means the set of commits reachable from that
>>   commit, following the commit ancestry chain.
>>
>> +The '{caret}' (caret) notation
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>   To exclude commits reachable from a commit, a prefix '{caret}'
>>   notation is used.  E.g. '{caret}r1 r2' means commits reachable
>>   from 'r2' but exclude the ones reachable from 'r1'.
>
> All of these headings render poorly in the manpage, at least for me 
> (Ubuntu 16.04).  Only the first word appears in bold; the '-quoted text is 
> not bold but underlined, and the rest of the header is plain.

Which doc package is that with? It had formatted OK for the html web pages.

>
>
> Also, I think calling this "The ^ notation" is confusing, because there's 
> already an earlier paragraph on the "<rev>^" syntax.

Yes, I noticed that after sending. Maybe "^<rev>" (i.e. include the <rev> 
part) to show that its a prefix not a suffix

>
> Maybe we don't need a header here?  I only suggest that because I'm having 
> trouble coming up with a nice alternative.  "Commit Exclusion"?
>

Part of the earlier discussions as about avoiding new termininologies just 
for the sake of it.

>>
>> -This set operation appears so often that there is a shorthand
>> +The '..' (two-dot) range notation
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Perhaps "Range notation", to mirror the capitalization of "Symmetric 
> Difference" in the next header?


OK
>
>> +The '{caret}r1 r2' set operation appears so often that there is a 
>> shorthand
>>   for it.  When you have two commits 'r1' and 'r2' (named according
>>   to the syntax explained in SPECIFYING REVISIONS above), you can ask
>>   for commits that are reachable from r2 excluding those that are 
>> reachable
>>   from r1 by '{caret}r1 r2' and it can be written as 'r1..r2'.
>>
>> +The '...' (three dot) Symmetric Difference notation
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>   A similar notation 'r1\...r2' is called symmetric difference
>>   of 'r1' and 'r2' and is defined as
>>   'r1 r2 --not $(git merge-base --all r1 r2)'.
>>   It is the set of commits that are reachable from either one of
>>   'r1' (Left side) or 'r2' (Right side) but not from both.
>>
>> -In these two shorthands, you can omit one end and let it default to 
>> HEAD.
>> +In these two shorthand notations, you can omit one end and let it 
>> default to HEAD.
>>   For example, 'origin..' is a shorthand for 'origin..HEAD' and asks 
>> "What
>>   did I do since I forked from the origin branch?"  Similarly, '..origin'
>>   is a shorthand for 'HEAD..origin' and asks "What did the origin do 
>> since
>>   I forked from them?"  Note that '..' would mean 'HEAD..HEAD' which is 
>> an
>>   empty range that is both reachable and unreachable from HEAD.
>
> Unfortunately the new headings make it appear that this paragraph is 
> exclusively part of the '...' notation section.  Folks reading the '..' 
> section are likely to skip it.

OK

>
> I like the examples, though.  I think it would be worthwhile to remove 
> this paragraph and fold it explicitly into the '..' and '...' notation 
> sections.
>
> So add something like this to the '..' section (only the first sentence 
> here is new):
>
> Either r1 or r2 can be omitted, in which case HEAD is used as
> the default.  For example, 'origin..' is a shorthand for
> 'origin..HEAD' and asks "What did I do since I forked from the
> origin branch?"  Similarly, '..origin' is a shorthand for
> 'HEAD..origin' and asks "What did the origin do since I forked
> from them?"  Note that '..' would mean 'HEAD..HEAD' which is an
> empty range that is both reachable and unreachable from HEAD.
>
> And also, add the same first sentence and a different example to the '...' 
> section.  Something like this:
>
> Either r1 or r2 can be omitted, in which case HEAD is used as
> the default.  For example, 'origin...' is a shorthand for
> 'origin...HEAD' and asks "What have I and origin both done
> since I forked from the origin branch?"  Note that 'origin...'
> and '...origin' ask the same question.
>
>>
>> +Additional '{caret}' Shorthand notations
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>   Two other shorthands for naming a set that is formed by a commit
>> -and its parent commits exist.  The 'r1{caret}@' notation means all
>> -parents of 'r1'.  'r1{caret}!' includes commit 'r1' but excludes
>> -all of its parents.
>> +and its parent commits exist.
>
> I think descriptions of <rev>^@ and <rev>^! should live under the main 
> description of <rev>^.  That part already describes the numeric suffix, so 
> describing a couple of special suffixes there seems like a natural fit.

Isn't it that these are ranges of commits, rather than a single commit, so 
would go in this part of the docs, but I see your point.

>
> However, if you choose to keep this little section, you need to move the 
> word "exist" earlier in the sentence:

OK.
>
> Two other shorthands exist for naming a set that is formed
> by a commit and its parent commits.
>
>>
>> -To summarize:
>> +The 'r1{caret}@' notation means all parents of 'r1'.
>> +
>> +'r1{caret}!' includes commit 'r1' but excludes all of its parents.
>> +
>> +Revision Range Summary
>> +----------------------
>
> I think this should be a sub-heading (~~~~~~~), not a top-level heading.
>

In the contect of the other pages it's included in, the use of lower case, 
is the next down level. ALL CAPS would be the top level heading.

I'll review.
--
Philip 

