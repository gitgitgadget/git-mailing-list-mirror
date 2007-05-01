From: Chris Shoemaker <c.shoemaker@cox.net>
Subject: Re: svn:externals using git submodules
Date: Tue, 1 May 2007 11:36:26 -0400
Message-ID: <20070501153626.GA21182@pe.Belkin>
References: <200705011121.17172.andyparkins@gmail.com> <20070501150724.GA20797@pe.Belkin> <20070501152228.GF5942@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue May 01 17:36:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HiuP2-0004yG-M2
	for gcvg-git@gmane.org; Tue, 01 May 2007 17:36:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752057AbXEAPg3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 11:36:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752159AbXEAPg3
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 11:36:29 -0400
Received: from eastrmmtao101.cox.net ([68.230.240.7]:49505 "EHLO
	eastrmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752057AbXEAPg2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 11:36:28 -0400
Received: from eastrmimpo02.cox.net ([68.1.16.120])
          by eastrmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070501153628.INSV19390.eastrmmtao101.cox.net@eastrmimpo02.cox.net>;
          Tue, 1 May 2007 11:36:28 -0400
Received: from localhost ([68.0.253.29])
	by eastrmimpo02.cox.net with bizsmtp
	id trcS1W00H0epFYL0000000; Tue, 01 May 2007 11:36:26 -0400
Received: from chris by localhost with local (Exim 4.43)
	id 1HiuOw-0005WF-S4; Tue, 01 May 2007 11:36:26 -0400
Content-Disposition: inline
In-Reply-To: <20070501152228.GF5942@spearce.org>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45949>

On Tue, May 01, 2007 at 11:22:28AM -0400, Shawn O. Pearce wrote:
> Chris Shoemaker <c.shoemaker@cox.net> wrote:
> > On Tue, May 01, 2007 at 11:21:14AM +0100, Andy Parkins wrote:
> > > Hello,
> > > 
> > > I've done this by hand as a proof of concept I suspect it would need loads of 
> > > work in git-svn to do it properly.  However, I thought I'd mention as part of 
> > > my "success with submodules" reports.
> > 
> > For my part, I wonder if it can be simplified somehow; and I suspect
> > it doesn't work well with svn:externals that specify a particular
> > revision.
> 
> Actually that is an interesting point that Chris makes.  Isn't the
> svn:externals property revision controlled on the parent directory?
> So each change to it is actually recorded in the revision history
> of the parent project.  

Yes and yes.

> And if every svn:externals URL included the
> exact version of the other project to include, aren't svn:externals
> then more-or-less like the subproject link support, except they
> also include the URL?

Just to clarify, my point was just that Andy's setup seems to assume
that the externals don't specify a revision.  If they do, maybe
git-svn can map the externals into subprojects.  Is this what
you're thinking?

-chris

> 
> -- 
> Shawn.
