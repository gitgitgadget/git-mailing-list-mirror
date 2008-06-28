From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: An alternate model for preparing partial commits
Date: Sat, 28 Jun 2008 15:51:12 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806281549060.9925@racer>
References: <9af502e50806262350t6e794a92g7751147f1882965@mail.gmail.com> <alpine.DEB.1.00.0806271408290.9925@racer> <7vprq2rbfz.fsf@gitster.siamese.dyndns.org> <20080628050317.GE9451@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jun 28 16:54:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCboX-0002JW-Lk
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 16:54:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753074AbYF1OxN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2008 10:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752859AbYF1OxM
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jun 2008 10:53:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:38032 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752823AbYF1OxL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jun 2008 10:53:11 -0400
Received: (qmail invoked by alias); 28 Jun 2008 14:53:09 -0000
Received: from 87.113.36.200.plusnet.pte-ag1.dyn.plus.net (EHLO racer.local) [87.113.36.200]
  by mail.gmx.net (mp001) with SMTP; 28 Jun 2008 16:53:09 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/aw4ds+F/aswlOhGzfwtI1KzG1E/p5SPlmyUI3H0
	Pn5rVo9zuxYVnR
X-X-Sender: gene099@racer
In-Reply-To: <20080628050317.GE9451@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86721>

Hi.

On Sat, 28 Jun 2008, Jeff King wrote:

> Here's a somewhat hackish implementation of "git stash -i" that just 
> relies on "add -i":

I like it.

> +ADD_OPTIONS="-u"
> +case "$1" in
> +	-i|-p) ADD_OPTIONS=$1; shift
> +esac

I'll squash in "|-e" here.

Note that some time ago, I was working on "git stash apply -i", which I 
never came around to finish.  Yesterday, I was briefly considering working 
on it, but I have other things to tend to now.

Ciao,
Dscho
