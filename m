From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 00/19] gitweb: Remove dependency on external diff and
 need for temporary files
Date: Sat, 26 Aug 2006 20:30:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0608262026230.11811@g5.osdl.org>
References: <200608240015.15071.jnareb@gmail.com> <200608252315.57181.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 27 05:31:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHBMR-0004vX-3Y
	for gcvg-git@gmane.org; Sun, 27 Aug 2006 05:30:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750982AbWH0Day (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Aug 2006 23:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbWH0Day
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Aug 2006 23:30:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23196 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750982AbWH0Dax (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Aug 2006 23:30:53 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k7R3UonW027755
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 26 Aug 2006 20:30:50 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k7R3Un9u013429;
	Sat, 26 Aug 2006 20:30:50 -0700
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200608252315.57181.jnareb@gmail.com>
X-Spam-Status: No, hits=-0.933 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.143 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26083>



On Fri, 25 Aug 2006, Jakub Narebski wrote:
>
> This series of patches (now finished) removes dependency on
> external diff (/usr/bin/diff) to produce commitdiff and blobdiff
> views, and the need for temporary files.

Ok, can we now please fix my final annouyance, which is that gitweb from 
the very beginning has apparently believed that the "Signed-off-by:" etc 
lines are not important, and they get stripped away when looking at the 
"commit-diff".

Also, "commit-diff" really should have some minimal authorship 
information. It's silly to have to go to "commit" and then separately ask 
for "diff" to see all these very basic things.

So I think that "commit-diff" should basically show the equivalent of "git 
show --pretty", ie author, date, commit message (including sign-offs) and 
then the diff.

No?

			Linus
