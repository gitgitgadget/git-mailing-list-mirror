From: Pavel Roskin <proski@gnu.org>
Subject: Re: Figured out how to get Mozilla into git
Date: Thu,  8 Jun 2006 23:12:00 -0400
Message-ID: <20060608231200.4bkoc8sggk88k0ow@webmail.spamcop.net>
References: <9e4733910606081917l11354e49q25f0c4aea40618ea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 09 05:12:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FoXPt-00066j-Vw
	for gcvg-git@gmane.org; Fri, 09 Jun 2006 05:12:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965118AbWFIDME (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Jun 2006 23:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965119AbWFIDME
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jun 2006 23:12:04 -0400
Received: from mailgate.cesmail.net ([216.154.195.36]:53908 "HELO
	mailgate.cesmail.net") by vger.kernel.org with SMTP id S965118AbWFIDMD
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 8 Jun 2006 23:12:03 -0400
Received: (qmail 20419 invoked from network); 9 Jun 2006 03:12:00 -0000
Received: from unknown (HELO delta.cesmail.net) (192.168.1.30)
  by mailgate.cesmail.net with SMTP; 9 Jun 2006 03:12:00 -0000
Received: (qmail 13709 invoked by uid 99); 9 Jun 2006 03:12:00 -0000
Received: from 68.236.0.220 ([68.236.0.220]) by webmail.spamcop.net (Horde)
	with HTTP for <proski@spamcop.net@cesmail.net>; Thu,  8 Jun 2006 23:12:00
	-0400
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910606081917l11354e49q25f0c4aea40618ea@mail.gmail.com>
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) 4.0-cvs
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21524>

Hi Jon,

Quoting Jon Smirl <jonsmirl@gmail.com>:

> I was able to import Mozilla into SVN without problem, it just occured
> to me to then import the SVN repository in git.

I feel bad that I didn't suggest it before.  That's quite expected.  Subversion
was created by  CVS developers with the intention of replacing CVS.  cvs2svn
was written by the same CVS developers, who paid attention to all CVS quirks. 
cvs2svn is quite mature and it has a testsuite, if I remember correctly.

My concern is how well a Subversion repository can be mapped to git considering
that Subversion is branch agnostic.  But if it works for Mozilla, this approach
could be recommended for anything big and serious.

> The import has been
> running a few hours now and it is up to the year 2000 (starts in
> 1998). Since I haven't hit any errors yet it will probably finish ok.
> I should have the results in the morning. I wonder how long it will
> take to start gitk on a 10GB repository.

That's the "raison d'etre" of qgit.  I don't know if gitk has anything that qgit
doesn't, except bisecting.

> Once I get this monster into git, are there tools that will let me
> keep it in sync with Mozilla CVS?

Ideally, make Mozilla developers use git :-)

> SVN renamed numeric branches to this form, unlabeled-3.7.24, so that
> may be a problem.

I think git-svn is supposed to do the svn->git part, but I'm afraid it will need
some work to do it effectively.  Google search for "cvs2svn incremental" brings
some patches.  cvsup can be used to synchronize the CVS repository.

--
Regards,
Pavel Roskin
