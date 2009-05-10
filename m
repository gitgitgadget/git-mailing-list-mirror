From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git svn master pointing to commit for older svn tag?
Date: Sat, 9 May 2009 18:37:42 -0700
Message-ID: <20090510013742.GC2000@dcvr.yhbt.net>
References: <2729632a0905061459v6c257b3ay60e1f454e8f2bb4a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Sun May 10 03:38:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2xzf-0001mj-8V
	for gcvg-git-2@gmane.org; Sun, 10 May 2009 03:38:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754555AbZEJBhn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 May 2009 21:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752697AbZEJBhm
	(ORCPT <rfc822;git-outgoing>); Sat, 9 May 2009 21:37:42 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:41742 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752461AbZEJBhm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 May 2009 21:37:42 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2EA31F791;
	Sun, 10 May 2009 01:37:42 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <2729632a0905061459v6c257b3ay60e1f454e8f2bb4a@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118698>

skillzero@gmail.com wrote:
> I'm using git svn to sync to a Subversion repository and it generally
> works, but somehow, it seems to have gotten into a state where master
> is pointing to the commit for an old svn tag rather than to the svn
> trunk so 'git svn rebase' never does anything.
> 
> If I look in .git/info/refs, I see that refs/heads/master is pointing
> to the commit for a specific tag and I can change to point to
> something else, but I'm wondering how it got into this state and if
> there's a better way to tell git svn to go back to using the svn trunk
> so future rebases work correctly?

You can use "git rebase refs/remotes/trunk" on any working tree
to reapply your current work against trunk.  "git svn rebase"
just uses "git rebase" internally anyways.

-- 
Eric Wong
