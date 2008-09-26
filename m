From: tom sgouros <tomfool@as220.org>
Subject: Re: mysterious error message
Date: Fri, 26 Sep 2008 10:32:48 -0400
Message-ID: <30988.1222439568@as220.org>
References: <20593.1222378418@as220.org> <alpine.DEB.1.00.0809261400400.13830@pacific.mpi-cbg.de.mpi-cbg.de>
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Sep 26 16:34:14 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjEOQ-0004o4-QJ
	for gcvg-git-2@gmane.org; Fri, 26 Sep 2008 16:34:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752521AbYIZOcy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2008 10:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752511AbYIZOcy
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Sep 2008 10:32:54 -0400
Received: from as220.org ([198.7.230.15]:55609 "EHLO ironzilla.as220.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752501AbYIZOcx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2008 10:32:53 -0400
Received: from localhost (localhost [127.0.0.1])
	by ironzilla.as220.org (Postfix) with ESMTP id AD5C9AAB11;
	Fri, 26 Sep 2008 10:32:52 -0400 (EDT)
X-Virus-Scanned: amavisd-new at as220.org
Received: from ironzilla.as220.org ([127.0.0.1])
	by localhost (as220.org [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id PtuAHazzyENy; Fri, 26 Sep 2008 10:32:49 -0400 (EDT)
Received: from as220.org (localhost [127.0.0.1])
	by ironzilla.as220.org (Postfix) with ESMTP id DDE73AAB02;
	Fri, 26 Sep 2008 10:32:48 -0400 (EDT)
In-reply-to: <alpine.DEB.1.00.0809261400400.13830@pacific.mpi-cbg.de.mpi-cbg.de> 
Comments: In-reply-to Johannes Schindelin <Johannes.Schindelin@gmx.de>
   message dated "Fri, 26 Sep 2008 14:01:26 +0200."
X-Mailer: MH-E 8.0.3; nmh 1.1; GNU Emacs 22.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96856>


> Hi,
> 
> On Thu, 25 Sep 2008, Tom Sgouros wrote:
> 
> > I receive the following error message when I try to do a 'git push':
> > 
> >   tomfool@toms-box:hpl$ git push
> >   updating 'refs/heads/master'
> >     from ad4ae7925d3dd23798e7c5b733d2d8f930f7410f
> >     to   5b5f5fae014a4f3535fa10b0f6e28b4bf3225dc3
> >    Also local refs/remotes/origin/master
> >   Generating pack...
> >   Done counting 10 objects.
> >   Deltifying 10 objects...
> >   error: pack-objects died with strange error
> >   unpack eof before pack header was fully read
> >   ng refs/heads/master n/a (unpacker error)
> >   error: failed to push to 'ssh://tomfool@as220.org/home/tomfool/hpl.git'
> >   tomfool@toms-box:hpl$
> 
> I got this message when I tried to push a project with submodules to a 
> server which had submodule-ignorant git installed.  Maybe it's that?

I'm not sure which versions are submodule-ignorant, but it's version
1.5.3.6 on the pusher and version 1.5.4.5 on the server.  I installed
git via the fink package manager.  Could there be some other
incompatibility? 

Thanks,

 -tom

-- 
 ------------------------
 tomfool at as220 dot org
 http://sgouros.com  
 http://whatcheer.net
