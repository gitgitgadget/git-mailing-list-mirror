From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn stomps on user properties
Date: Mon, 7 Apr 2008 00:40:44 -0700
Message-ID: <20080407074044.GA12394@muzzle>
References: <20080320170108.GA27194@dervierte>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steven Walter <stevenrwalter@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 09:41:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jilyr-0002sh-DE
	for gcvg-git-2@gmane.org; Mon, 07 Apr 2008 09:41:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752713AbYDGHkr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2008 03:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752711AbYDGHkq
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Apr 2008 03:40:46 -0400
Received: from hand.yhbt.net ([66.150.188.102]:44591 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752547AbYDGHkq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2008 03:40:46 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id EFEED7F41D5;
	Mon,  7 Apr 2008 00:40:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080320170108.GA27194@dervierte>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78954>

Steven Walter <stevenrwalter@gmail.com> wrote:
> I'm using git-svn to track an upstream subversion repository.  This
> upstream repository has several "user" SVN properties (i.e., not in the
> svn: namespace).  A recent git-svn dcommit resulted in one of these
> properties being reverted.
> 
> Here's what happened.  I started a git-svn dcommit of 3 very large
> commits.  In between commits 2 and 3, a commit was made by another
> person that changed one of our user properties.  When git-svn sent the
> third commit, it also reverted the property to its value before the
> other's user's change.
> 
> Why did that happen?  Surely it isn't expected behavior.  Glancing
> through git-svn, I don't see anywhere that it deals with properties
> directly, outside of svm/svnsync properties.
> 
> Thanks for any help or insight you can provide

Sorry, I'm not ignoring you, I just haven't had time to look into this
yet.

-- 
Eric Wong
