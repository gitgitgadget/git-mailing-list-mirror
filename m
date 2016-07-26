Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_03_06,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49E93203E3
	for <e@80x24.org>; Tue, 26 Jul 2016 18:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757514AbcGZSb2 (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 14:31:28 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:17154 "EHLO
	smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757246AbcGZSb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 14:31:26 -0400
Received: from PhilipOakley ([92.22.32.207])
	by smtp.talktalk.net with SMTP
	id S78VbMttCcpskS78VbyYJV; Tue, 26 Jul 2016 19:31:24 +0100
X-Originating-IP: [92.22.32.207]
X-Spam:	0
X-OAuthority: v=2.2 cv=ILRAMUnG c=1 sm=1 tr=0 a=rOGkjouw9mi83KKuktpS7A==:117
 a=rOGkjouw9mi83KKuktpS7A==:17 a=N659UExz7-8A:10 a=pGLkceISAAAA:8
 a=TQIqQIky2aeAzyuLQYkA:9 a=6kGIvZw6iX1k4Y-7sg4_:22
Message-ID: <EF592E1B359D4D8F87EC40A9465D3736@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:	"Philip Oakley" <philipoakley@iee.org>
To:	"Rodrigo Campos" <rodrigo@sdfg.com.ar>,
	"Jon Forrest" <nobozo@gmail.com>
Cc:	<git@vger.kernel.org>
References: <nn30dv$5sn$1@ger.gmane.org> <20160724185132.GN25141@sdfg.com.ar> <c0af7511-a5d5-29bb-d279-66b6c3e0519c@gmail.com>
Subject: Re: [RFC] A Change to Commit IDs Too Ridiculous to Consider?
Date:	Tue, 26 Jul 2016 15:26:32 +0100
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
X-CMAE-Envelope: MS4wfOFj6ozTWSuztKDvzaDVuOFMXqmwUOs0wgqror75lnGWY3+FMODUNHcRl8OodB+AgbqORIKpHuj2pO2teTyQB1GOnU+QDq1nCd1KtKZCCc0VJDT8z3G9
 fa+l2pwY6Nboi6+90p2w8yQmclcvoeFe1/CCR1IAg6rEoZsSBG3QiFNI/ery7Kg7SaRWFXbZx98JfD1hJN7o2S+hdFThYPm9mXpNq1upO98EuYWg8KkmH85x
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: "Jon Forrest" <nobozo@gmail.com>
> On 7/24/2016 11:51 AM, Rodrigo Campos wrote:
>> And what is the problem with that, if you are doing it with instructional
>> purposes? Let's assume that this helps and not confuses later when the 
>> commits
>> *do* change. What is the problem you face?
>
> A lot of instructional material contains stuff like "Do [xxx] and you'll
> see [zzz]. If you don't then something went wrong so try to figure out
> what happened and do it again."
>
> Git, as it stands, for good reason doesn't allow this approach.

You may want to look at how the test suite handles the need for well defined 
commit sequences.

It's not something I've really studied, but I am aware of the test_tick to 
increment the time and similar helpers.

There is a big learning step that needs to be got over by many beginners who 
have no concept of a DVCS, nor of multiple master copies (which to most is 
an oxymoron!), nor why the sha is a good solution and serial numbers are a 
bad solution!.

Being able to do a few "Hello World" commits starting at unix t=0, and then 
progressing on to see how they differ when it's unix=now time, or they use 
their own user IDs could be a useful step for those that need it.

>
> I don't think a Git beginner, when using a version of Git that somehow
> works the way I proposed, will be confused. The fact that performing the
> same steps results in the same commit IDs won't be something that
> they'll care about or even notice. The material can include a callout
> mentioning the difference between "real" Git and "learners" Git.
>
>> I mean, for some examples you can use HEAD, HEAD^, HEAD~4, etc. and that 
>> always
>> works, no matter the commit id.
>
> This will work in some cases, but should come later in a Git book.
> But, in many cases using relative commit IDs, rather than absolute,
> will be less clear (I believe).
>
>> In which cases do you want/need the commit ids to be equal?
>> Can you be more specific?
>
> Sure. Take a look at the 2nd or 3rd chapter of Pro Git Reedited, 2nd
> Edition (or just Pro Git 2nd Edition - it doesn't matter). You see
> lots of output showing 'git commit' commands and the commit IDs that
> result. I suspect you'd see the same in almost any book about Git.
>
> Jon
> --
Philip 

