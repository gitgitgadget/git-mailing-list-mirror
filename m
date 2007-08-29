From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [ANNOUNCE] GIT 1.5.3-rc7
Date: Wed, 29 Aug 2007 16:23:24 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708291621120.28586@racer.site>
References: <7vbqcqr6cz.fsf@gitster.siamese.dyndns.org> <46D57ECF.2050209@eudaptics.com>
 <Pine.LNX.4.64.0708291516020.28586@racer.site> <46D58C02.2070203@eudaptics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Johannes Sixt <j.sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Wed Aug 29 17:24:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQPOz-0007qu-IS
	for gcvg-git@gmane.org; Wed, 29 Aug 2007 17:24:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753532AbXH2PYO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Aug 2007 11:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753529AbXH2PYO
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 11:24:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:53190 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752691AbXH2PYN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 11:24:13 -0400
Received: (qmail invoked by alias); 29 Aug 2007 15:23:26 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp004) with SMTP; 29 Aug 2007 17:23:26 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18NYlV7pVgNmhR07jHIHhcm95os/m7ZfRpHC27uRQ
	D0ZZ/dbCcOd3no
X-X-Sender: gene099@racer.site
In-Reply-To: <46D58C02.2070203@eudaptics.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56962>

Hi,

On Wed, 29 Aug 2007, Johannes Sixt wrote:

> Johannes Schindelin schrieb:
> > On Wed, 29 Aug 2007, Johannes Sixt wrote:
> > 
> > > The MinGW port is now at 1.5.3-rc7, too.
> > 
> > Should we switch from  4msysgit.git's devel branch to your master branch?
> 
> No. There are still too many differences.

Right.  And I see that there are many more tests failing with mingw.git's 
master, too.  Should have tested that first.

> But I think it is time to rebase 4msysgit on top of 'devel' - without 
> the old devel commits, i.e.
> 
> 	git rebase --onto mingw/devel 382210f715
> 
> There is a lot of stuff in 4msysgit.git that is no longer needed or 
> superceded by mingw.git.
> 
> Side note: If you can live with a test suite does not complete without 
> failures you can rebase on top of master and avoid the devel branch. 
> (Think of broken repo when I rebase devel again.)

Hmm.  I really want to avoid that breakage...

To refresh my memory, could you please describe how mingw.git's master and 
devel branches are handled?

Ciao,
Dscho
