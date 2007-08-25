From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: tracking perms/ownership [was: empty directories]
Date: Sat, 25 Aug 2007 16:30:41 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0708251629320.16728@wbgn129.biozentrum.uni-wuerzburg.de>
References: <1187716461.5986.71.camel@beauty> <20070821134030.b763e9d3.seanlkml@sympatico.ca>
 <1187817948.5986.159.camel@beauty> <alpine.LFD.0.999.0708221618510.30176@woody.linux-foundation.org>
 <1187905879.5986.199.camel@beauty> <Pine.LNX.4.64.0708241136301.16728@wbgn129.biozentrum.uni-wuerzburg.de>
 <20070824100524.GA17348@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Josh England <jjengla@sandia.gov>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Aug 25 16:31:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOwfG-00057O-OL
	for gcvg-git@gmane.org; Sat, 25 Aug 2007 16:31:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759251AbXHYOap (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Aug 2007 10:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759145AbXHYOao
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Aug 2007 10:30:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:45381 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757460AbXHYOao (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Aug 2007 10:30:44 -0400
Received: (qmail invoked by alias); 25 Aug 2007 14:30:42 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp042) with SMTP; 25 Aug 2007 16:30:42 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/ilhVzmY3idiYLdpZxTRp3gq7HRYGA6cwaxgVNPA
	GQszz+eiHB8QsS
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070824100524.GA17348@coredump.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56635>

Hi,

On Fri, 24 Aug 2007, Jeff King wrote:

> On Fri, Aug 24, 2007 at 11:38:13AM +0200, Johannes Schindelin wrote:
> 
> > I wonder why you do not just use the "smudge" and "clean" attributes, and 
> > store the ownership _and_ the permissions in .gitacls.
> 
> Thinking about this more, are you proposing:
> 
> 1. Clean and smudge every file, looking up the attributes in .gitacls.

Yes, this is what I thought about.  And I'd just have looked up the file 
name by sha1.

The clean/smudge filter would update .gitacls in the index, too...

Ciao,
Dscho
