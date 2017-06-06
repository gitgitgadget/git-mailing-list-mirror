Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,STOX_REPLY_TYPE,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEB2420D11
	for <e@80x24.org>; Tue,  6 Jun 2017 11:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751440AbdFFLF7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Jun 2017 07:05:59 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:22504 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751412AbdFFLF6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2017 07:05:58 -0400
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id ICJAdDPhS46SJICJAd9AFh; Tue, 06 Jun 2017 12:05:57 +0100
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=CItoZljD c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=ybZZDoGAAAAA:8 a=GFEwop068PHR33_XSSUA:9 a=QEXdDO2ut3YA:10
 a=6kGIvZw6iX1k4Y-7sg4_:22 a=0RhZnL1DYvcuLYC8JZ5M:22
Message-ID: <D0E8FF50F1E74043AA0BD71E80C365E5@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "David" <bouncingcats@gmail.com>,
        "Junio C Hamano" <gitster@pobox.com>
Cc:     "Samuel Lijin" <sxlijin@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Stefan Beller" <sbeller@google.com>,
        "Kaartic Sivaraam" <kaarticsivaraam91196@gmail.com>,
        <git@vger.kernel.org>
References: <1496671452.4809.2.camel@gmail.com> <20170605231058.pgb4fgfb4z45bzmk@genre.crustytoothpaste.net> <CAGZ79kYp6GepJxZjaXhosX=vCh0vwa57+zFHK2gHFociiyTnDg@mail.gmail.com> <xmqqd1ai9bhf.fsf@gitster.mtv.corp.google.com> <20170606011151.qe5ycih77vqlqgme@genre.crustytoothpaste.net> <CAJZjrdWoK__rZVCG3vRSSEOPgxK7b_wWjpJ3YUQcLxw+J8KfGQ@mail.gmail.com> <xmqqvao9991r.fsf@gitster.mtv.corp.google.com> <CAMPXz=oorE7MQa4a_1eC-+Huf1Tf2XQFjEBcQxsOdso9BJ1S-A@mail.gmail.com>
Subject: Re: What does this output of git supposed to mean ?
Date:   Tue, 6 Jun 2017 12:07:21 +0100
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
X-Antivirus: AVG (VPS 170606-0, 06/06/2017), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfAhdn7X9u+GE3d5L1qu5HWUYaN021J+vyN77euj+RU7ewn80eKfhP1Omu+xd2DXHIfORH8I0uGPXW2K0o2eD69eyZeMHxER7VBTyF2sYZYIkSDiNZ1TQ
 flN53etL0lFCtI24P4CaHmmaDRHEHRTaITniloJIcwpKfoB/MyW3Lxo5lkuXAu8AammFLRLHDu26aD+S0IvrBYp5Yn0nGf5LgLp3c4p0+8nxFxuTaac/gIqX
 VnU0q4nSLVjuOmTKxmlwrSGUGQMpcpD5IMSs6mSVfwMkmmzaJGbsPHM9Oa4dXxxTTK+x2TOSr61SCRPx00rsdZMGSd2rg9WX2Utlacb11m6jC2WoFdS633/3
 KFb3LhW+IgbXq521vxH11rXHplrftw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "David" <bouncingcats@gmail.com>
> On 6 June 2017 at 11:52, Junio C Hamano <gitster@pobox.com> wrote:
>> Samuel Lijin <sxlijin@gmail.com> writes:
>>
>>> For what it's worth, I've never quite understood the "Initial commit"
>>> message, because the repository is in a state where there are no
>>> commits yet, not when HEAD is pointing to a root commit.
>>
>> In the context of "status", it probably is more logically correct if
>> it said "No commit yet" or something.  This is no longer "is initial
>> harder than root?" ;-)
>
> Exactly. I agree with OP, in the context of running 'git status', I find
> the string "Initial commit" confusing in the example below, because
> at that time no commits exist. This creates confusion what git is
> talking about. The 'git log' message is not very friendly either.
>
> Perhaps say something like "Repository is empty." there.

<bikeshed>
I like that. I think that is a very appropriately descriptive statement.

An alternative ,with slightly less textual change, could be "Waiting for 
initial commit"
</bikeshed>

>
> $ mkdir test
> $ cd test
> $ git init
> Initialized empty Git repository in 
> /mnt/hart/home/david_d08/junk/test/.git/
> $ git log
> fatal: bad default revision 'HEAD'
> $ git status
> On branch master
>
> Initial commit
>
> nothing to commit (create/copy files and use "git add" to track) 

