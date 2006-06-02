From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Importing Mozilla CVS into git
Date: Fri, 2 Jun 2006 09:46:29 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606020941210.2482@wbgn013.biozentrum.uni-wuerzburg.de>
References: <1149204044.27695.38.camel@neko.keithp.com>
 <9e4733910606011755n29a149f2m1409c5a23888f1c5@mail.gmail.com>
 <1149214075.5521.31.camel@neko.keithp.com> <9e4733910606011936i725e8eb2h8c2357f3688da43e@mail.gmail.com>
 <1149219593.5521.34.camel@neko.keithp.com> <9e4733910606012047h727a25f1vb367c880f8933c4e@mail.gmail.com>
 <1149220518.5521.43.camel@neko.keithp.com> <9e4733910606012100s7ace4721le6fbfbcaadfb6c43@mail.gmail.com>
 <20060602041107.GA5429@spearce.org> <1149223164.2443.33.camel@dv>
 <20060602044404.GB5429@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pavel Roskin <proski@gnu.org>, Jon Smirl <jonsmirl@gmail.com>,
	Keith Packard <keithp@keithp.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 02 09:46:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fm4Me-0005Si-T2
	for gcvg-git@gmane.org; Fri, 02 Jun 2006 09:46:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbWFBHqe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Jun 2006 03:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbWFBHqe
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jun 2006 03:46:34 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:38798 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751194AbWFBHqd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jun 2006 03:46:33 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id E946E2CEB;
	Fri,  2 Jun 2006 09:46:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id DB7BF2A94;
	Fri,  2 Jun 2006 09:46:31 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 839A51D0E;
	Fri,  2 Jun 2006 09:46:29 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060602044404.GB5429@spearce.org>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21152>

Hi,

On Fri, 2 Jun 2006, Shawn Pearce wrote:

> Pavel Roskin <proski@gnu.org> wrote:
> > On Fri, 2006-06-02 at 00:11 -0400, Shawn Pearce wrote:
> > 
> > > GIT today requires not only a decent UNIX shell but also, GNU tools,
> > > Perl and Python.  Porting to Solaris has recently had some more
> > > effort put into it to remove some of the GNU tool dependencies but
> > > perhaps one of the most important features (git-merge-recursive)
> > > is a Python script.
> > 
> > The great thing about git is that it's modular.  A single utility can be
> > replaced and retested in the same environment, without having to rewrite
> > the rest of the scripts.  A dedicated programmer with good C and Python
> > skills could rewrite git-merge-recursive.py in C in 2 days, I believe.
> > Add a few days of bug fixing, of course.
> 
> Heh.  Funny you should mention that.  I was just thinking a few
> minutes ago about working on that exact change...

I thought about this a couple of weeks ago. I recalled to have read 
something about the principle: if there is more than one merge-base 
candidate, it starts by merging the merge-base candidates until there is 
only one 'virtual' merge-base candidate.

However, looking at the code I fainted. Sure, a lot should be way easier 
in C, because the functions are already there, _but_ it seemed too much 
work for one afternoon nevertheless (and I did not have more time to 
spare).

Ciao,
Dscho
