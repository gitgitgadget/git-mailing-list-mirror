Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5746420A10
	for <e@80x24.org>; Tue,  7 Nov 2017 00:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755351AbdKGAbZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Nov 2017 19:31:25 -0500
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:7269 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933284AbdKGAaQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Nov 2017 19:30:16 -0500
Received: from PhilipOakley ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id BrmQek6sEAp17BrmQeNuxK; Tue, 07 Nov 2017 00:30:15 +0000
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.2 cv=EsGilWUA c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=IkcTkHD0fZMA:10 a=ybZZDoGAAAAA:8
 a=UziyymQPB0BlTLtpBHUA:9 a=QEXdDO2ut3YA:10 a=0RhZnL1DYvcuLYC8JZ5M:22
Message-ID: <F055F8BD064E4C268C3CC477C09ABD02@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Junio C Hamano" <gitster@pobox.com>,
        "Ann T Ropea" <bedhanger@gmx.de>
Cc:     "Git Mailing List" <git@vger.kernel.org>,
        "Daniel Barkalow" <barkalow@iabervon.org>
References: <20171105162730.31405-1-bedhanger@gmx.de> <xmqqtvy8i0pw.fsf@gitster.mtv.corp.google.com>
Subject: Re: [PATCH 1/3] checkout: describe_detached_head: remove 3dots after committish
Date:   Tue, 7 Nov 2017 00:30:13 -0000
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="utf-8";
        reply-type=original
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Antivirus: AVG (VPS 171106-2, 06/11/2017), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfD4RlLFIFWFzJw5tPvIEmC8r7eSzvFfCsFNxY9D3vghhHHz7eVGG/5aBMUbLYzt372DzHfPqOf8oCfHhgUqv3RFm9bao/liwtjjWKbxt26OA1ioIAQvh
 de27avoy+aB1orZmpj0Q221w1i0OaH2uChZstqoH/JJu0f3MO84vs6NnszfVljuO4dTIBu3GseO0eHW8e2WjcIWPns+1sJpSkNJGuNs2HzHJF9m9iaSV/tLq
 5uRAU2c93Zca9gkmc6bCIg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Junio C Hamano" <gitster@pobox.com>
> Ann T Ropea <bedhanger@gmx.de> writes:
>
>> This could be confusing not only for novices; in either case, no range
>> should be insinuated by describe_detached_head.
>
> We actually do not insinuate any range in these output.  These dots
> denote "truncated at the end, instead of giving full length."
>
> Another place these "many dots" appear is "git diff --raw", for
> example.
>

<bikeshed> The fancy word for the three dots is an `ellipsis`
- the omission from speech or writing of a word or words that are 
superfluous or able to be understood from contextual clues.
- from the Ancient Greek: ἔλλειψις, élleipsis, "omission" or "falling 
short".

The user/reader confusion may still be there though.
</bikeshed> 

