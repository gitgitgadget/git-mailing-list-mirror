Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C862202A0
	for <e@80x24.org>; Sat,  4 Nov 2017 19:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751618AbdKDTKl (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Nov 2017 15:10:41 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:28131 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751442AbdKDTKl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Nov 2017 15:10:41 -0400
Received: from PhilipOakley ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id B3q3efe0g3CyHB3q3ewD9q; Sat, 04 Nov 2017 19:10:39 +0000
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.2 cv=Zo+dE5zG c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=eCaPR_ZZXJV7MJ17OSMA:9 a=QEXdDO2ut3YA:10
Message-ID: <34068C1EF5694EBC8B86E1FF44B134FF@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Robert Dailey" <rcdailey.lists@gmail.com>,
        "Git" <git@vger.kernel.org>
References: <CAHd499AsY30b8LuCvjap-mZyzBEVsjK__We6Yh-y=5GqijObhw@mail.gmail.com>
Subject: Re: How to resolve mixture of modified and deleted conflicts easily in git?
Date:   Sat, 4 Nov 2017 19:10:33 -0000
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="utf-8";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Antivirus: AVG (VPS 171104-0, 04/11/2017), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfAGyuSa4Ib9gS27wAP+8Mby5F8cQRMk6glD3psmxYfVN85Y3An4DKJfl9KPKezIfz6IHpRVxqkKCzWQy4p0uP86jHAJz0ukYMP5Mp77EJPARqL3BscWY
 1UvVZa7rpCkimhSCxwTY9GBrmFfZEfutyjZIXM0WGqZkCszz5KLgt3dRaHBZoCLuQlh55nUILvKERB4z/xUIRycE+inVKtjz4DM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Robert Dailey" <rcdailey.lists@gmail.com>
> When doing a rebase, sometimes I will get `DU` and `UU` conflicts
> (locally deleted and locally modified, respectively). Furthermore, in
> some of these cases, I want to take "ours" for all conflicts,
> including ones where the local file is deleted. Ideally, it's just one
> command:
>
>    $ git checkout --ours .
>
> However, this fails for the locally deleted conflicts:
>
>    error: path 'foo.xml' does not have our version
>
> Even more annoyingly, the fact that these failures occur prevents the
> `UU` conflicts from being resolved. The whole operation fails
> atomically. I am not aware of a straightforward and uniform way to
> resolve conflicts with "ours" during a rebase when locally deleted
> files exist in the list of conflicts. What is the most elegant
> solution in this situation?
>
> I'm running Git for Windows v2.13.1.

Can you give the example commands and response?

In particular note the comment in the rebase command that the ours/theirs 
viewpoints are swapped, so you may find your stated "ours" should be (mid 
rebase) seen as "theirs".
--
Philip 

