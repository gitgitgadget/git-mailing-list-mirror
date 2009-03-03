From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git filter-branch: Process commits in --date-order
Date: Tue, 3 Mar 2009 01:28:10 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903030126530.10279@pacific.mpi-cbg.de>
References: <1236035454-12236-1-git-send-email-peda@lysator.liu.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Peter Rosin <peda@lysator.liu.se>
X-From: git-owner@vger.kernel.org Tue Mar 03 01:28:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeIUX-00017l-Rv
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 01:28:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757791AbZCCA0t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2009 19:26:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757533AbZCCA0s
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 19:26:48 -0500
Received: from mail.gmx.net ([213.165.64.20]:53486 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753854AbZCCA0s (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2009 19:26:48 -0500
Received: (qmail invoked by alias); 03 Mar 2009 00:26:45 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp045) with SMTP; 03 Mar 2009 01:26:45 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+13QA8qJG1HYQ7mrA+0/PWDx3i+iAH913s16eU0p
	ogqYY6OeJgYB/i
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1236035454-12236-1-git-send-email-peda@lysator.liu.se>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111982>

Hi,

On Tue, 3 Mar 2009, Peter Rosin wrote:

> When converting an svn repository to git, I am filtering the commits
> using --msg-filter. During this conversion I want to use the
> .git-rewrite/map data to fill in references to other commits. In the
> svn repo, there is a commit message e.g. "Cherry-pick r207", and I
> want to append "r207 = <commit>" to the git commit message, as r207
> no longer means very much. This works fine when the git commit
> corresponding to r207 has been filtered before the current commit, and
> is present in the map. When filtering in --topo-order, this is not
> always the case, making it impossible to look up the git commit.

I'd rather have this as an option.  God knows what breaks with time-skewed 
repositories if you use date-order instead of topo-order, and I'd rather 
not break that not quite uncommon case.

Ciao,
Dscho
