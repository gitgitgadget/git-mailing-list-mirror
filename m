Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 219101FD99
	for <e@80x24.org>; Sun, 14 Aug 2016 23:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751810AbcHNX3h (ORCPT <rfc822;e@80x24.org>);
	Sun, 14 Aug 2016 19:29:37 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:62289 "EHLO
	smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751566AbcHNX3g (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2016 19:29:36 -0400
Received: from PhilipOakley ([92.22.48.2])
	by smtp.talktalk.net with SMTP
	id Z4qUb42xzcpskZ4qUbC8a2; Mon, 15 Aug 2016 00:29:34 +0100
X-Originating-IP: [92.22.48.2]
X-Spam:	0
X-OAuthority: v=2.2 cv=ILRAMUnG c=1 sm=1 tr=0 a=dUEO/agNDYQW2w9YSFWSZw==:117
 a=dUEO/agNDYQW2w9YSFWSZw==:17 a=8nJEP1OIZ-IA:10 a=ybZZDoGAAAAA:8
 a=xtxXYLxNAAAA:8 a=v9PzwZj9Kv99ir_2s6kA:9 a=0RhZnL1DYvcuLYC8JZ5M:22
 a=xts0dhWdiJbonKbuqhAr:22
Message-ID: <F18C2CCC29E5470CA1374D9718B2A3E6@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:	"Philip Oakley" <philipoakley@iee.org>
To:	"Junio C Hamano" <gitster@pobox.com>
Cc:	"GitList" <git@vger.kernel.org>
References: <20160814214630.1312-1-philipoakley@iee.org><20160814214630.1312-2-philipoakley@iee.org><xmqq60r3knoz.fsf@gitster.mtv.corp.google.com><6ACCC850AC434350B15AADC19F02760B@PhilipOakley> <xmqqbn0vj6ze.fsf@gitster.mtv.corp.google.com>
Subject: Re: [PATCH v1 1/3] doc: commit: --fixup/--squash can take a commit revision
Date:	Mon, 15 Aug 2016 00:29:34 +0100
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
X-CMAE-Envelope: MS4wfH8HmfhwkMQqTysFyVQl3ixI/hXkdg8SvpwEw5AeRTsxKdnN+i1lVzz9j7DODpbV800FeEP4DtcsKHp2ZRSQ87ngWiQWTRn6UMaF/m42QsyQ0XVDPR4A
 VXFg7/XxLnwLeeWA5EeUhIGYn+XT3Yaz8P6/KSqIcZTzs6e+nx4P4a7f3nJRwI2LrFg3pq5sfvT0bw==
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: "Junio C Hamano" <gitster@pobox.com>
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>>> I think the
>>> use of "commit" in an angle-bracket-pair in the label for the
>>> section, i.e. "--fixup=<commit>", has been considered to be clear
>>> enough to tell that you can use usual extended SHA-1 syntax to
>>> specify the commit you want to talk about,
>>
>> I certainly hadn't picked up on that ability to use the extended sha1
>> syntax (specifying revisions...) here.
>
> By "has been considered", I meant that the documentation text is
> still open for improvement.  I just didn't find rewording "commit"
> with "commit revision" is that improvement we need there.
>
> Perhaps we need to have somewhere central a section that explains
> various notations used in the documentation set.  I think it is safe
> to say something like "unless otherwise qualified, <commit> (or any
> object type in an angle-bracket-pair) is used as a placeholder to
> take any acceptable way to spell object names (cf. gitrevisions for
> details)" these days [*1*].

True. I'm cautious that we may accidentally still hide it in another 
document that the user doesn't see when reading "this" (or any other)  man 
page.

Your sentence is short enough to be added to those few key pages that users 
refer to to get them started in the right direction.

> *1* In ancient days I think some plumbing commands only took 40-hex
> object names, but as far as I know they've all been updated.
> --
Philip 

