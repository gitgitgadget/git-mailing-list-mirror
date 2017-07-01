Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,STOX_REPLY_TYPE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DDAC20209
	for <e@80x24.org>; Sat,  1 Jul 2017 18:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752037AbdGASky (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Jul 2017 14:40:54 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:29013 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751911AbdGASkx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jul 2017 14:40:53 -0400
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id RNK7drEDhr1MoRNK7dErTM; Sat, 01 Jul 2017 19:40:51 +0100
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=ceCQlTLM c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=8nJEP1OIZ-IA:10 a=ybZZDoGAAAAA:8
 a=pGLkceISAAAA:8 a=hDZvntRJNyjRc6vnVH8A:9 a=wPNLvfGTeEIA:10
 a=0RhZnL1DYvcuLYC8JZ5M:22 a=6kGIvZw6iX1k4Y-7sg4_:22
Message-ID: <54E752528FED4662912D8CC94B19513D@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Junio C Hamano" <gitster@pobox.com>,
        "Kaartic Sivaraam" <kaarticsivaraam91196@gmail.com>
Cc:     <git@vger.kernel.org>,
        "Christian Couder" <christian.couder@gmail.com>
References: <20170630154306.26993-1-kaarticsivaraam91196@gmail.com>        <xmqq1sq1togq.fsf@gitster.mtv.corp.google.com>        <1498918546.4321.1.camel@gmail.com> <xmqqfuegnjnt.fsf@gitster.mtv.corp.google.com>
Subject: Re: [PATCH] hooks: add signature to the top of the commit message
Date:   Sat, 1 Jul 2017 19:40:52 +0100
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
X-Antivirus: AVG (VPS 170630-2, 30/06/2017), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfBv94KEwr/PluboCCF7FwDa5x1GbuLMeLJuseBu75Ifl1/KWhoZmpQO5EFPi3igFaRKNR9PzqiBWaU8dEmqjGCHAJYquv7Q5Zh6zaVU+j1lUrHDStJOH
 e0g6sooGsELRFnGCQtHtdKwkMlin59ehpIUy7/qm82LxTegaxa/WpTbif0w/QYAXYncU+jyzMlr+LBPg7oT2n365l80+1SMq6EQr44Zd6Q9Yp4P2keBIFdA8
 bQF0hpkvABB5NeQxjkVjVcsggVEgVCA/o91eP4ToKME=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Junio C Hamano" <gitster@pobox.com>
> Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:
>
>>> By the way, the one that is still actually enabled is no longer
>>> needed.  The commit template generated internally was corrected some
>>> time ago not to add the "Conflicts:" section without commenting it
>>> out.
>>>
>> I'll send in another patch that removes it but it seems removing it
>> would leave sample hook without anything turned on by default. That
>> doesn't sound fine, does it?
>
> Actually I was wondering if it is a good idea to remove it, as it
> seems to have outlived its usefulness.

Personally, I like the comfort of seeing the Conflicts: list, but if others 
have indicated otherwise...
--
Philip 

