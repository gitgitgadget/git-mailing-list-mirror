From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Commit to more than one branch at once?
Date: Fri, 6 Oct 2006 11:37:36 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610061136250.3952@g5.osdl.org>
References: <45269E02.50407@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 06 20:38:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVuZw-0005Ij-UU
	for gcvg-git@gmane.org; Fri, 06 Oct 2006 20:37:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422832AbWJFShq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Oct 2006 14:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422834AbWJFShq
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Oct 2006 14:37:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24736 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422832AbWJFShp (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Oct 2006 14:37:45 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k96IbbaX015012
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 6 Oct 2006 11:37:37 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k96IbaI8007515;
	Fri, 6 Oct 2006 11:37:36 -0700
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
In-Reply-To: <45269E02.50407@s5r6.in-berlin.de>
X-Spam-Status: No, hits=-0.468 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28430>



On Fri, 6 Oct 2006, Stefan Richter wrote:
> 
> if I git-cherry-pick a commit from branch A into branch B, this is shown
> as a difference in "git-log B..A".
> 
> Is it possible to commit a change to two or more branches but preserve
> the identity of the change? IOW, is there an alternative to
> git-cherry-pick that does not have above mentioned side effect?

If you _merge_ the change into both branches, it will be the identical 
commit in both.

So for example, one thing people can do is to have a separate "fixes" 
branch that is used for generic bugfixes and, which is merged into all 
other relevant branches.

		Linus
