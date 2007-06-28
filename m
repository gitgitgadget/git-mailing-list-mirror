From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-merge-ff: fast-forward only merge
Date: Thu, 28 Jun 2007 14:01:18 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706281400530.4438@racer.site>
References: <1182830470640-git-send-email-sam.vilain@catalyst.net.nz>
 <20070628113346.GA4914@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sam Vilain <sam.vilain@catalyst.net.nz>, git@vger.kernel.org
To: Matthias Lederhofer <matled@gmx.net>
X-From: git-owner@vger.kernel.org Thu Jun 28 15:07:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3tiN-0002Xo-LO
	for gcvg-git@gmane.org; Thu, 28 Jun 2007 15:07:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760750AbXF1NHN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jun 2007 09:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760734AbXF1NHN
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jun 2007 09:07:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:34089 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760705AbXF1NHL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jun 2007 09:07:11 -0400
Received: (qmail invoked by alias); 28 Jun 2007 13:07:10 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp054) with SMTP; 28 Jun 2007 15:07:10 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+78JMe9eK7YPr8+0ytLgrSd2uroCJ1ZlUwbcctkd
	UWrAQb72Nkvt7M
X-X-Sender: gene099@racer.site
In-Reply-To: <20070628113346.GA4914@moooo.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51104>

Hi,

On Thu, 28 Jun 2007, Matthias Lederhofer wrote:

> Sam Vilain <sam.vilain@catalyst.net.nz> wrote:
> > This is primarily so that there is an easy switch to 'git-pull' to
> > be sure to fast forward only.
> > ---
> >  Documentation/merge-strategies.txt |    5 +++++
> >  Makefile                           |    2 +-
> >  git-merge-ff.sh                    |    8 ++++++++
> >  3 files changed, 14 insertions(+), 1 deletions(-)
> >  create mode 100644 git-merge-ff.sh
> 
> git-merge-ff.sh should be executable, added to .gitignore and the
> strategy should be added to the available strategies.
> 
> And somehow it did not work for me at all:
> 
> % git merge -s ff origin/master
> git-merge.sh: needs update   
> Trying really trivial in-index merge...
> Wonderful.
> In-index merge
> [..]
> % git show HEAD|grep Merge
> Merge: 117a93c... f578825...
>     Merge commit 'origin/master'

To prevent something like this to happen, may I suggest adding a really 
simple, small test case?

Ciao,
Dscho
