From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] name-rev: introduce the --ref-filter=<regex> option
Date: Sat, 17 Feb 2007 18:50:51 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702171840140.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070127040618.GA14205@fieldses.org>
 <Pine.LNX.4.64.0701262022230.25027@woody.linux-foundation.org>
 <20070127044246.GC14205@fieldses.org> <20070127045552.GB9966@spearce.org>
 <7vhcudoxfj.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0701271334410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.63.0702171502040.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070217145921.GA16747@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 17 18:50:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HITi5-0005mQ-CI
	for gcvg-git@gmane.org; Sat, 17 Feb 2007 18:50:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992995AbXBQRuy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 12:50:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992996AbXBQRuy
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 12:50:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:56756 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S2992995AbXBQRux (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 12:50:53 -0500
Received: (qmail invoked by alias); 17 Feb 2007 17:50:52 -0000
X-Provags-ID: V01U2FsdGVkX18boEFji88bmIiVHPOP5ZyKNAzfGq7NaG+nARzY90
	on+A==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070217145921.GA16747@coredump.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39997>

Hi,

On Sat, 17 Feb 2007, Jeff King wrote:

> On Sat, Feb 17, 2007 at 03:02:36PM +0100, Johannes Schindelin wrote:
> 
> > > Instead of (or, in addition to) --tags, to use only tags for naming,
> > > you can now use --ref-filter=<regex> to specify which refs are
> > > used for naming.
> > > 
> > > Example:
> > > 
> > > 	$ git name-rev --ref-filter='/v1' 33db5f4d
> > > 	33db5f4d tags/v1.0rc1^0~1593
> > 
> > Likes, dislikes?
> 
> It's a neat idea, but I wonder if you could make it even more flexible
> by simply accepting a list of possible refs, and then you could filter
> using grep, or your own more complex selection algorithm.

You can do that with regexps also. And you're right, my code was meant to 
be simple...

Ciao,
Dscho
