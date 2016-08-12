Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 227E61F859
	for <e@80x24.org>; Fri, 12 Aug 2016 22:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751975AbcHLWqV (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 18:46:21 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:49590 "EHLO
	smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917AbcHLWqU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 18:46:20 -0400
Received: from PhilipOakley ([92.22.69.35])
	by smtp.talktalk.net with SMTP
	id YLCLbWcRaY8RwYLCMbsbkg; Fri, 12 Aug 2016 23:45:06 +0100
X-Originating-IP: [92.22.69.35]
X-Spam:	0
X-OAuthority: v=2.2 cv=b+Xw2ZOx c=1 sm=1 tr=0 a=118V6UEFpCLMRzptT8w30g==:117
 a=118V6UEFpCLMRzptT8w30g==:17 a=IkcTkHD0fZMA:10 a=8q6LdnVOAAAA:8
 a=xtxXYLxNAAAA:8 a=pGLkceISAAAA:8 a=DomwuBOuhIxaDlLMSfMA:9
 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=jNYSTCpFY2gkngftge3H:22
 a=xts0dhWdiJbonKbuqhAr:22 a=6kGIvZw6iX1k4Y-7sg4_:22
Message-ID: <7765A995ADF6470DBA99D000AF7B5538@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:	"Philip Oakley" <philipoakley@iee.org>
To:	"GitList" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Marc Branchaud" <marcnarc@xiplink.com>
Cc:	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
References: <20160720211007.5520-1-philipoakley@iee.org> <20160812070749.2920-1-philipoakley@iee.org> <20160812070749.2920-12-philipoakley@iee.org> <f418c41b-f590-0b6a-236a-c109a7296434@xiplink.com>
Subject: Re: [PATCH v5 11/12] doc: revisions: show revision expansion in examples
Date:	Fri, 12 Aug 2016 23:45:05 +0100
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
X-CMAE-Envelope: MS4wfIGVFYipSkWb3JJLW14XFZNaQWdZqPCbG4o1L/562JTh6C/wLL3jDHpHkVkFhwfigGuH9E91sBHPp9i5iO37nw9uj5diMWNKLrlgKxyP3x+FvPcEDDtV
 Vbnw3OWjVNwZIjVlzHcYaYOwtbAbtw1gNF3ZLB8OQAG6Md1GMe51NP0gPDWlpaMzgqSk7oYTF9GhlugoYJOHaEUwfQdOKmT4WvNCsbEcxTTxuuJfm9EiKAHm
 /PEaEdytucRgwER3CZhoIw==
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: "Marc Branchaud" <marcnarc@xiplink.com>
> On 2016-08-12 03:07 AM, Philip Oakley wrote:
>> The revisions examples show the revison arguments and the selected
>> commits, but do not show the intermediate step of the expansion of
>> the special 'range' notations. Extend the examples, including an
>> all-parents multi-parent merge commit example.
>>
>> Sort the examples and fix the alignment for those unaffected
>> in the next commit.
>>
>> Signed-off-by: Philip Oakley <philipoakley@iee.org>
>> ---
>> new
>> Cc: Jakub Narębski <jnareb@gmail.com>
>> ---
>>  Documentation/revisions.txt | 19 +++++++++++++------
>>  1 file changed, 13 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
>> index 70864d5..ac7dd8e 100644
>> --- a/Documentation/revisions.txt
>> +++ b/Documentation/revisions.txt
>> @@ -326,16 +326,23 @@ Revision Range Summary
>>    as giving commit '<rev>' and then all its parents prefixed with
>>    '{caret}' to exclude them (and their ancestors).
>>
>> -Here are a handful of examples:
>> +Here are a handful of examples using the Loeliger illustration above:
>>
>> +   Args   Expansion       Selection
>
> I think "Result" would be better than "Selection" here.

I wanted to avoid that. I feel that "Result" is too general. I had thought 
about using the 'ed' rather than 'ion' word endings, but that would require 
(to my mind) the noun e.g. "Expanded arguments" and " Selected commits" 
(still could be - see below), while the 'ion' endings felt complete. The 
Result is what is shown in thable below these headings ;-)


>
> Also, shouldn't all the ^ in these examples be {caret}?  (I likely just 
> don't understand the rationale for using {caret} in some places and ^ in 
> others...)

All the conversions appear to work. I think that asciidoc is viewing these a 
blocked text without any expansion. Plus, it would be horrendous trying to 
check the formatting (endless reruns of make.. ... .. )

>
>>     D                G H D
>>     D F              G H I J D F
>>     ^G D             H D
>>     ^D B             E I J F B
>> -   B..C             C
>> -   B...C            G H D E B C
>> +   B..C   = ^B C          C
>> +   B...C  = B ^F C        G H D E B C
>>     ^D B C           E I J F B C
>>     C                I J F C
>> -   C^@              I J F
>> -   C^!              C
>> -   F^! D            G H D F
>> +   C^@    = C^1
>
> I have a mixed reaction to showing this "C^1" expansion, and the "B^1 B^2 
> B^3" one as well.  I see the appeal of showing the parent notation, but 
> really that was already explained to death in the first section.

This was the whole point. For some (e.g. me) the explanations had fallen 
flat on their face, and it was difficult to see what it was on about. Now I 
know, it's all obvious, but what was needed was a carefully stepped through 
example or two. If the dear reader can't see the big steps, let's give them 
small steps.

Jacob had given an 'example' in response to my early query, but it just felt 
like repetion of what had already been said, but it didn't take the next 
[small] step, which this example does (partly because it can as it can use 
the Loeliger diagram, which wasn't available in Jacob's example).

I also deliberately added the B^@ and B^! (standalone) example as the C^@ 
and C^!  didn't have an 'all parents' (plurals!), but it did have the 
indentation issue - see above about stretching out the headers, which would 
give more space for the indentations.

> Here it's distracting.  I think it's clearer for the reader to remove 
> these expansions and just use the node names from the illustration.
>
>> +          = F             I J F
>> +   B^@    = B^1 B^2 B^3
>> +          = D E F         D G H E F I J
>> +   C^!    = C ^C^1
>
> I think this expansion might be better expressed as "C ^C^@".

I hadn't viewed it that way. It would be an extra step.

>        It'll be the same for "B^! = B ^B^@" as well, which demonstrates a 
> nice consistency and also helps to emphasize the meaning of the ^@ 
> notation.
>
>> +          = C ^F          C
>> +   B^! = B ^B^1 ^B^2 ^B^3
>> +       = B ^D ^E ^F       B
>
> The layout of these last two lines doesn't match the others.  They should 
> be:
>
>    B^!    = B ^B^1 ^B^2   ^B^3
>           = B ^D ^E ^F    B
>
> I see that the next patch fixes the layout of the unchanged examples, but 
> it leaves these two unaligned.

As noted it was about squeezing that one in. I'll look at alternate heading 
titles and spacing options.


--
Philip 

