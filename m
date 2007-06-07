From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn "cannot lock ref" error during fetch
Date: Wed, 6 Jun 2007 23:31:58 -0700
Message-ID: <20070607063158.GA2809@muzzle>
References: <50C9688F-9C62-43AC-A84D-D84561671BAC@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: James Peach <jamespeach@mac.com>
X-From: git-owner@vger.kernel.org Thu Jun 07 08:32:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwBXa-0003pL-Cj
	for gcvg-git@gmane.org; Thu, 07 Jun 2007 08:32:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbXFGGcB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 02:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750955AbXFGGcB
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 02:32:01 -0400
Received: from hand.yhbt.net ([66.150.188.102]:57202 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750825AbXFGGcA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 02:32:00 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 7A0972DC032;
	Wed,  6 Jun 2007 23:31:58 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Wed, 06 Jun 2007 23:31:58 -0700
Content-Disposition: inline
In-Reply-To: <50C9688F-9C62-43AC-A84D-D84561671BAC@mac.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49357>

James Peach <jamespeach@mac.com> wrote:
> Hi all,
> 
> I'm new to git, and I'm experimenting with using git-svn to interact  
> with a large SVN repository with lots of branches.
> 
> I initially did an init like this:
> 
> git-svn init -t tags -b branches -T trunk svn+ssh://server/svn/project
> 
> Then I did a git-svn fetch, which started pulling all the branches.  
> After a while, however, it hit a branch that it couldn't pull:
> 
> Found branch parent: (tags/project-92~9)  
> 767f1f1601a4deae459c99ea6c1d1b9ba8f57a65
> Following parent with do_update
> ...
> Successfully followed parent
> fatal: refs/remotes/tags/project-92~9: cannot lock the ref
> update-ref -m r13726 refs/remotes/tags/project-92~9  
> 950638ff72acc278156a0d55baafbabb43f2b772: command returned error: 128
> 
> Some amount of searching failed to turn up any hints on what this  
> error means or how I can work around it. I'd appreciate any advice ...

Is there a tag actually named "project-92~9"?  If so, it's
an invalid branch name for git.  I started working on a way
around it by mapping new names to it, but haven't gotten around to
finishing it....

-- 
Eric Wong
