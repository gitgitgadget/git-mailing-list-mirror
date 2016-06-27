Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D2A72018A
	for <e@80x24.org>; Mon, 27 Jun 2016 15:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751964AbcF0PjY (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 11:39:24 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:59067 "EHLO
	smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751878AbcF0PjW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 11:39:22 -0400
Received: from PhilipOakley ([92.22.77.210])
	by smtp.talktalk.net with SMTP
	id HYd5baA0oWqMCHYd5bBeT8; Mon, 27 Jun 2016 16:39:20 +0100
X-Originating-IP: [92.22.77.210]
X-Spam:	0
X-OAuthority: v=2.2 cv=PNpNwriC c=1 sm=1 tr=0 a=cCrl+6OZiP8jn5MmZEBMUQ==:117
 a=cCrl+6OZiP8jn5MmZEBMUQ==:17 a=8nJEP1OIZ-IA:10 a=ybZZDoGAAAAA:8
 a=xtxXYLxNAAAA:8 a=iuTkAwPzMwEpf_tTGaUA:9 a=0RhZnL1DYvcuLYC8JZ5M:22
 a=xts0dhWdiJbonKbuqhAr:22
Message-ID: <276137126E354C29A6F472556B76B3D6@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:	"Philip Oakley" <philipoakley@iee.org>
To:	"Junio C Hamano" <gitster@pobox.com>
Cc:	"Jeff King" <peff@peff.net>, "Git List" <git@vger.kernel.org>
References: <0648000B273C412AB7140AE959EBC99A@PhilipOakley><20160624160943.GA3170@sigill.intra.peff.net><xmqqh9cih6ym.fsf@gitster.mtv.corp.google.com><E61B46FFA8874DD3973AA96BE5B36790@PhilipOakley><xmqqwpldcamb.fsf@gitster.mtv.corp.google.com><8001594309A04A42859024BAEB8FF188@PhilipOakley> <xmqq4m8ed5zu.fsf@gitster.mtv.corp.google.com>
Subject: Re: name for A..B ranges?
Date:	Mon, 27 Jun 2016 16:39:19 +0100
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
X-CMAE-Envelope: MS4wfLWeyRL5zNNZGJ3qv19kfvLFeK/M0xSrRH8w+FDWnc5+RLVZlC/6joP9b3eyZq5GjQ/NItvxQYhKDCb/kI20DVG0bh4ZPE3QslglWMrO/Y1SGSNvW44G
 90wvY6s5deOL6sIsirQ+A13N/WEe8r6OjnFqAzGbR6NyDX3sx5bKqtfdqN7KadLBb/u0pt/KTkbwAsUuGqNCtAJhF7Mit/vstZV3Mt0FTFD9c/S1XwiVo3S7
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: "Junio C Hamano" <gitster@pobox.com>
> "Philip Oakley" <philipoakley@iee.org> writes:
> 
>> ..., I was wondering
>> if an alternative would be to refer to it via [use the headings of]
>> it's notation, i.e. "the 'two-dot' range notation" (or 'syntax' is
>> that is preferred), and the "three-dot symmetric difference notation".
> 
> That's a lot more sensible pair of headings, I would think.
> 
>> The existing explanatory text can stand as is, but they would now have
>> a section for readers to find.
>>
>> Or should I just drop this?
> 
> I like the approach to separate them into clearly marked sections.
> I primarily was reacting to the "single-sided" which nobody would
> understand.
> --

Thanks, I'll update the patches (probably tomorrow)
Philip
