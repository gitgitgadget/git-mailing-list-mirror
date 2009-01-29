From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Force commit date
Date: Thu, 29 Jan 2009 14:10:20 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0901291406000.19665@iabervon.org>
References: <1233253817209-2240539.post@n2.nabble.com> <1233254709681-2240602.post@n2.nabble.com> <200901291955.10769.markus.heidelberg@web.de> <1233255759118-2240702.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Zabre <427@free.fr>
X-From: git-owner@vger.kernel.org Thu Jan 29 20:11:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LScIn-00058L-DM
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 20:11:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753447AbZA2TKX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 14:10:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753068AbZA2TKX
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 14:10:23 -0500
Received: from iabervon.org ([66.92.72.58]:35394 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752663AbZA2TKW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 14:10:22 -0500
Received: (qmail 30017 invoked by uid 1000); 29 Jan 2009 19:10:20 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 29 Jan 2009 19:10:20 -0000
In-Reply-To: <1233255759118-2240702.post@n2.nabble.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107718>

On Thu, 29 Jan 2009, Zabre wrote:

> Markus Heidelberg wrote:
> > 
> > man git-commit-tree
> > -> GIT_COMMITTER_DATE
> > 
> > Though only in the git-commit-tree docs, it also works with git-commit.
> > Maybe it should be added there, too.
> > 
> 
> Thank you Markus, I'll have a look at this too !

You may want to consider whether those dates make most sense as the date 
of the commit, or the date the changes were done; git tracks both of 
these separately, in part because it's easy to have some work done at one 
time, and only make the commit that becomes part of the official project 
history much later (and these may be done by different people).

The date for the changes being done is set with GIT_AUTHOR_DATE

	-Daniel
*This .sig left intentionally blank*
