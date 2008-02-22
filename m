From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [Fwd: [ANNOUNCE] bzr-fastimport plugin, yet another Bazaar import
 option]
Date: Fri, 22 Feb 2008 10:36:41 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802221034140.17164@racer.site>
References: <47BE167A.4060005@internode.on.net> <20080222073228.GF8410@spearce.org> <47BE7E1C.4040303@internode.on.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Bazaar <bazaar@lists.canonical.com>, git@vger.kernel.org
To: Ian Clatworthy <ian.clatworthy@internode.on.net>
X-From: git-owner@vger.kernel.org Fri Feb 22 11:37:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSVHi-0007xx-5L
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 11:37:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753329AbYBVKhG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 05:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbYBVKhG
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 05:37:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:35788 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753329AbYBVKhD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 05:37:03 -0500
Received: (qmail invoked by alias); 22 Feb 2008 10:37:01 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp007) with SMTP; 22 Feb 2008 11:37:01 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+qF/pD0O2q18tKZcnNU+sxis6LABF14pjn2xiIwe
	kJdi4vftgieuEU
X-X-Sender: gene099@racer.site
In-Reply-To: <47BE7E1C.4040303@internode.on.net>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74714>

Hi,

On Fri, 22 Feb 2008, Ian Clatworthy wrote:

> Shawn O. Pearce wrote:
> 
> > Heh.  OOo is _huge_.  I think the best import into Git thus far is 
> > taking up about 1.5G of disk space once fully repacked.  I don't 
> > recall how they did the import, but coming from SVN I think they used 
> > git-svn, which is not based on git-fast-import.
> > 
> > What frontend are you using to go from SVN -> fast-import?
> 
> The pack file in the Git clone I have is 2.4G. I thought that was large 
> but it's quite small compared to the 82G svn dump that creates a 55G svn 
> repo!

The 2.4G have been compressed (loss-lessly ;-) to less than 1.5G.  Unlike 
other SCMs, git has transparent access to the object database, which means 
that we can actually repack _expensively_ for a better compression.

So yes, the Git clone you have _is_ 2.4G, but that size is not the best 
size you _can_ have.

Ciao,
Dscho
