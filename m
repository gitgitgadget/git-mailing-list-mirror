From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Importing Mozilla CVS into git
Date: Fri, 2 Jun 2006 00:44:04 -0400
Message-ID: <20060602044404.GB5429@spearce.org>
References: <1149204044.27695.38.camel@neko.keithp.com> <9e4733910606011755n29a149f2m1409c5a23888f1c5@mail.gmail.com> <1149214075.5521.31.camel@neko.keithp.com> <9e4733910606011936i725e8eb2h8c2357f3688da43e@mail.gmail.com> <1149219593.5521.34.camel@neko.keithp.com> <9e4733910606012047h727a25f1vb367c880f8933c4e@mail.gmail.com> <1149220518.5521.43.camel@neko.keithp.com> <9e4733910606012100s7ace4721le6fbfbcaadfb6c43@mail.gmail.com> <20060602041107.GA5429@spearce.org> <1149223164.2443.33.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Smirl <jonsmirl@gmail.com>, Keith Packard <keithp@keithp.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 02 06:44:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fm1W9-00063M-PC
	for gcvg-git@gmane.org; Fri, 02 Jun 2006 06:44:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbWFBEoK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Jun 2006 00:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbWFBEoK
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jun 2006 00:44:10 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:5850 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751121AbWFBEoJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jun 2006 00:44:09 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Fm1W2-00009G-F1; Fri, 02 Jun 2006 00:44:06 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9B7C720E445; Fri,  2 Jun 2006 00:44:04 -0400 (EDT)
To: Pavel Roskin <proski@gnu.org>
Content-Disposition: inline
In-Reply-To: <1149223164.2443.33.camel@dv>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21146>

Pavel Roskin <proski@gnu.org> wrote:
> On Fri, 2006-06-02 at 00:11 -0400, Shawn Pearce wrote:
> 
> > GIT today requires not only a decent UNIX shell but also, GNU tools,
> > Perl and Python.  Porting to Solaris has recently had some more
> > effort put into it to remove some of the GNU tool dependencies but
> > perhaps one of the most important features (git-merge-recursive)
> > is a Python script.
> 
> The great thing about git is that it's modular.  A single utility can be
> replaced and retested in the same environment, without having to rewrite
> the rest of the scripts.  A dedicated programmer with good C and Python
> skills could rewrite git-merge-recursive.py in C in 2 days, I believe.
> Add a few days of bug fixing, of course.

Heh.  Funny you should mention that.  I was just thinking a few
minutes ago about working on that exact change...
 
> Dependency on Cygwin, Perl and Python is too much.  Windows is becoming
> a legacy system in some circles, and it may run on legacy hardware.  Yet
> it's irreplaceable as a testing platform for many projects.

Its already legacy to me.  Heck its 2006 and my work desktop still
says something about 2000 when I login.  :-)
 
-- 
Shawn.
