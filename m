Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,STOX_REPLY_TYPE,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBCD21F406
	for <e@80x24.org>; Mon,  8 Jan 2018 11:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756222AbeAHLnq (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 06:43:46 -0500
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:29464 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756014AbeAHLnp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 06:43:45 -0500
Received: from PhilipOakley ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id YVqBeJ51hpb8rYVqBeVUKW; Mon, 08 Jan 2018 11:43:43 +0000
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.2 cv=ZM2noTzb c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=IkcTkHD0fZMA:10 a=wAQilCZWYVuxtQFh7EoA:9
 a=QEXdDO2ut3YA:10
Message-ID: <5D41958DFAC74BD8B69761D171C572DB@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     <git@vger.kernel.org>,
        "Friedrich Spee von Langenfeld" <stehlampen@arcor.de>
References: <5fb2c981-7a7b-5a0f-f2bb-b16189980d9b@arcor.de>
Subject: Re: Errors and other unpleasant things found by Cppcheck
Date:   Mon, 8 Jan 2018 11:43:42 -0000
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
X-Antivirus: AVG (VPS 180108-0, 08/01/2018), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfPru2mBtfVN/5KlsO5a5PQCCn0voN1JDiaija4DtZyQaD4ulRV8v2Lesk5NlEZfdiI6xSRLRupJ0riq2PK4947PhtLPIcEKljIQcpY3olf7rl41Pp9wY
 mXwrOWBdj99kXIGbTBV/j4r6ix+UnhflMdbHla+mZbjvOPP+IarplLcd0AFsSBMo0+ww2Upykh271jqjjaIHJy9QVaW+eunxaBk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Friedrich Spee von Langenfeld" <stehlampen@arcor.de>
> Hi,
>
> I analyzed the GitHub repository with Cppcheck. The resulting XML file
> is attached. Please open it in Cppcheck to view it comfortably.
>
> Especially the bunch of errors could be of interest to you.
>
Hi,

Thanks for the submission.

The list prefers that useful information is in plain text so as to avoid 
opening file types that may hide undesirable effects.

Was your analysis part of an organised scan, or a personal insight? It would 
help to know the background.

The project does have a number of known and accepted cases of 'unitialised 
variables' and known memory leaks which are acceptable in those cases.

If you picked out the few key issues that you feel should be addressed then 
a patch can be considered, e.g. the suggestion of the wildmatch macro (L263) 
that depends on the order of evaluation of side effects.

--
Philip 

