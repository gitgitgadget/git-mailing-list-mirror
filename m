Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE,STOX_REPLY_TYPE_WITHOUT_QUOTES shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55EB020756
	for <e@80x24.org>; Fri, 20 Jan 2017 22:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752330AbdATW2M (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jan 2017 17:28:12 -0500
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:65307 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751146AbdATW2L (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2017 17:28:11 -0500
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id UhfFcslr40KuvUhfFcRLvY; Fri, 20 Jan 2017 22:28:09 +0000
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=RZjSMBlv c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=8nJEP1OIZ-IA:10 a=uPZiAMpXAAAA:8
 a=7HR_eeyp91lrCSi93QcA:9 a=wPNLvfGTeEIA:10 a=svzibyHiZmA4t4YY0eFS:22
Message-ID: <8AED6D90D2B64AE3A63C6195CA983FE8@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Git List" <git@vger.kernel.org>
Cc:     "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
Subject: Idea: Add a filter option to 'git rebase'
Date:   Fri, 20 Jan 2017 22:28:11 -0000
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
X-CMAE-Envelope: MS4wfKnHuXk/2JucgNWZdD3+F3RoqhRzr5YEE/0u/9G/x/z0HQA6Xm5N5zqgbOYr8sqsXM/4kkwGjnucEryKhNiz9SkmKHea+r4FG0v/S2BtCeN6ePeYsrIR
 oI3zE+Wqjp77hwrMeG2nFX0/DWq3A3gp/L4/fZwRX/2bes2PrwigweLB+FU/TCP88alwEs3mNeHXV2YfY4kZFwxOE15dgW+yLp8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A recent question on stackoverflow 
http://stackoverflow.com/questions/41753252/drop-commits-by-commit-message-in-git-rebase 
sought to remove automatically commits that could be identified by relevant 
words in the commit message.

I had thought that the ubiquitous `git filter-branch` should be able to do 
this sort of thing. I was wrong. (It was pointed out to me that...) The man 
page notes that removing a commit via filter-branch does not remove the 
changes from following commits and directs readers to using `git rebase(1)`.

However the rebase command does not have any filter option to allow the 
automatic population of its TODO list with the appropriate 
pick/edit/drop/etc. values.

It does feel as if a --filter style option would be a useful addition to 
rebase to complement the filter-branch options once the current conversion 
from script to code is complete.

Is this something that should be put in the 'worth considering' pile?

--
Philip 

