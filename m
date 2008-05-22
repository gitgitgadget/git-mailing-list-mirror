From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] log --graph: draw '>' and '<' with --left-right
Date: Thu, 22 May 2008 13:47:23 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805221344360.30431@racer>
References: <alpine.DEB.1.00.0805221235430.30431@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Adam Simpkins <adam@adamsimpkins.net>
X-From: git-owner@vger.kernel.org Thu May 22 14:48:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzADH-0004RH-Br
	for gcvg-git-2@gmane.org; Thu, 22 May 2008 14:48:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761134AbYEVMrP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2008 08:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761015AbYEVMrP
	(ORCPT <rfc822;git-outgoing>); Thu, 22 May 2008 08:47:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:46467 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760676AbYEVMrO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2008 08:47:14 -0400
Received: (qmail invoked by alias); 22 May 2008 12:47:11 -0000
Received: from R5e98.r.pppool.de (EHLO racer.local) [89.54.94.152]
  by mail.gmx.net (mp044) with SMTP; 22 May 2008 14:47:11 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18qQak4ugoq1RY6rn1n0BJ2Tt+pcRIyOU2TEUePoT
	OB0bHX285ptYpR
X-X-Sender: gene099@racer
In-Reply-To: <alpine.DEB.1.00.0805221235430.30431@racer>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82619>

Hi,

On Thu, 22 May 2008, Johannes Schindelin wrote:

> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Sverre just notified me that the commit message is not brilliant.  How 
about this:

-- snip --
When calling "git log --left-right <branch1>...<branch2>", a single "<" or 
">" is shown in front of the commit line, to indicate which branch1 this 
commit comes from, branch1 or branch2.

However, it is easy to miss in the output of "git log --graph ...", since 
the graph still has "*" for regular commits and "M" for merge commits.  So 
imitate gitk, and show the "<" and ">" characters in the graph, too, 
instead of "*" (or "M").
-- snap --

Thanks,
Dscho
