From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: git-svn-import or CVS import from local HD rather than remote.
Date: Thu, 12 Jun 2008 16:56:13 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0806121652220.19665@iabervon.org>
References: <Pine.LNX.4.64.0806121214210.18454@xenau.zenez.com> <20080612185545.GN29404@genesis.frugalware.org> <Pine.LNX.4.64.0806121315540.18454@xenau.zenez.com> <alpine.LNX.1.00.0806121523370.19665@iabervon.org>
 <Pine.LNX.4.64.0806121348340.18454@xenau.zenez.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Git List <git@vger.kernel.org>
To: Boyd Lynn Gerber <gerberb@zenez.com>
X-From: git-owner@vger.kernel.org Thu Jun 12 22:57:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6tr3-0005qf-5q
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 22:57:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754329AbYFLU4P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 16:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754262AbYFLU4P
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 16:56:15 -0400
Received: from iabervon.org ([66.92.72.58]:36981 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754215AbYFLU4O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 16:56:14 -0400
Received: (qmail 13412 invoked by uid 1000); 12 Jun 2008 20:56:13 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Jun 2008 20:56:13 -0000
In-Reply-To: <Pine.LNX.4.64.0806121348340.18454@xenau.zenez.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84797>

On Thu, 12 Jun 2008, Boyd Lynn Gerber wrote:

> On Thu, 12 Jun 2008, Daniel Barkalow wrote:
> > On Thu, 12 Jun 2008, Boyd Lynn Gerber wrote:
> > > On Thu, 12 Jun 2008, Miklos Vajna wrote:
> > > > On Thu, Jun 12, 2008 at 12:36:43PM -0600, Boyd Lynn Gerber 
> > > > <gerberb@zenez.com> wrote:
> > > > > git-svnimport -C /working/git/project /master/svn/pub-svn/category/project
> > > > 
> > > > From RelNotes-1.5.4.txt:
> > > > 
> > > >  * "git svnimport" was removed in favor of "git svn".  It is still there
> > > >    in the source tree (contrib/examples) but unsupported.
> > > > 
> > > > Try using git-svn.
> > > 
> > > Thanks, I was not sure which I should use,  I had tried both with similar 
> > > results.  Here is what I used with git-svn
> > > 
> > > > git-svn clone /working/svn/networking/wireshark .
> > > Initialized empty Git repository in .git/
> > > Bad URL passed to RA layer: Unrecognized URL scheme for 
> > > '/working/svn/networking/wireshark' at /usr/bin/git-svn line 934
> > 
> > Maybe file:///working/svn/networking/wireshark?
> 
> This is really frustrating.
> 
> I have tried every combination of file://localhost/ file:///
> 
> This is what I get
> 
> git-svn clone file:///working/svn/network/wireshark/ -T trunk -b branches 
> -t tags wireshark
> Initialized empty Git repository in .git/
> Couldn't open a repository: Unable to open an ra_local session to URL: 
> Unable to open repository 'file:///working/svn/network/wireshark' at 
> /usr/bin/git-svn line 1048
> 
> > ls -la /working/svn/network/wireshark/
> total 16
> drwxr-xr-x  8 gerberb zenez  208 2008-06-10 12:44 .
> drwxr-xr-x  9 gerberb zenez  240 2008-06-12 13:00 ..
> drwxr-xr-x  6 gerberb zenez  240 2008-06-12 12:14 .svn
> drwxr-xr-x  6 gerberb zenez  152 2008-06-10 12:43 historic
> drwxr-xr-x  5 gerberb zenez  152 2008-06-10 12:46 prereleases
> drwxr-xr-x 86 gerberb zenez 2728 2008-06-10 12:37 releases
> drwxr-xr-x 26 gerberb zenez 7016 2008-06-10 12:39 trunk
> drwxr-xr-x 25 gerberb zenez 7136 2008-06-10 11:45 trunk-1.0

That looks like a SVN working copy, not an SVN repository. Maybe you want 
file:///master/svn/...?

	-Daniel
*This .sig left intentionally blank*
