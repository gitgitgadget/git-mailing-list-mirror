From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] clone: respect url.insteadOf setting in global
 configs
Date: Sun, 29 Jun 2008 22:50:34 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806292250220.9925@racer>
References: <27C25D70-0BFC-4362-A771-C7CAD89BC198@ai.rug.nl> <alpine.DEB.1.00.0806271353350.9925@racer> <alpine.DEB.1.00.0806271355520.9925@racer> <770C18A6-429E-49C0-BCF3-C2B229AAF5F9@ai.rug.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailinglist <git@vger.kernel.org>
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Sun Jun 29 23:53:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KD4ps-0001y5-2y
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 23:53:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752216AbYF2Vwc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 17:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752180AbYF2Vwb
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 17:52:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:36917 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752179AbYF2Vwb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 17:52:31 -0400
Received: (qmail invoked by alias); 29 Jun 2008 21:52:29 -0000
Received: from 87.113.36.200.plusnet.pte-ag1.dyn.plus.net (EHLO racer.local) [87.113.36.200]
  by mail.gmx.net (mp031) with SMTP; 29 Jun 2008 23:52:29 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+9ZYUPYFy9vVjEOzpOToIvdF/EFhN9139j5e66kn
	Q3Qk3po3GdqHiD
X-X-Sender: gene099@racer
In-Reply-To: <770C18A6-429E-49C0-BCF3-C2B229AAF5F9@ai.rug.nl>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86836>

Hi,

On Sun, 29 Jun 2008, Pieter de Bie wrote:

> On 27 jun 2008, at 14:56, Johannes Schindelin wrote:
> 
> > When we call "git clone" with a url that has a rewrite rule in either
> > $HOME/.gitconfig or /etc/gitconfig, the URL can be different from
> > what the command line expects it to be.
> >
> > So, let's use the URL as the remote structure has it, not the literal
> > string from the command line.
> >
> > Noticed by Pieter de Bie.
> 
> 
> This works great, thanks for the quick patch! :)

Thanks for the quick answer,
Dscho
