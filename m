From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: [PATCH] git-svnimport: added explicit merge graph option -G
Date: Mon, 25 Jun 2007 10:54:12 +0200
Message-ID: <20070625085412.GC4559@xp.machine.xx>
References: <7vk5tt25n7.fsf@assigned-by-dhcp.cox.net> <20070624084427.GA7715@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Stas Maximov <smaximov@yahoo.com>
X-From: git-owner@vger.kernel.org Mon Jun 25 10:54:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2kKu-0007bd-Jp
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 10:54:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbXFYIyP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 04:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbXFYIyP
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 04:54:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:41942 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751129AbXFYIyO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 04:54:14 -0400
Received: (qmail invoked by alias); 25 Jun 2007 08:54:12 -0000
Received: from p54AAAEFD.dip0.t-ipconnect.de (EHLO localhost) [84.170.174.253]
  by mail.gmx.net (mp053) with SMTP; 25 Jun 2007 10:54:12 +0200
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX18LwVIVI8EL9SFe0fbtDFSjegTds1e6UpOGsUGpVV
	FXJVo6PNBLOHVA
Mail-Followup-To: Stas Maximov <smaximov@yahoo.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <20070624084427.GA7715@xp.machine.xx>
User-Agent: Mutt/1.5.14+cvs20070403 (2007-04-02)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50882>

On Sun, Jun 24, 2007 at 10:44:27AM +0200, Peter Baumann wrote:
> On Sun, Jun 24, 2007 at 12:06:20AM -0700, Junio C Hamano wrote:
> > From: Stas Maximov <smaximov@yahoo.com>
> > Date: Sat, 23 Jun 2007 09:06:30 -0700
> > 
> > Allows explicit merge graph information to be provided. Each line
> > of merge graph file must contain a pair of SVN revision numbers
> > separated by space. The first number is child (merged to) SVN rev
> > number and the second is the parent (merged from) SVN rev number.
> > Comments can be started with '#' and continue to the end of line.
> > Empty and space-only lines are allowed and will be ignored.
> > ---
> > 
> >  * Stas, please give a "Signed-off-by" line, and get in the
> >    habit of always CC the list.
> > 
> >    I received a format-patch output as attachment from Stas.  As
> >    I cannot comment on the patch in that format, I am making a
> >    verbatim forward to the list.
> > 
> >    I'll comment on the patch separately when I am through it,
> >    but would appreciate comments from people who were involved
> >    in git-svnimport in the past, and still use it.
> > 
> >    "You should use git-svn instead" people can repeat that as
> >    usual, but at the same time it might be worth realizing that
> >    there are people who maintain git-svnimport being better for
> >    one-short importing.
> > 
> 
> [exchanging To:/Cc: as Junio just forwarded the message from Stas]
> 
> Not commenting on the patch per se, but wouldn't it make more
> sense to have such functionality in a history rewriting tool like
> e.g. git-branch-filter?
> 
> I had an svn import (git-svn) where I wanted to give correct
> branch/merge points, too, and so I manually created a grafts file
> annotating all the svn merges. Having such a thing as a _generic_ tool
> which operates on grafts would be much more usefull because you get one
> implementation which could be used for each and every importer out
> there. Sure, you have to transform the native revision specifieres into
> the GIT commit id's if you only have e.g. "merged r4711:4720 into trunk",
> but these functionality is much more common to have in importers
> than whats implemented in the above mentioned patch.
> 
> Another bonus point of using the grafts mechanism you'll get for free is
> that you could _look_ at the commit graph in gitk *before* doing the
> often expensive reimport of your project, so could be sure you haven't
> forgotten to mark a merge.
> 

There was a message that git-filter-branch already could to this, which
I didn't know:

http://thread.gmane.org/gmane.comp.version-control.git/50736/focus=50872

-Peter
