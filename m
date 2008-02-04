From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add platform-independent .git "symlink"
Date: Mon, 4 Feb 2008 21:31:06 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802042128170.8543@racer.site>
References: <8c5c35580802020959v613b9e32v321e97f93f2af761@mail.gmail.com> <1201975757-13771-1-git-send-email-hjemli@gmail.com> <alpine.LSU.1.00.0802021815510.7372@racer.site> <alpine.LSU.1.00.0802021825220.7372@racer.site>
 <47A78104.9050909@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Lars Hjemli <hjemli@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Mon Feb 04 22:32:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM8vK-00034z-Rz
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 22:32:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754308AbYBDVbq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 16:31:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754320AbYBDVbq
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 16:31:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:46405 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754257AbYBDVbp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 16:31:45 -0500
Received: (qmail invoked by alias); 04 Feb 2008 21:31:43 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp008) with SMTP; 04 Feb 2008 22:31:43 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19V9ItFauxVaDeYeo7j9Y6HZA1lMBVy0FE+Zfff2G
	jgjHwrGVLF6iFA
X-X-Sender: gene099@racer.site
In-Reply-To: <47A78104.9050909@nrlssc.navy.mil>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72574>

Hi,

On Mon, 4 Feb 2008, Brandon Casey wrote:

> Johannes Schindelin wrote:
> 
> > BTW just to tell you why I am so excited with your patch: I have a 
> > patch to git-branch in my tree, which implements the git-new-workdir 
> > functionality (it's a patch to git-branch, not git-checkout, mainly 
> > because git-checkout is no builtin yet).
> 
> Are you planning something that works like:
> 
>   $ cd <my_repo>
>   $ git branch
>     * master
>       other_branch
>   $ git checkout --new-workdir ../<other_work_dir> other_branch
> 
> (not sure how it would work using git-branch).

Something like this, yes.  In my local version of git, you can say "git 
branch --new-workdir=../bla new-branch [branch-point]".

> Have you thought about using git-clone instead?

Briefly.  But this is not about cloning the repository.  It is about 
having an additional working directory for the current repository.

> It seems a good fit but would require a new option to specify a branch 
> to checkout (which I believe is a requested feature for clone).

It is an often-requested feature for clone, but we have "clone -n" for 
now, and nobody seemed to care deeply enough to actually do something 
about it.

But really, clone is something different.  I _want_ the original 
repository to know that there is another working directory.

Ciao,
Dscho
