From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: VCS comparison table
Date: Thu, 19 Oct 2006 02:33:46 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0610190231140.14200@wbgn013.biozentrum.uni-wuerzburg.de>
References: <453536AE.6060601@utoronto.ca> <200610172301.27101.jnareb@gmail.com>
 <45354AD0.1020107@utoronto.ca> <BAYC1-PASMTP07AB11A64250AAF683424DAE0E0@CEZ.ICE>
 <45355CBB.80108@utoronto.ca> <BAYC1-PASMTP01369CD694D75CB61ACCC7AE0E0@CEZ.ICE>
 <eh64tk$rug$2@sea.gmane.org> <20061018172945.c0c58c38.seanlkml@sympatico.ca>
 <20061018213703.GE19194@spearce.org> <Pine.LNX.4.63.0610190134040.14200@wbgn013.biozentrum.uni-wuerzburg.de>
 <20061018235415.GA20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 19 02:34:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaLr6-0007Da-T1
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 02:33:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945926AbWJSAdt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 20:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945928AbWJSAdt
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 20:33:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:58274 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1945926AbWJSAdt (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Oct 2006 20:33:49 -0400
Received: (qmail invoked by alias); 19 Oct 2006 00:33:47 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp033) with SMTP; 19 Oct 2006 02:33:47 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20061018235415.GA20017@pasky.or.cz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29309>

Hi,

On Thu, 19 Oct 2006, Petr Baudis wrote:

> Dear diary, on Thu, Oct 19, 2006 at 01:38:45AM CEST, I got a letter
> where Johannes Schindelin <Johannes.Schindelin@gmx.de> said that...
> > On Wed, 18 Oct 2006, Shawn Pearce wrote:
> > 
> > > Today Git doesn't run natively on Windows.
> > 
> > As I mentioned some time ago, I started a branch on MinGW. It works quite 
> > well for the moment, but it lacks fork() emulation, and glob() emulation. 
> > And I lack the time to continue working on it.
> 
>   care to publish it somewhere, e.g. on repo.or.cz?

It is way to dirty for that. I would only dare give it somebody in return 
for the promise to clean everything up.

BTW I completely forgot that in the absence of poll() from MinGW, all the 
networking code is actually just wrapped into "return -1;" functions.

>   (P.S., have fun in Prague! Too bad I won't be around over the weekend.
> :-( )

Pity. You seem to have good connections...

Ciao,
Dscho
