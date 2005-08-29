From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: question git & branches
Date: Mon, 29 Aug 2005 08:03:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508290754410.3243@g5.osdl.org>
References: <4312C24E.4000803@candelatech.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 29 17:08:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9lBG-0000Hs-Ej
	for gcvg-git@gmane.org; Mon, 29 Aug 2005 17:04:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987AbVH2PEE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Aug 2005 11:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751021AbVH2PEE
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Aug 2005 11:04:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52123 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750987AbVH2PED (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Aug 2005 11:04:03 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7TF42jA030683
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 29 Aug 2005 08:04:02 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7TF3xme006640;
	Mon, 29 Aug 2005 08:04:00 -0700
To: Ben Greear <greearb@candelatech.com>
In-Reply-To: <4312C24E.4000803@candelatech.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7902>



On Mon, 29 Aug 2005, Ben Greear wrote:
> 
> I think I'm missing something fundamental though...  I wanted to
> change to the ben_dev_rfcnt branch to build a kernel without my
> additional patch.  git branch ben_dev_rfcnt seems to change
> it fine, but all of the changes for repository 'foo' are also
> still here.

"git branch" just creates the branch, it doesn't actually do anything
else. Use "git checkout <branchname>" to switch to it.

You can do both with "bit checkout -b <branchname>" which both creates the 
branch and switches to it.

(Both "git branch" and "git checkout -b <branchname>" that reate a new
branch take an optional argument which says what point you want the branch
to start at. It defaults to "current state", but you can create a branch
at any point in the history by just explicitly stating the commit name
that you want to start off with as the head of the branch)

Use "gitk --all" to visualize where the different branches are in the 
history, and a plain "git branch" with no arguments to list the branches 
and mark your currently active branch.

				Linus
