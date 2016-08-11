Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1DE820193
	for <e@80x24.org>; Thu, 11 Aug 2016 18:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbcHKS5v (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 14:57:51 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:25267 "EHLO
	smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888AbcHKS5u (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 14:57:50 -0400
Received: from PhilipOakley ([92.22.69.35])
	by smtp.talktalk.net with SMTP
	id XvApbUQR40KuvXvApbHxQ7; Thu, 11 Aug 2016 19:57:48 +0100
X-Originating-IP: [92.22.69.35]
X-Spam:	0
X-OAuthority: v=2.2 cv=RZjSMBlv c=1 sm=1 tr=0 a=118V6UEFpCLMRzptT8w30g==:117
 a=118V6UEFpCLMRzptT8w30g==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=xtxXYLxNAAAA:8 a=akrM_3bkTot6gdNX614A:9 a=6kGIvZw6iX1k4Y-7sg4_:22
 a=xts0dhWdiJbonKbuqhAr:22
Message-ID: <4AF832719F594FF487BFEFBC9D289942@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:	"Philip Oakley" <philipoakley@iee.org>
To:	"Jacob Keller" <jacob.keller@gmail.com>
Cc:	"Git List" <git@vger.kernel.org>
References: <D8F2D8316A4C4E198C6847C1165A8811@PhilipOakley> <CA+P7+xpyCQLsEHE-Hqqob5mQisW=aw1gC+5f6Qq3q01etjX2Ng@mail.gmail.com> <CA+P7+xrBegRdS-HXi2SfO0Uu6N=gUVVp_F29GCb1rQn9cnxnHQ@mail.gmail.com>
Subject: Re: Can cc's be included in patches sent by send-email
Date:	Thu, 11 Aug 2016 19:57:46 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfOvoPeGXKTsdEjdfJUVPvbmMlNxVT9XC0gjjBzDw/j+UxHFz+rMd4EPI7wIR6QkBOoiiXDBFy8tHIc72lVDJPOofjJ0apNKoL9JXvesf3Ni54Ls4iWjN
 vPj75Xos1MJj5Z+CVgMmimr61ttnOEeaU5aV7TSbpTCpjzDCzVi8N/txEtxckThbw6kW+Xa6IC37SkG8c/oqHFTyRhTTY208Q0g=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: "Jacob Keller" <jacob.keller@gmail.com>
> On Thu, Aug 11, 2016 at 12:58 AM, Jacob Keller <jacob.keller@gmail.com> 
> wrote:
>> On Thu, Aug 11, 2016 at 12:32 AM, Philip Oakley <philipoakley@iee.org> 
>> wrote:
>>> While 'git send-email' can have multiple --cc="addressee" options on the
>>> command line, is it possible for the "cc:addressee<a@b.c>" to actually 
>>> be
>>> included in the patches that are to be sent, so that different patches 
>>> can
>>> have different addressee?
>>>
>>> The fortmat-patch can include appropriate from lines, so it feels as if 
>>> the
>>> sender should be able to add cc: lines at the same place. Maybe its just
>>> part of th docs I've missed.
>>>
>>
>> Yes, just put them in the body as tags below the signed-off-by. It
>> should be on by default unless you change supresscc or signedoffbycc
>> configuration.
>>
>> Thanks,
>> Jake
>>
>
> See --suppress-cc or --signed-off-by-cc help in git help send-email.
>
> Thanks,
> Jake

Thanks,
I'll look at that. It wasn't immediately obvious what to do.

Philip 

