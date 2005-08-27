From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Storing state in $GIT_DIR
Date: Fri, 26 Aug 2005 17:23:10 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508261722410.3317@g5.osdl.org>
References: <46a038f905082420323b025e3b@mail.gmail.com>
 <Pine.LNX.4.58.0508251053000.3317@g5.osdl.org> <46a038f905082518306e9d7d2a@mail.gmail.com>
 <Pine.LNX.4.58.0508252051400.3317@g5.osdl.org> <46a038f90508252115415acc04@mail.gmail.com>
 <7v3boxl3o1.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0508260101390.23242@iabervon.org>
 <Pine.LNX.4.58.0508252219520.3317@g5.osdl.org> <7virxti6y5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 27 02:24:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8oTl-0004ww-G4
	for gcvg-git@gmane.org; Sat, 27 Aug 2005 02:23:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965180AbVH0AXV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Aug 2005 20:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965181AbVH0AXV
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Aug 2005 20:23:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53930 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965180AbVH0AXV (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Aug 2005 20:23:21 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7R0NBjA022097
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 26 Aug 2005 17:23:11 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7R0NAPN005496;
	Fri, 26 Aug 2005 17:23:10 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7virxti6y5.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7828>



On Thu, 25 Aug 2005, Junio C Hamano wrote:
> 
> "v0.99.5^0" means "look at the named object v0.99.5, dereference
> it repeatedly until you get a non-tag, and take the result,
> which had better be a commit".  If a tag can contain more than
> one pointers, I do not know what it means.

Yeah, we'd have to either just say "I can't do that, Dave", or specify 
that it only looks at the first object in the list.

		Linus
