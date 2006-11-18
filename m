X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Sean <seanlkml@sympatico.ca>
Subject: Re: [PATCH] Document git-runstatus
Date: Sat, 18 Nov 2006 15:04:31 -0500
Message-ID: <BAYC1-PASMTP103AEE0623ACD61079E916AEEF0@CEZ.ICE>
References: <455F1595.9020009@lsrfire.ath.cx>
	<20061118092644.a9f15669.seanlkml@sympatico.ca>
	<20061118143511.GM7201@pasky.or.cz>
	<455F210B.8000107@lsrfire.ath.cx>
	<BAYC1-PASMTP06C814AB518D7544770C01AEEF0@CEZ.ICE>
	<455F4F06.3090902@gmail.com>
	<BAYC1-PASMTP06DE3E6CFF9E49C2BF16C7AEEF0@CEZ.ICE>
	<455F60EA.2080009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 18 Nov 2006 20:04:50 +0000 (UTC)
Cc: A Large Angry SCM <gitzilla@gmail.com>,
	Rene Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Original-Message-Id: <20061118150431.81076072.seanlkml@sympatico.ca>
In-Reply-To: <455F60EA.2080009@gmail.com>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 18 Nov 2006 20:08:33.0859 (UTC) FILETIME=[5323C930:01C70B4D]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlWQZ-0007SS-7m for gcvg-git@gmane.org; Sat, 18 Nov
 2006 21:04:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756419AbWKRUEf (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 18 Nov 2006
 15:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756420AbWKRUEe
 (ORCPT <rfc822;git-outgoing>); Sat, 18 Nov 2006 15:04:34 -0500
Received: from bayc1-pasmtp10.bayc1.hotmail.com ([65.54.191.170]:43401 "EHLO
 BAYC1-PASMTP10.bayc1.hotmail.com") by vger.kernel.org with ESMTP id
 S1756416AbWKRUEe (ORCPT <rfc822;git@vger.kernel.org>); Sat, 18 Nov 2006
 15:04:34 -0500
Received: from linux1.attic.local ([65.93.43.81]) by
 BAYC1-PASMTP10.bayc1.hotmail.com over TLS secured channel with Microsoft
 SMTPSVC(6.0.3790.1830); Sat, 18 Nov 2006 12:08:33 -0800
Received: from guru.attic.local ([10.10.10.28]) by linux1.attic.local with
 esmtp (Exim 4.43) id 1GlVUN-00035f-5Z; Sat, 18 Nov 2006 14:04:31 -0500
To: Git Mailing List <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org

On Sat, 18 Nov 2006 11:37:14 -0800
A Large Angry SCM <gitzilla@gmail.com> wrote:

> I disagree. If a command is install on a system, it's man 
> pages/documentation should also be installed.

Well this isn't a huge issue.  One point you made though that struck
a chord is that many of the commands should probably not be in
section 1.

> I'm also not convinced that there are a "large number of commands [...] 
> that should only ever be accessed as plumbing". I am convinced, however, 
> that there are a number of relatively low level commands with poor user 
> interfaces that are useful on their own.

Is there really a reason for a git user to access these from the
command line rather than a script:

commit-tree, diff-files, diff-index, diff-tree, for-each-ref,
hash-object, http-fetch, http-push, index-pack, local-fetch,
merge-base, merge-index, merge-octopus, merge-one-file, merge-ours,
merge-recur, merge-recursive, merge-recursive-old, merge-resolve,
merge-stupid, merge-tree, receive-pack, runstatus, ssh-fetch, ssh-pull,
ssh-push, ssh-upload, symbolic-ref, unpack-file, unpack-objects,
update-ref, upload-archive, upload-pack, upload-tar, write-tree

Not a complete list, and maybe i overlooked something in there
that is needed from the command line, but for the most part 
these could be installed somewhere other than the users path.

