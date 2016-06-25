Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_50,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D0431FEAA
	for <e@80x24.org>; Sat, 25 Jun 2016 13:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751530AbcFYNuV (ORCPT <rfc822;e@80x24.org>);
	Sat, 25 Jun 2016 09:50:21 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:47873 "EHLO
	smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751522AbcFYNuU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jun 2016 09:50:20 -0400
Received: from PhilipOakley ([92.22.68.35])
	by smtp.talktalk.net with SMTP
	id GnyTbvQqJYIiqGnyTbpgHD; Sat, 25 Jun 2016 14:50:18 +0100
X-Originating-IP: [92.22.68.35]
X-Spam:	0
X-OAuthority: v=2.2 cv=P/l4vWIu c=1 sm=1 tr=0 a=MvvZD7eUgq4fJAFIMo7fmA==:117
 a=MvvZD7eUgq4fJAFIMo7fmA==:17 a=8nJEP1OIZ-IA:10 a=ybZZDoGAAAAA:8
 a=PKzvZo6CAAAA:8 a=B31L5rKBnpt_QikuOVcA:9 a=0RhZnL1DYvcuLYC8JZ5M:22
 a=q92HNjYiIAC_jH7JDaYf:22
Message-ID: <E61B46FFA8874DD3973AA96BE5B36790@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:	"Philip Oakley" <philipoakley@iee.org>
To:	"Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>
Cc:	"Git List" <git@vger.kernel.org>
References: <0648000B273C412AB7140AE959EBC99A@PhilipOakley><20160624160943.GA3170@sigill.intra.peff.net> <xmqqh9cih6ym.fsf@gitster.mtv.corp.google.com>
Subject: Re: name for A..B ranges?
Date:	Sat, 25 Jun 2016 14:50:16 +0100
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
X-CMAE-Envelope: MS4wfGlsPA6nmexC+AqVSk4zDJ3ZU74S5CLwV/vqOjHeBkHWn68IsL4e0tUADOwKRHWGB7Zjr0qr7uv96abqNf1PZ2PIfSY63eePUqWQ0VimmgYVOFolpQTf
 wq+U+R5JGxfxLVjV5HRVrLdOa3yqww50teCaq58eQC1I3Mfcg9Ksl6P89mbHaXpbB2qqbKpvvS2f6x2wjMXQ57tBDxie+aTWXtQ=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: "Junio C Hamano" <gitster@pobox.com>
> Jeff King <peff@peff.net> writes:
>
>> On Wed, Jun 22, 2016 at 08:25:59AM +0100, Philip Oakley wrote:
>>
>>> Is there a common name for the A..B range format (two dots) that would
>>> complement the A...B (three dots) symmetric range format's name?
>>>
>>> I was looking at the --left-right distinctions and noticed that the 
>>> trail
>>> back to the symmetric range description was rather thin (it's buried 
>>> within
>>> gitrevisions:Specifying Ranges, and even then its called a symmetric
>>> difference.
>>
>> I would just call it a range, or possibly a set difference. But I don't
>> think we have any established naming beyond that.
>
> Yup, I think "range" is the commonly used word in discussions here.
> When inventing A...B as a new thing in addition to A..B, we called
> the former "symmetric difference", and what is implied by that is
> the latter is "asymmetric difference"; we do not say that unless we
> are contrasting between the two, though.
>
I asked because the man page does indicae that it (A..B) is a special sort 
of revison range and "there is a shorthand for it", but then didn't have a 
way of naming it.

The symmetric difference is then brought in as a further similar notation. 
There are a number of Stackoverflow questions about the differences betwee 
'two dots' and 'three dots' as well, so having a word/phrase for it could 
help.

I was thinking that maybe "single-sided difference (two dots)" maybe one 
choice that is relatively neutral (or even a "two-dot range"...).

--
Philip 

