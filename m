Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 716D71F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 20:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbcHOUqS (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 16:46:18 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:34671 "EHLO
	smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932182AbcHOUqR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 16:46:17 -0400
Received: from PhilipOakley ([92.22.3.79])
	by smtp.talktalk.net with SMTP
	id ZOm0bclC40KuvZOm0bJvqV; Mon, 15 Aug 2016 21:46:16 +0100
X-Originating-IP: [92.22.3.79]
X-Spam:	0
X-OAuthority: v=2.2 cv=RZjSMBlv c=1 sm=1 tr=0 a=LkKjIWfvQdKNf3TZC4q4CQ==:117
 a=LkKjIWfvQdKNf3TZC4q4CQ==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=nGgYIBRuMf6PUNQpss0A:9 a=6kGIvZw6iX1k4Y-7sg4_:22
Message-ID: <3E80981D72F74A11A41A228901644E1C@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:	"Philip Oakley" <philipoakley@iee.org>
To:	"Jacob Keller" <jacob.keller@gmail.com>
Cc:	"Duy Nguyen" <pclouds@gmail.com>,
	"Stefan Beller" <sbeller@google.com>,
	"Git List" <git@vger.kernel.org>
References: <CA+P7+xpHDGY5RTR8ntrABdxqM6b4V9dndS68=kV1+1Ym1N6YKw@mail.gmail.com> <CAGZ79kba36GprgHA04_q4NmY2=_amoWyafUaLKkcknc3HsT_-g@mail.gmail.com> <CACsJy8C51UkH=tLSfGigAF0JjPxVS3fY0EHi0CNVRG8LY8YiCg@mail.gmail.com> <CA+P7+xo4UJ8W4G0gV=DMLs-9Ve4v0OKc0ZunmS5Y5B1k7L0P9w@mail.gmail.com> <CAGZ79kb27JZepMD5AmrHjOnf8haE8LehZd_CkvOQ1UoLEDuxKQ@mail.gmail.com> <CACsJy8BdmR5USJvjJ6xbjj=bP787tdS72_oL+PDq0D+FPYmiPA@mail.gmail.com> <DD86BC6E2E3245BA991E4D65CE66E4A8@PhilipOakley> <CA+P7+xqbmZznxq024fhkejp2FeCVYkOYHTSdR69Di3nkzYJooA@mail.gmail.com>
Subject: Re: storing cover letter of a patch series?
Date:	Mon, 15 Aug 2016 21:46:16 +0100
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
X-CMAE-Envelope: MS4wfE/gqNhi2u7lH8/+ktUfBjPgaoIL7+Kwb67xmr3su2pRgtddG5JTakUL6KEjMDGjsR+smugGiudH+GrsxP3Kg7XWKAxt6zX9ZH0WBk/0O1sLPrpZHFuU
 Ohw8Gc8Ro6t3ND8HFNuqnHEbVouOy6VUAnspW1n3UkYWp02tHyOAhArCZNsuZC/ZiEuHRzKKTbyoRql2NcTQW500UPtORKdj0y6eQ6gS12Ma2PhxUb6gL/u9
 GpSZeGtLcQ8FEv2sToZyXw==
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: "Jacob Keller" <jacob.keller@gmail.com>
[nip]
>>
>> I've no problem with more extensive methods for those preparing very big
>> patch series, or with those needing to merge together a lot of series and
>> want to keep the cover letters, but ensuring that a simple flow is 
>> possible
>> should still be there.
>> --
>> Philip
>>
>
> Some people have suggested this simple idea, and I like it, but they
> did mention that modifying the cover letter now requires a rebase over
> a potentially large series of patches, which can get annoying.
>
> Thanks,
> Jake

They can just add "squash! cover! <series>" commits for that ;-) Though more 
likely the advanced workflow would be used... We'll need both (more than 
one) options.
--
Philip 

