Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A66A41F859
	for <e@80x24.org>; Fri, 12 Aug 2016 19:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751900AbcHLTUV (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 15:20:21 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:31185 "EHLO
	smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751570AbcHLTUU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 15:20:20 -0400
Received: from PhilipOakley ([92.22.69.35])
	by smtp.talktalk.net with SMTP
	id YI09bWLa5Y8RwYI09bsXFZ; Fri, 12 Aug 2016 20:20:18 +0100
X-Originating-IP: [92.22.69.35]
X-Spam:	0
X-OAuthority: v=2.2 cv=b+Xw2ZOx c=1 sm=1 tr=0 a=118V6UEFpCLMRzptT8w30g==:117
 a=118V6UEFpCLMRzptT8w30g==:17 a=N659UExz7-8A:10 a=8q6LdnVOAAAA:8
 a=8ePtGGE778YcKzue-YsA:9 a=jNYSTCpFY2gkngftge3H:22
Message-ID: <30B1A2CFFF9A4544A8F03800FA5968BD@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:	"Philip Oakley" <philipoakley@iee.org>
To:	"GitList" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Marc Branchaud" <marcnarc@xiplink.com>
References: <20160720211007.5520-1-philipoakley@iee.org> <20160812070749.2920-1-philipoakley@iee.org> <58d0df88-4902-4519-df21-3ba3d86a19c9@xiplink.com>
Subject: Re: [PATCH v5 00/12] Update git revisions
Date:	Fri, 12 Aug 2016 20:20:16 +0100
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
X-CMAE-Envelope: MS4wfJc4q+mkrW/1CpBJfkvFfNatVTsM3dRKVnjv8EwFxs7hZHahbCzVnNeADW/alfSNfFdvSZWxEuUCiN1ZwT4GKT8unXYwXh5V3ZU9/uBXz3f+6e5VV2pu
 tLswwZsD8Je8Ea3y2ypvqkpR8aFL/RNDeHyQs6dWH+X4I+MRrIKIM6X0leJ25xP8Vvkpn7jkI8m1xIYnjBNPheD/smjq1ywJN0HpOq3HFJgixwl+t23FFRNJ
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: "Marc Branchaud" <marcnarc@xiplink.com>
> On 2016-08-12 03:07 AM, Philip Oakley wrote:
>> [2nd attempt : ISP troubles]
>>
>> This has grown like topsy from a little two patch series that tried to
>> name the 2-dots notation [1] into this extended set of tweaks.
>
> Honestly, I start just trying point out something concrete, like 
> misrendered headers, but then I figure since I'm sending a review comment 
> anyway I might as well go in-depth on the rest of the patch.
>
> I think I'm sticking to substantive comments, but if I'm getting too picky 
> please just swat me down!

No, that's fine. It's important to at least review these points.

I thought I'd picked up all the issues, but it looks like I missed at least 
one.

The caret thing has a bit of history - see 87c6aeb4efdd43559

It looks like its the two carets on a line mean superscript (Unconstrained 
quotes) and that maybe the issue.

Then it looks like {caret} does a replacement, though I can't find that in 
the asciidoc user guide.


I don't quite understand why the ^ symbols work for the Loliger examples, 
but hey ho, it's good they do...

I'll work on the tweaks, though it'll probably be tomorrow as we have 
visitors.

--
Philip 

