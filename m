Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9246B201C8
	for <e@80x24.org>; Fri, 10 Nov 2017 00:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755312AbdKJAZc (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Nov 2017 19:25:32 -0500
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:53064 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755252AbdKJAZb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Nov 2017 19:25:31 -0500
Received: from PhilipOakley ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id Cx8Tes5qEbjdZCx8Te2J2C; Fri, 10 Nov 2017 00:25:30 +0000
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.2 cv=ONFX5WSB c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=IkcTkHD0fZMA:10 a=1XWaLZrsAAAA:8
 a=EL8Z1Mq9f3FjVD9Dd8UA:9 a=QEXdDO2ut3YA:10
Message-ID: <54073F7B0C9E49C4BA55CA97A605A724@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Stefan Beller" <sbeller@google.com>
Cc:     "Junio C Hamano" <gitster@pobox.com>, "git" <git@vger.kernel.org>,
        "Kevin Daudt" <me@ikke.info>,
        "Jacob Keller" <jacob.keller@gmail.com>,
        "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
References: <20171028004419.10139-1-sbeller@google.com> <20171031003351.22341-1-sbeller@google.com> <20171031003351.22341-7-sbeller@google.com> <xmqqinevzvel.fsf@gitster.mtv.corp.google.com> <CAGZ79kYO=4SWzfKY6bU8Spn5Ubw39ghOH6wanFhFEsKD8q9vrA@mail.gmail.com> <xmqq4lqewu2b.fsf@gitster.mtv.corp.google.com> <CAGZ79kYC4=rDSWC7WCGVL4n4OC8BpvMJFwxx+LV9GqoGnSHFSA@mail.gmail.com> <xmqqinetsayr.fsf@gitster.mtv.corp.google.com> <xmqq375xs3zr.fsf@gitster.mtv.corp.google.com> <BFE987312194406AAAEA8DAC7EC5BFF5@PhilipOakley> <xmqqlgjlkzmm.fsf@gitster.mtv.corp.google.com> <D199FB1260C4462ABFC1F0F77D26EF06@PhilipOakley> <CAGZ79kYRunzS9vDO=Zk1jQk1BvwJomN5+=1gQi0aDau_qbamew@mail.gmail.com>
Subject: Re: [PATCH 6/7] builtin/describe.c: describe a blob
Date:   Fri, 10 Nov 2017 00:25:27 -0000
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
X-Antivirus: AVG (VPS 171109-2, 09/11/2017), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfMnd/7YTt9BP9U73uVGcRts7y/5f5r9JGW20zwB9im92dsb9IKRNw4klptinB42bi9xiJrNaT3yxn3lF5zKHmMiTtdl5qqDBzUTlq6G+1YB8JyBrI6qu
 EBvzkM9U2DJcUxobLTzi1QIHsc78C5xTmYrb2fesYV2/puIQ9UIj8YPBRu2nkGXPyhDcTuDe6pLaqNcjs0eOZDjYTLv7XgsVWCNE7eTzqdMMn2BT+9FmqI3q
 OWEbLMTOrP/bGXXFX/PvSUbcNIKN98YoHMO6AzfaeFtB0mqQYRVEv3CBge237XHy4KBzggq621+pssAENf85iA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Stefan Beller" <sbeller@google.com>
> Rereading this discussion, there is currently no urgent thing to address?

True.

> Then the state as announced by the last cooking email, to just cook it, 
> seems
> about right and we'll wait for further feedback.

Possibly only checking the documenation aspects, so folks don't fall into 
the same trap as me.. ;-)
--
Philip 

