From: Jason Riedy <ejr@EECS.Berkeley.EDU>
Subject: Re: [Census] So who uses git?
Date: Wed, 01 Feb 2006 08:15:43 -0800
Message-ID: <14138.1138810543@lotus.CS.Berkeley.EDU>
References: <Pine.LNX.4.64.0601311747360.7301@g5.osdl.org>
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 01 17:17:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4Ke4-0002C9-8h
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 17:15:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964855AbWBAQPp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 11:15:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964942AbWBAQPp
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 11:15:45 -0500
Received: from lotus.CS.Berkeley.EDU ([128.32.36.222]:13974 "EHLO
	lotus.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S964855AbWBAQPp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2006 11:15:45 -0500
Received: from lotus.CS.Berkeley.EDU (localhost [127.0.0.1])
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8) with ESMTP id k11GFixV014140
	for <git@vger.kernel.org>; Wed, 1 Feb 2006 08:15:44 -0800 (PST)
Received: from lotus.CS.Berkeley.EDU (ejr@localhost)
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/Submit) with ESMTP id k11GFhrW014139
	for <git@vger.kernel.org>; Wed, 1 Feb 2006 08:15:44 -0800 (PST)
In-reply-to: <Pine.LNX.4.64.0601311747360.7301@g5.osdl.org> 
To: unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15426>

And Linus Torvalds writes:
 - 
 - Has anybody used git over NFS? If it's this bad (or even close to), I 
 - guess the "mark files as up-to-date in the index" approach is a really 
 - good idea..

My normal use is on NFS (Solaris and Linux) and IBM's GPFS 
(AIX and Linux).  I haven't noticed any particular problems, 
and LAPACK and the reference BLAS make a moderately sized 
working set of around 3000 source files.  Not kernel sized, 
but not tiny.

However, I mostly use git over NFS on a relatively slow 
machine.  NFS is faster than the local disk...

Jason
