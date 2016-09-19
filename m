Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38ADF2070F
	for <e@80x24.org>; Mon, 19 Sep 2016 20:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751966AbcISUo4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 16:44:56 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:17181 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751261AbcISUoz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 16:44:55 -0400
Received: from PhilipOakley ([92.22.33.116])
        by smtp.talktalk.net with SMTP
        id m5QqbexelxR4bm5QqbygfZ; Mon, 19 Sep 2016 21:44:53 +0100
X-Originating-IP: [92.22.33.116]
X-Spam: 0
X-OAuthority: v=2.2 cv=JNN5iICb c=1 sm=1 tr=0 a=7PoCAWDTb98b1EGiAsJI/w==:117
 a=7PoCAWDTb98b1EGiAsJI/w==:17 a=8nJEP1OIZ-IA:10 a=ybZZDoGAAAAA:8
 a=xtxXYLxNAAAA:8 a=RofseRt18CATfGM-sU0A:9 a=wPNLvfGTeEIA:10
 a=0RhZnL1DYvcuLYC8JZ5M:22 a=xts0dhWdiJbonKbuqhAr:22
Message-ID: <9B75514A5DC94A5D86FAFB66BF66E9B0@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     "Michael J Gruber" <git@drmicha.warpmail.net>,
        "Git List" <git@vger.kernel.org>
References: <2AD952BD65034D25BF26C7F138D24F25@PhilipOakley>        <3b06b9ee-3975-acf1-41d8-02b774a2dd3c@drmicha.warpmail.net>        <xmqq8tunhns4.fsf@gitster.mtv.corp.google.com>        <989F47918A374EEF8C7FECD3CFC6767E@PhilipOakley> <xmqqintrek64.fsf@gitster.mtv.corp.google.com>
Subject: Re: clarification of `rev-list --no-walk ^<rev>`?
Date:   Mon, 19 Sep 2016 21:44:54 +0100
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
X-CMAE-Envelope: MS4wfKK0KA8vTvFXX0vnAnzLLJZ5BMn2nyRRg/tGWmrFE7B9gAGq7MY0kLaK6QDxEnPgteP1eB0SnAN4ncxM6ew8mdfA1Uf9d9etnqneL1E2CaR3vmXPgdpJ
 iL/nb4VBYJ2V+iMVhTZdQqRKcYjIUVvDT+PuNQN2V4S0WLnCnm0InIOJUxXf4/C1E0BEzS328uFzOPZMrcpriLWz7yxj7DIB8eGZwxh2/BLipPyW7pOX68Zf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Junio C Hamano" <gitster@pobox.com>
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>>>     Philip probably has a
>>> confused notion that "rev-list A..B C..D" is somehow a union of set
>>> A..B and C..D?
>>
>> That wasn't the issue. Though it does beg the question that it's the
>> same as "rev-list D B ^A ^C" isn't it?
>
> If you think it begs the question, then you haven't understood what
> I meant by all of the explanation.  Let me repeat:

Apologies. We appear to be having an British/American usage 
misunderstanding. Locally, the answer to the begged (rhetorically asked) 
question is, as you say, "Yes, they are the same". It was simply confirming 
our common understanding.

>
> "A..B C..D" is exactly a short-hand for "^A B ^C D" which is
> the same as ANY permutation like "D B ^A ^C".
>

regards,
Philip 

