Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 196A91FE4E
	for <e@80x24.org>; Thu, 16 Jun 2016 09:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753929AbcFPJER (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 05:04:17 -0400
Received: from mout01.posteo.de ([185.67.36.65]:46914 "EHLO mout01.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751683AbcFPJEO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Jun 2016 05:04:14 -0400
Received: from dovecot03.posteo.de (dovecot03.posteo.de [172.16.0.13])
	by mout01.posteo.de (Postfix) with ESMTPS id 9E69620B7D
	for <git@vger.kernel.org>; Thu, 16 Jun 2016 11:04:11 +0200 (CEST)
Received: from mail.posteo.de (localhost [127.0.0.1])
	by dovecot03.posteo.de (Postfix) with ESMTPSA id 3rVcrN6NZLz5vN9
	for <git@vger.kernel.org>; Thu, 16 Jun 2016 11:04:04 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8BIT
Date:	Thu, 16 Jun 2016 11:04:04 +0200
From:	Sven <sven@sand.rocks>
To:	git@vger.kernel.org
Subject: core.fscache on Windows trashes system
Message-ID: <52c5ee4f39701784bc451684a175f0c9@posteo.de>
X-Sender: sven@sand.rocks
User-Agent: Posteo Webmail
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hello List,

We use git in our company and found a problem with the version 2.8.3 
(x64 and x86). After installing git, with activated file system caching 
on Windows 8.1 Enterprise, on the first use of git there a git.exe 
processes started again and again. Multiple thousands instances are 
generated and do not stop until I renamed the git.exe and piece by piece 
the processes vanish. Renaming the executable to git.exe again, open git 
bash, same procedure.

I tried to let it go over night and kept the pc running (the processes 
used nearly all RAM (8GB) and the system swapped all the time. Next day 
everything went fine. After a reboot, it happens again. Only workaround 
till now for us is to uninstall git and install again with “Enable 
Filesystem cache” disabled.

Any other occurrences of this behavior? It does not happen on all pcs 
but we had 5 pcs until now with this strange behavior.

We have Kaspersky Endpoint Security 10 running that quarantines git.exe 
from time to time, maybe this could cause issues.


-- 
Ciao,

Sven
