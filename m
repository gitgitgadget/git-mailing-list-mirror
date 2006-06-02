From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Importing Mozilla CVS into git
Date: Fri, 2 Jun 2006 00:11:07 -0400
Message-ID: <20060602041107.GA5429@spearce.org>
References: <9e4733910606011521n106f8f24s6c7053ce51e3791e@mail.gmail.com> <1149204044.27695.38.camel@neko.keithp.com> <9e4733910606011755n29a149f2m1409c5a23888f1c5@mail.gmail.com> <1149214075.5521.31.camel@neko.keithp.com> <9e4733910606011936i725e8eb2h8c2357f3688da43e@mail.gmail.com> <1149219593.5521.34.camel@neko.keithp.com> <9e4733910606012047h727a25f1vb367c880f8933c4e@mail.gmail.com> <1149220518.5521.43.camel@neko.keithp.com> <9e4733910606012100s7ace4721le6fbfbcaadfb6c43@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Keith Packard <keithp@keithp.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 02 06:11:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fm10J-0002UT-19
	for gcvg-git@gmane.org; Fri, 02 Jun 2006 06:11:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbWFBELQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Jun 2006 00:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbWFBELQ
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jun 2006 00:11:16 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:9174 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751306AbWFBELP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jun 2006 00:11:15 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Fm0zw-0006nn-ML; Fri, 02 Jun 2006 00:10:56 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7967620E445; Fri,  2 Jun 2006 00:11:07 -0400 (EDT)
To: Jon Smirl <jonsmirl@gmail.com>
Content-Disposition: inline
In-Reply-To: <9e4733910606012100s7ace4721le6fbfbcaadfb6c43@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21142>

Jon Smirl <jonsmirl@gmail.com> wrote:
> On 6/1/06, Keith Packard <keithp@keithp.com> wrote:
> >On Thu, 2006-06-01 at 23:47 -0400, Jon Smirl wrote:
> >> On 6/1/06, Keith Packard <keithp@keithp.com> wrote:
> >> > Git runs fine on Windows these days; asking people to use reasonable
> >> > tools to contribute to the project doesn't seem crazy to me.
> >>
> >> WIndows, Mac, Solaris and Linux will cover most Firefox developers.
> >> Is git to go on those platforms? Is WIndows native or cygwin?
> >
> >I think the windows stuff may still be cygwin, but Mac and Solaris work
> >fine with the git, of course. It's just simple posix code, after all
> 
> It is going to have to be native Windows to move some of the
> developers over. They are true blue MS types that won't touch anything
> close to Unix so cygwin is out.

Then GIT on Windows might be out.

GIT today requires not only a decent UNIX shell but also, GNU tools,
Perl and Python.  Porting to Solaris has recently had some more
effort put into it to remove some of the GNU tool dependencies but
perhaps one of the most important features (git-merge-recursive)
is a Python script.

I'm running GIT at work on a Windows/Cygwin installation which is
really quite bare bones.  I think I have about 15 Cygwin packages
installed total and GIT is running fine in that environment.
It can't send patches by email but the corporate firewalls wouldn't
permit that anyway...

Perhaps you can tell the true blue MS types that Cygwin is a native
Windows application.  After all it uses the Win32 API.  :-)

-- 
Shawn.
