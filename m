From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] Teach "git branch" about --new-workdir
Date: Sun, 22 Jul 2007 22:25:40 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707222223460.14781@racer.site>
References: <Pine.LNX.4.64.0707221956210.14781@racer.site>
 <Pine.LNX.4.64.0707222205050.23426@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Sun Jul 22 23:25:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICiwA-0006uk-TZ
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 23:25:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755841AbXGVVZy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 17:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760622AbXGVVZy
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 17:25:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:43020 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755689AbXGVVZx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 17:25:53 -0400
Received: (qmail invoked by alias); 22 Jul 2007 21:25:51 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp056) with SMTP; 22 Jul 2007 23:25:51 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+P/+ViCraPr4p74H/e45NGza2mtucktfHE5y1kbd
	ofqGrrIhlpHS5p
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0707222205050.23426@reaper.quantumfyre.co.uk>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53322>

Hi,

On Sun, 22 Jul 2007, Julian Phillips wrote:

> On Sun, 22 Jul 2007, Johannes Schindelin wrote:
> 
> > 	IMHO this is a better syntax than what is in contrib/, and "git
> > 	branch" is probably the right place for such a thing, from a
> > 	user's perspective.
> 
> Surely checkout would make more sense than branch?  You are effectively 
> checking out into a new directory ... also you may want to get an 
> existing branch (certainly most of my usage of new-workdir is checking 
> out existing branches, e.g. to look at - as in build and play with - an 
> interesting branch that someone else has pushed out).

My rationale here was:

- to make sure that the user cannot check out the same branch as in the 
  current repo, _or some other workdir of it_, and

- to have finer grained lock control, as well as respecting has_symlinks.

Ciao,
Dscho
