From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [BUG] gitk fails with argument that is both existing directory
 and branch name
Date: Tue, 3 Jul 2007 22:55:22 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707032248570.4071@racer.site>
References: <20070703202301.GA24071@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
X-From: git-owner@vger.kernel.org Tue Jul 03 23:55:35 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5qLN-00086a-CA
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 23:55:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753449AbXGCVzb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 17:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753385AbXGCVzb
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 17:55:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:59025 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752691AbXGCVza (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 17:55:30 -0400
Received: (qmail invoked by alias); 03 Jul 2007 21:55:29 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp047) with SMTP; 03 Jul 2007 23:55:29 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX190IyggpIB0h5+YZm7gwEfM0fwNu2hIwt2Ckho/rD
	5lLEdWk2mq9meV
X-X-Sender: gene099@racer.site
In-Reply-To: <20070703202301.GA24071@informatik.uni-freiburg.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51540>

Hi,

On Tue, 3 Jul 2007, Uwe Kleine-K?nig wrote:

> 	zeisberg@cassiopeia:~/gsrc/linux-2.6$ git rev-list ^linus/master fixes
> 	fatal: ambiguous argument 'fixes': both revision and filename
> 	Use '--' to separate filenames from revisions
> 
> but 
> 	
> 	gitk ^linus/master fixes --

Umm. Why don't you just use gitk linus/master..fixes? This is how we teach 
people to use rev-list anyway.

Ciao,
Dscho
