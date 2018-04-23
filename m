Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B716E1F424
	for <e@80x24.org>; Mon, 23 Apr 2018 20:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755308AbeDWUeh (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 16:34:37 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:16944 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755165AbeDWUeg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 16:34:36 -0400
Received: from PhilipOakley ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id AiARfRQZylWlTAiARfQHDt; Mon, 23 Apr 2018 21:34:35 +0100
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.3 cv=N4gH6V1B c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=8nJEP1OIZ-IA:10 a=XM0nyQBuu00CSQUsQo0A:9
 a=wPNLvfGTeEIA:10
Message-ID: <0E6803122A5241F98148087A045993BC@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
Cc:     "Git List" <git@vger.kernel.org>,
        "Junio C Hamano" <gitster@pobox.com>,
        "Jacob Keller" <jacob.keller@gmail.com>,
        "Stefan Beller" <sbeller@google.com>,
        "Eric Sunshine" <sunshine@sunshineco.com>,
        "Phillip Wood" <phillip.wood@dunelm.org.uk>,
        "Igor Djordjevic" <igor.d.djordjevic@gmail.com>,
        "Johannes Sixt" <j6t@kdbg.org>,
        "Sergey Organov" <sorganov@gmail.com>,
        =?iso-8859-1?Q?Martin_=C5gren?= <martin.agren@gmail.com>
References: <cover.1524139900.git.johannes.schindelin@gmx.de> <cover.1524306546.git.johannes.schindelin@gmx.de> <7360a072f6fdd276d30839613434329b645e2cce.1524306546.git.johannes.schindelin@gmx.de> <9270DF86352B4E3493AADA159E7FFE33@PhilipOakley> <nycvar.QRO.7.76.6.1804231401130.15174@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Subject: Re: [PATCH v8 06/16] sequencer: introduce the `merge` command
Date:   Mon, 23 Apr 2018 21:34:35 +0100
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
X-Antivirus: AVG (VPS 180423-2, 23/04/2018), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfG3Hnn1Z9h8t1dYmR6yO6SDZMeQy4+3xw8ESyFBnJImuqiXNLv7Mc18qmm6fFS5TaJgpmjze82Y3NBDA8zwk/SoMCgI3NhQfJuZ/XGZ0JwMi9PN4X7Hs
 M5MEnHNjU7oa38zhQ8QEL2umkK2zK6+QqgsHJvKjjz2E6S86lTAise4PwC2XtK20y37EngMcTXAe51hqV1lkBx0mc6Xw9bRNcnuq7oboWtKV6BkgzufDJzye
 ke/74w7OQSAeka6S06lDGT4shsZUQ0cw+mMgCvKdv1Rj/s8D7shuAhFnzr6FMrfADQHeykyrETHNrVSV+NYS6hU/LqW6o7DCWKD68jbXGLeyPhCrnlJgJ41V
 cUsz6gfc4VUU1SlxHRquvYzV4tFxBStP4pzVy9b8IDWChiZomFyT3TwmvQvykyCPaR+1PpEGH40JxzBkTYgyaLLK7BUoJ8sfpBz+43n23N1iAVHJ4NMN0iUl
 EY92tREGTf7KtLRztAt6k9wfS/2GOBXOsyYzTw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Johannes Schindelin" <Johannes.Schindelin@gmx.de> : Monday, April 23, 
2018 1:03 PM
Subject: Re: [PATCH v8 06/16] sequencer: introduce the `merge` command


> Hi Philip,
>
[...]
>
>> > label onto
>> >
>> > # Branch abc
>> > reset onto
>>
>> Is this reset strictly necessary. We are already there @head.
>
> No, this is not strictly necessary, but

I've realised my misunderstanding. I was thinking this (and others) was 
equivalent to

$  git reset <thatHead'onto'> # maybe even --hard,

i.e. affecting the worktree

rather that just being a movement of the Head rev (though I may be having 
brain fade here regarding untracked files etc..)

>
> - it makes it easier to auto-generate (otherwise you would have to keep
>  track of the "current HEAD" while generating that todo list, and
>
> - if I keep the `reset onto` there, then it is *a lot* easier to reorder
>  topic branches.
>
> Ciao,
> Dscho
>
Thanks

Philip 

