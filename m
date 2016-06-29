Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_20,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AD8A1FF40
	for <e@80x24.org>; Wed, 29 Jun 2016 16:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbcF2QSk (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 12:18:40 -0400
Received: from ser-smtp-vm-1.dakosy.de ([195.244.0.87]:45955 "EHLO
	ser-smtp-vm-1.dakosy.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921AbcF2QSj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 12:18:39 -0400
Received: from [10.7.2.114] (helo=ser-smtpdak-vm-1.dakosy.de)
	by ser-smtp-vm-1.dakosy.de with esmtp (Exim 4.76)
	(envelope-from <neuling@dakosy.de>)
	id 1bIICD-0002xt-8i
	for git@vger.kernel.org; Wed, 29 Jun 2016 18:18:37 +0200
Received: from daktales1.dakosy.de ([10.7.2.20])
	by ser-smtpdak-vm-1.dakosy.de with esmtp (Exim 4.82)
	(envelope-from <neuling@dakosy.de>)
	id 1bIICD-0007Il-5T
	for git@vger.kernel.org; Wed, 29 Jun 2016 18:18:37 +0200
To:	git@vger.kernel.org
MIME-Version: 1.0
Subject: git pull --rebase should use fast forward merge if possible
X-KeepSent: 95D98CB6:47969C1C-C1257FE1:0058D980;
 type=4; name=$KeepSent
X-Mailer: IBM Notes Release 9.0.1FP5 SHF164 February 10, 2016
Message-ID: <OF95D98CB6.47969C1C-ONC1257FE1.0058D980-C1257FE1.0059986D@dakosy.de>
From:	neuling@dakosy.de
Date:	Wed, 29 Jun 2016 18:18:37 +0200
X-MIMETrack: Serialize by Router on DAKTALES1/DAKOSY/DE at 29.06.2016 18:18:37,
	Serialize complete at 29.06.2016 18:18:37
Content-Type: text/plain; charset="US-ASCII"
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi, 

since I have added "pull.rebase=preserve" to my global configuration I 
wonder why "git pull" also trys to rebase if a fast forward merge is 
possible. 

A fast forward merge would speed up every pull if your local branch 
contains no new commits and the remote branch is ahead. The result would 
be the same. 

Is it possible to change the behavior of "git pull 
--rebase=true|preserve|interactive" to use a fast forward merge if the 
remote branch is ahead and the local branch contains no new commits? 


Regards, 
Mattias 
