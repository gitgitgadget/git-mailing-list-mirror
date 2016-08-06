Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2DA61F859
	for <e@80x24.org>; Sat,  6 Aug 2016 20:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752150AbcHFUgm (ORCPT <rfc822;e@80x24.org>);
	Sat, 6 Aug 2016 16:36:42 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:55069 "EHLO
	smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105AbcHFUgl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2016 16:36:41 -0400
Received: from PhilipOakley ([2.96.196.12])
	by smtp.talktalk.net with SMTP
	id W5f8bmQG4gKstW5f8btWv2; Sat, 06 Aug 2016 18:45:32 +0100
X-Originating-IP: [2.96.196.12]
X-Spam:	0
X-OAuthority: v=2.2 cv=GdBVpkfL c=1 sm=1 tr=0 a=OwftO12tmsRMoVo1KIFhnA==:117
 a=OwftO12tmsRMoVo1KIFhnA==:17 a=8nJEP1OIZ-IA:10 a=NEAV23lmAAAA:8
 a=HBghJYNH8iwJv25W1yYA:9 a=Bn2pgwyD2vrAyMmN8A2t:22
Message-ID: <996096FBF9464263A35A5AEDED7F34EF@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:	"Philip Oakley" <philipoakley@iee.org>
To:	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
Cc:	"Duy Nguyen" <pclouds@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Eric Sunshine" <sunshine@sunshineco.com>,
	"Jeff King" <peff@peff.net>, "Johannes Sixt" <j6t@kdbg.org>,
	"Jakub Narebski" <jnareb@gmail.com>
References: <cover.1469547160.git.johannes.schindelin@gmx.de> <cover.1470051326.git.johannes.schindelin@gmx.de> <8ff71aba37be979f05abf88f467ec932aa522bdd.1470051326.git.johannes.schindelin@gmx.de> <xmqqlh0gjpr6.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608021004080.79248@virtualbox> <xmqqy44ec15p.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608031021050.79248@virtualbox> <CAPc5daXJzMsJf5K84XBFuQ5=q_OwtYUW2FikZ2QsZWk8fa9jgg@mail.gmail.com> <alpine.DEB.2.20.1608031753431.107993@virtualbox> <CACsJy8Bzcwfvhc9dQ2EehmAJ+kGwC5VHL4d+4Z-GfmM6e2+3wg@mail.gmail.com> <FAE9116880074D6FA421942CCAEC368F@PhilipOakley> <alpine.DEB.2.20.1608061036270.5786@virtualbox>
Subject: Re: patch submission process, was Re: [PATCH v6 06/16] merge_recursive: abort properly upon errors
Date:	Sat, 6 Aug 2016 18:45:32 +0100
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
X-CMAE-Envelope: MS4wfMTG+5Uc7yGI7JvVcSaQ3TTSpp4UfAfgdVbtNFRWa1RYJeGxn+AKq9xRpL301CMJWS0bwnbgYGfHoTHJCeNo4UyTeeawTmfQowZFKcjsHlTwyCAXgpsp
 siSevrKrOwbWKAp+snlsSYjg6L+1vdfiKjcNefQ6O1WKgMIM/U1fG7Ff/Tzs3XhgC80NwugCj1qTajGeJUxFWEbyLL/+Qvbs1XNgPqUtUxN5zxFO0pF2vyqC
 vMYuP/5GhwW6M1rlbs0weW62yzVx29Zh77Hncgs/uTrCs4Po9cDGrmJuVhjqeu7TOjTzqUWQbp/P5V1a00q9kgJTbhT/yjtGKANzQc63NjGHYaPGyQe8wl/m
 ElQjq2/WwA6x3qHo3Cbj1fduNEYP1A==
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
> Hi Philip,
>
> On Fri, 5 Aug 2016, Philip Oakley wrote:
>
>> In the same vein, I always want,with my workflow, to use "fixup!
>> <short_sha1>".
>
> Good news for you: this is already supported. See here:
>
> https://github.com/git/git/blob/v2.9.2/git-rebase--interactive.sh#L786-L796
>

That's odd <knowing look>, I never saw any of that in the documentation...

Blame says it was 68d5d03 (rebase: teach --autosquash to match on sha1 in 
addition to message, 2010-11-04) which was before I discovered Git. Maybe 
another documentation fixup needed ;-)

Mind you I'm not sure about 22c5b13 (rebase -i: handle fixup! fixup! 
in --autosquash, 2013-06-27) which looks to only allow one fixup, but maybe 
I'm misreading. [e.g. recieve multiple fixups from the list, or need extra 
fixups as code of documentation is tested]

The capability is still good to know.

Philip 

