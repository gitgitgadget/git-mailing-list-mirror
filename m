From: Martin Renold <martinxyz@gmx.ch>
Subject: Re: [PATCH] git status -q (similar to subversion)
Date: Sun, 28 Jun 2009 23:01:17 +0200
Message-ID: <20090628210117.GA7821@old.homeip.net>
References: <Pine.LNX.4.64.0906272248570.11453@cube> <20090628185218.GB8634@sigio.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 28 23:01:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ML1V5-00059H-L1
	for gcvg-git-2@gmane.org; Sun, 28 Jun 2009 23:01:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753187AbZF1VBP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2009 17:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752730AbZF1VBP
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Jun 2009 17:01:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:39354 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756084AbZF1VBO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2009 17:01:14 -0400
Received: (qmail invoked by alias); 28 Jun 2009 21:01:16 -0000
Received: from 84-74-83-103.dclient.hispeed.ch (EHLO bazaar) [84.74.83.103]
  by mail.gmx.net (mp070) with SMTP; 28 Jun 2009 23:01:16 +0200
X-Authenticated: #1936982
X-Provags-ID: V01U2FsdGVkX1+pB0krq+2pb9hZlo4NjlXXc6XUZKrHYsj/ZaHIqk
	qKLaMorEwc9/QZ
Received: from martin by bazaar with local (Exim 4.69)
	(envelope-from <martinxyz@gmx.ch>)
	id 1ML1Uz-0002VF-Ep
	for git@vger.kernel.org; Sun, 28 Jun 2009 23:01:17 +0200
Content-Disposition: inline
In-Reply-To: <20090628185218.GB8634@sigio.peff.net>
X-Virus: Hi! I'm a header virus! Copy me into yours and join the fun!
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122423>

On Sun, Jun 28, 2009 at 02:52:18PM -0400, Jeff King wrote:
> On Sat, Jun 27, 2009 at 10:57:13PM +0200, Unknown wrote:
> > Here is a tiny patch adding -q option to git status.
> > It means -uno (Show no untracked files).
> 
> It seems from the subject like you are trying to emulate a similar
> option in "svn status".

As a former svn user I also miss -q.  I like to keep untracked non-ignored
files lying around as a short-term TODO list.

I think the point is not SVN compatibility.  The point is that SVN just got
the commandline interface right here ;-) because -q easier to discover and
remember (many programs have --quiet/-q).  And when you use it you will use
it several times in a row.  For this -uno is already too much to bother
typing (assuming you have an alias 'git st').

bye,
Martin
