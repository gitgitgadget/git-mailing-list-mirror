From: Andreas Krey <a.krey@gmx.de>
Subject: Re: first parent, commit graph layout, and pull merge direction
Date: Fri, 24 May 2013 15:42:14 +0200
Message-ID: <20130524134214.GA26617@inner.h.apk.li>
References: <20130522115042.GA20649@inner.h.apk.li> <7v4ndukhx0.fsf@alter.siamese.dyndns.org> <20130523090657.GB23933@inner.h.apk.li> <20130523192512.GR9448@inner.h.apk.li> <519F32DC.0@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Holger Hellmuth (IKS)" <hellmuth@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri May 24 15:42:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfsGW-0000xa-Rc
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 15:42:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751755Ab3EXNmX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 09:42:23 -0400
Received: from continuum.iocl.org ([217.140.74.2]:41097 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285Ab3EXNmW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 09:42:22 -0400
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id r4ODgEW27124;
	Fri, 24 May 2013 15:42:14 +0200
Content-Disposition: inline
In-Reply-To: <519F32DC.0@ira.uka.de>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225353>

On Fri, 24 May 2013 11:29:00 +0000, Holger Hellmuth (IKS) wrote:
...
> Here is an idea (probably already discussed in the long history of git):
> 1) the branch name is recorded in a commit (for merges the branch that 
> is updated)

The branch name is almost completely meaningless. I could just
do my feature in my local master and never have a different name.

Or commit something onto tmp that I then fast-forward into my
(properly named) feature branch.

> 2) unique identifier of repository is recorded in commit (optional)

That is pure noise (in my workflow).

> 3) simple configurable ordering and/or coloring scheme in gitk based on 
> committer,branch name and repo (with wildcards).

Ok, gitk could use some features. :-)

...
> Is this a bad idea or just no one did it yet?

Possibly not bad (hg does parts of it), but un-git-ish?

(I'm not sure that it was *intended* that the parents
of a merge commit have an order, except that they need
to for deterministic hashes.)

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
