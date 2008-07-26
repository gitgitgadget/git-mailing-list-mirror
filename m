From: Petr Baudis <pasky@suse.cz>
Subject: Re: [SCRIPT] git-upstream: prints the tracking chain starting at
	the named ref
Date: Sat, 26 Jul 2008 18:39:54 +0200
Message-ID: <20080726163954.GA32184@machine.or.cz>
References: <26F09105-BFA2-4FA2-86AA-B9E6F9DE3762@slashdot.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Scott Collins <scc@slashdot.org>
X-From: git-owner@vger.kernel.org Sat Jul 26 18:41:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMmpT-00076w-FB
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 18:41:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753614AbYGZQj5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 12:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753560AbYGZQj5
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 12:39:57 -0400
Received: from w241.dkm.cz ([62.24.88.241]:43584 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753049AbYGZQj4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 12:39:56 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id A525C393B8FA; Sat, 26 Jul 2008 18:39:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <26F09105-BFA2-4FA2-86AA-B9E6F9DE3762@slashdot.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90255>

  Hi,

On Sat, Jul 26, 2008 at 10:44:29AM -0400, Scott Collins wrote:
> Here's a script I've sort of `grown' over the past few weeks.
>
> I use it to quickly see where a tracking branch stands with respect to 
> upstream refs _without_ actually fetching or even switching to the tracking 
> branch.  This may not be useful for everyones' work-flows; but I find it 
> handy. I'm posting because it may be of use to others (and feedback, if 
> any, can only improve it).

  I wonder why is it a problem to fetch first in your workflow? If there
is nothing for a fetch, git-upstream is going to be as fast as git fetch
&& git branch, if there is something for a fetch, you probably want to
fetch anyway if you're running this script.

  Note that in very recent Git trees, git branch -v will show some
tracking information, however it could use quite some improvement (print
something even if the branch equals the remote branch, print the
ahead/behind combination in case the branch does not fast-forward) -
maybe it might be more effective to enhance that instead?

-- 
				Petr "Pasky" Baudis
As in certain cults it is possible to kill a process if you know
its true name.  -- Ken Thompson and Dennis M. Ritchie
