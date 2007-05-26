From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: Problems importing SVN repo via git-svnimport
Date: Sat, 26 May 2007 17:34:43 +0200
Message-ID: <20070526153443.GC2674@planck.djpig.de>
References: <20070526125553.GC10324@artsapartment.org> <20070526130643.GA2674@planck.djpig.de> <20070526151046.GA2239@artsapartment.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Art Haas <ahaas@airmail.net>
X-From: git-owner@vger.kernel.org Sat May 26 17:35:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HryIE-0007ww-7O
	for gcvg-git@gmane.org; Sat, 26 May 2007 17:34:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753953AbXEZPes (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 May 2007 11:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754050AbXEZPes
	(ORCPT <rfc822;git-outgoing>); Sat, 26 May 2007 11:34:48 -0400
Received: from planck.djpig.de ([85.10.192.180]:2569 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753953AbXEZPes (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2007 11:34:48 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id 1FB98274014;
	Sat, 26 May 2007 17:34:45 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bMz-kvPVFgwQ; Sat, 26 May 2007 17:34:44 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id EDDAA274013; Sat, 26 May 2007 17:34:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070526151046.GA2239@artsapartment.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48477>

On Sat, May 26, 2007 at 10:10:46AM -0500, Art Haas wrote:
> On Sat, May 26, 2007 at 03:06:43PM +0200, Frank Lichtenheld wrote:
> > On Sat, May 26, 2007 at 07:55:53AM -0500, Art Haas wrote:
> > > I'm happy to dive into the perl code in svnimport and make changes to
> > > help debug this problem, if there is actually a problem and not user
> > > error on my part. Any help from 'svnimport' experts will be greatly
> > > appreciated. The public repo listed above has the same contents as my
> > > local repo, so feel free to poke around it to see how things are
> > > structured.
> > 
> > You might want to try git-svn instead. It should support everything you
> > can do with git-svnimport and much more. Plus it is actively maintained
> > which I wouldn't say about git-svnimport.
> 
> Hi.
> 
> The git-svn docs say that it serves as a bi-directionaly gateway

It can be happily used for one-time imports, too. You might want to
use some options like the authors file and perhaps --no-metadata.
Can't say much about the rest of your plans since I'm no git-svn
expert. I have only ever used it for one-time imports so far.

> between git and svn, but that the main repo is a Subversion repository.
> My goal with the PythonCAD repo is to convert it so that the main
> repository is in git, and then I'm going to try to use git-svn to
> push my changes into the now-secondary Subversion repo. This way, I can
> make a distributed git repo available to developers wanting to
> contribute to PythonCAD, plus keep the developers currently using
> Subversion from having to make any changes if they either don't want to
> or are unable to (i.e. windows developers/users).
> 
> Is git-svnimport maintenence on the wane?

Search the archive of the last month for posts on git-svnimport...
IIRC there was one typo fix and one thread about a problem with it
that ended in the question wether it should be removed.

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
