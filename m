From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] [BUG] Add a test to check git-prune does not throw away
 revs hidden by a graft.
Date: Thu, 18 May 2006 14:37:06 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605181435230.10823@g5.osdl.org>
References: <20060518213519.14577.67309.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 18 23:37:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgqBL-0002b9-W4
	for gcvg-git@gmane.org; Thu, 18 May 2006 23:37:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbWERVhP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 May 2006 17:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbWERVhP
	(ORCPT <rfc822;git-outgoing>); Thu, 18 May 2006 17:37:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48795 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751402AbWERVhN (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 May 2006 17:37:13 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4ILb7tH001342
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 18 May 2006 14:37:07 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4ILb68o002682;
	Thu, 18 May 2006 14:37:06 -0700
To: Yann Dirson <ydirson@altern.org>
In-Reply-To: <20060518213519.14577.67309.stgit@gandelf.nowhere.earth>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20303>



On Thu, 18 May 2006, Yann Dirson wrote:
> 
> This test fails with 1.3.x and HEAD.  This is a very serious bug, since it
> causes data loss.

Is it/does it?

I'd assume that if you have a graft, you _want_ the history to be hidden 
and pruned. 

That's how you'd drop history, if you wanted to do it on purpose.

		Linus
