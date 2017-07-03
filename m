Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4931202AB
	for <e@80x24.org>; Mon,  3 Jul 2017 19:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752255AbdGCTNE (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jul 2017 15:13:04 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:64710 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752038AbdGCTND (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2017 15:13:03 -0400
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id S6mKdzJx80DqZS6mKdDsgw; Mon, 03 Jul 2017 20:13:01 +0100
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=PvPRVEE3 c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=8nJEP1OIZ-IA:10 a=ybZZDoGAAAAA:8
 a=xtxXYLxNAAAA:8 a=3Eyz6yWsl_VLsd-ZWU0A:9 a=wPNLvfGTeEIA:10
 a=0RhZnL1DYvcuLYC8JZ5M:22 a=xts0dhWdiJbonKbuqhAr:22
Message-ID: <C31723137B784D54A3CDB1B7D9432D7E@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>
References: <xmqqk23tp2jk.fsf@gitster.mtv.corp.google.com>        <4374FA169AD7465AA39BDB477A348B02@PhilipOakley> <xmqqo9t1l6vi.fsf@gitster.mtv.corp.google.com>
Subject: Re: What's cooking in git.git (Jun 2017, #09; Fri, 30)
Date:   Mon, 3 Jul 2017 20:13:02 +0100
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
X-Antivirus: AVG (VPS 170703-0, 03/07/2017), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfGFpwiWVAvdwinNLlUx02uxavbor8He+U0u72frfbW6jDWWy/VxBdLpfDAq9wDM86uFXK7Y5p+NkEZcu01MWfAzlrt7+ByhR2O4r1Joz+t4f9NiXtOBq
 nHQo2LgDYSSISXPL/Ozq3iNNdl+mJ3RXqci0U/+RZka/wEI5v+hnk/U5U8UCFwKRZGO+wJis00L7FA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Junio C Hamano" <gitster@pobox.com>
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>> Junio,
>> Is it possible to include a table of contents that lists the
>> integration branches, split by your categories, to help find areas of
>> interest?
>>
>> [Graduated to "master"]
>> * topic list
>> [New Topics]
>> [Stalled]
>> [Cooking]
>> [Discarded]
>>
>> The TOC wouldn't need the [] or * markings if that's a problem.
>
> I am not sure what you are asking.  Is this the command you are
> looking for?
>
> $ grep -e "^[[*]" whats-cooking.txt
>
Ah, thanks.

It does presume that one has extracted the email to the text file, which is 
easier on some systems and mail clients than others ;-)
Am I right that the What's cooking  is prepared by a script?
--
Philip 

