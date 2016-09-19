Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19FE02070F
	for <e@80x24.org>; Mon, 19 Sep 2016 20:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753000AbcISUMw (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 16:12:52 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:12243 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752901AbcISUMv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 16:12:51 -0400
Received: from PhilipOakley ([92.22.33.116])
        by smtp.talktalk.net with SMTP
        id m4vobetWAxR4bm4vobyf9z; Mon, 19 Sep 2016 21:12:49 +0100
X-Originating-IP: [92.22.33.116]
X-Spam: 0
X-OAuthority: v=2.2 cv=JNN5iICb c=1 sm=1 tr=0 a=7PoCAWDTb98b1EGiAsJI/w==:117
 a=7PoCAWDTb98b1EGiAsJI/w==:17 a=8nJEP1OIZ-IA:10 a=ybZZDoGAAAAA:8
 a=xtxXYLxNAAAA:8 a=3Eyz6yWsl_VLsd-ZWU0A:9 a=wPNLvfGTeEIA:10
 a=0RhZnL1DYvcuLYC8JZ5M:22 a=xts0dhWdiJbonKbuqhAr:22
Message-ID: <DDC820F0373F4534B4A9D12E8B7B866B@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     "Michael J Gruber" <git@drmicha.warpmail.net>,
        "Git List" <git@vger.kernel.org>
References: <2AD952BD65034D25BF26C7F138D24F25@PhilipOakley><3b06b9ee-3975-acf1-41d8-02b774a2dd3c@drmicha.warpmail.net><xmqq8tunhns4.fsf@gitster.mtv.corp.google.com><989F47918A374EEF8C7FECD3CFC6767E@PhilipOakley> <xmqqintrek64.fsf@gitster.mtv.corp.google.com>
Subject: Re: clarification of `rev-list --no-walk ^<rev>`?
Date:   Mon, 19 Sep 2016 21:12:51 +0100
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
X-CMAE-Envelope: MS4wfGbs+/WrKapqUFsLgAz+xIWFXtqSJezGQM/KJaWCNIb/wGIRNIEfx9yO6xhHddJ0MgF+jtt0lpD7LM1Rcbasf07f1l7nrZyeIktPamfR5F0SZc2eu81J
 EY9hbBNbDIbmsbOQpyfpKjZEir6ys2jY8s+5t5J1OddligON5GMuUTcEOi20/1YUyLVT/7CVEj0JScBqGdUiJ3BfEsqi+wRn6SVyY/ohzez5GrbdRdboyU3k
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Junio C Hamano" <gitster@pobox.com>
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>>>     Philip probably has a
>>> confused notion

Hi Junio,

Could you clarify a particular point from here..

> The "--no-walk" tells the rev-list machinery "I have only positives;
> do not traverse from them AT ALL but just use these positives".
> Only under that condition, the order of the positive ends you list
> on the command line matters.

What does "--do-walk" do ("Overrides a previous --no-walk"), and when would 
it be applied?

--
Philip 

