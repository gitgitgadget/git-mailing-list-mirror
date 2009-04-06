From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: The EGIT Chronicles Issue Volume 3, Issue 1
Date: Mon, 6 Apr 2009 08:03:48 -0700
Message-ID: <20090406150348.GH23604@spearce.org>
References: <200904060833.27711.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Mon Apr 06 17:06:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqqOa-00080n-8Q
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 17:05:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751727AbZDFPDu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 11:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751597AbZDFPDu
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 11:03:50 -0400
Received: from george.spearce.org ([209.20.77.23]:49758 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751195AbZDFPDu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 11:03:50 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 44E6A38215; Mon,  6 Apr 2009 15:03:48 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200904060833.27711.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115843>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
>
> Most interestingly, some Eclipse developers, i.e. the ones
> that build and contribute to the Eclipse platform, have raised
> interest in Git for source control. We have had an Eclipse
> proposal under development for a while and finally submitted
> EGit for consideration as and Eclipse Technology project.  Link:
> http://www.eclipse.org/proposals/egit/
> 
> Egit is EPL and BSD licensed which license-wise qualifies it for
> inclusion into the Eclipse project, unlike the nearest competitor
> Mercurial that cannot be bundled with Eclipse due to the GPL.

For pretty much this reason alone, Eclipse is starting to consider
switching from CVS and SVN to Git.  Some committers were interested
in a switch to Mecurial, but the GPL license makes it unfriendly
to the project's distribution rules.

> - Shawn's been working on Gerrit2, a code review system built on
> top of JGit, the core of the Eclipse plugin.

Its also sucking up all of my time.

But... its open source, and is gaining (some) momentum in Git
communities that want mandatory code review, but who also want to
avoid the bottleneck of a maintainer / "merge monkey".

Junio made some remark back when I joined Google that Google just
swallows up open source developers whole, and you never hear from
them again.  At least half true.  Fortunately I am at least able to
open source (EPL if in EGit, BSD if in JGit, else APLv2) everything
that I do while in that big black hole known as Google.

> - Lots of stuff is coming. For example, a few diff engines are
> being considered, a blame implementation has been demonstrated,
> though not fully ready yet. Some simple merge/cherry picking
> capability is included already, but without the diff/patch engine
> it's not as fully automated as one might want yet. Gerrit2 uses
> it though.

The lack of a diff engine is starting to become an issue for me
in Gerrit2.  Maybe next month I'll be able to get to it, if someone
doesn't beat me to it first.  Gerrit2 users are asking for proper
cherry pick support, not just the path-level-only cr*p we do now.

-- 
Shawn.
