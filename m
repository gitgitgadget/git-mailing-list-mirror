From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git User's Survey 2007 unfinished summary continued
Date: Sun, 21 Oct 2007 23:15:07 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710212308540.25221@racer.site>
References: <8fe92b430710081355i7d3dbaa2q9a8939b55d7ca7dc@mail.gmail.com> 
 <Pine.LNX.4.64.0710130130380.25221@racer.site>  <1192827476.4522.93.camel@cacharro.xalalinux.org>
  <4719B655.90204@op5.se> <DE4FB702-24E8-421F-8447-04A5C7F7B5D2@zib.de>
 <8fe92b430710201606i47e85b24k17abd819bf0d353b@mail.gmail.com>
 <Pine.LNX.4.64.0710210031130.25221@racer.site> <471AFD07.4040606@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>,
	Steffen Prohaska <prohaska@zib.de>,
	Federico Mena Quintero <federico@novell.com>,
	git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon Oct 22 00:15:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ijj59-0005rK-5n
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 00:15:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750924AbXJUWP2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2007 18:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750891AbXJUWP2
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Oct 2007 18:15:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:36430 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750864AbXJUWP1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2007 18:15:27 -0400
Received: (qmail invoked by alias); 21 Oct 2007 22:15:25 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp040) with SMTP; 22 Oct 2007 00:15:25 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18WvtB7QKcWKtd784WPw/B9cM2lkLMfNukqS4V9kb
	uW41hnJFVpRo4o
X-X-Sender: gene099@racer.site
In-Reply-To: <471AFD07.4040606@op5.se>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61917>

Hi,

On Sun, 21 Oct 2007, Andreas Ericsson wrote:

> Johannes Schindelin wrote:
> 
> > On Sun, 21 Oct 2007, Jakub Narebski wrote:
> > 
> > > On 10/20/07, Steffen Prohaska <prohaska@zib.de> wrote:
> > > 
> > > > Maybe we could group commands into more categories?
> > > > 
> > > > plumbing: should be hidden from the 'normal' user. Porcelain
> > > >    should be sufficient for every standard task.
> > >
> > > The problem is division between what is porcelain and what is 
> > > plumbing. Some commands are right on border (git-fsck, 
> > > git-update-index, git-rev-parse comes to mind).
> > 
> > Sorry, but my impression from the latest mails was that the commands 
> > are fine.  What is lacking is a nice, _small_ collection of 
> > recommended workflows.  And when we have agreed on such a set of 
> > workflows, we optimize the hell out of them.  Only this time it is not 
> > performance, but user-friendliness.
> 
> http://www.kernel.org/pub/software/scm/git/docs/everyday.html would be a 
> good starting point, I think.

I don't think so.  Way too few authors were involved in writing this 
document, so it is not "typical" in and of itself.

I'd really like people to respond not so much with broad and general 
statements to my mail (those statements tend to be rather useless to find 
how to make git more suitable to newbies), but rather with concrete top 
ten lists of what they do daily.

My top ten list:

- git diff
- git commit
- git status
- git fetch
- git rebase
- git pull
- git cherry-pick
- git bisect
- git push
- git add

Of course, my list is somewhat skewed (because I am quite comfortable with 
the commands git provided; otherwise I would have provided -- unlike 
others, probably -- patches, and would have fought -- also unlike others 
-- to get them in, such as --color-words).

So again, I'd like people who did _not_ tweak git to their likings to tell 
the most common steps they do.  My hope is that we see things that are 
good practices, but could use an easier user interface.

Ciao,
Dscho
