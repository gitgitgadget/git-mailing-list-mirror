From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: newbie questions about git design and features (some wrt hg)
Date: Thu, 1 Feb 2007 11:49:52 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702011149290.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <3c6c07c20701300820l42cfc8dbsb80393fc1469f667@mail.gmail.com>
 <200702010058.43431.jnareb@gmail.com> <20070201003429.GQ10108@waste.org>
 <200702010157.51452.jnareb@gmail.com> <45C19DD0.20504@fs.ei.tum.de>
 <Pine.LNX.4.63.0702011108430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45C1BDD3.8050103@fs.ei.tum.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
X-From: git-owner@vger.kernel.org Thu Feb 01 11:50:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCZVt-0004ad-Rm
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 11:49:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422735AbXBAKtz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 05:49:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422782AbXBAKty
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 05:49:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:36630 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1422735AbXBAKty (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 05:49:54 -0500
Received: (qmail invoked by alias); 01 Feb 2007 10:49:52 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp019) with SMTP; 01 Feb 2007 11:49:52 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45C1BDD3.8050103@fs.ei.tum.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38343>

Hi,

On Thu, 1 Feb 2007, Simon 'corecode' Schubert wrote:

> Johannes Schindelin wrote:
> > > If you rename, you take the penalty of duplicating the content
> > > (compressed) with a new name.  No big deal there. So there are *no*
> > > file-ids.  Blobs go into the data/index file which corresponds to their
> > > filename.
> > So, can you explain to me how a filename is _not_ a file-id?
> 
> It is not a file-id like other SCM use it (I think monotone, not sure though).
> If you copy/move the content to a new name, the ID will not stay the same.
> Just see it as a hash bucket which allows you easy access to the history for a
> file currently with this name.

Ah, thanks. I misunderstood the meaning of file-id in _that_ context.

Ciao,
Dscho
