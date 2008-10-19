From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Moving a 5 person dev team from CVS to git
Date: Sun, 19 Oct 2008 13:20:40 -0700
Message-ID: <20081019202040.GG14786@spearce.org>
References: <200810192127.55954.fg@one2team.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Francis Galiegue <fg@one2team.net>
X-From: git-owner@vger.kernel.org Mon Oct 20 12:02:14 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrepR-0000gV-76
	for gcvg-git-2@gmane.org; Sun, 19 Oct 2008 22:24:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751785AbYJSUUl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2008 16:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751787AbYJSUUl
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Oct 2008 16:20:41 -0400
Received: from george.spearce.org ([209.20.77.23]:55428 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751726AbYJSUUk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Oct 2008 16:20:40 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 11B683835F; Sun, 19 Oct 2008 20:20:40 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200810192127.55954.fg@one2team.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98639>

Francis Galiegue <fg@one2team.net> wrote:
> 
> I have successfully imported all CVS modules into an equivalent number of git 
> repositories so far. Unfortunately, I have two problems:
> 
> * the git-cvsserver does not support branching and tagging;
> * I have successfully built the Eclipse plugin (Java 6, Eclipse 3.4), but am 
> unable to make it clone a repository and see it in a project, despite quite a 
> few hours googling around (it _does_ clone, I see the repo in the workspace; 
> but it's invisible within Eclipse).

After a clone is complete you need to import the projects from your
the directory you cloned into.  File->Import; General->Existing
projects; select the directory in your workspace where the repo
is housed, or just select your workspace and let Eclipse search
recursively for the projects.

We'd like to support automatically importing the projects after
the clone is complete, but thus far we haven't put the effort into
restarting the import wizard UI after the download is done.
 
> Is branching and tagging support a planned feature for git-cvsserver?

No.  Nor is it likely to ever get added.  Development on
git-cvsserver is stalled as the code is complete enough for anyone
who actively uses it today.  Patches for it are welcome if you are
willing to take over development and maintenance of it.  But its
more-or-less frozen at this point.

> Also, is 
> there a step-by-step guide on using egit to clone an existing repository? 
> (I'm a total beginner with Eclipse, so it may well be that I need to google 
> some more.)

No, not yet.  You could try adding it to the egit wiki page(s):

  http://git.or.cz/gitwiki/EclipsePlugin

-- 
Shawn.
