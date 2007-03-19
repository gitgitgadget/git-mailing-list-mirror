From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: RE: [wishlist] graphical diff
Date: Mon, 19 Mar 2007 14:00:32 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703191359380.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <001001c769fe$af8f4400$0b0aa8c0@abf.local>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-610279858-1174309232=:22628"
Cc: 'Robin Rosenberg' <robin.rosenberg.lists@dewire.com>,
	'git' <git@vger.kernel.org>
To: Raimund Bauer <ray@softwarelandschaft.com>
X-From: git-owner@vger.kernel.org Mon Mar 19 14:00:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTHTb-0002kq-Lm
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 14:00:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933856AbXCSNAf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 09:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933853AbXCSNAf
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 09:00:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:47676 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933856AbXCSNAe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 09:00:34 -0400
Received: (qmail invoked by alias); 19 Mar 2007 13:00:33 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp045) with SMTP; 19 Mar 2007 14:00:33 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18XyX0axFAXrUXIgXGw9QLwNsRU7RyWdHYxXR+9VS
	ATjbS5s7kuGYVl
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <001001c769fe$af8f4400$0b0aa8c0@abf.local>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42613>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-610279858-1174309232=:22628
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 19 Mar 2007, Raimund Bauer wrote:

> On Monday, March 19, Johannes Schindelin wrote:
> > > söndag 18 mars 2007 14:16 skrev Raimund Bauer:
> > > > I think it would be really helpful (especially for 
> > newbies like me) 
> > > > to have an option like
> > > > 
> > > > git diff --gui [revisions] <singe path spec>
> > 
> > And how do you set _what_ gui you want? Everybody has her pet 
> > diff-viewer 
> > (mine is less, BTW).
> 
> Maybe with a git.gui config option (like merge.tool)?
> Or by specifying on the commandline:
> 
> git diff --gui=<my-gui-differ> ...
> 
> And <my-gui-differ> = xxdiff | kompare | tkdiff | ...

Have you actually looked at the patch I sent? It is more logical to say 
"git -p=<bla> diff ..." when the option "-p" (without "=") already exists.

Ciao,
Dscho

---1148973799-610279858-1174309232=:22628--
