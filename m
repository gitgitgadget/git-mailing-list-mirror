From: Jason Riedy <ejr@EECS.Berkeley.EDU>
Subject: Re: Git 1.3.2 on Solaris
Date: Wed, 17 May 2006 09:35:24 -0700
Message-ID: <6471.1147883724@lotus.CS.Berkeley.EDU>
References: <Pine.LNX.4.64.0605170919290.10823@g5.osdl.org>
Cc: Stefan Pfetzing <stefan.pfetzing@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 17 18:35:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgOzj-0001W9-04
	for gcvg-git@gmane.org; Wed, 17 May 2006 18:35:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbWEQQf2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 12:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750711AbWEQQf2
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 12:35:28 -0400
Received: from lotus.CS.Berkeley.EDU ([128.32.36.222]:7861 "EHLO
	lotus.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S1750703AbWEQQf2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 May 2006 12:35:28 -0400
Received: from lotus.CS.Berkeley.EDU (localhost [127.0.0.1])
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/3.141592645) with ESMTP id k4HGZPgH006475;
	Wed, 17 May 2006 09:35:25 -0700 (PDT)
Received: from lotus.CS.Berkeley.EDU (ejr@localhost)
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/Submit) with ESMTP id k4HGZOcL006474;
	Wed, 17 May 2006 09:35:24 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
In-reply-to: <Pine.LNX.4.64.0605170919290.10823@g5.osdl.org> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20213>

And Linus Torvalds writes:
 - 
 - Now, I'm told pkgsrc is horrible, but it can't be so horrid as to not 
 - allow private directories?

Works fine.
  1) Depend on the GNU tools through the buildlink, um, stuff.
  2) Add a config.mak via a local patch that sets gitexecprefix.
  3) Add another local patch that sets up links within that
     gitexecprefix to the GNU tools.  Remember to check if the
     GNU tools were installed without the silly g prefix.

And pkgsrc itself works just fine without the silly g prefix,
or at least does for me as a mere user (and as well as it does
work).  But if you intend on adding the package upstream, it'll
need something to cope with the g.  And pkgsrc handles local
patches...

Jason
