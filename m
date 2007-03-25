From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Removed the printf("rm 'file'") from git-rm.
Date: Sun, 25 Mar 2007 23:36:35 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0703252335280.4045@wbgn013.biozentrum.uni-wuerzburg.de>
References: <11747590062554-git-send-email-tilman@code-monkey.de>
 <7vodmhc06f.fsf@assigned-by-dhcp.cox.net> <20070325210418.GA29221@code-monkey.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Tilman Sauerbeck <tilman@code-monkey.de>
X-From: git-owner@vger.kernel.org Sun Mar 25 23:36:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVaOG-0001Nj-AQ
	for gcvg-git@gmane.org; Sun, 25 Mar 2007 23:36:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932778AbXCYVgh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Mar 2007 17:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932810AbXCYVgh
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Mar 2007 17:36:37 -0400
Received: from mail.gmx.net ([213.165.64.20]:56465 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932806AbXCYVgg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2007 17:36:36 -0400
Received: (qmail invoked by alias); 25 Mar 2007 21:36:35 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp049) with SMTP; 25 Mar 2007 23:36:35 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18cysNj3kgcrqtAAnWB56n3FTeX85qLmw1X5Ku9pG
	MwAEcKUw5bzx9L
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070325210418.GA29221@code-monkey.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43082>

Hi,

On Sun, 25 Mar 2007, Tilman Sauerbeck wrote:

> Junio C Hamano [2007-03-24 23:22]:
> > Tilman Sauerbeck <tilman@code-monkey.de> writes:
> > 
> > > We used to print that, because you actually had to run the output
> > > of git-rm to get rid of the files before Git 1.5. Now that git-rm
> > > really removes the files, it's not needed anymore.
> > 
> > Even though I admit I do not deeply care, as I never use 'git
> > rm' myself, I do not necessarily agree with "because" part.
> > 
> > I suspect people are by now accustomed to see the assuring
> > feedback from the command when used this way:
> > [snip]
> 
> Too bad, I find it rather annoying and irritating.

Why not do the common thing, and add a "--quiet" option? You can even add 
a config variable to enable it by default (for git-rm). It's not like 
git-rm is performance critical...

> A: Because it messes up the order in which people normally read text.
> Q: Why is top-posting such a bad thing?
> A: Top-posting.
> Q: What is the most annoying thing on usenet and in e-mail?

Funny!

Ciao,
Dscho
