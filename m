From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] push: Learn to set up branch tracking with '--track'
Date: Mon, 2 Feb 2009 14:52:26 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902021449370.3586@pacific.mpi-cbg.de>
References: <cover.1233236267u.git.johannes.schindelin@gmx.de> <alpine.DEB.1.00.0901291438030.3586@pacific.mpi-cbg.de> <20090129223308.GB12871@coredump.intra.peff.net> <20090129231715.GA17399@coredump.intra.peff.net> <alpine.DEB.1.00.0901300127450.3586@pacific.mpi-cbg.de>
 <20090130050925.GA18809@coredump.intra.peff.net> <alpine.DEB.1.00.0901301656290.3586@pacific.mpi-cbg.de> <20090130162258.GA7065@sigill.intra.peff.net> <alpine.DEB.1.00.0901301804030.3586@pacific.mpi-cbg.de> <20090202131611.GB8487@sigio.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 02 14:53:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTzEs-0008KL-TY
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 14:53:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752294AbZBBNv7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 08:51:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752184AbZBBNv7
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 08:51:59 -0500
Received: from mail.gmx.net ([213.165.64.20]:45563 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752090AbZBBNv6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 08:51:58 -0500
Received: (qmail invoked by alias); 02 Feb 2009 13:51:56 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp037) with SMTP; 02 Feb 2009 14:51:56 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/yfSVri1HyERYOyaPWVkJU+GsC357tyrBH1NkLSu
	t/qKovUPjsF5rX
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090202131611.GB8487@sigio.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108087>

Hi,

On Mon, 2 Feb 2009, Jeff King wrote:

> It looks like the consensus is to add a branch.master config section 
> even when cloning an empty repo. And that should address my concern in 
> the 99% of cases where people use the default "master" setup. Which kind 
> of takes away the main use case for this topic.

>From where I sit, the main use would have been:

	# <hackhackhack>
	$ git init
	$ git add .
	$ git commit -m initial\ revision
	# <hackhackhack>
	# <create a repository on repo.or.cz>
	$ git remote add origin $URL
	$ git push -t origin master

BTW I always wondered if it would make sense to introduce "git commit 
--init" for the first 3 Git commands.  I use them way too often.

Ah, well, I will install an alias on all of my machines.

Ciao,
Dscho
