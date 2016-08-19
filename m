Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2683A1F859
	for <e@80x24.org>; Fri, 19 Aug 2016 18:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754080AbcHSSFs (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 14:05:48 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:15018 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753671AbcHSSFq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 14:05:46 -0400
Received: from PhilipOakley ([92.22.78.247])
        by smtp.talktalk.net with SMTP
        id ao9ybUsyVxR4bao9ybeiq7; Fri, 19 Aug 2016 19:04:51 +0100
X-Originating-IP: [92.22.78.247]
X-Spam: 0
X-OAuthority: v=2.2 cv=JNN5iICb c=1 sm=1 tr=0 a=QUcn+e1hWw6XCKiaygDIVQ==:117
 a=QUcn+e1hWw6XCKiaygDIVQ==:17 a=IkcTkHD0fZMA:10 a=-EdA6a1OTtBhc3P8i8kA:9
Message-ID: <04D3C5DBA44C4AC48D0D846B337D2EE0@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Olaf Hering" <olaf@aepfle.de>, <git@vger.kernel.org>
References: <20160818144421.GA9062@aepfle.de>
Subject: Re: git format-patch --break-rewrites broken in 2.9.3
Date:   Fri, 19 Aug 2016 19:04:50 +0100
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
X-CMAE-Envelope: MS4wfE31SpkAc5sa7aWoE5E5xK8hUhg3LDzFQBJhBwrEGjujS/JIujTSqfLYEmgsv50s5a778T1FxKlSIaQzwhaAl+SeGapZO3oIwV0KIefsTdwD8wTgC7uM
 odAZtXafvujvr0g9LlZb8XoX2C6cuWoMrZL37AoR0hUBK1fp1//oR0G//U7G2ZUWfMAgGxuy75wzow==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 18, 2016 at 04:44:21PM +0200, Olaf Hering wrote:

> This command used to create a diff which can be consumed by patch. But
> at least with 2.9.3 it just gives a rename output:
>
>  git format-patch \
>         --no-signature \
>         --stdout \
>         --break-rewrites \
>         --keep-subject \
> 
> 95fa0405c5991726e06c08ffcd8ff872f7fb4f2d^..95fa0405c5991726e06c08ffcd8ff872f7fb4f2d
>
>
> What must be done now to get a usable patch?

As an aside, the range can be shortened to

95fa0405c5991726e06c08ffcd8ff872f7fb4f2d^!

It's something I picked up when doing the doc update on 'specifying 
revisions'.

--

Philip

