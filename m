Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9739520699
	for <e@80x24.org>; Fri, 28 Oct 2016 16:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965911AbcJ1QcG (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 12:32:06 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:58149 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938026AbcJ1QcC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 12:32:02 -0400
Received: from PhilipOakley ([92.22.74.108])
        by smtp.talktalk.net with SMTP
        id 0A4Tc6zL0gKst0A4Wcr5Ss; Fri, 28 Oct 2016 17:32:01 +0100
X-Originating-IP: [92.22.74.108]
X-Spam: 0
X-OAuthority: v=2.2 cv=GdBVpkfL c=1 sm=1 tr=0 a=gemZZafLxLrjWEucDwrW+g==:117
 a=gemZZafLxLrjWEucDwrW+g==:17 a=8nJEP1OIZ-IA:10 a=ybZZDoGAAAAA:8
 a=zt4M0vM_rS_3yaQlNlgA:9 a=wPNLvfGTeEIA:10 a=0RhZnL1DYvcuLYC8JZ5M:22
Message-ID: <F9BA48672D734288B0A079846AFC8498@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Junio C Hamano" <gitster@pobox.com>,
        "Stefan Beller" <sbeller@google.com>
Cc:     "Brandon Williams" <bmwill@google.com>,
        "Git List" <git@vger.kernel.org>
References: <20161027223834.35312-1-bmwill@google.com>        <xmqqk2ct4bmr.fsf@gitster.mtv.corp.google.com>        <CAGZ79kYm1txscyBpmfJQceCLFrZAN09y-2nV1zCjE2a1+_jrLA@mail.gmail.com> <xmqq1sz1425w.fsf@gitster.mtv.corp.google.com>
Subject: Re: [RFC PATCH 0/5] recursively grep across submodules
Date:   Fri, 28 Oct 2016 16:06:18 +0100
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
X-CMAE-Envelope: MS4wfHv+pZcYf+md0nJ0z23qGAbBD1NhWvWnd7LfQr72Nm8wNYlt0PtTesWwADfHr6Vn9vpWQYdjRuez9SOEiwp/5lJJTtrUSh4bojNiSUzXOwjLMcfMDMcY
 n1DS697zJ3yfVBgV5kgPHLLk9CrRhjvcGh5FJJMxg3T5IEWewvoue9VZZMGQMgAkc3caEZixcSugQ4mI5bRfWU6/upcAs4aOe4O8xPlsY+i4EZ2iHbQrLDrK
 2dDkyAs2w2g/JuXQvK7hGg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Junio C Hamano" <gitster@pobox.com>
>
> I hate it when people become overly defensive and start making
> excuses when given harmless observations.
>

Hi Junio,

It can sometimes be difficult for readers to appreciate which way comments 
are meant to be interpreted, especially as one cannot usually 'see' the 
issue being raised with one's personal work, no matter who writes them. I 
too have to supportively review the work of others (as a volunteer), who 
then don't always respond or understand, as hoped, and it can be 
frustrating.

It can be very hard to write a reasonable write up that gets the balance 
between being on the one hand patronising (e.g. over-explained) and on the 
other too terse, and yet still not be too nuanced that the points are 
missed. The responder has the similar problem, especially if they have 
misunderstood the comment, and then end up just end up digging the hole 
deeper by over-explaining their position. Extricating the discussion from 
the trap can be tricky.

Thank you for your reviews.
--
Philip 

