From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH v2] Fix fetch/pull when run without --update-head-ok
Date: Mon, 13 Oct 2008 13:08:50 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0810131305200.19665@iabervon.org>
References: <alpine.DEB.1.00.0810111336350.22125@pacific.mpi-cbg.de.mpi-cbg.de> <alpine.LNX.1.00.0810121501590.19665@iabervon.org> <alpine.DEB.1.00.0810131129110.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com, spearce@spearce.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 13 19:10:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpQvm-00052O-RS
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 19:10:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755874AbYJMRIx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 13:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754841AbYJMRIx
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 13:08:53 -0400
Received: from iabervon.org ([66.92.72.58]:33068 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754727AbYJMRIw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 13:08:52 -0400
Received: (qmail 29642 invoked by uid 1000); 13 Oct 2008 17:08:50 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 13 Oct 2008 17:08:50 -0000
In-Reply-To: <alpine.DEB.1.00.0810131129110.22125@pacific.mpi-cbg.de.mpi-cbg.de>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98125>

On Mon, 13 Oct 2008, Johannes Schindelin wrote:

> 
> Some confusing tutorials suggested that it would be a good idea to fetch
> into the current branch with something like this:
> 
> 	git fetch origin master:master
> 
> (or even worse: the same command line with "pull" instead of "fetch").
> While it might make sense to store what you want to pull, it typically
> is plain wrong when the current branch is "master".
> 
> As noticed by Junio, this behavior should be triggered by _not_ passing
> the --update-head-ok option, but somewhere along the lines we lost that
> behavior.
> 
> NOTE: this patch does not completely resurrect the original behavior
> without --update-head-ok: the check for the current branch is now _only_
> performed in non-bare repositories.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Acked-by: Daniel Barkalow <barkalow@iabervon.org>
