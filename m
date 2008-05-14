From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] cvsexportcommit: chomp only removes trailing
 whitespace
Date: Wed, 14 May 2008 23:15:53 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805142313280.30431@racer>
References: <alpine.DEB.1.00.0805141526160.30431@racer> <7vskwkojhy.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0805141936410.30431@racer> <200805142206.53242.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu May 15 00:19:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwPHD-0005Sx-7A
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 00:16:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756724AbYENWPz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 18:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751604AbYENWPz
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 18:15:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:35354 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758539AbYENWPx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 18:15:53 -0400
Received: (qmail invoked by alias); 14 May 2008 22:15:52 -0000
Received: from R2b68.r.pppool.de (EHLO racer.local) [89.54.43.104]
  by mail.gmx.net (mp058) with SMTP; 15 May 2008 00:15:52 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/JbQELV+fJqbQnjdhryVsqRCInlERZPQbxtOr8m7
	X709GVAEGpWpuZ
X-X-Sender: gene099@racer
In-Reply-To: <200805142206.53242.robin.rosenberg@dewire.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82153>

Hi,

On Wed, 14 May 2008, Robin Rosenberg wrote:

> > Yes, that is the idea.  The point is: there are at least two different 
> > implementations of cvs, and I do not want to rely on a particular one.
> 
> Does CVSNT add extra spaces?

Probably.  At least a CR I would expect.

> A question arises. Can we use cvs update instead? It can be used to 
> retrieve the latest version (as the -u flag to cvsexportcommit does) and 
> it will tell you what status each affected file has. cvs update -n will 
> just give us the status with unambigous file names.

Will it?  The thing is: as far as I can see, cvs is only "porcelain", i.e. 
the output is meant for users' consumption, not scripts'.

So I wanted to be safe, and strip all leading and trailing whitespace, 
call "cvs status" (if necessary, in several runs, so that no ambiguous 
file names can be returned).

Ciao,
Dscho
