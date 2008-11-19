From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git commit won't add an untracked file given on the command
 line
Date: Wed, 19 Nov 2008 02:07:41 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811190206170.30769@pacific.mpi-cbg.de>
References: <20081118211237.234d8035@crow> <200811182227.20076.fge@one2team.com> <20081118214730.005fc72d@crow>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Francis Galiegue <fge@one2team.com>, git@vger.kernel.org
To: Mark Burton <markb@ordern.com>
X-From: git-owner@vger.kernel.org Wed Nov 19 02:01:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2bRU-0004Xc-60
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 02:01:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbYKSA7s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2008 19:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750990AbYKSA7r
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Nov 2008 19:59:47 -0500
Received: from mail.gmx.net ([213.165.64.20]:55215 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750928AbYKSA7r (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2008 19:59:47 -0500
Received: (qmail invoked by alias); 19 Nov 2008 00:59:45 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp067) with SMTP; 19 Nov 2008 01:59:45 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+0FOtJlE20LMI/kgVXqGoZwuwjwnUV/i5AEjxN1V
	i+iaoK1JOPy8J0
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20081118214730.005fc72d@crow>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101296>

Hi,

On Tue, 18 Nov 2008, Mark Burton wrote:

> Hi Francis,
> 
> > You must "git add .gitignore" first. And yes, this is by design.
> 
> Err, that's a bit odd isn't it because "git add" stages the content into 
> the index but the whole point of specifying files on the command line to 
> "git commit" is to commit the changes in the specified files while 
> ignoring what's currently in the index (so says the man page for 
> commit).

It may be a traditional wart, but a helpful one.  Remember, you can also 
say:

	git commit that/directory/

I do _not_ want Git to add all untracked (and unignored) files in that 
directory automatically.

Ciao,
Dscho
