From: tom sgouros <tomfool@as220.org>
Subject: Re: mysterious error message
Date: Fri, 26 Sep 2008 10:29:29 -0400
Message-ID: <30774.1222439369@as220.org>
References: <20593.1222378418@as220.org> <20080926082003.GA6772@strlen.de>
Cc: git@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@strlen.de>
X-From: git-owner@vger.kernel.org Fri Sep 26 16:30:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjELE-0003Xw-Hw
	for gcvg-git-2@gmane.org; Fri, 26 Sep 2008 16:30:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752372AbYIZO3f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2008 10:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752391AbYIZO3f
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Sep 2008 10:29:35 -0400
Received: from as220.org ([198.7.230.15]:55543 "EHLO ironzilla.as220.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752270AbYIZO3e (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2008 10:29:34 -0400
Received: from localhost (localhost [127.0.0.1])
	by ironzilla.as220.org (Postfix) with ESMTP id A2A34AAB11;
	Fri, 26 Sep 2008 10:29:33 -0400 (EDT)
X-Virus-Scanned: amavisd-new at as220.org
Received: from ironzilla.as220.org ([127.0.0.1])
	by localhost (as220.org [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id UXw5ck2nmR9g; Fri, 26 Sep 2008 10:29:29 -0400 (EDT)
Received: from as220.org (localhost [127.0.0.1])
	by ironzilla.as220.org (Postfix) with ESMTP id 7EEBFAAB02;
	Fri, 26 Sep 2008 10:29:29 -0400 (EDT)
In-reply-to: <20080926082003.GA6772@strlen.de> 
Comments: In-reply-to Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@strlen.de>
   message dated "Fri, 26 Sep 2008 10:20:03 +0200."
X-Mailer: MH-E 8.0.3; nmh 1.1; GNU Emacs 22.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96854>


> Hello,
> 
> On Thu, Sep 25, 2008 at 05:33:38PM -0400, Tom Sgouros wrote:
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
> > 
> > I haven't been able to interpret this message, and haven't found it in
> > the documentation, and google has let me down, too.  Can anyone tell me
> > what is causing it?
> I think it's a problem on the pushing side.  Maybe out of disk space (in
> $GIT_DIR or $TMP_DIR)?  Does git repack work?
> 

I did have a disk space issue on the pushing side, but have cleared it
up.  Is there something that needs to be reset, do you think?

Yes, git repack seems to work fine.  "Counting 215 objects, Deltifying
215 objects."  But I still get the same error message afterwards.

Thanks,

 -tom

-- 
 ------------------------
 tomfool at as220 dot org
 http://sgouros.com  
 http://whatcheer.net
