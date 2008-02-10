From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Removing things from a repo that shouldn't be there
Date: Sun, 10 Feb 2008 17:38:20 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802101738120.11591@racer.site>
References: <9e4733910802100915t56d0f63fh90c303b35f6af921@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 18:39:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOG8j-0004Zj-CF
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 18:38:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbYBJRiT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 12:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbYBJRiT
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 12:38:19 -0500
Received: from mail.gmx.net ([213.165.64.20]:33363 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751195AbYBJRiT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 12:38:19 -0500
Received: (qmail invoked by alias); 10 Feb 2008 17:38:17 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp012) with SMTP; 10 Feb 2008 18:38:17 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/X5uhyvFLXIvGksY7bqRc2isv4NOj77V+izo4KoX
	9uDCyOa70CvmtB
X-X-Sender: gene099@racer.site
In-Reply-To: <9e4733910802100915t56d0f63fh90c303b35f6af921@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73380>

Hi,

On Sun, 10 Feb 2008, Jon Smirl wrote:

> In the lazy clone thread there is mention of a large, generated file 
> being checked into the tree. Let's say we have a tree like this and it 
> is ok to delete the generated file since it didn't really need to be 
> checked in. Is there a procedure to chase down all the revisions, delete 
> them, and then regenerate the commits to reflect the deletion? I don't 
> need this tool, I'm just wondering if there is a reasonable solution to 
> the problem.

filter-branch.

Ciao,
Dscho
