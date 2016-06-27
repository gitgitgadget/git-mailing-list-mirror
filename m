Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 004D02018A
	for <e@80x24.org>; Mon, 27 Jun 2016 13:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751817AbcF0Nhk (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 09:37:40 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:49123 "EHLO
	smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869AbcF0Nhj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 09:37:39 -0400
Received: from PhilipOakley ([92.22.77.210])
	by smtp.talktalk.net with SMTP
	id HWjHbZsOFWqMCHWjHbBZWi; Mon, 27 Jun 2016 14:37:36 +0100
X-Originating-IP: [92.22.77.210]
X-Spam:	0
X-OAuthority: v=2.2 cv=PNpNwriC c=1 sm=1 tr=0 a=cCrl+6OZiP8jn5MmZEBMUQ==:117
 a=cCrl+6OZiP8jn5MmZEBMUQ==:17 a=8nJEP1OIZ-IA:10 a=ybZZDoGAAAAA:8
 a=xtxXYLxNAAAA:8 a=zcIeSEVUdEuAh7XjdX0A:9 a=0RhZnL1DYvcuLYC8JZ5M:22
 a=xts0dhWdiJbonKbuqhAr:22
Message-ID: <8001594309A04A42859024BAEB8FF188@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:	"Philip Oakley" <philipoakley@iee.org>
To:	"Junio C Hamano" <gitster@pobox.com>
Cc:	"Jeff King" <peff@peff.net>, "Git List" <git@vger.kernel.org>
References: <0648000B273C412AB7140AE959EBC99A@PhilipOakley><20160624160943.GA3170@sigill.intra.peff.net><xmqqh9cih6ym.fsf@gitster.mtv.corp.google.com><E61B46FFA8874DD3973AA96BE5B36790@PhilipOakley> <xmqqwpldcamb.fsf@gitster.mtv.corp.google.com>
Subject: Re: name for A..B ranges?
Date:	Mon, 27 Jun 2016 14:37:35 +0100
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
X-CMAE-Envelope: MS4wfI/aZL+jElPYQ1em0NQy7YdSg0v0KsaLSnvA8bdsXj2dmBb2IX5VxHpYPSxnw7+n+nVVSVdA2OxPb18vBwSoj4W3VX1zuddOs+tYxl3QtJcfebNJ9rf2
 /1PTgZFyvdMhNxWXeaawgZzZqmwfX9r/64oy6N1j/kT62TI7NA2x6Sq2NRKkLW01b3udwJPmUP0IhVxB/11gOh65h5AkPy1xBio+IRpRrcCnafXKrTlh+nXE
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: "Junio C Hamano" <gitster@pobox.com>
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>>> Yup, I think "range" is the commonly used word in discussions here.
>>> When inventing A...B as a new thing in addition to A..B, we called
>>> the former "symmetric difference", and what is implied by that is
>>> the latter is "asymmetric difference"; we do not say that unless we
>>> are contrasting between the two, though.
>>>
>> I asked because the man page does indicae that it (A..B) is a special
>> sort of revison range and "there is a shorthand for it", but then
>> didn't have a way of naming it.
>
> I do not see "is a special sort of revision range" improved in your
> two patches, though.

Hi Junio

I'm not sure what's meant here. That patch was about ensuring that the 
relevant syntax notations had headings to make them more easily locatable, 
not to change the explanations.

>
> Knowing that A..B is merely a short-hand for ^A B is important to
> understand how revision ranges work (e.g. "A..B C" is not "union of
> A..B and C"), so I think it is worth addressing if the existing
> description appeared to you that it may confuse readers.

I felt the explanations, once found, were OK. It was the discovery step I 
was hoepfully addressing.
>
>> The symmetric difference is then brought in as a further similar
>> notation. There are a number of Stackoverflow questions about the
>> differences betwee 'two dots' and 'three dots' as well, so having a
>> word/phrase for it could help.
>>
>> I was thinking that maybe "single-sided difference (two dots)" maybe
>> one choice that is relatively neutral (or even a "two-dot range"...).
>
> When contrasting .. and ..., we have always used "asymmetric" vs
> "symmetric".  I'd prefer to see usnot invent new phrase nobody has
> used, which leads to unnecessary confusion and learning burden.

Rather than trying to find a complement to the previously invented 
"symmetric difference" name (for the section heading), I was wondering if an 
alternative would be to refer to it via [use the headings of] it's notation, 
i.e. "the 'two-dot' range notation" (or 'syntax' is that is preferred), and 
the "three-dot symmetric difference notation".

The existing explanatory text can stand as is, but they would now have a 
section for readers to find.

Or should I just drop this?

--
Philip

