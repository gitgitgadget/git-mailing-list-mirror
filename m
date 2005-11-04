From: David Brown <git@davidb.org>
Subject: Re: binary safe?
Date: Fri, 4 Nov 2005 13:27:01 -0800
Message-ID: <20051104212701.GA4310@old.davidb.org>
References: <86br115r0z.fsf@blue.stonehenge.com> <7v7jbpbb3l.fsf@assigned-by-dhcp.cox.net> <46a038f90511031500p3d6ed433s6efe3f5a5e60bcf8@mail.gmail.com> <20051104165419.GA12145@old.davidb.org> <46a038f90511041322x1d9f7a50ndafe724c2e8d368b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 04 22:27:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EY95Y-0008HQ-IY
	for gcvg-git@gmane.org; Fri, 04 Nov 2005 22:27:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750915AbVKDV1F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Nov 2005 16:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750917AbVKDV1F
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Nov 2005 16:27:05 -0500
Received: from adsl-64-172-240-129.dsl.sndg02.pacbell.net ([64.172.240.129]:1682
	"EHLO mail.davidb.org") by vger.kernel.org with ESMTP
	id S1750915AbVKDV1D (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2005 16:27:03 -0500
Received: from davidb by mail.davidb.org with local (Exim 4.54 #1 (Debian))
	id 1EY95R-0001A9-Lv; Fri, 04 Nov 2005 13:27:01 -0800
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f90511041322x1d9f7a50ndafe724c2e8d368b@mail.gmail.com>
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11160>

On Sat, Nov 05, 2005 at 10:22:29AM +1300, Martin Langhoff wrote:

> (That being said, if you have a case where git-cvsimport is doing the
> wrong thing, let me know!)
> 
> > However, since CVS (RCS really) can remember the state of this flag, it
> > does work to  'cvs admin -ko filename' beforehand, and then do the
> > cvsimport without the '-k' option.
> 
> Yes, but a repo you don't control, where people are using keywords,
> means thatyou need to do -kk to kill the keywords or your imported
> files are going to have a horrid amount of noise in them.

Yes, the unpleasantness of CVS.

However, I was unable to do a proper git-cvsimport of the SourceForge 'vim'
archive, with '-k'.  By not giving it '-k' and using cvs admin '-ko' on the
appropriate files, I was able to get the correct results.

May be the interpretation of the option depends on the particular server
being used?

I can investigate later which particular file is causing the problem.

Dave
