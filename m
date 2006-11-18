X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Sean <seanlkml@sympatico.ca>
Subject: Re: [PATCH] Document git-runstatus
Date: Sat, 18 Nov 2006 11:04:20 -0500
Message-ID: <BAYC1-PASMTP06C814AB518D7544770C01AEEF0@CEZ.ICE>
References: <455F1595.9020009@lsrfire.ath.cx>
	<20061118092644.a9f15669.seanlkml@sympatico.ca>
	<20061118143511.GM7201@pasky.or.cz>
	<455F210B.8000107@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 18 Nov 2006 16:04:42 +0000 (UTC)
Cc: Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Original-Message-Id: <20061118110420.d1c504fc.seanlkml@sympatico.ca>
In-Reply-To: <455F210B.8000107@lsrfire.ath.cx>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 18 Nov 2006 16:07:49.0171 (UTC) FILETIME=[B16F5030:01C70B2B]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlSg7-0003BA-Q6 for gcvg-git@gmane.org; Sat, 18 Nov
 2006 17:04:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755083AbWKRQEX (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 18 Nov 2006
 11:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755148AbWKRQEX
 (ORCPT <rfc822;git-outgoing>); Sat, 18 Nov 2006 11:04:23 -0500
Received: from bayc1-pasmtp06.bayc1.hotmail.com ([65.54.191.166]:42873 "EHLO
 BAYC1-PASMTP06.bayc1.hotmail.com") by vger.kernel.org with ESMTP id
 S1755083AbWKRQEW (ORCPT <rfc822;git@vger.kernel.org>); Sat, 18 Nov 2006
 11:04:22 -0500
Received: from linux1.attic.local ([65.93.43.81]) by
 BAYC1-PASMTP06.bayc1.hotmail.com over TLS secured channel with Microsoft
 SMTPSVC(6.0.3790.1830); Sat, 18 Nov 2006 08:07:48 -0800
Received: from guru.attic.local ([10.10.10.28]) by linux1.attic.local with
 esmtp (Exim 4.43) id 1GlRjv-0002pd-Iu; Sat, 18 Nov 2006 10:04:19 -0500
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org

On Sat, 18 Nov 2006 16:04:43 +0100
Rene Scharfe <rene.scharfe@lsrfire.ath.cx> wrote:

> git-status is a wrapper around git-runstatus that takes the same
> options as git-commit.  It could have been named 'git-commit --dry-run'.

What could be said in the docs as to when the use of one is preferred
over the other?

> > All commands deserve a man page.
> 
> Exactly.  Even plumbers read manuals ;-).  Well, me at least.

Heh, I suppose you and Petr are right.  It's just that in recent
discussions the great number of commands provided by Git is seen
as a UI problem.  Thus having two commands that seem to do the
exact same thing gives more such pain for no gain.

It's possible that plumbers should not be seen as "users" but
rather as coders capable of reading traditional text based
(non man-page) documentation for their purposes, and man pages
should only exist (or at least installed) for user level commands.

