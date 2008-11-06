From: Eric Wong <normalperson@yhbt.net>
Subject: Re: How to rebase for git svn?
Date: Thu, 6 Nov 2008 01:55:00 -0800
Message-ID: <20081106095500.GA9587@untitled>
References: <4911EF4C.8030703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yang Zhang <yanghatespam@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 06 10:56:19 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ky1b8-0001oN-94
	for gcvg-git-2@gmane.org; Thu, 06 Nov 2008 10:56:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753285AbYKFJzE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Nov 2008 04:55:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753291AbYKFJzD
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Nov 2008 04:55:03 -0500
Received: from hand.yhbt.net ([66.150.188.102]:38501 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752942AbYKFJzB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Nov 2008 04:55:01 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id BCB5C2DC01A;
	Thu,  6 Nov 2008 09:55:00 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4911EF4C.8030703@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100224>

Yang Zhang <yanghatespam@gmail.com> wrote:
> Hi, I made a git svn repository from an svn repository.  Then I cloned  
> the git repository, committed some changes to the clone, and pulled back  
> to the original repository.  However, now the original repository gives  
> me conflicts whenever I run git svn rebase.  I believe this is because  
> git pull treats the other repository's commits as a branch and merges  
> them back instead of rebasing them and maintaining the type of linear  
> history that is good for playing with svn.  Any hints as to how to fix  
> this?  I think the solution is to undo the merge that resulted from the  
> pull, but I don't know how to do this.
>
> I wrote a simple script reproducing exactly what's going on (along with  
> a transcript of its output).  I tried to make it as simple as possible,  
> but it can probably be simplified even more to reproduce the problem:
>
> http://assorted.svn.sourceforge.net/viewvc/assorted/sandbox/trunk/src/git/gitsvn.bash?revision=1057&view=markup
>
> Thanks in advance for any help!

Hi,

Try passing --rebase or --squash with "git pull" to keep history linear
for SVN.

-- 
Eric Wong
