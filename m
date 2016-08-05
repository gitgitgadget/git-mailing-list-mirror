Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D1E12018E
	for <e@80x24.org>; Fri,  5 Aug 2016 18:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754201AbcHESmO (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 14:42:14 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:11236 "EHLO
	smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934607AbcHESmK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 14:42:10 -0400
Received: from PhilipOakley ([2.96.196.12])
	by smtp.talktalk.net with SMTP
	id Vk4NbGPmT0KuvVk4NbE1po; Fri, 05 Aug 2016 19:42:08 +0100
X-Originating-IP: [2.96.196.12]
X-Spam:	0
X-OAuthority: v=2.2 cv=RZjSMBlv c=1 sm=1 tr=0 a=OwftO12tmsRMoVo1KIFhnA==:117
 a=OwftO12tmsRMoVo1KIFhnA==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=OzfMmKlo8qZVzuY7yW8A:9 a=6kGIvZw6iX1k4Y-7sg4_:22
Message-ID: <FAE9116880074D6FA421942CCAEC368F@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:	"Philip Oakley" <philipoakley@iee.org>
To:	"Duy Nguyen" <pclouds@gmail.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
Cc:	"Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Eric Sunshine" <sunshine@sunshineco.com>,
	"Jeff King" <peff@peff.net>, "Johannes Sixt" <j6t@kdbg.org>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
References: <cover.1469547160.git.johannes.schindelin@gmx.de> <cover.1470051326.git.johannes.schindelin@gmx.de> <8ff71aba37be979f05abf88f467ec932aa522bdd.1470051326.git.johannes.schindelin@gmx.de> <xmqqlh0gjpr6.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608021004080.79248@virtualbox> <xmqqy44ec15p.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608031021050.79248@virtualbox> <CAPc5daXJzMsJf5K84XBFuQ5=q_OwtYUW2FikZ2QsZWk8fa9jgg@mail.gmail.com> <alpine.DEB.2.20.1608031753431.107993@virtualbox> <CACsJy8Bzcwfvhc9dQ2EehmAJ+kGwC5VHL4d+4Z-GfmM6e2+3wg@mail.gmail.com>
Subject: Re: patch submission process, was Re: [PATCH v6 06/16] merge_recursive: abort properly upon errors
Date:	Fri, 5 Aug 2016 19:42:10 +0100
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
X-CMAE-Envelope: MS4wfH/tx0thgE4bp3FIG0K/KwiHp17/itZVQpDXIOmYjzoLoO9qybB/iNGK2GGgCVZCZepaZ4KdQNj165SnJsKv9gpnWVwKCDpbZCHOhWO9A21MIiTjP6vj
 jLTuNhroj+1p9oEFV+SmPO6RTwyiQNgBIRoEZPXv8X5wxrWrQdvv/veubT98DwMTHpwj2iuWIppfOuk8AnBpb5n/lwSkYkryAKDo0PQOkoBD8ByuZZL1ZGgm
 LaNMWebyTzkdhbnvdEa0IGedH2lK3UYKquDKA3MWf/Ssvla3wZdIK34lcijClpVBBayZtVow1JQGZL5BRsQCGX6Y9HVYpTNuWnLJF+spCSjaXVdut22cSh/3
 oGk8Hr41FAd6CRzpNoUY8Z1WnZiurg==
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: "Duy Nguyen" <pclouds@gmail.com>
> On Wed, Aug 3, 2016 at 6:07 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>> It would be a totally different matter, of course, if you used the
>> branches I publish via my GitHub repository, added fixup! and squash!
>> commits, published the result to a public repository and then told me to
>> pull from there, that would make things easier. We could even introduce a
>> reword! construct, to make the review of the suggested edits of the 
>> commit
>> message easier.
>
> On the topic of fixup and squash and everything. Is anyone else
> annoyed that the commit title is taken for fixup!, squash!
> instructions? After you have added a few of them, "git log --oneline"
> becomes useless. All you see is "fixup! A", "fixup! A", "fixup! B",
> "fixup! A".
>
> Would it be better to let the user control the title? We still need
> the cue "fixup!", "squash!"... at the beginning of the title, but the
> original commit reference is appended at the end, like s-o-b lines.

In the same vein, I always want,with my workflow, to use "fixup! 
<short_sha1>".

This would be to save trying to retype the title correctly, and simply use 
the abbreviated sha1, which would nicely allow an extra short summaty of 
what the fixup is about.

Philip 

