Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,BODY_URI_ONLY,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E30A201A9
	for <e@80x24.org>; Mon, 20 Feb 2017 22:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751357AbdBTWYl (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Feb 2017 17:24:41 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:6850 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751334AbdBTWYk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2017 17:24:40 -0500
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id fwNpc4NjH46SJfwNpc4uap; Mon, 20 Feb 2017 22:24:38 +0000
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=CItoZljD c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=wKIBzRcAee3veybPcaIA:9 a=QEXdDO2ut3YA:10 a=6kGIvZw6iX1k4Y-7sg4_:22
Message-ID: <4C20E99781EC4D6D82D48FBF9D9472A1@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Alex Hoffman" <spec@gal.ro>,
        "Oleg Taranenko" <olegtaranenko@gmail.com>,
        =?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     "Jacob Keller" <jacob.keller@gmail.com>,
        "Johannes Sixt" <j6t@kdbg.org>,
        "Christian Couder" <christian.couder@gmail.com>,
        "Stephan Beyer" <s-beyer@gmx.net>, "git" <git@vger.kernel.org>
References: <CAMX8fZWe2HO78ySonHX0adtPUxVPbj5_vo-NUGrjwpb7gPdGrQ@mail.gmail.com> <d4991e4b-cbc4-da14-381a-88704e457a19@gmx.net> <3ff5ce3c-285f-cb9a-d1d4-46323524dab7@kdbg.org> <CAMX8fZVkBU6M8fkUcRr69V97_NTSOGGmPB1U-ObhmVv3i6wQhg@mail.gmail.com> <477d3533-d453-9499-e06e-72f45488d421@kdbg.org> <CAMX8fZW2y+iPRfSbXVcHufbM+CsqgekS_0WnCEJ++=njy_TvKg@mail.gmail.com> <CAP8UFD3ngMvVy2XLzYNn9OFbS+zQpWTW=pravpHhA-0PcDVhfg@mail.gmail.com> <CAMX8fZVeAEJ5tfCO_4Pebnq=rysaJ2xDMjH-9pjmPeF4FziLFw@mail.gmail.com> <d7bb866d-4a50-f75e-ff4c-bcdd54f75459@kdbg.org> <CAMX8fZWRgeK5XjSrFYzZea8YgT9Mqm0XJBxQGt1eqdWZU+DEnA@mail.gmail.com> <CA+P7+xrch9WDo6OgU3vUEpXqAETZ07mkf76dC9nJctm0LTFQHQ@mail.gmail.com> <CABEd3j8sgDd8DXW8+2Q7pjANPTr-Ws1Xs1ap875mkxFOfnenYw@mail.gmail.com> <58d25138-de2e-6995-444f-79c3ac0bbad2@gmail.com> <CABEd3j8m5D=bBbUD+uzvE9c8AwdBEM79Np7Pnin-RLL=Hjq06A@mail.gmail.com> <CAMX8fZUNHmouUsgEY3+0CmTaEp+y5b1-Cp8Nk3OttTc30v0R5A@mail.gmail.com> <ca1ef8f6-58cf-4994-d1bf-39e04b42dd4c@gmail.com>
Subject: Re: Git bisect does not find commit introducing the bug
Date:   Mon, 20 Feb 2017 22:24:37 -0000
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
X-CMAE-Envelope: MS4wfLvFqRAE7WmehSzrSpBN+W1ag8dcxNhSHdrIh+iRXSx0p/eBr1dRmHvRUeNKvw1+FzPI0c8DxR4pFx/bqqNxD4saN23vWoiyla89QULC34DTN+ckV0Xu
 pG5I7+/96WGYHnK0Mne/VCc8RyN1PLhLd3QpJDU6QkmkHmycFXohP9lzxu6tDmpQfZ27l5eYWoS9HKt0FlR5t4LJBWxqMu1CxLUa5iYolTPz+Tq1XZLesVDk
 NIoimLE1bdahH+qiWe9I2c8Km7p6Mxz69GMsZR4lHwuTk3PxGyHwSBX4iM1Sn0/jpkbN+iGJowajLjhgyJKCdUb65AoqcU882OQ8rQQBYXIoEiRlmiv110ri
 VGX9wh4KbGFTlBR4lpxiJvanzLOnxw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Jakub Narębski" <jnareb@gmail.com>
>W dniu 20.02.2017 o 21:31, Alex Hoffman pisze:
>> I see two different problems each with a different assumption (see the
>> definition of "bisectable" in the email of Junio C Hamano):
>>
>> 1. (Current) Assume the entire history graph is bisectable. DO: Search
>> where in the entire graph the first 'trait'/transition occurs.
>>
>> 2. (New) Assume only the graph between one good commit and one bad
>> commit is bisectable. DO: Search where the first transition occurs in
>> the graph between these two commits.
>
> If `git bisect` is/would be affected by `git log` history-related options
> then this is what `--strict-ancestor` option gives/would give.
>
isn't that spelt `--ancestry-path` ?
(--ancestry-path has it's own issues such as needing an --first-parent-show 
option, but that's possibly a by the by)
--
Philip 

