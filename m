From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Looking for SCM that lets me publish part of a repository
Date: Sun, 5 Mar 2006 20:48:30 -0500
Message-ID: <20060306014830.GE25790@spearce.org>
References: <1141608679.16980.12.camel@mattlaptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 06 02:48:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FG4px-0003KW-5s
	for gcvg-git@gmane.org; Mon, 06 Mar 2006 02:48:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbWCFBse (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Mar 2006 20:48:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751529AbWCFBse
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Mar 2006 20:48:34 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:44981 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751319AbWCFBse (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Mar 2006 20:48:34 -0500
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FG4ph-00081e-Uy; Sun, 05 Mar 2006 20:48:22 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 368B420FBBF; Sun,  5 Mar 2006 20:48:30 -0500 (EST)
To: Matt McCutchen <hashproduct@verizon.net>
Content-Disposition: inline
In-Reply-To: <1141608679.16980.12.camel@mattlaptop>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17263>

Matt McCutchen <hashproduct@verizon.net> wrote:
> For the last week or so, I have been looking for a SCM system to hold
> many of my projects, some of which are available to the public and
> others of which are not.  It would be nice if I could use a single large
> private repository on my computer with each project in a separate
> folder.  Then I would like to pull some of the projects (but not all)
> into a world-readable repository on my Web site.  I have looked at
> several SCMs and have not found a way to make any of them do this, but I
> like GIT best on other grounds.  Is there a way I can coerce GIT to
> clone and pull one folder out of a repository but ignore the rest?

No.  And actually this is probably not the best way to use GIT.

If you want to segment your work into ``public'' and ``non-public''
then you should at least segment your work into two repositories:
``public'' and ``non-public''.  But you really should segment your
repository to a project-by-project basis.  That is each project
should have its own repository.

That said if there are many files which will have identical content
across many projects you may be able to save disk space by placing
all objects into a single object directory; but that's entirely
independent of project organization.

Unlike CVS, Subversions, etc. GIT repositories are dirt-cheap to
create.  Don't think twice about creating a different repository
for a new project.  I think I'm up on about 50 repositories at
this point; however each one is typically less than a megabyte in
total size.

-- 
Shawn.
