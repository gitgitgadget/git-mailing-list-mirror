Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D97161F859
	for <e@80x24.org>; Tue, 16 Aug 2016 22:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753087AbcHPWLJ (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 18:11:09 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:3180 "EHLO
	smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752263AbcHPWLI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 18:11:08 -0400
Received: from PhilipOakley ([92.22.79.128])
	by smtp.talktalk.net with SMTP
	id ZmZdbOozaxR4bZmZdbczAm; Tue, 16 Aug 2016 23:11:06 +0100
X-Originating-IP: [92.22.79.128]
X-Spam:	0
X-OAuthority: v=2.2 cv=JNN5iICb c=1 sm=1 tr=0 a=XEvdTb7KCAz4OJCw3EI8rA==:117
 a=XEvdTb7KCAz4OJCw3EI8rA==:17 a=8nJEP1OIZ-IA:10 a=xtxXYLxNAAAA:8
 a=ybZZDoGAAAAA:8 a=YhUV6Cqo3N5zZXdVSWoA:9 a=xts0dhWdiJbonKbuqhAr:22
 a=0RhZnL1DYvcuLYC8JZ5M:22
Message-ID: <CAE3EC6B78644AA8BD07FED08AF44EAE@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:	"Philip Oakley" <philipoakley@iee.org>
To:	"Philip Oakley" <philipoakley@iee.org>,
	"Junio C Hamano" <gitster@pobox.com>
Cc:	"GitList" <git@vger.kernel.org>
References: <20160814214630.1312-1-philipoakley@iee.org><20160814214630.1312-2-philipoakley@iee.org><xmqq60r3knoz.fsf@gitster.mtv.corp.google.com><6ACCC850AC434350B15AADC19F02760B@PhilipOakley> <xmqqbn0vj6ze.fsf@gitster.mtv.corp.google.com> <F18C2CCC29E5470CA1374D9718B2A3E6@PhilipOakley>
Subject: Re: [PATCH v1 1/3] doc: commit: --fixup/--squash can take a commit revision
Date:	Tue, 16 Aug 2016 23:11:05 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfJ1r91gdBmZ5ZZHd2cO2u4pTlomNpexztu5TlGEee6Jh2w0d4JB2rhIiz4Z6cNKZZKiIk9bgU5RxanFZ18A5oI5UGtrbjmMSoKa+XbVU9QXeFUd7wsN6
 /nrvW6GnOF3Gt+amw89uGOb7IyA+U0AChvlHsTVMbvb22vPD9tqPhM+6WIpSMcpwFSCmtuhbPeUgpYGtDx1kq8wkSz+ZYYYW2g7HYLiUlcM58YqB9HViW8AX
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: "Philip Oakley" <philipoakley@iee.org>
> From: "Junio C Hamano" <gitster@pobox.com>
>> "Philip Oakley" <philipoakley@iee.org> writes:
>>
>>>> I think the
>>>> use of "commit" in an angle-bracket-pair in the label for the
>>>> section, i.e. "--fixup=<commit>", has been considered to be clear
>>>> enough to tell that you can use usual extended SHA-1 syntax to
>>>> specify the commit you want to talk about,
>>>
>>> I certainly hadn't picked up on that ability to use the extended sha1
>>> syntax (specifying revisions...) here.
>>
>> By "has been considered", I meant that the documentation text is
>> still open for improvement.  I just didn't find rewording "commit"
>> with "commit revision" is that improvement we need there.
>>
>> Perhaps we need to have somewhere central a section that explains
>> various notations used in the documentation set.  I think it is safe
>> to say something like "unless otherwise qualified, <commit> (or any
>> object type in an angle-bracket-pair) is used as a placeholder to
>> take any acceptable way to spell object names (cf. gitrevisions for
>> details)" these days [*1*].
>
> True. I'm cautious that we may accidentally still hide it in another 
> document that the user doesn't see when reading "this" (or any other)  man 
> page.
>
> Your sentence is short enough to be added to those few key pages that 
> users refer to to get them started in the right direction.
>
>> *1* In ancient days I think some plumbing commands only took 40-hex
>> object names, but as far as I know they've all been updated.
>> --

I'll take the patch series away and have a rework over the coming week or 
so.

Philip 

