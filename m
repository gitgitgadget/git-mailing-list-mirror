From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Teach git submodule update to use distributed
 repositories
Date: Thu, 17 Jul 2008 13:13:11 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807171311010.8986@racer>
References: <320075ff0807170508j3d3c1ef8j49df576fc47debe2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Nigel Magnay <nigel.magnay@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 17 14:14:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJSN9-0007bi-J6
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 14:14:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755065AbYGQMNN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 08:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754909AbYGQMNM
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 08:13:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:50587 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754707AbYGQMNM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 08:13:12 -0400
Received: (qmail invoked by alias); 17 Jul 2008 12:13:10 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp067) with SMTP; 17 Jul 2008 14:13:10 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+X/q44rW+XWt9tUn06WbZR7xITTY/fBjjpO7vTjK
	cFpn3WF+CC5JGl
X-X-Sender: gene099@racer
In-Reply-To: <320075ff0807170508j3d3c1ef8j49df576fc47debe2@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88837>

Hi,

On Thu, 17 Jul 2008, Nigel Magnay wrote:

> When doing a git submodule update, it fetches any missing submodule
> commits from the repository specified in .gitmodules.

Huh?  It takes what is in .git/config!  Not what is in .gitmodules.

So if you have another remote (or URL, e.g. if you have ssh:// access, but 
the .gitmodules file lists git://), just edit .git/config.

I meant, that is the whole _point_ of having a two-step init/update 
procedure.

Ciao,
Dscho
