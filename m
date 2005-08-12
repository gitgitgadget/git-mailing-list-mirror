From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Use "-script" postfix for scripts
Date: Fri, 12 Aug 2005 14:55:01 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508121451590.3295@g5.osdl.org>
References: <Pine.LNX.4.63.0508121526050.25606@wgmdd8.biozentrum.uni-wuerzburg.de>
 <7vwtmrxjbb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 12 23:56:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3hUn-00046Y-Hm
	for gcvg-git@gmane.org; Fri, 12 Aug 2005 23:55:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbVHLVzQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Aug 2005 17:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbVHLVzQ
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Aug 2005 17:55:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23233 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751297AbVHLVzP (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Aug 2005 17:55:15 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7CLt6jA013423
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 12 Aug 2005 14:55:06 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7CLt1dP013589;
	Fri, 12 Aug 2005 14:55:04 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwtmrxjbb.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.44__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 12 Aug 2005, Junio C Hamano wrote:
> 
> I have never liked the original -script name convention.  It
> only meant that they are implemented as scripts (as opposed to
> those on the $(PROG) Makefile variable), but the end users who
> end up typing their names from the command line, and to a lesser
> degree the people who use them in their scripts, should not care
> how they are implemented to begin with.

Well, end users _don't_ care, since they are supposed to use just a simple
"git xxx".

The advantage with "git-xxx-script" is for git developers: at least yours 
truly does "grep xyz *.c" all the time, and the "grep abc *-script" is 
entirely analogous to that. That's where the "-script" ending comes from: 
it really helps pick out the stuff you can grep from (as opposed to the 
stuff that got compiled and isn't greppable).

Sure, I could have called it ".sh" instead to make it look even more like 
a shell script thing, but I actually think "-script" describes any 
scripting language - shell, perl, you name it..

			Linus
