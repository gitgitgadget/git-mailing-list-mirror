From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: The msysGit Herald, issue 2
Date: Mon, 24 Sep 2007 17:32:12 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709241731510.28395@racer.site>
References: <Pine.LNX.4.64.0709232153230.28395@racer.site>
 <alpine.LFD.0.999.0709240840310.3579@woody.linux-foundation.org>
 <46F7E2A5.6030202@eudaptics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	msysgit@googlegroups.com, git@vger.kernel.org
To: Johannes Sixt <j.sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Mon Sep 24 18:33:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZqsN-0007wY-Cv
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 18:33:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760603AbXIXQdS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2007 12:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761583AbXIXQdS
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Sep 2007 12:33:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:38905 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761723AbXIXQdQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2007 12:33:16 -0400
Received: (qmail invoked by alias); 24 Sep 2007 16:33:14 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp014) with SMTP; 24 Sep 2007 18:33:14 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ozrAhsaxokvHqavQwK0L2CbUdZztofBVrp0v7qy
	YTJehj0k9ULTts
X-X-Sender: gene099@racer.site
In-Reply-To: <46F7E2A5.6030202@eudaptics.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59059>

Hi,

On Mon, 24 Sep 2007, Johannes Sixt wrote:

> Linus Torvalds schrieb:
> > 
> > On Sun, 23 Sep 2007, Johannes Schindelin wrote:
> > > > 6) What was the most frustrating moment when working with Git?
> > > Just the other day, I wanted to fetch a set of changes from a public
> > > repo into my test repo in order to cherry-pick from them - and it
> > > automatically fetched all the tags. But, the heck, I don't want them tags
> > > here, just the commits. I just can't figure out how to avoid the
> > > automatic
> > > fetching of tags.
> > 
> > The way this was *supposed* to work is that if you are not fetching a
> > "tracking branch", it should not fetch any tags.
> > 
> > Maybe this got broken lately?
> > 
> > Or maybe you did fetch a tracking branch?
> 
> I don't think I fetched a tracking branch. If I do:
> 
>    $ mkdir foo && cd foo && git init
>    $ git fetch ../git master:refs/heads/master
> 
> (where ../git is a clone of git.git with a few local changes), I get all the
> tags. Good or bad?

The ":refs/heads/master" part says that you fetch into a tracking branch.

Ciao,
Dscho
