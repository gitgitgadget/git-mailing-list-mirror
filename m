From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Status of Mac OS/X ports of git and cogito?
Date: Sun, 11 Sep 2005 10:46:46 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509111043430.3242@g5.osdl.org>
References: <deofnh$jl0$1@sea.gmane.org> <7vd5o03uof.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0509111159190.32555@wgmdd8.biozentrum.uni-wuerzburg.de>
 <7vvf17tsoa.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	John Ellson <ellson@research.att.com>, git@vger.kernel.org,
	Patrick Mauritz <oxygene@studentenbude.ath.cx>,
	Jason Riedy <ejr@EECS.Berkeley.EDU>
X-From: git-owner@vger.kernel.org Sun Sep 11 19:48:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEVv8-0003np-Vm
	for gcvg-git@gmane.org; Sun, 11 Sep 2005 19:47:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964992AbVIKRrM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 13:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964995AbVIKRrM
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 13:47:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39402 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964992AbVIKRrK (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Sep 2005 13:47:10 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8BHklBo013773
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 11 Sep 2005 10:46:47 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8BHkkhR014260;
	Sun, 11 Sep 2005 10:46:46 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vvf17tsoa.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8305>



On Sun, 11 Sep 2005, Junio C Hamano wrote:
>
> Patrick and Jason CC:'ed because they also have portability
> issues and seem to have good ideas about how they should be
> solved.  Linus CC:'ed because he once expressed rather strongly
> his dislike about autoconf.

I personally think autoconf is the devils tool, and have had much more 
luck with

 - creating "compat" libraries that implement functions that some 
   configurations don't have.

   Sometimes this involves renaming the function, in order to avoid 
   clashes with broken implementations of same.

 - just ignoring the really broken systems (old HP-UX etc is terminally 
   diseased, and simply not worth worrying about)

autoconf generates an unreadable mess that can't be fixed. Doing it by 
hand at least means you can fix it.

But hey, I don't care that much any more, since I'm not the sucker who 
maintains it ;)

		Linus
