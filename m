From: Boyd Lynn Gerber <gerberb@zenez.com>
Subject: Re: git-svn-import or CVS import from local HD rather than remote.
Date: Thu, 12 Jun 2008 14:46:42 -0600
Message-ID: <Pine.LNX.4.64.0806121445370.18454@xenau.zenez.com>
References: <Pine.LNX.4.64.0806121214210.18454@xenau.zenez.com>
 <20080612185545.GN29404@genesis.frugalware.org> <Pine.LNX.4.64.0806121315540.18454@xenau.zenez.com>
 <alpine.LNX.1.00.0806121523370.19665@iabervon.org>
 <Pine.LNX.4.64.0806121348340.18454@xenau.zenez.com>
 <20080612204154.GP29404@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Git List <git@vger.kernel.org>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Thu Jun 12 22:48:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6thr-00025m-7d
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 22:47:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754761AbYFLUqp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 16:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754601AbYFLUqp
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 16:46:45 -0400
Received: from zenez.com ([166.70.62.2]:26312 "EHLO xenau.zenez.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754525AbYFLUqo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 16:46:44 -0400
Received: by xenau.zenez.com (Postfix, from userid 1000)
	id 2591BE8036; Thu, 12 Jun 2008 14:46:43 -0600 (MDT)
Received: from localhost (localhost [127.0.0.1])
	by xenau.zenez.com (Postfix) with ESMTP id 18070E8035;
	Thu, 12 Jun 2008 14:46:43 -0600 (MDT)
In-Reply-To: <20080612204154.GP29404@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84793>

On Thu, 12 Jun 2008, Miklos Vajna wrote:
> On Thu, Jun 12, 2008 at 01:57:28PM -0600, Boyd Lynn Gerber <gerberb@zenez.com> wrote:
> > This is really frustrating.
> > 
> > I have tried every combination of file://localhost/ file:///
> > 
> > This is what I get
> > 
> > git-svn clone file:///working/svn/network/wireshark/ -T trunk -b branches 
> > -t tags wireshark
> > Initialized empty Git repository in .git/
> > Couldn't open a repository: Unable to open an ra_local session to URL: 
> > Unable to open repository 'file:///working/svn/network/wireshark' at 
> > /usr/bin/git-svn line 1048
> 
> Did you do just a simple checkout or do you have the full repository at
> /working/svn/network/wireshark?
> 
> You need the later if you want to do the conversion offline.

I have the full svn for each of the svn projects.  Eventually I want the 
communications to go both ways.
 

--
Boyd Gerber <gerberb@zenez.com>
ZENEZ	1042 East Fort Union #135, Midvale Utah  84047
