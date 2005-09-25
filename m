From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Implementing diff, was Re: git 0.99.7b doesn't build on Cygwin
Date: Sun, 25 Sep 2005 10:00:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509250959540.3308@g5.osdl.org>
References: <ud5mznc1x.fsf@peter-b.co.uk>
 <Pine.LNX.4.63.0509231537390.11109@wgmdd8.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.58.0509231647300.3308@g5.osdl.org> <Pine.LNX.4.58.0509231737140.3308@g5.osdl.org>
 <7vzmq1twh5.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0509251745160.17672@wgmdd8.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.63.0509250854570.22725@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 25 19:01:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJZsF-0004rc-0U
	for gcvg-git@gmane.org; Sun, 25 Sep 2005 19:01:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751531AbVIYRBI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Sep 2005 13:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751535AbVIYRBI
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Sep 2005 13:01:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26010 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751531AbVIYRBH (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Sep 2005 13:01:07 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8PH104s010120
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 25 Sep 2005 10:01:00 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8PH0w06022247;
	Sun, 25 Sep 2005 10:00:59 -0700
To: Davide Libenzi <davidel@xmailserver.org>
In-Reply-To: <Pine.LNX.4.63.0509250854570.22725@localhost.localdomain>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.118 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9270>



On Sun, 25 Sep 2005, Davide Libenzi wrote:
>
> What you'd have to do, if you chose to use diffutils stuff, is to 
> transform the main() of diff in diff_main(), use setjmp/longjmp to capture 
> its exit()s, and make it use a proper allocator (if you want to avoid 
> leaks upon aborts).

I'd love to use libxdiff instead since you say it can do it, but quite
frankly, the man-page didn't much help me. Do you have an example of how
to generate a uni-diff with it? Something that mortal men can read and say 
"oh"?

		Linus
