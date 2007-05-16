From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: newby question about merge.
Date: Wed, 16 May 2007 23:39:08 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705162325020.6410@racer.site>
References: <20070515113820.2621c8d5@localhost.localdomain>  <f2c23k$dm0$1@sea.gmane.org>
  <Pine.LNX.4.64.0705161241560.6410@racer.site> 
 <46d6db660705160721u24e43f7bmb5171555158089fb@mail.gmail.com> 
 <Pine.LNX.4.64.0705161542540.6410@racer.site>
 <46d6db660705161235k130fabc2i6acb45d71b85891e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Christian MICHON <christian.michon@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 17 00:39:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoS9O-00046y-FK
	for gcvg-git@gmane.org; Thu, 17 May 2007 00:39:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754394AbXEPWjO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 May 2007 18:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755551AbXEPWjO
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 18:39:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:38366 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754394AbXEPWjN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2007 18:39:13 -0400
Received: (qmail invoked by alias); 16 May 2007 22:39:11 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp001) with SMTP; 17 May 2007 00:39:11 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+ptXBDel6pwUdoioiT7w53myNQTtrbzzNwuTeUh/
	jOvt/AXsWcigM9
X-X-Sender: gene099@racer.site
In-Reply-To: <46d6db660705161235k130fabc2i6acb45d71b85891e@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47465>

Hi,

On Wed, 16 May 2007, Christian MICHON wrote:

> On 5/16/07, Johannes Schindelin wrote:
> > [please, Christian, do not cut the Cc: list. In particular, do _not_ 
> > cut the person you are _responding_ to from the Cc: list]
> 
> [ oops. I thought some of us sometimes receive doublets of emails,
> being in reply_to and cc of git@vger.kernel.org. point *taken* ]

Actually, I get doublets. Which is good, since I am more unlikely to just 
delete _two_ copies of the same mail.

> I know the API changes frequently. But engineers don't like too many 
> changes usually, and like to carry a portable/stable way. "git cat-file" 
> at least behaves as it was in 1.4.x :)

Those changes were good changes. "git-show" is here to stay. 
"git-cat-file" only appeals to Unix zealots who even sleep in their 
command line.

> > > As far as I can tell, using git-1.4.4.4 or ealier, you would still 
> > > need git-cat-file -p... to fix this merge conflict.
> > 
> > If you are using pre-1.5 Git, you should really, really upgrade.
> 
> While in principle I'd agree, in practice I do not. Git API changes 
> increased learning curve for people who actually started with git a year 
> ago.

I think I can pretty much guarantee that git-cat-file will stay plumbing. 
As much as it will keep its not-exactly-user-friendly command line 
arguments.

And I can pretty much guarantee that git-show will always be the good 
thing for an end user to call.

> > And most importantly: if you suggest a change in the man pages, it 
> > should reflect the new Git versions, _not_ the old ones.
> 
> nope, I would not dare to suggest. I'm not a git developer: just a git 
> user :)

You are right: for general help, this list is open for older versions of 
Git. What triggered my response, though, was the suggestion to put that 
particular command line, which indeed scares people away from Git (I tried 
it on somebody), into a man page.

	git-show <revision>:<path>

is so much nicer.

Ciao,
Dscho
