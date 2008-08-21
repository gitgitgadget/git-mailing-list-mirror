From: Boyd Lynn Gerber <gerberb@zenez.com>
Subject: Re: Bug/problem with 1.6.0 on UnixWare
Date: Thu, 21 Aug 2008 06:18:02 -0600
Message-ID: <alpine.LNX.1.10.0808210610440.29396@xenau.zenez.com>
References: <alpine.LNX.1.10.0808210522450.24713@xenau.zenez.com> <e2b179460808210435w31b911a5ie6059b5628db8138@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git List <git@vger.kernel.org>
To: Mike Ralphson <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 14:19:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KW98F-0003Y1-7c
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 14:19:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbYHUMSL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 08:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750932AbYHUMSK
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 08:18:10 -0400
Received: from zenez.com ([166.70.62.2]:25988 "EHLO xenau.zenez.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750861AbYHUMSJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 08:18:09 -0400
Received: by xenau.zenez.com (Postfix, from userid 1000)
	id 8543C113761; Thu, 21 Aug 2008 06:18:03 -0600 (MDT)
Received: from localhost (localhost [127.0.0.1])
	by xenau.zenez.com (Postfix) with ESMTP id 56AF511375A;
	Thu, 21 Aug 2008 06:18:03 -0600 (MDT)
In-Reply-To: <e2b179460808210435w31b911a5ie6059b5628db8138@mail.gmail.com>
User-Agent: Alpine 1.10 (LNX 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93141>

On Thu, 21 Aug 2008, Mike Ralphson wrote:
> 2008/8/21 Boyd Lynn Gerber <gerberb@zenez.com>:
> > I am having the same problem on UnixWare as I have with the SCO OpenServer
> > 6. trying to build git-1.6.0.
> >
> > Here is the error.
> >
> >    CC shell.o
> >    AR compat/lib.a
> >    LINK git-shell
> > Undefined                       first referenced
> > symbol                              in file
> > hexval_table                        abspath.o
> > null_sha1                           abspath.o
> > trust_executable_bit                abspath.o
> > has_symlinks                        abspath.o
> > UX:ld: ERROR: Symbol referencing errors. No output written to git-shell
> > gmake: *** [git-shell] Error 1
> 
> I think you've hit the problem described here:
> http://article.gmane.org/gmane.comp.version-control.git/92945/match=git+shell
> 
> Junio's revert of the offending commit is I think in the 'next' branch.

Yep, that sounds about right.  It has bitten me on the 12 platforms, I 
submitted to get git working on them.  I will look at reverting it.  

I just tried to get this working and now I am being flooded with emails 
from people that are trying git for the first time, and asking...

How I could your recommend such a broken SCM?  I told them to got back to 
the 1.5.X but being new to git and then not being able to build and use it 
is causing a lot of flack.  I am getting emails now about my recommending 
git, as it is broken.  I should not have announce to the various lists 
about how great git is and that they should dump their older SCM's in 
favor of git.  Really bad timing on my part.  I just hope these people 
will give git an other try.

Thanks,

--
Boyd Gerber <gerberb@zenez.com>
ZENEZ	1042 East Fort Union #135, Midvale Utah  84047
