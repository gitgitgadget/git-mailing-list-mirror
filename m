From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-remote exclude
Date: Tue, 16 Jan 2007 12:16:32 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701161214460.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45AA44D6.6080605@gmail.com> <200701151155.26111.andyparkins@gmail.com>
 <7vodp00xag.fsf@assigned-by-dhcp.cox.net> <200701161026.49752.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Jan 16 12:16:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6mIw-0006bD-C8
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 12:16:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbXAPLQe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Jan 2007 06:16:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750846AbXAPLQe
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jan 2007 06:16:34 -0500
Received: from mail.gmx.net ([213.165.64.20]:39232 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750896AbXAPLQe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jan 2007 06:16:34 -0500
Received: (qmail invoked by alias); 16 Jan 2007 11:16:32 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp054) with SMTP; 16 Jan 2007 12:16:32 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Andy Parkins <andyparkins@gmail.com>
In-Reply-To: <200701161026.49752.andyparkins@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36929>

Hi,

On Tue, 16 Jan 2007, Andy Parkins wrote:

> On Monday 2007 January 15 21:56, Junio C Hamano wrote:
> 
> > I do not think you are interested in "not these two but everything 
> > else".  You are interested in maint, master, next, pu and man.  You 
> > can get away by saying "not these two but everything else" only 
> > because you are implicitly trusting me not to publish insane number of 
> > random throw-away branches left and right.
> 
> Nope.  I think I'm right.  You're right that I'm trusting you not to 
> publish an insane number of branches, but that holds for the glob-mode 
> only, regardless of whether the NOT fetches are in place.  The sort of 
> thing I imagine happening is that as maintainer you suddenly say - I 
> think 1.5.0 is so good that we'll maintain it for longer than usual.  
> In which case we would suddenly get a branch for maint-1.5.0.  I would 
> want that branch, but I still don't want man, html and todo.

Fine. Submit a patch. And if that patch makes git-fetch not as fragile as 
I expect it to do, I am not opposed to inclusion. I'll just not use that 
feature. And I'll still find your usage confused.

Ciao,
Dscho
