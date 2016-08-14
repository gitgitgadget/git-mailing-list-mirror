Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B78151FD99
	for <e@80x24.org>; Sun, 14 Aug 2016 17:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752885AbcHNRcD (ORCPT <rfc822;e@80x24.org>);
	Sun, 14 Aug 2016 13:32:03 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:34754 "EHLO
	smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752496AbcHNRcD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2016 13:32:03 -0400
Received: from PhilipOakley ([92.22.48.2])
	by smtp.talktalk.net with SMTP
	id YzGRb3cEPcpskYzGSbC1Oh; Sun, 14 Aug 2016 18:32:01 +0100
X-Originating-IP: [92.22.48.2]
X-Spam:	0
X-OAuthority: v=2.2 cv=ILRAMUnG c=1 sm=1 tr=0 a=dUEO/agNDYQW2w9YSFWSZw==:117
 a=dUEO/agNDYQW2w9YSFWSZw==:17 a=8nJEP1OIZ-IA:10 a=D6O_kKuFAAAA:8
 a=M7rlcskdn6499gi0RAQA:9 a=OivCWuwqUyt3bHEeSeq1:22
Message-ID: <4B56CDE3883A4341994E6382DF68C438@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:	"Philip Oakley" <philipoakley@iee.org>
To:	"Norman Shapiro" <norm@dad.org>, <git@vger.kernel.org>
Cc:	<norm@dad.org>
References: <201608141458.u7EEwF8P099500@shell1.rawbw.com>
Subject: Re: Getting the "message" given a branch designation and conversely
Date:	Sun, 14 Aug 2016 18:32:00 +0100
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
X-CMAE-Envelope: MS4wfEDP8LCyX9Gw76ea6mUv4RhtBZgRFWNFc6enX47PaA3CqkiiYyglsaGjTVaNDQ6OeR0XIxhQkp8ZNrrm3/X2wtd1pHptzL9TD0WXRRTEp2rashH3meh9
 SIqrMX8CwSLKjJRgodRdtWt1d3y/BOkuPT0C5uASXXdRmdnsUK2TrIMBSCklghDwKoWniSIQzq9Wek3mczs8Zzia+Yie6Sm0N5c=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: <norm@dad.org>
>I am learning how to use git. I would like to know how:
>
> Given a branch's designation, such as "master~4", how can I see the 
> message I
> furnished when I created the branch using "git commit"?
>
> Conversely, given the message I furnished to "git commit", when I created 
> a
> branch, how can I see the branch's designation?
>
> Context:
>
>    Operating System: Red Hat Enterprise Linux Workstation release 6.8
>
>    git version: 1.7.1
>
> Thank you, very much.
>
>    Norman Shapiro
> --

Norman,

To see the commit message try 'git log'. You will need a revision range, so 
try 'git help revisions' to set a guide about all the different ways you can 
spell that. While at it, it's worth 'git help glossary' just to understand 
some of the terminology.

--
Philip
'git log HEAD~4^!' 

