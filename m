From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: git-svn-import or CVS import from local HD rather than remote.
Date: Thu, 12 Jun 2008 15:24:24 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0806121523370.19665@iabervon.org>
References: <Pine.LNX.4.64.0806121214210.18454@xenau.zenez.com> <20080612185545.GN29404@genesis.frugalware.org> <Pine.LNX.4.64.0806121315540.18454@xenau.zenez.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Git List <git@vger.kernel.org>
To: Boyd Lynn Gerber <gerberb@zenez.com>
X-From: git-owner@vger.kernel.org Thu Jun 12 21:25:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6sQC-0001UW-W1
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 21:25:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754130AbYFLTY0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 15:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754294AbYFLTY0
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 15:24:26 -0400
Received: from iabervon.org ([66.92.72.58]:34976 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753662AbYFLTY0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 15:24:26 -0400
Received: (qmail 7802 invoked by uid 1000); 12 Jun 2008 19:24:24 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Jun 2008 19:24:24 -0000
In-Reply-To: <Pine.LNX.4.64.0806121315540.18454@xenau.zenez.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84776>

On Thu, 12 Jun 2008, Boyd Lynn Gerber wrote:

> On Thu, 12 Jun 2008, Miklos Vajna wrote:
> > On Thu, Jun 12, 2008 at 12:36:43PM -0600, Boyd Lynn Gerber 
> > <gerberb@zenez.com> wrote:
> > > git-svnimport -C /working/git/project /master/svn/pub-svn/category/project
> > 
> > From RelNotes-1.5.4.txt:
> > 
> >  * "git svnimport" was removed in favor of "git svn".  It is still there
> >    in the source tree (contrib/examples) but unsupported.
> > 
> > Try using git-svn.
> 
> Thanks, I was not sure which I should use,  I had tried both with similar 
> results.  Here is what I used with git-svn
> 
> > git-svn clone /working/svn/networking/wireshark .
> Initialized empty Git repository in .git/
> Bad URL passed to RA layer: Unrecognized URL scheme for 
> '/working/svn/networking/wireshark' at /usr/bin/git-svn line 934

Maybe file:///working/svn/networking/wireshark?

	-Daniel
*This .sig left intentionally blank*
