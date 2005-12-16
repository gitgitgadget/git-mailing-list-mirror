From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] faking cvs annotate
Date: Fri, 16 Dec 2005 14:12:46 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0512161412310.3698@g5.osdl.org>
References: <46a038f90512151713i118e58acia466d0f65ff91383@mail.gmail.com>
 <Pine.LNX.4.63.0512160229140.6323@wbgn013.biozentrum.uni-wuerzburg.de>
 <46a038f90512152037u66993aadg566a2a47abd279c9@mail.gmail.com>
 <Pine.LNX.4.64.0512160843450.3060@g5.osdl.org>
 <Pine.LNX.4.64.0512161636150.26663@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 16 23:15:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EnNpV-0008ME-GA
	for gcvg-git@gmane.org; Fri, 16 Dec 2005 23:13:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932496AbVLPWNa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Dec 2005 17:13:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932523AbVLPWNa
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Dec 2005 17:13:30 -0500
Received: from smtp.osdl.org ([65.172.181.4]:4508 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932496AbVLPWN3 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Dec 2005 17:13:29 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jBGMCrDZ007439
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 16 Dec 2005 14:12:54 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jBGMClgg014366;
	Fri, 16 Dec 2005 14:12:48 -0800
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0512161636150.26663@localhost.localdomain>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.57__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13760>



On Fri, 16 Dec 2005, Nicolas Pitre wrote:

> On Fri, 16 Dec 2005, Linus Torvalds wrote:
> 
> > But, for example:
> > 
> > 	[torvalds@g5 linux-history]$ time git-whatchanged drivers/char/Makefile > /dev/null 
> > 	real    0m37.993s
> > 	user    0m41.912s
> > 	sys     0m0.400s
> 
> Hmmm... I'd like to have a system like that too, where reality is 
> smaller than the sum of system and user time.  ;-)

It's called "smp".

You can buy then anywhere.

		Linus
