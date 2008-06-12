From: Boyd Lynn Gerber <gerberb@zenez.com>
Subject: Re: git-svn-import or CVS import from local HD rather than remote.
Date: Thu, 12 Jun 2008 13:57:28 -0600
Message-ID: <Pine.LNX.4.64.0806121348340.18454@xenau.zenez.com>
References: <Pine.LNX.4.64.0806121214210.18454@xenau.zenez.com>
 <20080612185545.GN29404@genesis.frugalware.org> <Pine.LNX.4.64.0806121315540.18454@xenau.zenez.com>
 <alpine.LNX.1.00.0806121523370.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Git List <git@vger.kernel.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu Jun 12 21:58:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6swR-0006NZ-IV
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 21:58:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758029AbYFLT5a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 15:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754873AbYFLT5a
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 15:57:30 -0400
Received: from zenez.com ([166.70.62.2]:26834 "EHLO xenau.zenez.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754130AbYFLT53 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 15:57:29 -0400
Received: by xenau.zenez.com (Postfix, from userid 1000)
	id 2DE5EE7FDE; Thu, 12 Jun 2008 13:57:28 -0600 (MDT)
Received: from localhost (localhost [127.0.0.1])
	by xenau.zenez.com (Postfix) with ESMTP id 190F2E7FDD;
	Thu, 12 Jun 2008 13:57:28 -0600 (MDT)
In-Reply-To: <alpine.LNX.1.00.0806121523370.19665@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84779>

On Thu, 12 Jun 2008, Daniel Barkalow wrote:
> On Thu, 12 Jun 2008, Boyd Lynn Gerber wrote:
> > On Thu, 12 Jun 2008, Miklos Vajna wrote:
> > > On Thu, Jun 12, 2008 at 12:36:43PM -0600, Boyd Lynn Gerber 
> > > <gerberb@zenez.com> wrote:
> > > > git-svnimport -C /working/git/project /master/svn/pub-svn/category/project
> > > 
> > > From RelNotes-1.5.4.txt:
> > > 
> > >  * "git svnimport" was removed in favor of "git svn".  It is still there
> > >    in the source tree (contrib/examples) but unsupported.
> > > 
> > > Try using git-svn.
> > 
> > Thanks, I was not sure which I should use,  I had tried both with similar 
> > results.  Here is what I used with git-svn
> > 
> > > git-svn clone /working/svn/networking/wireshark .
> > Initialized empty Git repository in .git/
> > Bad URL passed to RA layer: Unrecognized URL scheme for 
> > '/working/svn/networking/wireshark' at /usr/bin/git-svn line 934
> 
> Maybe file:///working/svn/networking/wireshark?

This is really frustrating.

I have tried every combination of file://localhost/ file:///

This is what I get

git-svn clone file:///working/svn/network/wireshark/ -T trunk -b branches 
-t tags wireshark
Initialized empty Git repository in .git/
Couldn't open a repository: Unable to open an ra_local session to URL: 
Unable to open repository 'file:///working/svn/network/wireshark' at 
/usr/bin/git-svn line 1048

> ls -la /working/svn/network/wireshark/
total 16
drwxr-xr-x  8 gerberb zenez  208 2008-06-10 12:44 .
drwxr-xr-x  9 gerberb zenez  240 2008-06-12 13:00 ..
drwxr-xr-x  6 gerberb zenez  240 2008-06-12 12:14 .svn
drwxr-xr-x  6 gerberb zenez  152 2008-06-10 12:43 historic
drwxr-xr-x  5 gerberb zenez  152 2008-06-10 12:46 prereleases
drwxr-xr-x 86 gerberb zenez 2728 2008-06-10 12:37 releases
drwxr-xr-x 26 gerberb zenez 7016 2008-06-10 12:39 trunk
drwxr-xr-x 25 gerberb zenez 7136 2008-06-10 11:45 trunk-1.0

It is the exact same message wheter I use...

> cd /working/git/network/wireshark/
> git-svn clone file:///working/svn/network/wireshark .
> git-svn clone file:///working/svn/network/wireshark? .
> git-svn clone file:///working/svn/network/wireshark/ .
> cd /working/git/network/
> git-svn clone file:///working/svn/network/wireshark wireshark
> git-svn clone file:///working/svn/network/wireshark? wireshark
> git-svn clone file:///working/svn/network/wireshark/ wireshark

Add the options -T trunk -b branches -t tags above same results.

git-svn really does not like to import from a local svn file...

Any other ideas,

Thanks, I really apperciate the assistance.

--
Boyd Gerber <gerberb@zenez.com>
ZENEZ	1042 East Fort Union #135, Midvale Utah  84047
