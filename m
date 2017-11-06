Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50BC420A10
	for <e@80x24.org>; Mon,  6 Nov 2017 23:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755099AbdKFXuJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Nov 2017 18:50:09 -0500
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:40457 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754356AbdKFXuH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Nov 2017 18:50:07 -0500
Received: from PhilipOakley ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id Br9Yek485Ap17Br9ZeNuTp; Mon, 06 Nov 2017 23:50:05 +0000
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.2 cv=EsGilWUA c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=8nJEP1OIZ-IA:10 a=ybZZDoGAAAAA:8
 a=xtxXYLxNAAAA:8 a=JS-1R52wtdgw_pkmB2EA:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19
 a=wPNLvfGTeEIA:10 a=0RhZnL1DYvcuLYC8JZ5M:22 a=xts0dhWdiJbonKbuqhAr:22
Message-ID: <D199FB1260C4462ABFC1F0F77D26EF06@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Junio C Hamano" <gitster@pobox.com>,
        "Stefan Beller" <sbeller@google.com>
Cc:     "git" <git@vger.kernel.org>, "Kevin Daudt" <me@ikke.info>,
        "Jacob Keller" <jacob.keller@gmail.com>,
        "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
References: <20171028004419.10139-1-sbeller@google.com>        <20171031003351.22341-1-sbeller@google.com>        <20171031003351.22341-7-sbeller@google.com>        <xmqqinevzvel.fsf@gitster.mtv.corp.google.com>        <CAGZ79kYO=4SWzfKY6bU8Spn5Ubw39ghOH6wanFhFEsKD8q9vrA@mail.gmail.com>        <xmqq4lqewu2b.fsf@gitster.mtv.corp.google.com>        <CAGZ79kYC4=rDSWC7WCGVL4n4OC8BpvMJFwxx+LV9GqoGnSHFSA@mail.gmail.com>        <xmqqinetsayr.fsf@gitster.mtv.corp.google.com>        <xmqq375xs3zr.fsf@gitster.mtv.corp.google.com>        <BFE987312194406AAAEA8DAC7EC5BFF5@PhilipOakley> <xmqqlgjlkzmm.fsf@gitster.mtv.corp.google.com>
Subject: Re: [PATCH 6/7] builtin/describe.c: describe a blob
Date:   Mon, 6 Nov 2017 23:50:03 -0000
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
X-Antivirus: AVG (VPS 171106-2, 06/11/2017), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfMopnKq5f2QVkLly/6G16ET8Ua2vo0iL4XqpBwT69GcsxQfwALVIOIG9lJn0Qwlvqd12zlDxZGXrCpoaDfKvyWCYUU06e/Zmcq7awgv3E3yiyhQ2WVC2
 9Bgzz947+gOs0zj1LUryPQmvOq2h6RHAZt48+TIz11F+Ba1DQFhAhpVLdthG4bCI6c3R5zqKlmH/mpfBMZMsBLSnTtjJrx2w/hyszpwZm/luiDR7OO61AnX4
 1Ko4mk+u+AiXKeBQVK2ZBkJe9nfQogkz/JXM6CvSG82TZAWPBlxlwS2wp3fpLOaEPfYbCqVRAmx0zYEZ9gkAKw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Junio C Hamano" <gitster@pobox.com>
Sent: Sunday, November 05, 2017 6:28 AM
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>> Is this not also an alternative case, relative to the user, for the
>> scenario where the user has an oid/sha1 value but does not know what
>> it is, and would like to find its source and type relative to the
>> `describe` command.
>
> I am not sure what you wanted to say with "source and type RELATIVE TO
> the describe command".

The 'relative to' was meaning the user's expectation about this particular 
command. For a non-expert user, who may not have come across cat-file yet, 
their world view may not extend beyond 'Git describe <this>' for me.

>
> The first thing the combination of the user and the describe command
> would do when the user has a 40-hex string would be to do the
> equivalent of "cat-file -t" to learn if it even exists and what its
> type is.  With Stefan's patch, that is what describe command does in
> order to choose quite a different codeflow from the traditional mode
> when it learns that it was given a blob.

I realised, after sending, that this was probably the method for 
non-ambiguous shortened oid's. Thanks for the reminder.
>
>> IIUC the existing `describe` command only accepts <commit-ish> values,
>> and here we are extending that to be even more inclusive, but at the
>> same time the options become more restricted.
>
> Do you mean that the command should check if it was given an option
> that would not be applicable to the "find a commit that has the
> blob" mode, once it learns that it was given a blob and needs to go
> in that codepath?  I think that would make sense.

Correct, it was the option selection aspect.
>
>> Or have I misunderstood how the fast commit search and the slower
>> potentially-a-blob searching are disambiguated?
>
> I do not think so.  We used to barf when we got anything but
> commit-ish, but Stefan's new code kicks in if the object turns out
> to be a blob---I think that is what you mean by the disambiguation.

Correct. We ask to describe an object, but then the option choices may vary 
by type.

The new [blob] synopys only lists <options>, while the old [commit-ish] 
shows specifics. It wasn't clear if the options are the same for both. I 
quess they are the same once the cat-file -t has done its bit. Its only the 
speed that's affected.

As a side note, the commit message example don't show any pathspec that is 
not in the top level directory.

--
Philip 

