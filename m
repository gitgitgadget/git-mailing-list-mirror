From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Considering teaching plumbing to users harmful
Date: Wed, 16 Jul 2008 18:21:02 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807161804400.8950@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 16 19:22:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJAhX-00068l-6s
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 19:22:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751631AbYGPRVE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 13:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751406AbYGPRVD
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 13:21:03 -0400
Received: from mail.gmx.net ([213.165.64.20]:41027 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751002AbYGPRVB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 13:21:01 -0400
Received: (qmail invoked by alias); 16 Jul 2008 17:20:59 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp024) with SMTP; 16 Jul 2008 19:20:59 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+NbegtVv6NhaWmjUUsH8J/6swnlhKPtYXl0JaNRt
	lRZGmgQqZ8Vwcy
X-X-Sender: gene099@racer
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88698>

Hi,

there have been a number of occasions where I came across people trying to 
be helpful and teaching Git newbies a few tricks.

However, in quite a number of cases, which seem to surge over the last 
weeks, I see people suggesting the use of rev-parse, ls-tree, rev-list 
etc.

Their rationale is invariably "but I found it useful", and they seem to be 
unable to recognize the puzzlement in the faces of the people they are 
trying to help.

Instead they insist that they did nothing wrong.

I had the pleasure of introducing Git to a few users in the last months 
and in my opinion, restricting myself to teaching them these commands 
first helped tremendously:

- clone, pull, status, add, commit, push, log

All of these were presented without options, to keep things simple.

In particular, I refrained from giving them the "-a" option to commit.  
That seemed to help incredibly with their embracing the index as a natural 
concept (which it is).

Often I presented the "pull" and "push" commands _only_ with "origin 
master" ("origin is where the repository came from, and master is the 
branch; you will want to use other parameters here after you used Git for 
a while").

_After_ they grew comfortable with Git, I taught them a few options here 
and there, not hiding, but also not promoting the full range of options.

So the next tricks were

- log -p, rm, diff, diff --cached, show

The last one is "show", and with that command, I taught the 
"<commit>:" and "<commit>:<file>" syntax, too (which some Git old-timers 
did not know about ;-)

The pace needed to be adjusted to the users, in my experience, but not the 
order.

Now, it makes me really, really sad that Git has a reputation of being 
complicated, but I regularly hear from _my_ users that they do not 
understand how that came about.

Am I the only one who deems teaching plumbing to users ("I like it raw!  
So I teach it the same way!") harmful?

Ciao,
Dscho "who is sad"
