Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE,STOX_REPLY_TYPE_WITHOUT_QUOTES shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 312331F859
	for <e@80x24.org>; Thu, 11 Aug 2016 07:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932573AbcHKHcU (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 03:32:20 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:54280 "EHLO
	smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932432AbcHKHcR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 03:32:17 -0400
Received: from PhilipOakley ([92.22.69.114])
	by smtp.talktalk.net with SMTP
	id XkTJbwTCpcpskXkTJbA5Io; Thu, 11 Aug 2016 08:32:10 +0100
X-Originating-IP: [92.22.69.114]
X-Spam:	0
X-OAuthority: v=2.2 cv=ILRAMUnG c=1 sm=1 tr=0 a=h+OJL76/cHwS59+GNvyE+w==:117
 a=h+OJL76/cHwS59+GNvyE+w==:17 a=8nJEP1OIZ-IA:10 a=fNfMx4uSAcoXG5hcbGkA:9
Message-ID: <D8F2D8316A4C4E198C6847C1165A8811@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:	"Philip Oakley" <philipoakley@iee.org>
To:	"Git List" <git@vger.kernel.org>
Subject: Can cc's be included in patches sent by send-email
Date:	Thu, 11 Aug 2016 08:32:08 +0100
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
X-CMAE-Envelope: MS4wfP4XOox+iTwhJ7mjPCa3BkslqGxXQHKl7WrDaB1CgCK5UQ8D7L1QVc4r3ougt7jqBfEKBqZsWXQUG0w2M0t5BAIdMWdRfl3Mt2XbLbGnQkzJ34LrBSuT
 c+K+sKYrwkbriTc2qSMmF/lXSyvjffuotQDL4q17So9nkt2LYCsbOylT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

While 'git send-email' can have multiple --cc="addressee" options on the 
command line, is it possible for the "cc:addressee<a@b.c>" to actually be 
included in the patches that are to be sent, so that different patches can 
have different addressee?

The fortmat-patch can include appropriate from lines, so it feels as if the 
sender should be able to add cc: lines at the same place. Maybe its just 
part of th docs I've missed.

This is for the workflow where the patch series (including cover letter) is 
reviewed before send-email is invoked to send to all adressees.

--
Philip 

