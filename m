From: sean <seanlkml@sympatico.ca>
Subject: Re: Who do I report bugs in the git source web browser thing to?
Date: Thu, 23 Mar 2006 18:23:36 -0500
Message-ID: <BAYC1-PASMTP04E797AD25632CF422EA86AEDE0@CEZ.ICE>
References: <200603231143.17762.rob@landley.net>
	<Pine.LNX.4.64.0603230856250.26286@g5.osdl.org>
	<200603231747.32166.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: torvalds@osdl.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 24 00:26:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMZBr-0007rT-3l
	for gcvg-git@gmane.org; Fri, 24 Mar 2006 00:26:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161006AbWCWX0A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Mar 2006 18:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161007AbWCWX0A
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Mar 2006 18:26:00 -0500
Received: from bayc1-pasmtp04.bayc1.hotmail.com ([65.54.191.164]:57135 "EHLO
	BAYC1-PASMTP04.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1161006AbWCWXZ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Mar 2006 18:25:59 -0500
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP04.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 23 Mar 2006 15:25:59 -0800
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 165E2644C28;
	Thu, 23 Mar 2006 18:25:58 -0500 (EST)
To: Rob Landley <rob@landley.net>
Message-Id: <20060323182336.062fc63a.seanlkml@sympatico.ca>
In-Reply-To: <200603231747.32166.rob@landley.net>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 23 Mar 2006 23:25:59.0649 (UTC) FILETIME=[24A3E510:01C64ED1]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 23 Mar 2006 17:47:31 -0500
Rob Landley <rob@landley.net> wrote:

> On Thursday 23 March 2006 12:03 pm, Linus Torvalds wrote:
> > On Thu, 23 Mar 2006, Rob Landley wrote:
> > Pick another file, like the Makefile, to see what real history looks like
> > (or, better yet, go into a different directory that actually sees more
> > real work, like kernel/, and look at the history of files there).
> 
> I was trying to find out when symlink support went in to gen_init_cpio.c, so 
> that was the only file that interested me.  I forgot that the bitkeeper 
> history never got moved over.
> 

Rob,

You might be able to find what you need in the bk history imported into 
git as "Linux kernel history" by Thomas Gleixner on kernel.org:

http://kernel.org/git/?p=linux/kernel/git/tglx/history.git;a=history;h=e7e173af42dbf37b1d946f9ee00219cb3b2bea6a;f=usr/gen_init_cpio.c

Sean
