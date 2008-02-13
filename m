From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH updated] Add "--dirstat" for some directory statistics
Date: Wed, 13 Feb 2008 13:48:22 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802131347490.30505@racer.site>
References: <alpine.LFD.1.00.0802121308360.2920@woody.linux-foundation.org> <fou7pu$dpq$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Abdelrazak Younes <younes@lyx.org>
X-From: git-owner@vger.kernel.org Wed Feb 13 14:48:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPHyp-0005YP-6O
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 14:48:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755147AbYBMNsU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 08:48:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754882AbYBMNsT
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 08:48:19 -0500
Received: from mail.gmx.net ([213.165.64.20]:44394 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754279AbYBMNsR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 08:48:17 -0500
Received: (qmail invoked by alias); 13 Feb 2008 13:48:15 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp022) with SMTP; 13 Feb 2008 14:48:15 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+xVM0tyjqx9IEqcjVDSKDtAW3v+xna98PAUmzAfv
	A78ksJFB+5Y1cn
X-X-Sender: gene099@racer.site
In-Reply-To: <fou7pu$dpq$1@ger.gmane.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73794>

Hi,

On Wed, 13 Feb 2008, Abdelrazak Younes wrote:

> Linus Torvalds wrote:
> > 	   7.6% fs/afs/
> > 	   7.6% fs/fuse/
> > 	   7.6% fs/gfs2/
> > 	   5.1% fs/jffs2/
> > 	   5.1% fs/nfs/
> > 	   5.1% fs/nfsd/
> > 	   7.6% fs/reiserfs/
> > 	  15.3% fs/
> [...]
> > For an example of the cumulative reporting, the above commit becomes
> [...]
> > 	   7.6% fs/afs/
> > 	   7.6% fs/fuse/
> > 	   7.6% fs/gfs2/
> > 	   5.1% fs/jffs2/
> > 	   5.1% fs/nfs/
> > 	   5.1% fs/nfsd/
> > 	   7.6% fs/reiserfs/
> > 	  61.5% fs/
> 
> 
> May I suggest this instead so to get rid of the cumulative option?
> 
>  	   7.6% fs/afs
>  	   7.6% fs/fuse
>  	   7.6% fs/gfs2
>  	   5.1% fs/jffs2
>  	   5.1% fs/nfs
>  	   5.1% fs/nfsd
>  	   7.6% fs/reiserfs
>  	  15.3% fs/
>  	  61.5% fs
> 
> A trailing slash would mean "no recursive, only this directory" and no
> trailing slash means well the opposite :-)

My 2cents: I find that highly counterintuitive (yes, I am a frequent user 
of "du").

Ciao,
Dscho
