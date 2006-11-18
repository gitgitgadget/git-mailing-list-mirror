X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Sean <seanlkml@sympatico.ca>
Subject: Re: [PATCH] Document git-runstatus
Date: Sat, 18 Nov 2006 13:49:25 -0500
Message-ID: <BAYC1-PASMTP06DE3E6CFF9E49C2BF16C7AEEF0@CEZ.ICE>
References: <455F1595.9020009@lsrfire.ath.cx>
	<20061118092644.a9f15669.seanlkml@sympatico.ca>
	<20061118143511.GM7201@pasky.or.cz>
	<455F210B.8000107@lsrfire.ath.cx>
	<BAYC1-PASMTP06C814AB518D7544770C01AEEF0@CEZ.ICE>
	<455F4F06.3090902@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 18 Nov 2006 18:49:40 +0000 (UTC)
Cc: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Original-Message-Id: <20061118134925.3be201f1.seanlkml@sympatico.ca>
In-Reply-To: <455F4F06.3090902@gmail.com>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 18 Nov 2006 18:52:54.0718 (UTC) FILETIME=[C199D5E0:01C70B42]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlVFt-0008ON-MA for gcvg-git@gmane.org; Sat, 18 Nov
 2006 19:49:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756373AbWKRSta (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 18 Nov 2006
 13:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756371AbWKRSta
 (ORCPT <rfc822;git-outgoing>); Sat, 18 Nov 2006 13:49:30 -0500
Received: from bayc1-pasmtp06.bayc1.hotmail.com ([65.54.191.166]:51987 "EHLO
 BAYC1-PASMTP06.bayc1.hotmail.com") by vger.kernel.org with ESMTP id
 S1756370AbWKRSt3 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 18 Nov 2006
 13:49:29 -0500
Received: from linux1.attic.local ([65.93.43.81]) by
 BAYC1-PASMTP06.bayc1.hotmail.com over TLS secured channel with Microsoft
 SMTPSVC(6.0.3790.1830); Sat, 18 Nov 2006 10:52:54 -0800
Received: from guru.attic.local ([10.10.10.28]) by linux1.attic.local with
 esmtp (Exim 4.43) id 1GlUJh-0002z7-0n; Sat, 18 Nov 2006 12:49:25 -0500
To: gitzilla@gmail.com
Sender: git-owner@vger.kernel.org

On Sat, 18 Nov 2006 10:20:54 -0800
A Large Angry SCM <gitzilla@gmail.com> wrote:


> Are you suggesting that all non section 1 man pages should not exist?
> 

No...  I was wrong to suggest there shouldn't be a man page.. I
guess my real concern was why this particular command was needed
at all.

Really, it's not the man pages that are the problem but rather
the large number of commands that are installed into the standard
path that should only ever be accessed as plumbing.

The plumbing-only commands should really be installed somewhere
else, and man pages for them need only be installed in a
-devel package, not in the standard install.

