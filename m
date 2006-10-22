From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Commit-ish shortcut for immediate parent range
Date: Sun, 22 Oct 2006 11:25:13 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610221117570.3962@g5.osdl.org>
References: <200610221548.42048.andyparkins@gmail.com>
 <Pine.LNX.4.64.0610221017180.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 22 20:30:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gbi5i-000413-RI
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 20:30:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbWJVSaT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 14:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbWJVSaT
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 14:30:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49384 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750700AbWJVSaS (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Oct 2006 14:30:18 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9MIPEaX017904
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 22 Oct 2006 11:25:14 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9MIPDFW029670;
	Sun, 22 Oct 2006 11:25:13 -0700
To: Andy Parkins <andyparkins@gmail.com>
In-Reply-To: <Pine.LNX.4.64.0610221017180.3962@g5.osdl.org>
X-Spam-Status: No, hits=-0.479 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29770>



On Sun, 22 Oct 2006, Linus Torvalds wrote:
> 
> So the thing to do is just
> 
> 	git show 3435fdb4c
> 
> and be happy.

Btw, if you really _only_ want the diff, you can do either

	git-diff-tree -p 3435fdb4c

which is the traditional "core" command for this. Somewhat sadly, I don't 
think we have a way to actually turn _off_ the description printing, so 
while you can turn off the _diff_ with "-s", the best you can do wrt the 
commit message is probably to use "--pretty=oneline" to cut it down to a 
single line.

I wonder if we should have a "--pretty=none" thing, so that you can use 
the "higher-level" git commands without seeing the log message.

Hmm..

			Linus
