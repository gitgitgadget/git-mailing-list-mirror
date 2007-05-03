From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git benchmarks at OpenOffice.org wiki
Date: Thu, 3 May 2007 11:33:21 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705031131410.4015@racer.site>
References: <200705012346.14997.jnareb@gmail.com> <87lkg61j99.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Florian Weimer <fw@deneb.enyo.de>
X-From: git-owner@vger.kernel.org Thu May 03 11:33:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjXgj-0007r2-Of
	for gcvg-git@gmane.org; Thu, 03 May 2007 11:33:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965576AbXECJdW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 May 2007 05:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965692AbXECJdW
	(ORCPT <rfc822;git-outgoing>); Thu, 3 May 2007 05:33:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:55232 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965576AbXECJdV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2007 05:33:21 -0400
Received: (qmail invoked by alias); 03 May 2007 09:33:18 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp052) with SMTP; 03 May 2007 11:33:18 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Gwnp8VQ5G0iilTJw8uexEI8h9HsyUcOH7XFYhNo
	UCbeJKkRMVtdVU
X-X-Sender: gene099@racer.site
In-Reply-To: <87lkg61j99.fsf@mid.deneb.enyo.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46077>

Hi,

On Thu, 3 May 2007, Florian Weimer wrote:

> * Jakub Narebski:
> 
> > What I'm really concerned about is branch switch and merging branches, 
> > when one of the branches is an old one (e.g. unxsplash branch), which 
> > takes 3min (!) according to the benchmark. 13-25sec for commit is also 
> > bit long, but BRANCH SWITCHING which takes 3 MINUTES!?
> 
> IIRC, GIT accesses every file in the tree, not just the ones that need
> updating.  How many files were actually updated when you changed
> branches in your experiment?

No. Git does not access every file, but rather all stats. That is a huge 
difference. And it should not take _that_ long for ~64000 files. Granted, 
it will cause a substantial delay, but not in the range of minutes.

Ciao,
Dscho
